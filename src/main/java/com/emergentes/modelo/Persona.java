package com.emergentes.modelo;

public class Persona {

    private int idpersona;
    private String tipo_persona;
    private String nombre;
    private String ci_documento;
    private String direccion;
    private String telefono;
    private String email;

    public Persona() {
        this.idpersona = 0;
        this.tipo_persona = "";
        this.nombre = "";
        this.ci_documento = "";
        this.direccion = "";
        this.telefono = "";
        this.email = "";
    }


    public int getIdpersona() {
        return idpersona;
    }

    public void setIdpersona(int idpersona) {
        this.idpersona = idpersona;
    }

    public String getTipo_persona() {
        return tipo_persona;
    }

    public void setTipo_persona(String tipo_persona) {
        this.tipo_persona = tipo_persona;
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

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Persona{" + "idpersona=" + idpersona + ", tipo_persona=" + tipo_persona + ", nombre=" + nombre + ", ci_documento=" + ci_documento + ", direccion=" + direccion + ", telefono=" + telefono + ", email=" + email + '}';
    }

}
