package com.emergentes.dao;

import com.emergentes.modelo.Ingreso;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class IngresoDAOimpl extends ConexionBD implements IngresoDAO {

    @Override
    public int insert(Ingreso ingreso) throws Exception {
        int id = 0;
        try {
            this.conectar();
            PreparedStatement ps = this.conn.prepareStatement("INSERT INTO ingreso (idproveedor,idusuario,tipo_comprobante,serie_comprobante,num_comprobante,fecha_hora,total_compra,estado) values (?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, ingreso.getIdproveedor());
            ps.setInt(2, ingreso.getIdusuario());
            ps.setString(3, ingreso.getTipo_comprobante());
            ps.setString(4, ingreso.getSerie_comprobante());
            ps.setString(5, ingreso.getNum_comprobante());
            ps.setDate(6, ingreso.getFecha_hora());
            ps.setDouble(7, ingreso.getTotal_compra());
            ps.setString(8, ingreso.getEstado());
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
    public void update(Ingreso ingreso) throws Exception {

    }

    @Override
    public void delete(int id) throws Exception {
        try {
            this.conectar();
            PreparedStatement ps = this.conn.prepareStatement("DELETE FROM ingresso WHERE idingreso=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public Ingreso getById(int id) throws Exception {
        Ingreso ingre = new Ingreso();
        try {
            this.conectar();
            String sql = "select i.*,p.nombre as proveedor,u.nombre as usuario from ingreso i LEFT JOIN persona p ON i.idproveedor=p.idpersona LEFT JOIN usuario u ON i.idusuario=u.idusuario where i.idingreso=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ingre.setIdingreso(rs.getInt("idingreso"));
                ingre.setIdproveedor(rs.getInt("idproveedor"));
                ingre.setIdusuario(rs.getInt("idusuario"));
                ingre.setTipo_comprobante(rs.getString("tipo_comprobante"));
                ingre.setSerie_comprobante(rs.getString("serie_comprobante"));
                ingre.setNum_comprobante(rs.getString("num_comprobante"));
                ingre.setFecha_hora(rs.getDate("fecha_hora"));
                ingre.setTotal_compra(rs.getDouble("total_compra"));
                ingre.setEstado(rs.getString("estado"));
                ingre.setProveedor(rs.getString("proveedor"));
                ingre.setUsuario(rs.getString("usuario"));

            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return ingre;
    }

    @Override
    public List<Ingreso> getAll() throws Exception {
        List<Ingreso> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select i.*,p.nombre as proveedor,u.nombre as usuario from ingreso i LEFT JOIN persona p ON i.idproveedor=p.idpersona LEFT JOIN usuario u ON i.idusuario=u.idusuario";
            PreparedStatement ps = this.conn.prepareStatement(sql);   
            ResultSet rs = ps.executeQuery();
            lista = new ArrayList<Ingreso>();
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Ingreso ingre = new Ingreso();
                ingre.setIdingreso(rs.getInt("idingreso"));
                ingre.setIdproveedor(rs.getInt("idproveedor"));
                ingre.setIdusuario(rs.getInt("idusuario"));
                ingre.setTipo_comprobante(rs.getString("tipo_comprobante"));
                ingre.setSerie_comprobante(rs.getString("serie_comprobante"));
                ingre.setNum_comprobante(rs.getString("num_comprobante"));
                ingre.setFecha_hora(rs.getDate("fecha_hora"));
                ingre.setTotal_compra(rs.getDouble("total_compra"));
                ingre.setEstado(rs.getString("estado"));
                ingre.setProveedor(rs.getString("proveedor"));
                ingre.setUsuario(rs.getString("usuario"));
                lista.add(ingre);
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
    public Vector<Double> getCompraMes() throws Exception {
       Vector<Double> ventasMes = new Vector<>();
        try {
            this.conectar();
            String sql = "SELECT MONTH(fecha_hora) AS mes, sum(total_compra) AS total_compras FROM ingreso GROUP BY MONTH(fecha_hora)";
            PreparedStatement ps = this.conn.prepareStatement(sql);  
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                double compra_tm = rs.getDouble("total_compras");
                ventasMes.add(compra_tm);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return ventasMes;
    }

    @Override
    public Vector<String> getMesC() throws Exception {
       Vector<String> meses = new Vector<>();
        try {
            this.conectar();
            String sql = "SELECT DATE_FORMAT(fecha_hora, '%M') AS meses FROM ingreso  GROUP BY MONTH(fecha_hora)";
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
