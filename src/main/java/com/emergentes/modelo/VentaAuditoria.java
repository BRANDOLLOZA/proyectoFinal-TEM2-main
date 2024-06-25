package com.emergentes.modelo;

import java.sql.Date;

public class VentaAuditoria {

    private int idventa;
    private int idcliente;
    private int idusuario;
    private String tipo_comprobante;
    private String serie_comprobante;
    private String num_comprobante;
    private Date fecha_hora;
    private double total_venta;
    private String estado;
    private String cliente;
    private String usuario;
    private double total_venta_mes;
    private String usuarioAud;
    private String fechaAud;
    private String estadoAud;

    public VentaAuditoria() {
    }

    public int getIdventa() {
        return idventa;
    }

    public void setIdventa(int idventa) {
        this.idventa = idventa;
    }

    public int getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(int idcliente) {
        this.idcliente = idcliente;
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

    public double getTotal_venta() {
        return total_venta;
    }

    public void setTotal_venta(double total_venta) {
        this.total_venta = total_venta;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public double getTotal_venta_mes() {
        return total_venta_mes;
    }

    public void setTotal_venta_mes(double total_venta_mes) {
        this.total_venta_mes = total_venta_mes;
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
        return "ventaAuditoria{" + "idventa=" + idventa + ", idcliente=" + idcliente + ", idusuario=" + idusuario + ", tipo_comprobante=" + tipo_comprobante + ", serie_comprobante=" + serie_comprobante + ", num_comprobante=" + num_comprobante + ", fecha_hora=" + fecha_hora + ", total_venta=" + total_venta + ", estado=" + estado + ", cliente=" + cliente + ", usuario=" + usuario + ", total_venta_mes=" + total_venta_mes + ", usuarioAud=" + usuarioAud + ", fechaAud=" + fechaAud + ", estadoAud=" + estadoAud + '}';
    }

}
