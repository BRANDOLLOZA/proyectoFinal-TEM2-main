package com.emergentes.dao;

import com.emergentes.modelo.Venta;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;

public class VentaDAOimpl extends ConexionBD implements VentaDAO {

    @Override
    public int insert(Venta venta) throws Exception {
        int id = 0;
        try {

            this.conectar();
            PreparedStatement ps = this.conn.prepareStatement("INSERT INTO venta (idcliente,idusuario,tipo_comprobante,serie_comprobante,num_comprobante,fecha_hora,total_venta,estado) values (?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, venta.getIdcliente());
            ps.setInt(2, venta.getIdusuario());
            ps.setString(3, venta.getTipo_comprobante());
            ps.setString(4, venta.getSerie_comprobante());
            ps.setString(5, venta.getNum_comprobante());
            ps.setDate(6, venta.getFecha_hora());
            ps.setDouble(7, venta.getTotal_venta());
            ps.setString(8, venta.getEstado());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return id;
    }

    @Override
    public void update(Venta venta) throws Exception {

    }

    @Override
    public void delete(int id) throws Exception {
        try {
            this.conectar();
            PreparedStatement ps = this.conn.prepareStatement("DELETE FROM venta WHERE idventa=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public Venta getById(int id) throws Exception {
        Venta ven = new Venta();
        try {
            this.conectar();
            String sql = "select v.*,p.nombre as cliente,u.nombre as usuario from venta v LEFT JOIN persona p ON v.idcliente=p.idpersona LEFT JOIN usuario u ON v.idusuario=u.idusuario where v.idventa=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ven.setIdventa(rs.getInt("idventa"));
                ven.setIdcliente(rs.getInt("idcliente"));
                ven.setIdusuario(rs.getInt("idusuario"));
                ven.setTipo_comprobante(rs.getString("tipo_comprobante"));
                ven.setSerie_comprobante(rs.getString("serie_comprobante"));
                ven.setNum_comprobante(rs.getString("num_comprobante"));
                ven.setFecha_hora(rs.getDate("fecha_hora"));
                ven.setTotal_venta(rs.getDouble("total_venta"));
                ven.setEstado(rs.getString("estado"));
                ven.setCliente(rs.getString("cliente"));
                ven.setUsuario(rs.getString("usuario"));

            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return ven;
    }

    @Override
    public List<Venta> getAll() throws Exception {
        //Creamos una coleccion de clientes y la instanciamos como nuevo objeto
        List<Venta> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select v.*,p.nombre as cliente,u.nombre as usuario from venta v LEFT JOIN persona p ON v.idcliente=p.idpersona LEFT JOIN usuario u ON v.idusuario=u.idusuario where p.tipo_persona='Cliente'";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();
            //Iniciamos la lista
            lista = new ArrayList<Venta>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Venta ven = new Venta();
                ven.setIdventa(rs.getInt("idventa"));
                ven.setIdcliente(rs.getInt("idcliente"));
                ven.setIdusuario(rs.getInt("idusuario"));
                ven.setTipo_comprobante(rs.getString("tipo_comprobante"));
                ven.setSerie_comprobante(rs.getString("serie_comprobante"));
                ven.setNum_comprobante(rs.getString("num_comprobante"));
                ven.setFecha_hora(rs.getDate("fecha_hora"));
                ven.setTotal_venta(rs.getDouble("total_venta"));
                ven.setEstado(rs.getString("estado"));
                ven.setCliente(rs.getString("cliente"));
                ven.setUsuario(rs.getString("usuario"));
                lista.add(ven);
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
    public Vector<Double> getVentaMes() throws Exception {
        Vector<Double> vector = new Vector<>();
        try {
            this.conectar();
            String sql = "SELECT MONTH(fecha_hora) AS mes, sum(total_venta) AS total_ventas FROM venta GROUP BY MONTH(fecha_hora)";
            PreparedStatement ps = this.conn.prepareStatement(sql);  
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                double ventas_tm = rs.getDouble("total_ventas");
                vector.add(ventas_tm);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return vector;
    }

    @Override
    public Vector<String> getMes() throws Exception {
        Vector<String> meses = new Vector<>();
        try {
            this.conectar();
            String sql = "SELECT DATE_FORMAT(fecha_hora, '%M') AS meses FROM venta WHERE YEAR(fecha_hora) = YEAR(CURDATE()) GROUP BY MONTH(fecha_hora) ORDER BY MONTH(fecha_hora);";
            PreparedStatement ps = this.conn.prepareStatement(sql);  
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String mes = rs.getString("meses");
                meses.add(mes);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return meses;
    }

}
