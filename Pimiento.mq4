//+------------------------------------------------------------------+
//|                                                     Pimiento.mq4 |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright   "Copyright 2022, Pimient Investment"
#property description "Pimiento es un asesor experto multi estrategia"
#property description "Permite implementar las estrategias muy rápido"
#property description "Intercambio de estrategia con una simple línea"
#property description "Está programado para ser el esqueleto perfecto"
#property description "Estructuras de pequeños gestores según su tipo"
#property description "Escrito en palabras absolutamente descriptivas"
#property description "Optimizado para evitar los bucles innecesarios"
#property description "Generador de getters y setters incluído en PHP"
#property description "Totalmente comentado para entender bien los EA"
#property description "Ideal para empezar a programar tus propios EAs"
#property link        "https://127.0.0.1"
#property strict
#property version     "1.01"

//+------------------------------------------------------------------+
//| El esqueleto principal, este es el armazón, simple y sencilo que |
//| te permitirá tener tu código limpio, claro para poder entenderlo |
//| siempre que lo vuelvas a mirar tras décadas en el tiempo, además |
//| de no necesitar ser modificado para la implementación de futuras |
//| estrategias, ya que el único archivo que deberías editar de todo |
//| este código es el gestor de tu negocio y, excepcionalmente el de |
//| los selectores o interruptores que determinan como se deberán de |
//| comportar las estrategias según las configures para tus eventos. |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Incluímos los distintos gestores                                 |
//+------------------------------------------------------------------+
#include "PimientoGestorEventos.mqh"
#include "PimientoGestorMercado.mqh"

//+------------------------------------------------------------------+
//| Evento que se ejecuta una sola vez cuando se carga el experto    |
//+------------------------------------------------------------------+
int OnInit()
{
    Print("Experto cargado con éxito");

    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Evento que se ejecuta una sola vez cuando aparece una nueva vela |
//+------------------------------------------------------------------+
void OnBar()
{
    Print("Nueva vela disponible");
}

//+------------------------------------------------------------------+
//| Evento que se ejecuta cada vez que cambia el precio del mercado  |
//+------------------------------------------------------------------+
void OnTick()
{
    // Paso 1) 
    // Obtenemos los datos del símbolo
    //
    // Si no podemos obtener los datos del símbolo no podemos continuar
    // por que necesitamos saber ciertas cosas del símbolo actual para
    // poder ejecutar las operaciones, como por ejemplo los lotajes
    // máximo y mínimo o el incremento entre ambos 0.01, 0.10, 1.00 ...
    if (!CargaDatosDelSimbolo())
    {
        Print("No ha sido posible cargar los datos del símbolo");

        return;
    }

    // Paso 2)
    // Ejecutamos los eventos para cuando se genera una nueva vela
    //
    // Esto se ejecuta en cada tick pero el evento realmente sólo salta
    // en el primer tick disponible de la nueva vela generada, hasta
    // entonces son ignorados y no ejecuta nada, es un evento disponible
    // en MT5 pero no en MT4 hasta ahora :)
    EjecutaOnBar();

    // Paso 3)
    // Cargamos los datos de las ordenes actuales
    //
    // Esta función es la más pesada ya que es el bucle que recorre las
    // órdenes y las va leyendo una a una para sacar los totales de los
    // beneficios, el número de abiertas, las abiertas y protegidas, el
    // beneficio máximo actual, así como la pérdida, y más datos que te
    // serviran para poder evaluar, y aplicar tu estrategia según estos
    // datos, la idea principal es que antes de hacer nada se recopilen
    // estos datos y lo haga una única vez, así no tendrás que volver a
    // recorrer las ordenes para no malgastar un cómputo innecesario.
    //
    // Mírate CargaDatosDeOrdenes, ahí están todos los datos guardados.
    CargaDatosDeOrdenes();

    // Paso 4)
    // Decidimos si hay que proteger, o no, alguna o todas las órdenes
    // existentes actualmente, esto dependerá de tu lógica de negocio.
    DecideSiProteger();

    // Paso 5)
    // Compramos, Vendemos o realizamos cobertura si tenemos margen
    //
    // El margen es la cantidad de dinero disponible que requiere el
    // broker para mantener las órdenes que tenemos actualmente en el
    // mercado abiertas, esto es la garantía de que no perderá dinero
    // el broker en el caso de que tu cuenta se queme, ya que cuando
    // llegues a un punto de margen 0 el broker te hará el temido SO
    // o MC de Stop Out y Margin Call para cerrarte las órdenes ya que
    // sin margen no podrás ni abrir más operaciones ni mantener las
    // actualmente abiertas.
    //
    // Esto es así para evitar que tu cuenta entre en negativo y le
    // debas dinero al broker, que el está asumiendo por tí cuando tu
    // cuenta está apalancada (1:200) en dónde 1€ tuyo vale 200€ en
    // el mercado, es el broker quien pone esos 199€ restantes, por
    // eso se lleva comisión de apertura y/o de mantenimiento.
    //
    // En este ejemplo se usa un 70% de margen libre disponible para
    // seguir operando respecto al balance inicial de la cuenta.
    if (DisponemosDeMargenLibre())
    {
        // Paso 5.1)
        // Decidimos si comprar según tu estrategia.
        DecideSiComprar();

        // Paso 5.2)
        // Decidimos si vender según tu estrategia.
        DecideSiVender();

        // Paso 5.3)
        // Decidimos si aplicar cobertura según tu estrategia.
        DecideSiCobertura();
    }

    // Paso 6)
    // Decidimos si hay que cerrar, o no, alguna o todas las órdenes
    // existentes actualmente, esto dependerá de tu lógica de negocio.
    DecideSiCerrar();
}
//+------------------------------------------------------------------+
