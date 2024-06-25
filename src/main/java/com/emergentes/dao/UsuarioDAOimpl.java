package com.emergentes.dao;

import com.emergentes.modelo.Usuario;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAOimpl extends ConexionBD implements UsuarioDAO {

    @Override
    public void insert(Usuario usuario) throws Exception {
        try {
            this.conectar();
            PreparedStatement ps = this.conn.prepareStatement("INSERT INTO usuario (nombre,ci_documento,email,cargo,login,clave,condicion,idrol) values (?,?,?,?,?,md5(?),?,?)");
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getCi_documento());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getCargo());
            ps.setString(5, usuario.getLogin());
            ps.setString(6, usuario.getClave());
            ps.setInt(7, usuario.getCondicion());
            ps.setInt(8, usuario.getIdrol());
            ps.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public void update(Usuario usuario) throws Exception {
        try {
            this.conectar();
            PreparedStatement ps = this.conn.prepareStatement("UPDATE usuario SET nombre=?, ci_documento=?, email=?,cargo=?,login=?,clave=md5(?),condicion=?,idrol=? WHERE idusuario=?");

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getCi_documento());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getCargo());
            ps.setString(5, usuario.getLogin());
            ps.setString(6, usuario.getClave());
            ps.setInt(7, usuario.getCondicion());
            ps.setInt(8, usuario.getIdrol());
            ps.setInt(9, usuario.getIdusuario());
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
            PreparedStatement ps = this.conn.prepareStatement("DELETE FROM usuario WHERE idusuario=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public Usuario getById(int id) throws Exception {
        //Creamos un objeto y la instanciamos como nuevo objeto
        Usuario us = new Usuario();
        try {
            this.conectar();
            String sql = "select u.*,r.nombre as rol_nombre from usuario u LEFT JOIN rol r ON u.idrol=r.idrol where idusuario=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                us.setIdusuario(rs.getInt("idusuario"));
                us.setNombre(rs.getString("nombre"));
                us.setCi_documento(rs.getString("ci_documento"));
                us.setEmail(rs.getString("email"));
                us.setCargo(rs.getString("cargo"));
                us.setLogin(rs.getString("login"));
                us.setCondicion(rs.getInt("condicion"));
                us.setIdrol(rs.getInt("idrol"));
                us.setRol_nombre(rs.getString("rol_nombre"));
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return us;
    }

    @Override
    public List<Usuario> getAll() throws Exception {
        //Creamos una coleccion de clientes y la instanciamos como nuevo objeto
        List<Usuario> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select u.*,r.nombre as rol_nombre from usuario u LEFT JOIN rol r ON u.idrol=r.idrol";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();
            //Iniciamos la lista
            lista = new ArrayList<Usuario>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Usuario us = new Usuario();
                us.setIdusuario(rs.getInt("idusuario"));
                us.setNombre(rs.getString("nombre"));
                us.setCi_documento(rs.getString("ci_documento"));
                us.setEmail(rs.getString("email"));
                us.setCargo(rs.getString("cargo"));
                us.setLogin(rs.getString("login"));
                us.setCondicion(rs.getInt("condicion"));
                us.setIdrol(rs.getInt("idrol"));
                us.setRol_nombre(rs.getString("rol_nombre"));
                lista.add(us);
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
