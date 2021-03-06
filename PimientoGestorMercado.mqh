//+------------------------------------------------------------------+
//|                                        PimientoGestorMercado.mqh |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Pimient Investment"
#property link      "https://127.0.0.1"
#property strict
#property version   "1.01"

//+------------------------------------------------------------------+
//| El cuadro de interruptores, es aquí, y únicamente aquí, en dónde |
//| tendrás que cambiar, una sóla línea, para cambiar el modo en que |
//| opera tu robot, por ejemplo al comprar, para que en lugar de     |
//| hacerlo usando la estrategia A, lo haga usando una nueva y mejor |
//| estrategia B, así no tendrás que borrar o comentar la estrategia |
//| A, y podrás mantenerla para analizarla, mejorarla o incluso para |
//| hacer distintas versiones del mismo robot según vayan surgiendo  |
//| tus necesidades de trading.                                      |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Incluímos los distintos gestores                                 |
//+------------------------------------------------------------------+
#include "PimientoGestorNegocio.mqh"

//+------------------------------------------------------------------+
//| Aquí es donde decides que estrategia se usará para la cobertura  |
//+------------------------------------------------------------------+
void DecideSiCobertura()
{
    CoberturaSegunEstrategia(ESTRATEGIA_A);
}

//+------------------------------------------------------------------+
//| Aquí es donde decides que estrategia se usará para las compras   |
//+------------------------------------------------------------------+
void DecideSiComprar()
{
    CompraSegunEstrategia(ESTRATEGIA_A);
}

//+------------------------------------------------------------------+
//| Aquí es donde decides que estrategia se usará para los cierres   |
//+------------------------------------------------------------------+
void DecideSiCerrar()
{
    CierraSegunEstrategia(ESTRATEGIA_A);
}

//+------------------------------------------------------------------+
//| Aquí es donde decides que estrategia se usará para las ordenes   |
//+------------------------------------------------------------------+
bool DecideSiOperar(const int ticketDeOrden, const int tipoDeOrden, const double resultadoDeOrden, const double stopLossDeOrden, const double takeProfitDeOrden, const double lotsDeOrden)
{
    return OperaSegunEstrategia(ESTRATEGIA_B, ticketDeOrden, tipoDeOrden, resultadoDeOrden, stopLossDeOrden, takeProfitDeOrden, lotsDeOrden);
}

//+------------------------------------------------------------------+
//| Aquí es donde decides que estrategia se usará para los stop loss |
//+------------------------------------------------------------------+
void DecideSiProteger()
{
    ProtegeSegunEstrategia(ESTRATEGIA_B);
}

//+------------------------------------------------------------------+
//| Aquí es donde decides que estrategia se usará para las ventas    |
//+------------------------------------------------------------------+
void DecideSiVender()
{
    VendeSegunEstrategia(ESTRATEGIA_A);
}
//+------------------------------------------------------------------+
