
package com.emergentes.modelo;

public class Usuario {
    private int idusuario;
    private String nombre;
    private String ci_documento;
    private String email;
    private String cargo;
    private String login;
    private String clave;
    private int condicion;
    private int idrol;
    private String rol_nombre;
    private Rol rolC;
    public Usuario() {
        this.idusuario=0;
        this.nombre="";
        this.ci_documento="";
        this.email="";
        this.cargo="";
        this.login="";
        this.clave="";
        this.condicion=0;
        this.idrol=0;
        this.rol_nombre="";
    }

    public int getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(int idusuario) {
        this.idusuario = idusuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCi_documento() {
        return ci_documento;
    }

    public void setCi_documento(String ci_documento) {
        this.ci_documento = ci_documento;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public int getCondicion() {
        return condicion;
    }

    public void setCondicion(int condicion) {
        this.condicion = condicion;
    }

    public int getIdrol() {
        return idrol;
    }

    public void setIdrol(int idrol) {
        this.idrol = idrol;
    }

    public String getRol_nombre() {
        return rol_nombre;
    }

    public void setRol_nombre(String rol_nombre) {
        this.rol_nombre = rol_nombre;
    }

    public Rol getRolC() {
        return rolC;
    }

    public void setRolC(Rol rolC) {
        this.rolC = rolC;
    }
    
}
    