
package com.emergentes.modelo;
public class Rol {
    private int idrol;
    private String nombre;
    private String descripcion;

    public Rol() {
        this.idrol=0;
        this.nombre="";
        this.descripcion="";
    }

    public int getIdrol() {
        return idrol;
    }

    public void setIdrol(int idrol) {
        this.idrol = idrol;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
}
