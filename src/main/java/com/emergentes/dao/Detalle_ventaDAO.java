package com.emergentes.dao;

import com.emergentes.modelo.Detalle_venta;
import java.util.List;

public interface Detalle_ventaDAO {
    public void insert(Detalle_venta detalle_venta)throws Exception;
    public void update(Detalle_venta detalle_venta)throws Exception;
    public void delete(int id)throws Exception;
    public Detalle_venta getById(int id)throws Exception;
    public List<Detalle_venta>getAll()throws Exception; 
    public List<Detalle_venta>getAllId(int id)throws Exception;
}
