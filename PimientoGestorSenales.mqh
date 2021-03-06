//+------------------------------------------------------------------+
//|                                        PimientoGestorSenales.mqh |
//|                               Copyright 2022, Pimient Investment |
//|                                                https://127.0.0.1 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Pimient Investment"
#property link      "https://127.0.0.1"
#property strict
#property version   "1.01"

//+------------------------------------------------------------------+
//| Gestor de señales, aquí es dónde deberías configurar las señales |
//| para que se disparen los eventos de tu lógica de negocio, con un |
//| ejemplo de un par de medias he puesto como sería posible usar la |
//| function de TendenciaAlcista y TendenciaBajista para detectar la |
//| tendencia, según requiera y así poder actuar en consecuencia con |
//| lógica de negocio, aquí sólo deberían estar eventos tendenciales |
//| para poder activar toda la lógica de tu negocio cuando se de los |
//| eventos tendenciales.                                            |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Constantes de señales, si no quieres fijar los valores, para que |
//| puedan ser cambiados durante la ejecución en los Backtest, debes |
//| usar input vaiables en lugar de constantes.                      |
//|                                                                  |
//| Mírate https://docs.mql4.com/basis/variables/inputvariables      |
//+------------------------------------------------------------------+
#define PERIODOS_MEDIA_RAPIDA   50
#define PERIODOS_MEDIA_LENTA    200
#define PRIMERA_VELA_DISPONIBLE 1

//+------------------------------------------------------------------+
//| Un simple detector de cambio de tendencia, este es un ejemplo    |
//| sólo para demostrar como se puede implementar en el código, no   |
//| lo uses o perderás todo tu dinero, elabora un método mas serio   |
//+------------------------------------------------------------------+
bool CambioDeTendencia(const int vela = PRIMERA_VELA_DISPONIBLE)
{
    bool cambioAlcistaBajista = TendenciaAlcista(vela + 1) && TendenciaBajista(vela);
    bool cambioBajistaAlcista = TendenciaBajista(vela + 1) && TendenciaAlcista(vela);
    
    return cambioAlcistaBajista || cambioBajistaAlcista;
}

//+------------------------------------------------------------------+
//| Función para la tendencia alcista                                |
//+------------------------------------------------------------------+
bool TendenciaAlcista(const int vela = PRIMERA_VELA_DISPONIBLE)
{
    return 1 == TendenciaValor(vela);
}

//+------------------------------------------------------------------+
//| Función para la tendencia bajista                                |
//+------------------------------------------------------------------+
bool TendenciaBajista(const int vela = PRIMERA_VELA_DISPONIBLE)
{
    return 0 == TendenciaValor(vela);
}

//+------------------------------------------------------------------+
//| Función para el valor de la tendencia                            |
//+------------------------------------------------------------------+
int TendenciaValor(const int vela = PRIMERA_VELA_DISPONIBLE)
{
    // Recuerda que esto es sólo un ejemplo, un cruce de medias tan simple no es ninguna estrategia valida
    double valorMediaRapida = iMA(Symbol(), Period(), PERIODOS_MEDIA_RAPIDA, 0, MODE_EMA, PRICE_CLOSE, vela);
    double valorMediaLenta  = iMA(Symbol(), Period(), PERIODOS_MEDIA_LENTA, 0, MODE_EMA, PRICE_CLOSE, vela);

    // Si la media rápida está por encima de la lenta suponemos que es alcista, aunque esto no es muy fiable
    if (valorMediaRapida > valorMediaLenta)
    {
        // Alcista
        return 1;
    }

    // Bajista
    return 0;    
}
//+------------------------------------------------------------------+
