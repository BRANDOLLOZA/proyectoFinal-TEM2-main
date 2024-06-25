package com.emergentes.utiles;

import java.util.Date;
import java.text.SimpleDateFormat;

public class Conversiones {

    private static final String FORMATO_FECHA = "dd-MM-yyyy HH:mm:ss";
    
    public static String formatearFecha(Date fecha) {
        SimpleDateFormat formateador = new SimpleDateFormat(FORMATO_FECHA);
        return formateador.format(fecha);
    }
}

