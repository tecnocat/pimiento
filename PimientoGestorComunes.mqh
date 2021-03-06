//+------------------------------------------------------------------+
//|                                        PimientoGestorComunes.mqh |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Pimient Investment"
#property link      "https://127.0.0.1"
#property strict
#property version   "1.01"

//+------------------------------------------------------------------+
//| Gestor de funciones comunes, sólo contiene operaciones sencillas |
//| que pueden ser de utilidad para manipular datos o formatearlos.  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Devuelve true si la lista contiene el elemento a buscar          |
//+------------------------------------------------------------------+
template <typename TIPO> bool ListaContiene(TIPO &lista[], TIPO elemento)
{
    int total = ArraySize(lista);

    for (int i = 0; i < total; i++)
    {
        if (lista[i] == elemento)
        {
            return true;
        }
    }

    return false;
}

//+------------------------------------------------------------------+
//| Borra un elemento de la lista perdiendo el orden de la misma     |
//+------------------------------------------------------------------+
template <typename TIPO> void ListaBorra(TIPO &lista[], int indice)
{
    int total = ArraySize(lista) - 1;
    lista[indice] = lista[total];
    ArrayResize(lista, total);
}

//+------------------------------------------------------------------+
//| Borra un elemento de la lista manteniendo el orden de la misma   |
//+------------------------------------------------------------------+
template <typename TIPO> void ListaBorraOrdenado(TIPO &lista[], int indice)
{
    for (int total = ArraySize(lista) - 1; indice < total; ++indice)
    {
        lista[indice] = lista[indice + 1];
    }

    ArrayResize(lista, total);
}

//+------------------------------------------------------------------+
//| Devuelve la posición del elemento a buscar en la lista           |
//+------------------------------------------------------------------+
template <typename TIPO> int ListaPosicion(TIPO &lista[], TIPO elemento)
{
    int total = ArraySize(lista);

    for (int i = 0; i < total; i++)
    {
        if (lista[i] == elemento)
        {
            return i;
        }
    }

    return EMPTY;
}

//+------------------------------------------------------------------+
//| Agrega un nuevo elemento a la lista                              |
//+------------------------------------------------------------------+
template <typename TIPO> void ListaAgrega(TIPO &lista[], TIPO elemento)
{
    int total = ArraySize(lista);
    ArrayResize(lista, total + 1);
    lista[total] = elemento;
}

//+------------------------------------------------------------------+
//| Devuelve un valor en formato de cadena de texto como dinero      |
//+------------------------------------------------------------------+
template <typename TIPO> string Dinero(const TIPO valor)
{
    return DecimalFormateado((double) valor, "€");
}

//+------------------------------------------------------------------+
//| Devuelve un decimal en formado de cadena de texto                |
//+------------------------------------------------------------------+
string DecimalFormateado(const double valor, const string simbolo = "", const int decimales = 2)
{
    return DoubleToString(valor, decimales) + simbolo;
}

//+------------------------------------------------------------------+
//| Devuelve un valor en formato de cadena de texto como lotaje      |
//+------------------------------------------------------------------+
template <typename TIPO> string Lote(const TIPO valor)
{
    return DecimalFormateado((double) valor, "L");
}

//+------------------------------------------------------------------+
//| Devuelve un decimal en formato de cadena de texto como entero    |
//+------------------------------------------------------------------+
string Numero(const double valor)
{
    return IntegerToString((int) MathRound(valor));
}

//+------------------------------------------------------------------+
//| Devuelve un entero en formato de cadena de texto                 |
//+------------------------------------------------------------------+
string Numero(const int valor)
{
    return IntegerToString(valor);
}

//+------------------------------------------------------------------+
//| Devuelve un valor en formato de cadena de texto como porcentaje  |
//+------------------------------------------------------------------+
template <typename TIPO> string Porcentaje(const TIPO valor)
{
    return DecimalFormateado((double) valor, "%");
}

//+------------------------------------------------------------------+
//| Devuelve un decimal en formato de cadena de texto como precio    |
//+------------------------------------------------------------------+
string Precio(const double valor)
{
    return DecimalFormateado(valor, "", Digits);
}
//+------------------------------------------------------------------+