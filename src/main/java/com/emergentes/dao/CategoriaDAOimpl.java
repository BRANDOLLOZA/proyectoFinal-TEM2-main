
package com.emergentes.dao;

import com.emergentes.modelo.Categoria;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAOimpl extends ConexionBD implements CategoriaDAO {

    @Override
    public void insert(Categoria categoria) throws Exception {
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "insert into categoria (nombre,descripcion,condicion) values (?,?,?)";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setString(1, categoria.getNombre());
            ps.setString(2, categoria.getDescripcion());
            ps.setInt(3, categoria.getCondicion());
            ps.executeUpdate();
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public void update(Categoria categoria) throws Exception {
    try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "update categoria set nombre=? ,descripcion=?,condicion=? where idcategoria=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setString(1, categoria.getNombre());
            ps.setString(2, categoria.getDescripcion());
            ps.setInt(3, categoria.getCondicion());
            ps.setInt(4, categoria.getIdcategoria());
            ps.executeUpdate();
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public void delete(int id) throws Exception {
    try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "delete from categoria where idcategoria=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setInt(1, id);
            ps.executeUpdate();
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public Categoria getById(int id) throws Exception {
    //Creamos un objeto y la instanciamos como nuevo objeto
        Categoria categoria = new Categoria();
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select * from categoria where idcategoria=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            //Si hay un registro entonces lo leemos y lo pondremos el el objeto cli
            if (rs.next()) {
                categoria.setIdcategoria(rs.getInt("idcategoria"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setDescripcion(rs.getString("descripcion"));
                categoria.setCondicion(rs.getInt("condicion"));
            }
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return categoria;
    }

    @Override
    public List<Categoria> getAll() throws Exception {
    //Creamos una coleccion de clientes y la instanciamos como nuevo objeto
        List<Categoria> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select * from categoria";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();
            //Iniciamos la lista
            lista = new ArrayList<Categoria>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Categoria categoria = new Categoria();
                categoria.setIdcategoria(rs.getInt("idcategoria"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setDescripcion(rs.getString("descripcion"));
                categoria.setCondicion(rs.getInt("condicion"));
                lista.add(categoria);
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
    
}
