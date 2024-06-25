package com.emergentes.dao;

import com.emergentes.modelo.Articulo;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ArticuloDAOimpl extends ConexionBD implements ArticuloDAO {

    @Override
    public void insert(Articulo articulo) throws Exception {
        try {
            this.conectar();
            PreparedStatement ps = this.conn.prepareStatement("INSERT INTO articulo (idcategoria,codigo,nombre,stock,descripcion,imagen,condicion) values (?,?,?,?,?,?,?)");
            ps.setInt(1, articulo.getIdcategoria());
            ps.setString(2, articulo.getCodigo());
            ps.setString(3, articulo.getNombre());
            ps.setInt(4, articulo.getStock());
            ps.setString(5, articulo.getDescripcion());
            ps.setString(6, articulo.getImagen());
            ps.setInt(7, articulo.getCondicion());
            ps.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public void update(Articulo articulo) throws Exception {
        try {
            this.conectar();
            PreparedStatement ps = this.conn.prepareStatement("UPDATE articulo SET idcategoria=?, codigo=?, nombre=?,stock=?,descripcion=?,imagen=?,condicion=? WHERE idarticulo=?");
            ps.setInt(1, articulo.getIdcategoria());
            ps.setString(2, articulo.getCodigo());
            ps.setString(3, articulo.getNombre());
            ps.setInt(4, articulo.getStock());
            ps.setString(5, articulo.getDescripcion());
            ps.setString(6, articulo.getImagen());
            ps.setInt(7, articulo.getCondicion());
            ps.setInt(8, articulo.getIdarticulo());
            ps.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public void delete(int id) throws Exception {
        try {
            this.conectar();
            PreparedStatement ps = this.conn.prepareStatement("DELETE FROM articulo WHERE idarticulo=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public Articulo getById(int id) throws Exception {
        //Creamos un objeto y la instanciamos como nuevo objeto
        Articulo art = new Articulo();
        try {
            this.conectar();
            String sql = "select a.*,c.nombre as categoria from articulo a LEFT JOIN categoria c ON a.idcategoria=c.idcategoria where idarticulo=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                art.setIdarticulo(rs.getInt("idarticulo"));
                art.setCodigo(rs.getString("codigo"));
                art.setNombre(rs.getString("nombre"));
                art.setStock(rs.getInt("stock"));
                art.setDescripcion(rs.getString("descripcion"));
                art.setImagen(rs.getString("imagen"));
                art.setCondicion(rs.getInt("condicion"));
                art.setIdcategoria(rs.getInt("idcategoria"));
                art.setCategoria(rs.getString("categoria"));
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return art;
    }

    @Override
    public List<Articulo> getAll() throws Exception {
        //Creamos una coleccion de clientes y la instanciamos como nuevo objeto
        List<Articulo> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            //String sql = "select a.*,c.nombre as categoria from articulo a LEFT JOIN categoria c ON a.idcategoria=c.idcategoria";
            String sql="select a.*,c.nombre as categoria,di.precio_venta from articulo a LEFT JOIN categoria c ON a.idcategoria=c.idcategoria LEFT join detalle_ingreso di on a.idarticulo=di.idarticulo GROUP by a.nombre";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();
            //Iniciamos la lista
            lista = new ArrayList<Articulo>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Articulo art = new Articulo();
                art.setIdarticulo(rs.getInt("idarticulo"));
                art.setCodigo(rs.getString("codigo"));
                art.setNombre(rs.getString("nombre"));
                art.setStock(rs.getInt("stock"));
                art.setDescripcion(rs.getString("descripcion"));
                art.setImagen(rs.getString("imagen"));
                art.setCondicion(rs.getInt("condicion"));
                art.setIdcategoria(rs.getInt("idcategoria"));
                art.setCategoria(rs.getString("categoria"));
                art.setPrecio_venta(rs.getDouble("precio_venta"));
                lista.add(art);
            }
            rs.close();
            ps.close();
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return lista;
    }

    public List<Articulo> getAllStock() throws Exception {
        List<Articulo> listaA = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "SELECT idarticulo,nombre,stock FROM articulo WHERE stock <= 5 LIMIT 6;";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();
            //Iniciamos la lista
            listaA = new ArrayList<Articulo>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Articulo stockArt = new Articulo();
                stockArt.setIdarticulo(rs.getInt("idarticulo"));
                stockArt.setNombre(rs.getString("nombre"));
                stockArt.setStock(rs.getInt("stock"));
                listaA.add(stockArt);
            }
            rs.close();
            ps.close();
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return listaA;

    }
}
