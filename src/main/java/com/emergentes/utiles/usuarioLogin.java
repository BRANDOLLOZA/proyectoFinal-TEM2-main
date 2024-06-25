package com.emergentes.utiles;

import com.emergentes.modelo.Rol;
import com.emergentes.modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class usuarioLogin extends ConexionBD {

    public Usuario ideentificar(Usuario user) throws Exception {
        Usuario usu = null;
        Connection con = this.conectar();
        PreparedStatement pr;
       // Statement st = null;
        ResultSet rs = null;
        String sql = "select u.idusuario,u.nombre,r.nombre as rol from usuario u LEFT join rol r on u.idrol=r.idrol where u.login='" + user.getLogin() + "'and u.clave=MD5('" + user.getClave() + "')";
        try {
            pr = con.prepareStatement(sql);
            rs = pr.executeQuery();
            if (rs.next() == true) {
                usu = new Usuario();
                usu.setIdusuario(rs.getInt("idusuario"));
                usu.setNombre(rs.getString("nombre"));
                usu.setLogin(user.getLogin());
                usu.setRolC(new Rol());
                usu.getRolC().setNombre(rs.getString("rol"));
                //usu.setRol_nombre(rs.getString("rol"));
            }

        } catch (Exception e) {
            System.out.println("Error" + e.getMessage());
        } finally {
            if (rs != null && rs.isClosed()==false) {
                rs.close();
            }
            rs=null;
           
        }
       
        return usu;
    }
}
