//+------------------------------------------------------------------+
//|                                        PimientoGestorSimbolo.mqh |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Pimient Investment"
#property link      "https://127.0.0.1"
#property strict
#property version   "1.01"

//+------------------------------------------------------------------+
//| Gestor del símbolo, se encarga de obtener todos los datos de él, |
//| y además calcular el lotaje en base al balance de la cuenta.     |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Variables del símbolo, sólo deben de usarse internamente aquí.   |
//+------------------------------------------------------------------+
double _incrementoLote;
double _maximoLote;
double _minimoLote;
long   _spreadSimbolo;
double _swapDeCompra;
double _swapDeVenta;

//+------------------------------------------------------------------+
//| Función para calcular el lotaje según balance, se incrementa a % |
//+------------------------------------------------------------------+
double CalculaLotaje(const bool incremental = true)
{
    double static balance = AccountBalance();
    double ganancia       = AccountBalance() - balance;
    double lotaje         = _minimoLote;

    if (incremental && 0 < ganancia)
    {
        lotaje = NormalizeDouble(_minimoLote + _minimoLote * (ganancia / balance * 100) / 100, 2);
    }

    return NormalizaLotaje(lotaje);
}

//+------------------------------------------------------------------+
//| Carga los datos del símbolo leyéndolos del mercado               |
//+------------------------------------------------------------------+
bool CargaDatosDelSimbolo()
{
    _incrementoLote = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_STEP);
    _maximoLote     = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX);
    _minimoLote     = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);
    _spreadSimbolo  = SymbolInfoInteger(Symbol(), SYMBOL_SPREAD);
    _swapDeCompra   = SymbolInfoDouble(Symbol(), SYMBOL_SWAP_LONG);
    _swapDeVenta    = SymbolInfoDouble(Symbol(), SYMBOL_SWAP_SHORT);

    return _minimoLote && _maximoLote;
}

//+------------------------------------------------------------------+
//| Esto normaliza el lotaje a un valor de rango válido              |
//+------------------------------------------------------------------+
double NormalizaLotaje(double lotaje)
{
    if (!CargaDatosDelSimbolo())
    {
        Print("Error al intentar normalizar el lotaje, no disponemos de información de los datos del símbolo");
        
        return lotaje;
    }

    if (0 < _maximoLote && _maximoLote < lotaje)
    {
        lotaje = _maximoLote;
    }

    double producto = NormalizeDouble(lotaje / _incrementoLote, 0);

    if (0 != lotaje - producto * _incrementoLote)
    {
        lotaje = producto * _incrementoLote;
    }

    if (lotaje < _minimoLote)
    {
        lotaje = _minimoLote;
    }

    return lotaje;
}
//+------------------------------------------------------------------+
