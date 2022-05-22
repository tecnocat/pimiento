//+------------------------------------------------------------------+
//|                                        PimientoGestorValores.mqh |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Pimient Investment"
#property link      "https://127.0.0.1"
#property strict
#property version   "1.01"

//+------------------------------------------------------------------+
//| El gestor de valores, aquí es dónde se guardan y manipulan todos |
//| los datos del asesor experto, no se usará ninguna variable fuera |
//| de este archivo, así el código está más limpio y es más fácil de |
//| evitar errores por declarar variables en distintos archivos, con |
//| esto se centraliza todo el un único archivo, y además se hace el |
//| buen uso de pseudo getters y setters en lugar de llamar de forma |
//| directa a las variables, de este modo se facilita la lectura del |
//| mismo, y se asegura de que los valores de las variables solo són |
//| modificados por las funciones que aquí se contemplan.            |
//|                                                                  |
//| Además la mejora sobre este gestor de variables es que el código |
//| se auto genera con un script externo en PHP para generar todos y |
//| cada uno de los métodos, para leer y guardar los distintos tipos |
//| de variable según su tipo, por ejemplo funciones de suma y resta |
//| para enteros, conteos, agregacion y eliminación para los de tipo |
//| array, y lo mejor de todo es que los mantiene ordenados de forma |
//| alfabética para que resulte más fácil localizar las funciones :) |
//|                                                                  |
//| Para su generación tienes que disponer de PHP 7.4 y ejecutar:    |
//|                                                                  |
//| php -f PimientoGeneraValores.php                                 |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Incluímos los distintos gestores                                 |
//+------------------------------------------------------------------+
#include "PimientoGestorComunes.mqh"

//+------------------------------------------------------------------+
//| Listado de las variables, sólo tendras que declarar con el mismo |
//| formato las que quieras agregar, y a partir de la línea en donde |
//| pone GENERACIÓN AUTOMÁTICA A PARTIR DE AQUÍ, el código se creará |
//| mágicamente con el script en PHP que tendrás que ejecutar.       |
//+------------------------------------------------------------------+
bool   _soloHayCompras            = false;
bool   _soloHayVentas             = false;
double _beneficioDeCompras        = 0;
double _beneficioDeVentas         = 0;
double _beneficioMaximoDeAmbas    = 0;
double _beneficioMaximoDeCompras  = 0;
double _beneficioMaximoDeVentas   = 0;
double _beneficioTotal            = 0;
double _perdidaDeCompras          = 0;
double _perdidaDeVentas           = 0;
double _perdidaTotal              = 0;
int    _ordenesDeCompraAbiertas   = 0;
int    _ordenesDeCompraProtegidas = 0;
int    _ordenesDeVentaAbiertas    = 0;
int    _ordenesDeVentaProtegidas  = 0;
int    _ordenesParaProteger       [];

//+------------------------------------------------------------------+
//|              GENERACIÓN AUTOMÁTICA A PARTIR DE AQUÍ              |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
bool SoloHayCompras()
{
    return _soloHayCompras;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaSoloHayCompras(const bool valor)
{
    _soloHayCompras = valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
bool SoloHayVentas()
{
    return _soloHayVentas;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaSoloHayVentas(const bool valor)
{
    _soloHayVentas = valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
double BeneficioDeCompras()
{
    return _beneficioDeCompras;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaBeneficioDeCompras(const double valor)
{
    _beneficioDeCompras = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaBeneficioDeCompras(const double valor)
{
    _beneficioDeCompras += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaBeneficioDeCompras(const double valor)
{
    _beneficioDeCompras -= valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
double BeneficioDeVentas()
{
    return _beneficioDeVentas;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaBeneficioDeVentas(const double valor)
{
    _beneficioDeVentas = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaBeneficioDeVentas(const double valor)
{
    _beneficioDeVentas += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaBeneficioDeVentas(const double valor)
{
    _beneficioDeVentas -= valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
double BeneficioMaximoDeAmbas()
{
    return _beneficioMaximoDeAmbas;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaBeneficioMaximoDeAmbas(const double valor)
{
    _beneficioMaximoDeAmbas = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaBeneficioMaximoDeAmbas(const double valor)
{
    _beneficioMaximoDeAmbas += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaBeneficioMaximoDeAmbas(const double valor)
{
    _beneficioMaximoDeAmbas -= valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
double BeneficioMaximoDeCompras()
{
    return _beneficioMaximoDeCompras;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaBeneficioMaximoDeCompras(const double valor)
{
    _beneficioMaximoDeCompras = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaBeneficioMaximoDeCompras(const double valor)
{
    _beneficioMaximoDeCompras += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaBeneficioMaximoDeCompras(const double valor)
{
    _beneficioMaximoDeCompras -= valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
double BeneficioMaximoDeVentas()
{
    return _beneficioMaximoDeVentas;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaBeneficioMaximoDeVentas(const double valor)
{
    _beneficioMaximoDeVentas = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaBeneficioMaximoDeVentas(const double valor)
{
    _beneficioMaximoDeVentas += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaBeneficioMaximoDeVentas(const double valor)
{
    _beneficioMaximoDeVentas -= valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
double BeneficioTotal()
{
    return _beneficioTotal;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaBeneficioTotal(const double valor)
{
    _beneficioTotal = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaBeneficioTotal(const double valor)
{
    _beneficioTotal += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaBeneficioTotal(const double valor)
{
    _beneficioTotal -= valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
double PerdidaDeCompras()
{
    return _perdidaDeCompras;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaPerdidaDeCompras(const double valor)
{
    _perdidaDeCompras = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaPerdidaDeCompras(const double valor)
{
    _perdidaDeCompras += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaPerdidaDeCompras(const double valor)
{
    _perdidaDeCompras -= valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
double PerdidaDeVentas()
{
    return _perdidaDeVentas;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaPerdidaDeVentas(const double valor)
{
    _perdidaDeVentas = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaPerdidaDeVentas(const double valor)
{
    _perdidaDeVentas += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaPerdidaDeVentas(const double valor)
{
    _perdidaDeVentas -= valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
double PerdidaTotal()
{
    return _perdidaTotal;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaPerdidaTotal(const double valor)
{
    _perdidaTotal = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaPerdidaTotal(const double valor)
{
    _perdidaTotal += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaPerdidaTotal(const double valor)
{
    _perdidaTotal -= valor;
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
int OrdenesDeCompraAbiertas()
{
    return _ordenesDeCompraAbiertas;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaOrdenesDeCompraAbiertas(const int valor)
{
    _ordenesDeCompraAbiertas = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaOrdenesDeCompraAbiertas(const int valor)
{
    _ordenesDeCompraAbiertas += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaOrdenesDeCompraAbiertas(const int valor)
{
    _ordenesDeCompraAbiertas -= valor;
}

//+------------------------------------------------------------------+
//| Suma 1 el valor                                                  |
//+------------------------------------------------------------------+
void aumentaOrdenesDeCompraAbiertas()
{
    sumaOrdenesDeCompraAbiertas(1);
}

//+------------------------------------------------------------------+
//| Resta 1 el valor                                                 |
//+------------------------------------------------------------------+
void disminuyeOrdenesDeCompraAbiertas()
{
    restaOrdenesDeCompraAbiertas(1);
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
int OrdenesDeCompraProtegidas()
{
    return _ordenesDeCompraProtegidas;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaOrdenesDeCompraProtegidas(const int valor)
{
    _ordenesDeCompraProtegidas = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaOrdenesDeCompraProtegidas(const int valor)
{
    _ordenesDeCompraProtegidas += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaOrdenesDeCompraProtegidas(const int valor)
{
    _ordenesDeCompraProtegidas -= valor;
}

//+------------------------------------------------------------------+
//| Suma 1 el valor                                                  |
//+------------------------------------------------------------------+
void aumentaOrdenesDeCompraProtegidas()
{
    sumaOrdenesDeCompraProtegidas(1);
}

//+------------------------------------------------------------------+
//| Resta 1 el valor                                                 |
//+------------------------------------------------------------------+
void disminuyeOrdenesDeCompraProtegidas()
{
    restaOrdenesDeCompraProtegidas(1);
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
int OrdenesDeVentaAbiertas()
{
    return _ordenesDeVentaAbiertas;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaOrdenesDeVentaAbiertas(const int valor)
{
    _ordenesDeVentaAbiertas = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaOrdenesDeVentaAbiertas(const int valor)
{
    _ordenesDeVentaAbiertas += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaOrdenesDeVentaAbiertas(const int valor)
{
    _ordenesDeVentaAbiertas -= valor;
}

//+------------------------------------------------------------------+
//| Suma 1 el valor                                                  |
//+------------------------------------------------------------------+
void aumentaOrdenesDeVentaAbiertas()
{
    sumaOrdenesDeVentaAbiertas(1);
}

//+------------------------------------------------------------------+
//| Resta 1 el valor                                                 |
//+------------------------------------------------------------------+
void disminuyeOrdenesDeVentaAbiertas()
{
    restaOrdenesDeVentaAbiertas(1);
}

//+------------------------------------------------------------------+
//| Devuelve su valor                                                |
//+------------------------------------------------------------------+
int OrdenesDeVentaProtegidas()
{
    return _ordenesDeVentaProtegidas;
}

//+------------------------------------------------------------------+
//| Guarda su valor                                                  |
//+------------------------------------------------------------------+
void guardaOrdenesDeVentaProtegidas(const int valor)
{
    _ordenesDeVentaProtegidas = valor;
}

//+------------------------------------------------------------------+
//| Suma el valor                                                    |
//+------------------------------------------------------------------+
void sumaOrdenesDeVentaProtegidas(const int valor)
{
    _ordenesDeVentaProtegidas += valor;
}

//+------------------------------------------------------------------+
//| Resta el valor                                                   |
//+------------------------------------------------------------------+
void restaOrdenesDeVentaProtegidas(const int valor)
{
    _ordenesDeVentaProtegidas -= valor;
}

//+------------------------------------------------------------------+
//| Suma 1 el valor                                                  |
//+------------------------------------------------------------------+
void aumentaOrdenesDeVentaProtegidas()
{
    sumaOrdenesDeVentaProtegidas(1);
}

//+------------------------------------------------------------------+
//| Resta 1 el valor                                                 |
//+------------------------------------------------------------------+
void disminuyeOrdenesDeVentaProtegidas()
{
    restaOrdenesDeVentaProtegidas(1);
}

//+------------------------------------------------------------------+
//| Devuelve un elemento de la lista                                 |
//+------------------------------------------------------------------+
int OrdenesParaProteger(const int posicion)
{
    return _ordenesParaProteger[posicion];
}

//+------------------------------------------------------------------+
//| Agrega un elemento a la lista                                    |
//+------------------------------------------------------------------+
void agregaOrdenesParaProteger(const int elemento)
{
    ListaAgrega(_ordenesParaProteger, elemento);
}

//+------------------------------------------------------------------+
//| Elimina un elemento de la lista si existe                        |
//+------------------------------------------------------------------+
void eliminaOrdenesParaProteger(const int elemento)
{
    if (ListaContiene(_ordenesParaProteger, elemento))
    {
        ListaBorra(_ordenesParaProteger, ListaPosicion(_ordenesParaProteger, elemento));
    }
}

//+------------------------------------------------------------------+
//| Comprueba si existe un elemento en la lista                      |
//+------------------------------------------------------------------+
bool existeOrdenesParaProteger(const int elemento)
{
    return ListaContiene(_ordenesParaProteger, elemento);
}

//+------------------------------------------------------------------+
//| Devuelve el número de elementos en la lista                      |
//+------------------------------------------------------------------+
int cuentaOrdenesParaProteger()
{
    return ArraySize(_ordenesParaProteger);
}

//+------------------------------------------------------------------+
//| Vacía los elementos de la lista                                  |
//+------------------------------------------------------------------+
void vaciaOrdenesParaProteger()
{
    ArrayFree(_ordenesParaProteger);
}
//+------------------------------------------------------------------+