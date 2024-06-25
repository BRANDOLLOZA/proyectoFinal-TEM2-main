package com.emergentes.dao;

import com.emergentes.modelo.Venta;
import java.util.List;
import java.util.Vector;

public interface VentaDAO {
    public int insert(Venta venta)throws Exception;
    public void update(Venta venta)throws Exception;
    public void delete(int id)throws Exception;
    public Venta getById(int id)throws Exception;
    public List<Venta>getAll()throws Exception;
    public Vector<Double> getVentaMes()throws Exception;
    public Vector<String> getMes()throws Exception;
}
