//+------------------------------------------------------------------+
//|                                        PimientoGestorOrdenes.mqh |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Pimient Investment"
#property link      "https://127.0.0.1"
#property strict
#property version   "1.01"

//+------------------------------------------------------------------+
//| El gestor de órdenes, sólo se encargará de recopilar información |
//| y almacenarla en métodos que podrás consultar de forma muy clara |
//| y descriptiva para así construir tus estrategias, en un lenguaje |
//| muy sencillo y natural 100% Español y fácil de entender.         |
//|                                                                  |
//| Este código no tiene niguna lógica de negocio sólo son un par de |
//| métodos para abrir, cerrar o proteger órdenes, no tendrán ningún |
//| tipo de lógica y no necesitarás modificar o implementar nada.    |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Importamos las funciones para evitar una dependencia cíclica     |
//+------------------------------------------------------------------+
#import "PimientoGestorMercado.mqh"
bool DecideSiOperar(const int ticketDeOrden, const int tipoDeOrden, const double resultadoDeOrden, const double stopLossDeOrden, const double takeProfitDeOrden, const double lotsDeOrden);
#import

//+------------------------------------------------------------------+
//| Incluímos los distintos gestores                                 |
//+------------------------------------------------------------------+
#include "PimientoGestorDineros.mqh"
// Librería de MT4 para transformar códigos de error a frases de texto
#include <stdlib.mqh>

//+------------------------------------------------------------------+
//| El único bucle que existe en el código para procesar las ordenes |
//+------------------------------------------------------------------+
void CargaDatosDeOrdenes()
{
    // Siempre antes de cada iteración ponemos todos los valores a cero
    // Estos valores són genéricos para todas las estrategias, si por
    // algún casual necesitas implementar algo más específíco por la
    // naturaleza de tu estrategia, como por ejemplo saber si la última
    // orden fué de compra o de venta, o incluso a que precio se abrió
    // sólo tienes que irte al gestor de valores y declarar la nueva
    // variable que guardará dicho valor, con el mismo formato que el
    // resto que hay ahora de ejemplo, y una vez declarada ejecutar el
    // script generador de setters y getters que te crearán funciones
    // de forma automática útiles para el tipo de valor que hayas
    // declarado en la nueva variable que has agregado.
    vaciaOrdenesParaProteger();
    guardaBeneficioDeCompras(0);
    guardaBeneficioDeVentas(0);
    guardaBeneficioTotal(0);
    guardaOrdenesDeCompraAbiertas(0);
    guardaOrdenesDeCompraProtegidas(0);
    guardaOrdenesDeVentaAbiertas(0);
    guardaOrdenesDeVentaProtegidas(0);
    guardaPerdidaDeCompras(0);
    guardaPerdidaDeVentas(0);
    guardaPerdidaTotal(0);
    guardaSoloHayCompras(true);
    guardaSoloHayVentas(true);

    // Recorremos todas las ordenes por posición de la última a la primera
    for (int i = OrdersTotal() - 1; i >= 0; i--)
    {
        // Si por alguna extraña razón la orden ya no existe continuamos
        if (!OrderSelect(i, SELECT_BY_POS))
        {
            Print("Ocurrió un error extraño, la orden con posición #" + IntegerToString(i) + " no se pudo seleccionar");

            continue;
        }

        // Sólo atendemos a las órdenes que correspondan al símbolo actual
        // Podría usar el magic number pero no veo razón alguna para hacerlo
        if (OrderSymbol() != Symbol())
        {
            continue;
        }

        // Guardamos los valores de la orden actual para su procesamiento
        double lotsDeOrden       = OrderLots();
        double precioDeOrden     = OrderOpenPrice();
        double resultadoDeOrden  = OrderProfit() - MathAbs(OrderCommission()) - MathAbs(OrderSwap());
        double stopLossDeOrden   = OrderStopLoss();
        double takeProfitDeOrden = OrderTakeProfit();
        int    ticketDeOrden     = OrderTicket();
        int    tipoDeOrden       = OrderType();

        // Aquí llamamos a la función especial del gestor de mercado, lee la documentación de la misma
        // Como ves si nos devuelve un true no tenemos en cuenta la orden actual para guardado de datos
        // es dentro de esta función en donde determinamos si una orden deberá ser protegida o no según
        // tu estrategia, para protegerla sólo hay que llamar a agregaOrdenesParaProteger(ticketDeOrden)
        // dentro del bloque de tu estrategia de la función OperaSegunEstrategia en el gestor de negocio
        if (DecideSiOperar(ticketDeOrden, tipoDeOrden, resultadoDeOrden, stopLossDeOrden, takeProfitDeOrden, lotsDeOrden))
        {
            continue;
        }

        // Guardamos si solo hay ventas o compras, una cancela a la otra
        guardaSoloHayCompras(SoloHayCompras() && OP_BUY == tipoDeOrden);
        guardaSoloHayVentas(SoloHayVentas() && OP_SELL == tipoDeOrden);

        // Si es una orden de compra (no soporta buy stop o buy limit)
        if (OP_BUY == tipoDeOrden)
        {
            // Incrementamos el total de ordenes de compra abiertas
            aumentaOrdenesDeCompraAbiertas();

            // Si el resultado de la orden de compra es positivo
            if (0 < resultadoDeOrden)
            {
                sumaBeneficioDeCompras(resultadoDeOrden);
            }
            // o si por el contrario la compra está en negativo
            else
            {
                sumaPerdidaDeCompras(resultadoDeOrden);
            }

            // Si la orden de compra tiene stop loss
            if (stopLossDeOrden)
            {
                aumentaOrdenesDeCompraProtegidas();
            }
        }

        // Si es una orden de venta (no soporta sell stop o sell limit)
        if (OP_SELL == tipoDeOrden)
        {
            // Incrementamos el total de ordenes de venta abiertas
            aumentaOrdenesDeVentaAbiertas();

            // Si el resultado de la orden de venta es positivo
            if (0 < resultadoDeOrden)
            {
                sumaBeneficioDeVentas(resultadoDeOrden);
            }
            // o si por el contrario la venta está en negativo
            else
            {
                sumaPerdidaDeVentas(resultadoDeOrden);
            }

            // Si la orden de venta tiene stop loss
            if (stopLossDeOrden)
            {
                aumentaOrdenesDeVentaProtegidas();
            }
        }

        // Si el resultado de la orden es positivo
        if (0 < resultadoDeOrden)
        {
            sumaBeneficioTotal(resultadoDeOrden);
        }
        // o si por el contrario está en negativo
        else
        {
            sumaPerdidaTotal(resultadoDeOrden);
        }
    }

    // Si sólo hay compras y sólo hay ventas significa que no hay órdenes,
    // esto es debido a que el bucle no se ha ejecutado con ninguna, y las
    // dos se han quedado con el valor por defecto cuando se han reseteado
    if (SoloHayCompras() && SoloHayVentas())
    {
        // Para que no sea incoherente el valor ambos deben devolver false
        guardaSoloHayCompras(false);
        guardaSoloHayVentas(false);
    }
}

//+------------------------------------------------------------------+
//| Función de compra                                                |
//+------------------------------------------------------------------+
void Compra(const double stopLoss = 0, const double takeProfit = 0, double lotaje = 0)
{
    // Si no pasamos lotaje lo auto calculamos, mírate el gestor del símbolo
    if (0 == lotaje)
    {
        lotaje = CalculaLotaje();
    }

    // Intentamos colocar la orden en mercado
    int orden = OrderSend(Symbol(), OP_BUY, lotaje, Ask, 3, stopLoss, takeProfit);

    // Si tiene éxito nos devuelve el ID del ticket de la orden
    if (EMPTY != orden)
    {
        Print("Abierta nueva orden de compra #" + IntegerToString(orden) + " de " + DoubleToString(lotaje, 2) + " lotes");
    }
    // y si no pintamos el mensaje del error para solucionarlo
    else
    {
        Print("Ha sido imposible abrir la nueva orden de compra por este error: " + ErrorDescription(GetLastError()));
    }
}

//+------------------------------------------------------------------+
//| Función de cierre                                                |
//+------------------------------------------------------------------+
void Cierra(const int orden)
{
    // Si la orden ya no existe pintamos error y salimos
    if (!OrderSelect(orden, SELECT_BY_TICKET))
    {
        Print("No se puede cerrar la orden #" + IntegerToString(orden) + " por que no existe");

        return;
    }

    // Sacamos los datos de la orden para su proceso y tratamos de cerrarla
    double lotajeDeOrden    = OrderLots();
    double resultadoDeOrden = OrderProfit() - MathAbs(OrderCommission()) - MathAbs(OrderSwap());
    bool   cerrada          = OrderClose(OrderTicket(), OrderLots(), OP_BUY == OrderType() ? Bid : Ask, 3);

    // Si la hemos conseguido cerrar pintamos los datos de ella
    if (cerrada)
    {
        Print("Se ha cerrado la orden #" + IntegerToString(orden) + " de " + DoubleToString(lotajeDeOrden, 2) + " lotes y resultado " + DoubleToString(resultadoDeOrden, 2) + "€ correctamente");
    }
    // y si no pintamos el mensaje del error para solucionarlo
    else
    {
        Print("Ha sido imposible cerrar la orden #" + IntegerToString(orden) + " de " + DoubleToString(lotajeDeOrden, 2) + " lotes y resultado " + DoubleToString(resultadoDeOrden, 2) + "€ por este error: " + ErrorDescription(GetLastError()));
    }
}

//+------------------------------------------------------------------+
//| Función para el stop loss, permite hacer trailing a N ticks      |
//+------------------------------------------------------------------+
void MueveStopLoss(const int orden, const int tics)
{
    // Si la orden ya no existe pintamos error y salimos
    if (!OrderSelect(orden, SELECT_BY_TICKET))
    {
        Print("No se puede mover el stop loss de la orden #" + IntegerToString(orden) + " por que no existe la orden");

        return;
    }

    // Pasamos la distancia en ticks de entero a decimal
    double distancia = tics * Point();
    double stopLoss  = 0;

    // Si es una orden de compra y además el stop loss está por debajo de la distancia establecida lo movemos
    if (OP_BUY == OrderType() && NormalizeDouble(OrderStopLoss(), Digits) < NormalizeDouble(Ask - distancia, Digits))
    {
        stopLoss = Ask - distancia;
    }
    // Si es una orden de venta y además el stop loss está por encima de la distancia establecida lo movemos
    else if (OP_SELL == OrderType() && (NormalizeDouble(OrderStopLoss(), Digits) > NormalizeDouble(Bid + distancia, Digits) || OrderStopLoss() == 0))
    {
        stopLoss = Bid + distancia;
    }

    // Si no se ha modificado el stop loss, por que no se haya dado ninguna condición, entonces no hacemos nada y salimos
    if (0 >= stopLoss)
    {
        return;
    }

    // Si conseguimos modificar la orden salimos, esto es sólo para evitar un warning del compilador de MT4:
    // return value of 'OrderModify' should be checked
    if (OrderModify(orden, OrderOpenPrice(), NormalizeDouble(stopLoss, Digits), OrderTakeProfit(), OrderExpiration()))
    {
        return;
    }
}

//+------------------------------------------------------------------+
//| Función de venta                                                 |
//+------------------------------------------------------------------+
void Vende(const double stopLoss = 0, const double takeProfit = 0, double lotaje = 0)
{
    // Si no pasamos lotaje lo auto calculamos, mírate el gestor del símbolo
    if (0 == lotaje)
    {
        lotaje = CalculaLotaje();
    }

    // Intentamos colocar la orden en mercado
    int orden = OrderSend(Symbol(), OP_SELL, lotaje, Bid, 3, stopLoss, takeProfit);

    // Si tiene éxito nos devuelve el ID del ticket de la orden
    if (EMPTY != orden)
    {
        Print("Abierta nueva orden de venta #" + IntegerToString(orden) + " de " + DoubleToString(lotaje, 2) + " lotes");
    }
    // y si no pintamos el mensaje del error para solucionarlo
    else
    {
        Print("Ha sido imposible abrir la nueva orden de venta por este error: " + ErrorDescription(GetLastError()));
    }
}
//+------------------------------------------------------------------+