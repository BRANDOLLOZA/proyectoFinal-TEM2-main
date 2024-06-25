package com.emergentes.dao;

import com.emergentes.modelo.Detalle_ingreso;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Detalle_ingresoDAOimpl extends ConexionBD implements Detalle_ingresoDAO {

    @Override
    public void insert(Detalle_ingreso detalle_ingreso) throws Exception {
        try {
            this.conectar();
            PreparedStatement dv = this.conn.prepareStatement("INSERT INTO detalle_ingreso (idingreso,idarticulo,cantidad,precio_compra,precio_venta) values (?,?,?,?,?)");
            dv.setInt(1, detalle_ingreso.getIdingreso());
            dv.setInt(2, detalle_ingreso.getIdarticulo());
            dv.setInt(3, detalle_ingreso.getCantidad());
            dv.setDouble(4, detalle_ingreso.getPrecio_compra());
            dv.setDouble(5, detalle_ingreso.getPrecio_venta());
            dv.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public void update(Detalle_ingreso detalle_ingreso) throws Exception {

    }

    @Override
    public void delete(int id) throws Exception {

    }

    @Override
    public Detalle_ingreso getById(int id) throws Exception {
        Detalle_ingreso dingreso = new Detalle_ingreso();
        try {
            this.conectar();
            String sql = "select di.*,a.nombre as articulo,(di.cantidad*di.precio_compra) as subtotal from detalle_ingreso di LEFT join articulo a on di.idarticulo=a.idarticulo where di.idingreso=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                dingreso.setIddetalle_ingreso(rs.getInt("iddetalle_ingreso"));
                dingreso.setIdingreso(rs.getInt("idingreso"));
                dingreso.setIdarticulo(rs.getInt("idarticulo"));
                dingreso.setCantidad(rs.getInt("cantidad"));
                dingreso.setPrecio_compra(rs.getDouble("precio_compra"));
                dingreso.setPrecio_venta(rs.getDouble("precio_venta"));
                dingreso.setArticulo(rs.getString("articulo"));
                dingreso.setSubtotal(rs.getDouble("subtotal"));
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return dingreso;
    }

    @Override
    public List<Detalle_ingreso> getAll() throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Detalle_ingreso> getAllId(int id) throws Exception {
        List<Detalle_ingreso> lista = null;
        try {
            this.conectar();
            String sql = "select di.*,a.nombre as articulo,(di.cantidad*di.precio_compra) as subtotal from detalle_ingreso di LEFT join articulo a on di.idarticulo=a.idarticulo where di.idingreso=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            lista = new ArrayList<Detalle_ingreso>();
            while (rs.next()) {
                Detalle_ingreso dingreso = new Detalle_ingreso();
                dingreso.setIddetalle_ingreso(rs.getInt("iddetalle_ingreso"));
                dingreso.setIdingreso(rs.getInt("idingreso"));
                dingreso.setIdarticulo(rs.getInt("idarticulo"));
                dingreso.setCantidad(rs.getInt("cantidad"));
                dingreso.setPrecio_compra(rs.getDouble("precio_compra"));
                dingreso.setPrecio_venta(rs.getDouble("precio_venta"));
                dingreso.setArticulo(rs.getString("articulo"));
                dingreso.setSubtotal(rs.getDouble("subtotal"));
                lista.add(dingreso);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return lista;
    }
}
