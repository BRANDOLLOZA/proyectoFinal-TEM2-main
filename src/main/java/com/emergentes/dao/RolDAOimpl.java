package com.emergentes.dao;

import com.emergentes.modelo.Rol;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RolDAOimpl extends ConexionBD implements RolDAO {

    @Override
    public void insert(Rol rol) throws Exception {
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "insert into rol (nombre,descripcion) values (?,?)";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setString(1, rol.getNombre());
            ps.setString(2, rol.getDescripcion());
            ps.executeUpdate();
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public void update(Rol rol) throws Exception {
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "update rol set nombre=? ,descripcion=? where idrol=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setString(1, rol.getNombre());
            ps.setString(2, rol.getDescripcion());
            ps.setInt(3, rol.getIdrol());
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
            String sql = "delete from rol where idrol=?";
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
    public Rol getById(int id) throws Exception {
        //Creamos un objeto y la instanciamos como nuevo objeto
        Rol rol = new Rol();
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select * from rol where idrol=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            //Si hay un registro entonces lo leemos y lo pondremos el el objeto cli
            if (rs.next()) {
                rol.setIdrol(rs.getInt("idrol"));
                rol.setNombre(rs.getString("nombre"));
                rol.setDescripcion(rs.getString("descripcion"));
            }
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return rol;
    }

    @Override
    public List<Rol> getAll() throws Exception {
        //Creamos una coleccion de clientes y la instanciamos como nuevo objeto
        List<Rol> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select * from rol";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();
            //Iniciamos la lista
            lista = new ArrayList<Rol>();
            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Rol ro = new Rol();
                ro.setIdrol(rs.getInt("idrol"));
                ro.setNombre(rs.getString("nombre"));
                ro.setDescripcion(rs.getString("descripcion"));
                lista.add(ro);
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
