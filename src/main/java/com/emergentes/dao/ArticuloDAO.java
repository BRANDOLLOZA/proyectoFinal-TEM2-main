package com.emergentes.dao;

import com.emergentes.modelo.Articulo;
import java.util.List;

public interface ArticuloDAO {
   public void insert(Articulo articulo)throws Exception;
    public void update(Articulo articulo)throws Exception;
    public void delete(int id)throws Exception;
    public Articulo getById(int id)throws Exception;
    public List<Articulo>getAll()throws Exception; 
    public List<Articulo>getAllStock()throws Exception;
}
