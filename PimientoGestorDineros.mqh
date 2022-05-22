//+------------------------------------------------------------------+
//|                                        PimientoGestorDineros.mqh |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Pimient Investment"
#property link      "https://127.0.0.1"
#property strict
#property version   "1.01"

//+------------------------------------------------------------------+
//| El gestor del dinero, aquí es dónde se coloca las funciones para |
//| ayudarte a gestionar la salud de la cuenta, por ejemplo no tener |
//| mas de un 70% de margen comprometido o no usar mas de un 1% para |
//| cada operación como pérdida. Para los cálculos usamos siempre el |
//| balance en lugar del equity por una sencilla razón, hasta que no |
//| cierras las órdenes el flotante actual no pasa a formar parte de |
//| tu balance, y esto puede comprometer la cuenta si tu equity sube |
//| mucho y finalmente no lo cierras con esos valores, habrías sobre |
//| comprometido el capital real de tu cuenta, sin llegar a tenerlo. |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Incluímos los distintos gestores                                 |
//+------------------------------------------------------------------+
#include "PimientoGestorSimbolo.mqh"
#include "PimientoGestorValores.mqh"

//+------------------------------------------------------------------+
//| Una cuenta saludable no compromete mas del 70% del capital       |
//+------------------------------------------------------------------+
bool DisponemosDeMargenLibre()
{
    return AccountFreeMargin() > AccountBalance() * 0.3;
}

//+------------------------------------------------------------------+
//| Una cuenta saludable no arriesga mas del 1% por operación        |
//+------------------------------------------------------------------+
double MaximaPerdidaPorOperacion()
{
    return AccountBalance() * 0.01;
}
//+------------------------------------------------------------------+