package com.emergentes.utiles;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    //Establecemos el driver para conectarnos a la base de datos
    static public String driver = "com.mysql.cj.jdbc.Driver";
    //Establecer la direccion de conexion
    static public String url = "jdbc:mysql://localhost:3306/db_sistema";
    //Establece el Usuario
    static public String usuario = "root";
    //Establece la contraseña
    static public String password = "";

    //Variable de alcance protected (Permite gestionar la conexion)
    protected Connection conn = null; //Necesita libreria

    //Creamos el contructori
    public ConexionBD() {
        try {
            //Especificar el driver de la base de datos
            Class.forName(driver);
            //Mandamos lo parametro sde connexion
            conn = DriverManager.getConnection(url, usuario, password);
        } catch (ClassNotFoundException ex) {
            System.out.println("Error en el Driver" + ex.getMessage());
        } catch (SQLException ex) {
            System.out.println("Error al realizar la conexion" + ex.getMessage());
        }
    }
    //Creamos un metodo para devolvernos la conexion
    public Connection conectar() {
        //Retornar el valor de la propiedad conexion
        return conn;
    }

    //Creamos un metodo para desconectar o cerrar
    public void desconectar() {
        try {
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Error al cerrar la conexion: " + ex.getMessage());
        }
    }
}
