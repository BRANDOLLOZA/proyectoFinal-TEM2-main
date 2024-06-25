package com.emergentes.modelo;

import java.sql.Date;

public class IngresoAuditoria {

    private int idingreso;
    private int idproveedor;
    private int idusuario;
    private String tipo_comprobante;
    private String serie_comprobante;
    private String num_comprobante;
    private Date fecha_hora;

    private double total_compra;
    private String estado;
    private String proveedor;
    private String usuario;
    private String usuarioAud;
    private String fechaAud;
    private String estadoAud;

    public IngresoAuditoria() {
    }

    public int getIdingreso() {
        return idingreso;
    }

    public void setIdingreso(int idingreso) {
        this.idingreso = idingreso;
    }

    public int getIdproveedor() {
        return idproveedor;
    }

    public void setIdproveedor(int idproveedor) {
        this.idproveedor = idproveedor;
    }

    public int getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(int idusuario) {
        this.idusuario = idusuario;
    }

    public String getTipo_comprobante() {
        return tipo_comprobante;
    }

    public void setTipo_comprobante(String tipo_comprobante) {
        this.tipo_comprobante = tipo_comprobante;
    }

    public String getSerie_comprobante() {
        return serie_comprobante;
    }

    public void setSerie_comprobante(String serie_comprobante) {
        this.serie_comprobante = serie_comprobante;
    }

    public String getNum_comprobante() {
        return num_comprobante;
    }

    public void setNum_comprobante(String num_comprobante) {
        this.num_comprobante = num_comprobante;
    }

    public Date getFecha_hora() {
        return fecha_hora;
    }

    public void setFecha_hora(Date fecha_hora) {
        this.fecha_hora = fecha_hora;
    }

    public double getTotal_compra() {
        return total_compra;
    }

    public void setTotal_compra(double total_compra) {
        this.total_compra = total_compra;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getUsuarioAud() {
        return usuarioAud;
    }

    public void setUsuarioAud(String usuarioAud) {
        this.usuarioAud = usuarioAud;
    }

    public String getFechaAud() {
        return fechaAud;
    }

    public void setFechaAud(String fechaAud) {
        this.fechaAud = fechaAud;
    }

    public String getEstadoAud() {
        return estadoAud;
    }

    public void setEstadoAud(String estadoAud) {
        this.estadoAud = estadoAud;
    }

    @Override
    public String toString() {
        return "ingresoAuditoria{" + "idingreso=" + idingreso + ", idproveedor=" + idproveedor + ", idusuario=" + idusuario + ", tipo_comprobante=" + tipo_comprobante + ", serie_comprobante=" + serie_comprobante + ", num_comprobante=" + num_comprobante + ", fecha_hora=" + fecha_hora + ", total_compra=" + total_compra + ", estado=" + estado + ", proveedor=" + proveedor + ", usuario=" + usuario + ", usuarioAud=" + usuarioAud + ", fechaAud=" + fechaAud + ", estadoAud=" + estadoAud + '}';
    }
    
    
}
