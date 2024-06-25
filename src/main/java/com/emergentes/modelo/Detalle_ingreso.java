package com.emergentes.modelo;
public class Detalle_ingreso {
    private int iddetalle_ingreso;
    private int idingreso;
    private int idarticulo;
    private int cantidad;
    private double precio_compra;
    private double precio_venta;

    private String articulo;
    private double subtotal;
   
    public Detalle_ingreso() {
    }

    public int getIddetalle_ingreso() {
        return iddetalle_ingreso;
    }

    public void setIddetalle_ingreso(int iddetalle_ingreso) {
        this.iddetalle_ingreso = iddetalle_ingreso;
    }

    public int getIdingreso() {
        return idingreso;
    }

    public void setIdingreso(int idingreso) {
        this.idingreso = idingreso;
    }

    public int getIdarticulo() {
        return idarticulo;
    }

    public void setIdarticulo(int idarticulo) {
        this.idarticulo = idarticulo;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecio_compra() {
        return precio_compra;
    }

    public void setPrecio_compra(double precio_compra) {
        this.precio_compra = precio_compra;
    }

    public double getPrecio_venta() {
        return precio_venta;
    }

    public void setPrecio_venta(double precio_venta) {
        this.precio_venta = precio_venta;
    }

    public String getArticulo() {
        return articulo;
    }

    public void setArticulo(String articulo) {
        this.articulo = articulo;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    
}
