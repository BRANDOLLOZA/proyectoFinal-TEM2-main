package com.emergentes.dao;

import com.emergentes.modelo.Persona;
import java.util.List;

public interface ProveedorDAO {
    public void insert(Persona persona)throws Exception;
    public void update(Persona persona)throws Exception;
    public void delete(int id)throws Exception;
    public Persona getById(int id)throws Exception;
    public List<Persona>getAll()throws Exception;
    
}
