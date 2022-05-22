//+------------------------------------------------------------------+
//|                                        PimientoGestorNegocio.mqh |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Pimient Investment"
#property link      "https://127.0.0.1"
#property strict
#property version   "1.01"

//+------------------------------------------------------------------+
//| La lógica de tu negocio (estrategia) debe de estar sólo aquí,    |
//| concentra toda la lógica "valiosa" sólamente aquí, esto te       |
//| permitirá localizar en un sólo sitio donde pueden estar los      |
//| posibles problemas, ya que el resto del código es 99% genérico   |
//| y no representa ninguna ayuda financiera para hacer que tu       |
//| asesor sea mas o menos rentable, sólamente agiliza tu desarrollo |
//| y facilita la rapidez de implementación, a parte de que puedes   |
//| usar este código como esqueleto para tus robots si los vendes o  |
//| alquilas y así poder centrarte en lo que realmente importa.      |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Incluímos los distintos gestores                                 |
//+------------------------------------------------------------------+
#include "PimientoGestorOrdenes.mqh"
#include "PimientoGestorSenales.mqh"

//+------------------------------------------------------------------+
//| Constantes de estrategia, esto es un sistema que diseñé con el   |
//| fin de poder cambiar de un modo muy rápido la forma en la que se |
//| abren o cierran las órdenes según la estrategia a implementar.   |
//| Esto me permite poder implementar varias estrategias sin la      |
//| necesidad de comentar o borrar código, y sobretodo sin repetir   |
//| una y otra vez las mismas funciones en distintos archivos cada   |
//| vez que quiero desarrollar un nuevo robot, gracias a esto sólo   |
//| uso este esqueleto agregando mas ifs en cada nueva iteración de  |
//| la nueva estrategia a probar o implementar, algunas estrategias  |
//| desarrolladas en el pasado resultaron ser muy buenas combinadas  |
//| con otros controles que en su día no utilicé y que ahora si que  |
//| lo están, resultando muy cómodo combinar estrategias entre sí :) |
//+------------------------------------------------------------------+
#define ESTRATEGIA_A "Describe un poco que hace tu estrategia"
#define ESTRATEGIA_B "Otra descripción para otra estrategia"
#define ESTRATEGIA_C "Y otra más..."
#define ESTRATEGIA_D "Puedes usar esto para recordar como funcionan, no seas escueto"
#define ESTRATEGIA_E "Más y más..."
#define ESTRATEGIA_F "Así hasta Z"
#define ESTRATEGIA_G "Recuerda que el límite lo pones tú, yo sólo te doy el sistema :P"

//+------------------------------------------------------------------+
//| Ejemplo de como una estrategia concreta podría tener sus inputs  |
//+------------------------------------------------------------------+
// ESTRATEGIA_A
input string TiempoInfo = "Tiempo en minutos para cerrar las órdenes";
input int    Tiempo     = 60;

//+------------------------------------------------------------------+
//| La protección está diseñada para poner o mover los stop loss, se |
//| refiere a ese tipo de protección, a establecer el stop loss de   |
//| las órdenes y a ninguna otra protección más, para la cobertura   |
//| ya existe su función específica para actuar en caso de que uses  |
//| algún tipo de cobertura, ahí sí se pueden abrir más órdenes pero |
//| aquí no.                                                         |
//|                                                                  |
//| El contexto de esta función es global y debe afectar a todas las |
//| ordenes, esto significa que es ejecutado una única vez cada tick |
//| lo que implica que previamente ha tenido que recopilar todas las |
//| ordenes a proteger desde dentro del único for que existe en todo |
//| el código, que es ahí en dónde se procesan una a una todas las   |
//| ordenes abiertas y según los criterios se marcan o no para ser   |
//| protegidas.                                                      |
//|                                                                  |
//| La función que decide si marcar las órdenes para ser protegidas  |
//| es OperaSegunEstrategia dentro del gestor de ordenes, la función |
//| determina dentro del único bucle existente, y que recorre todas  |
//| las órdenes, si se debe marcar para proteger o no, entre otras   |
//| muchas cosas, de este modo conseguimos recorrer una única vez    |
//| todas las órdens que hay para así reducir la carga que supone el |
//| recorrer todas las órdenes con bucles.                           |
//|                                                                  |
//| El ejemplo de cómo sólo la estrategia B es la que usa protección |
//+------------------------------------------------------------------+
void ProtegeSegunEstrategia(const string estrategia)
{
    if (ESTRATEGIA_A == estrategia)
    {
        // Sin protección
    }
    else if (ESTRATEGIA_B == estrategia)
    {
        if (!OrderSelect(0, SELECT_BY_POS))
        {
            return;
        }

        MueveStopLoss(OrderTicket(), 1000);
    }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CompraSegunEstrategia(const string estrategia)
{
    if (ESTRATEGIA_A == estrategia)
    {
        if (0 == OrdenesDeCompraAbiertas() && TendenciaAlcista() && CambioDeTendencia())
        {
            Print("Hay un cambio de tendencia a alcista por lo que abrimos una compra");
            Compra();
        }
    }
    else if (ESTRATEGIA_B == estrategia)
    {
        if (0 == OrdenesDeCompraAbiertas() && TendenciaAlcista())
        {
            Print("Hay una tendencia alcista por lo que abrimos una compra");
            Compra();
        }
    }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void VendeSegunEstrategia(const string estrategia)
{
    if (ESTRATEGIA_A == estrategia)
    {
        if (0 == OrdenesDeVentaAbiertas() && TendenciaBajista() && CambioDeTendencia())
        {
            Print("Hay un cambio de tendencia a bajista por lo que abrimos una venta");
            Vende();
        }
    }
    else if (ESTRATEGIA_B == estrategia)
    {
        if (0 == OrdenesDeVentaAbiertas() && TendenciaBajista())
        {
            Print("Hay una tendencia bajista por lo que abrimos una venta");
            Vende();
        }
    }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CoberturaSegunEstrategia(const string estrategia)
{
    if (ESTRATEGIA_A == estrategia)
    {
        // Sin cobertura
    }
    else if (ESTRATEGIA_B == estrategia)
    {
        // Sin cobertura
    }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CierraSegunEstrategia(const string estrategia)
{
    if (ESTRATEGIA_A == estrategia)
    {
        if (!OrderSelect(0, SELECT_BY_POS))
        {
            return;
        }

        if (Tiempo <= (TimeCurrent() - OrderOpenTime()) / 60)
        {
            Cierra(OrderTicket());
        }
    }
    else if (ESTRATEGIA_B == estrategia)
    {
        // Sin cierres
    }
}

//+------------------------------------------------------------------+
//| Esta función es la única que podríamos decir que tiene un cierto |
//| comportamiento especial, ya que es llamada en el único bucle que |
//| existe en todo el código para procesar las órdenes y se llama en |
//| cada orden para determinar si debemos hacer algo especial, o no, |
//| con dicha orden, dentro del propio bucle.                        |
//|                                                                  |
//| Para entender el funcionamiento pondré un ejemplo:               |
//|                                                                  |
//| Imagina que tienes 3 órdenes actualmente abiertas, y que una de  |
//| ellas tienes que cerrarla por los motivos que sean, en ese caso  |
//| cuando dicha orden sea procesada por el bucle y tu la cierres al |
//| llamar a esta función, tendrás que excluirla de ser contada como |
//| operaciones abiertas para que no sume, ya que no existirá en los |
//| posteriores cálculos que tu código hará, por que si no serán del |
//| todo erróneos al tener en cuenta una orden que ya no existe, del |
//| mismo modo que no se tendrá que sumar ni su pérdida ni ganancia, |
//| ya que si no, tu código puede fallar estrepitosamente.           |
//|                                                                  |
//| En el caso de que el número de órdens cambie en este punto, por  |
//| que las cierres como en el ejemplo anterior, deberás devolver un |
//| true si se dan las circuntancias que han hecho que esa orden ya  |
//| no esté disponible en el mercado por haberse cerrado.            |
//|                                                                  |
//| Si por el contrario lo único que has hecho ha sido mover su stop |
//| loss y la orden sigue existiendo, entonces no necesitas devolver |
//| nada y dejar que la función al final devuelva el false por tí.   |
//+------------------------------------------------------------------+
bool OperaSegunEstrategia(const string estrategia, const int ticketDeOrden, const int tipoDeOrden, const double resultadoDeOrden, const double stopLossDeOrden, const double takeProfitDeOrden, const double lotsDeOrden)
{
    if (ESTRATEGIA_A == estrategia)
    {
        // Sin operacion
    }
    else if (ESTRATEGIA_B == estrategia)
    {
        MueveStopLoss(ticketDeOrden, 1000);
    }

    return false;
}
//+------------------------------------------------------------------+
