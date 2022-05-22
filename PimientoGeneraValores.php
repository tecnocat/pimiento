<?php

echo str_repeat('*', 180) . PHP_EOL;
$file   = __DIR__ . DIRECTORY_SEPARATOR . 'PimientoGestorValores.mqh';
$lines  = file($file);
$types  = [
    'bool',
    'double',
    'int',
    'long',
    'string',
];
$header = [];
$values = [];
$output = [
    '',
    '//+------------------------------------------------------------------+',
    '//|              GENERACIÓN AUTOMÁTICA A PARTIR DE AQUÍ              |',
    '//+------------------------------------------------------------------+',
];

foreach ($lines as $line)
{
    sanitize($line);
    echo $line . PHP_EOL;
    $parts = explode(' ', $line);
    $parts = array_filter($parts, 'trim');
    $parts = array_values($parts);

    if (empty($line) && isset($end))
    {
        break;
    }

    if (empty($parts[0]) || !in_array($parts[0], $types) || ('=' != $parts[2] && '[];' != $parts[2]))
    {
        $header[] = $line;

        continue;
    }

    $end      = true;
    $values[] = $line;
    $tipado   = $parts[0];
    $nombre   = ucfirst(substr($parts[1], 1));
    $variable = $parts[1];

    if ('[];' === $parts[2])
    {
        $output[] = '';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = '//| Devuelve un elemento de la lista                                 |';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = "$tipado $nombre(const int posicion)";
        $output[] = '{';
        $output[] = '    return ' . $variable . '[posicion];';
        $output[] = '}';
        $output[] = '';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = '//| Agrega un elemento a la lista                                    |';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = "void agrega$nombre(const $tipado elemento)";
        $output[] = '{';
        $output[] = "    ListaAgrega($variable, elemento);";
        $output[] = '}';
        $output[] = '';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = '//| Elimina un elemento de la lista si existe                        |';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = "void elimina$nombre(const $tipado elemento)";
        $output[] = '{';
        $output[] = "    if (ListaContiene($variable, elemento))";
        $output[] = '    {';
        $output[] = "        ListaBorra($variable, ListaPosicion($variable, elemento));";
        $output[] = '    }';
        $output[] = '}';
        $output[] = '';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = '//| Comprueba si existe un elemento en la lista                      |';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = "bool existe$nombre(const $tipado elemento)";
        $output[] = '{';
        $output[] = "    return ListaContiene($variable, elemento);";
        $output[] = '}';
        $output[] = '';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = '//| Devuelve el número de elementos en la lista                      |';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = "int cuenta$nombre()";
        $output[] = '{';
        $output[] = "    return ArraySize($variable);";
        $output[] = '}';
        $output[] = '';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = '//| Vacía los elementos de la lista                                  |';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = "void vacia$nombre()";
        $output[] = '{';
        $output[] = "    ArrayFree($variable);";
        $output[] = '}';
    }
    else
    {
        $output[] = '';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = '//| Devuelve su valor                                                |';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = "$tipado $nombre()";
        $output[] = '{';
        $output[] = "    return $variable;";
        $output[] = '}';
        $output[] = '';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = '//| Guarda su valor                                                  |';
        $output[] = '//+------------------------------------------------------------------+';
        $output[] = "void guarda$nombre(const $tipado valor)";
        $output[] = '{';
        $output[] = "    $variable = valor;";
        $output[] = '}';

        if ($tipado == 'double' || $tipado == 'int')
        {
            $output[] = '';
            $output[] = '//+------------------------------------------------------------------+';
            $output[] = '//| Suma el valor                                                    |';
            $output[] = '//+------------------------------------------------------------------+';
            $output[] = "void suma$nombre(const $tipado valor)";
            $output[] = '{';
            $output[] = "    $variable += valor;";
            $output[] = '}';
            $output[] = '';
            $output[] = '//+------------------------------------------------------------------+';
            $output[] = '//| Resta el valor                                                   |';
            $output[] = '//+------------------------------------------------------------------+';
            $output[] = "void resta$nombre(const $tipado valor)";
            $output[] = '{';
            $output[] = "    $variable -= valor;";
            $output[] = '}';
        }

        if ($tipado == 'int')
        {
            $output[] = '';
            $output[] = '//+------------------------------------------------------------------+';
            $output[] = '//| Suma 1 el valor                                                  |';
            $output[] = '//+------------------------------------------------------------------+';
            $output[] = "void aumenta$nombre()";
            $output[] = '{';
            $output[] = "    suma$nombre(1);";
            $output[] = '}';
            $output[] = '';
            $output[] = '//+------------------------------------------------------------------+';
            $output[] = '//| Resta 1 el valor                                                 |';
            $output[] = '//+------------------------------------------------------------------+';
            $output[] = "void disminuye$nombre()";
            $output[] = '{';
            $output[] = "    resta$nombre(1);";
            $output[] = '}';
        }
    }
}

$output[] = '//+------------------------------------------------------------------+';
$contents = implode(PHP_EOL, $header) . PHP_EOL . implode(PHP_EOL, order($values)) . PHP_EOL . implode(PHP_EOL, $output);

file_put_contents($file, $contents);

function sanitize(string &$text)
{
    $text = str_replace(PHP_EOL, '', $text);
    $text = preg_replace('/[\x00-\x1F\x7F]/u', '', $text);
}

function order(array $lines): array
{
    $data           = [];
    $result         = [];
    $lengthType     = 0;
    $lengthVariable = 0;

    foreach ($lines as $line)
    {
        $parts          = explode(' ', preg_replace('/\s+/', ' ', $line));
        $lengthType     = max(strlen($parts[0]), $lengthType);
        $lengthVariable = max(strlen($parts[1]), $lengthVariable);

        if (!isset($data[$parts[0]]))
        {
            $data[$parts[0]] = [];
        }

        $data[$parts[0]][] = implode('#', $parts);
    }

    ksort($data);

    foreach ($data as $type => &$variables)
    {
        sort($variables);

        foreach ($variables as $variable)
        {
            $parts    = explode('#', $variable);
            $result[] = $type . spaces($lengthType, $type) . $parts[1] . spaces($lengthVariable, $parts[1]) . $parts[2] . (isset($parts[3]) ? ' ' . $parts[3] : '');
        }
    }

    return $result;
}

function spaces(int $spaces, string $item): string
{
    return str_repeat(' ', $spaces - strlen($item) + 1);
}