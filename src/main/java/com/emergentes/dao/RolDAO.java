/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.emergentes.dao;

import com.emergentes.modelo.Rol;
import java.util.List;

/**
 *
 * @author German
 */
public interface RolDAO {

    public void insert(Rol rol) throws Exception;

    public void update(Rol rol) throws Exception;

    public void delete(int id) throws Exception;

    public Rol getById(int id) throws Exception;

    public List<Rol> getAll() throws Exception;
}
