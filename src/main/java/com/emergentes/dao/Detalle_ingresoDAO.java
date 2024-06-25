
package com.emergentes.dao;

import com.emergentes.modelo.Detalle_ingreso;
import java.util.List;

public interface Detalle_ingresoDAO {
    public void insert(Detalle_ingreso detalle_ingreso)throws Exception;
    public void update(Detalle_ingreso detalle_ingreso)throws Exception;
    public void delete(int id)throws Exception;
    public Detalle_ingreso getById(int id)throws Exception;
    public List<Detalle_ingreso>getAll()throws Exception;
    public List<Detalle_ingreso>getAllId(int id)throws Exception;
}
