//+------------------------------------------------------------------+
//|                                        PimientoGestorEventos.mqh |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Pimient Investment"
#property link      "https://127.0.0.1"
#property strict
#property version   "1.01"

//+------------------------------------------------------------------+
//| ¡ATENCIÓN ATENCIÓN ATENCIÓN ATENCIÓN ATENCIÓN ATENCIÓN ATENCIÓN! |
//|                                                                  |
//| ESTE SCRIPT NO PUEDE SER COMPILADO, ESTÁ INTENCIONADAMENTE HECHO |
//| ASÍ. NO SE TRATA DE NINGÚN ERROR, ESTE SCRIPT POR SÍ MISMO NO ES |
//| FUNCIONAL, YA QUE SU ÚNICO PROPÓSITO DE EXISTIR ES EL DE INVOCAR |
//| LA FUNCIÓN OnBar QUE DEBERÁS COLOCAR EN EL ARCHIVO .MQ4 DE TU EA |
//| PARA TENER DISPONIBLE UN EVENTO COMO OnTick QUE SEA DISPARADO EN |
//| CUANTO SE DETECTE LA FORMACIÓN DE UNA NUEVA VELA EN EL GRÁFICO.  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Cuando el valor de Time[0] es distinto al anterior significa que |
//| se ha formado una nueva vela, en ese caso ejecutamos OnBar y     |
//| guardamos la nueva fecha hasta la siguiente vela.                |
//|                                                                  |
//| La última vela es Time[0], la anterior Time[1] y así Time[2]...  |
//| Todas las velas tiene valores Open, Close, High, Low y Time      |
//|                                                                  |
//| Mírate https://docs.mql4.com/predefined/open                     |
//+------------------------------------------------------------------+
void EjecutaOnBar()
{
    // Una variable estática no desaparce del scope, esto significa que
    // la primera vez se declarará su valor, y las siguientes ocasiones
    // se usará dicho valor pudiendose cambiar según se necesite.
    // Nunca se volverá a declarar de nuevo, esto lo realiza 1 sóla vez
    // el valor permanecerá siempre durante toda la vida del programa.
    static datetime fecha = Time[0];

    // Tener en cuenta de que nunca se ejecutará al inicio de cargar el EA
    // sólo entrará cuando la fecha de la vela anterior sea distinta a la
    // de la vela actual, es decir, literalmente cuando aparezca una vela
    if (fecha != Time[0])
    {
        fecha = Time[0];

        // Ejecutamos OnBar, mismo formato de nombre que OnInit, OnTick etc...
        OnBar();
    }
}
//+------------------------------------------------------------------+
