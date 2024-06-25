package com.emergentes.dao;

import com.emergentes.modelo.Persona;
import com.emergentes.utiles.ConexionBD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAOimpl extends ConexionBD implements ClienteDAO {

    @Override
    public void insert(Persona persona) throws Exception {
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "insert into persona (tipo_persona,nombre,ci_documento,direccion,telefono,email) values (?,?,?,?,?,?)";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setString(1, persona.getTipo_persona());
            ps.setString(2, persona.getNombre());
            ps.setString(3, persona.getCi_documento());
            ps.setString(4, persona.getDireccion());
            ps.setString(5, persona.getTelefono());
            ps.setString(6, persona.getEmail());
            ps.executeUpdate();
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
    }

    @Override
    public void update(Persona persona) throws Exception {
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "update persona set tipo_persona=? ,nombre=?,ci_documento=?,direccion=?,telefono=?,email=? where idpersona=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setString(1, persona.getTipo_persona());
            ps.setString(2, persona.getNombre());
            ps.setString(3, persona.getCi_documento());
            ps.setString(4, persona.getDireccion());
            ps.setString(5, persona.getTelefono());
            ps.setString(6, persona.getEmail());
            ps.setInt(7, persona.getIdpersona());
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
            String sql = "delete from persona where idpersona=?";
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
    public Persona getById(int id) throws Exception {
        //Creamos un objeto y la instanciamos como nuevo objeto
        Persona per = new Persona();
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select * from persona where idpersona=?";
            PreparedStatement ps = this.conn.prepareStatement(sql);
            //Del objeto cliente vamos obteniendo los valores
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            //Si hay un registro entonces lo leemos y lo pondremos el el objeto cli
            if (rs.next()) {
                per.setIdpersona(rs.getInt("idpersona"));
                per.setTipo_persona(rs.getString("tipo_persona"));
                per.setNombre(rs.getString("nombre"));
                per.setCi_documento(rs.getString("Ci_documento"));
                per.setDireccion(rs.getString("direccion"));
                per.setTelefono(rs.getString("telefono"));
                per.setEmail(rs.getString("email"));
            }
            //Recomendable usar un try cath
        } catch (Exception e) {
            throw e;
        } finally {
            this.desconectar();
        }
        return per;
    }

    @Override
    public List<Persona> getAll() throws Exception {
        //Creamos una coleccion de clientes y la instanciamos como nuevo objeto
        List<Persona> lista = null;
        try {
            //Como es una extencion de conectar se paso todos los metodos para utilizar
            this.conectar();
            String sql = "select * from persona where tipo_persona ='Cliente' ";
            PreparedStatement ps = this.conn.prepareStatement(sql);

            //Se tiene el resultado en rs    
            ResultSet rs = ps.executeQuery();

            //Iniciamos la lista
            lista = new ArrayList<Persona>();

            //Cambiamos el if por while al ser mas de un registro
            while (rs.next()) {
                //Instanciasmo un nuevo objeto
                Persona per = new Persona();
                per.setIdpersona(rs.getInt("idpersona"));
                per.setTipo_persona(rs.getString("tipo_persona"));
                per.setNombre(rs.getString("nombre"));
                per.setCi_documento(rs.getString("Ci_documento"));
                per.setDireccion(rs.getString("direccion"));
                per.setTelefono(rs.getString("telefono"));
                per.setEmail(rs.getString("email"));

                lista.add(per);
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
