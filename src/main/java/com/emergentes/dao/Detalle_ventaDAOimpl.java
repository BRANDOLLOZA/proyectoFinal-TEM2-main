package com.emergentes.dao;

import com.emergentes.modelo.Detalle_venta;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Detalle_ventaDAOimpl extends ConexionBD implements Detalle_ventaDAO {

    @Override
    public void insert(Detalle_venta detalle_venta) throws Exception {
        try {
            this.conectar();
            PreparedStatement dv = this.conn.prepareStatement("INSERT INTO detalle_venta (idventa,idarticulo,cantidad,precio_venta,descuento) values (?,?,?,?,?)");
            dv.setInt(1, detalle_venta.getIdventa());
            dv.setInt(2, detalle_venta.getIdarticulo());
            dv.setInt(3, detalle_venta.getCantidad());
            dv.setDouble(4, detalle_venta.getPrecio_venta());
            dv.setDouble(5, detalle_venta.getDescuento());
            dv.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public void update(Detalle_venta detalle_venta) throws Exception {

    }

    @Override
    public void delete(int id) throws Exception {

    }

    @Override
    public Detalle_venta getById(int id) throws Exception {
        //Creamos un objeto y la instanciamos como nuevo objeto
        Detalle_venta dventa = new Detalle_venta();
        try {
            this.conectar();
            String sql = "select dv.*,a.nombre as articulo,(dv.cantidad*dv.precio_venta-dv.descuento) as subtotal from detalle_venta dv LEFT join articulo a on dv.idarticulo=a.idarticulo where dv.idventa=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                dventa.setIddetalle_venta(rs.getInt("iddetalle_venta"));
                dventa.setIdventa(rs.getInt("idventa"));
                dventa.setIdarticulo(rs.getInt("idarticulo"));
                dventa.setCantidad(rs.getInt("cantidad"));
                dventa.setPrecio_venta(rs.getDouble("precio_venta"));
                dventa.setDescuento(rs.getDouble("descuento"));
                dventa.setArticulo(rs.getString("articulo"));
                dventa.setSubtotal(rs.getDouble("subtotal"));
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return dventa;
    }

    @Override
    public List<Detalle_venta> getAllId(int id) throws Exception {
        List<Detalle_venta> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select dv.*,a.nombre as articulo,(dv.cantidad*dv.precio_venta-dv.descuento) as subtotal from detalle_venta dv LEFT join articulo a on dv.idarticulo=a.idarticulo where dv.idventa=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            lista = new ArrayList<Detalle_venta>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Detalle_venta dventa = new Detalle_venta();
                dventa.setIddetalle_venta(rs.getInt("iddetalle_venta"));
                dventa.setIdventa(rs.getInt("idventa"));
                dventa.setIdarticulo(rs.getInt("idarticulo"));
                dventa.setCantidad(rs.getInt("cantidad"));
                dventa.setPrecio_venta(rs.getDouble("precio_venta"));
                dventa.setDescuento(rs.getDouble("descuento"));
                dventa.setArticulo(rs.getString("articulo"));
                dventa.setSubtotal(rs.getDouble("subtotal"));
                lista.add(dventa);
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

    @Override
    public List<Detalle_venta> getAll() throws Exception {
        List<Detalle_venta> listaP = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "SELECT a.nombre AS nombre_producto,d.precio_venta AS precio_unitario,SUM(d.cantidad) AS c_total_vendido,SUM(d.precio_venta * d.cantidad) AS total_venta FROM venta v INNER JOIN detalle_venta d ON v.idventa = d.idventa INNER JOIN articulo a ON d.idarticulo = a.idarticulo WHERE MONTH(v.fecha_hora) = MONTH(CURRENT_DATE()) AND YEAR(v.fecha_hora) = YEAR(CURRENT_DATE()) GROUP BY d.idarticulo ORDER BY c_total_vendido DESC LIMIT 6";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();
            //Iniciamos la lista
            listaP = new ArrayList<Detalle_venta>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Detalle_venta productos_masVen = new Detalle_venta();
                productos_masVen.setArticulo(rs.getString("nombre_producto"));
                productos_masVen.setPrecio_venta(rs.getDouble("precio_unitario"));
                productos_masVen.setCantidad(rs.getInt("c_total_vendido"));
                productos_masVen.setSubtotal(rs.getDouble("total_venta"));
                listaP.add(productos_masVen);
            }
            rs.close();
            ps.close();
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return listaP;
    }

}
