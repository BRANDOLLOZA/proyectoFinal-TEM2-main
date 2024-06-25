package com.emergentes.dao;

import com.emergentes.modelo.IngresoAuditoria;
import com.emergentes.modelo.VentaAuditoria;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ventaAuditoriaDAOimpl extends ConexionBD {

    public List<VentaAuditoria> getAllAuditoriaVentas() throws Exception {
        //Creamos una coleccion de clientes y la instanciamos como nuevo objeto
        List<VentaAuditoria> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select v.*,p.nombre as cliente,u.nombre as usuario from ventaauditoria v LEFT JOIN persona p ON v.idcliente=p.idpersona LEFT JOIN usuario u ON v.idusuario=u.idusuario";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();
            //Iniciamos la lista
            lista = new ArrayList<VentaAuditoria>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                VentaAuditoria venAud = new VentaAuditoria();
                venAud.setIdventa(rs.getInt("idventa"));
                venAud.setIdcliente(rs.getInt("idcliente"));
                venAud.setIdusuario(rs.getInt("idusuario"));
                venAud.setTipo_comprobante(rs.getString("tipo_comprobante"));
                venAud.setSerie_comprobante(rs.getString("serie_comprobante"));
                venAud.setNum_comprobante(rs.getString("num_comprobante"));
                venAud.setFecha_hora(rs.getDate("fecha_hora"));
                venAud.setTotal_venta(rs.getDouble("total_venta"));
                venAud.setEstado(rs.getString("estado"));
                venAud.setCliente(rs.getString("cliente"));
                venAud.setUsuario(rs.getString("usuario"));
                venAud.setUsuarioAud(rs.getString("usuarioAud"));
                venAud.setFechaAud(rs.getString("fechaAud"));
                venAud.setEstadoAud(rs.getString("estadoAud"));

                lista.add(venAud);
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

    public List<IngresoAuditoria> getAllAuditoriaIngreso() throws Exception {
        //Creamos una coleccion de clientes y la instanciamos como nuevo objeto
        List<IngresoAuditoria> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select i.*,p.nombre as proveedor,u.nombre as usuario from ingresoauditoria i LEFT JOIN persona p ON i.idproveedor=p.idpersona LEFT JOIN usuario u ON i.idusuario=u.idusuario";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();
            //Iniciamos la lista
            lista = new ArrayList<IngresoAuditoria>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                IngresoAuditoria ingreAud = new IngresoAuditoria();
                ingreAud.setIdingreso(rs.getInt("idingreso"));
                ingreAud.setIdproveedor(rs.getInt("idproveedor"));
                ingreAud.setIdusuario(rs.getInt("idusuario"));
                ingreAud.setTipo_comprobante(rs.getString("tipo_comprobante"));
                ingreAud.setSerie_comprobante(rs.getString("serie_comprobante"));
                ingreAud.setNum_comprobante(rs.getString("num_comprobante"));
                ingreAud.setFecha_hora(rs.getDate("fecha_hora"));
                ingreAud.setTotal_compra(rs.getDouble("total_compra"));
                ingreAud.setEstado(rs.getString("estado"));
                ingreAud.setProveedor(rs.getString("proveedor"));
                ingreAud.setUsuario(rs.getString("usuario"));
                ingreAud.setUsuarioAud(rs.getString("usuarioAud"));
                ingreAud.setFechaAud(rs.getString("fechaAud"));
                ingreAud.setEstadoAud(rs.getString("estadoAud"));
                lista.add(ingreAud);
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
