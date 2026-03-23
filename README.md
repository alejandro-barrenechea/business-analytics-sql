# Proyecto SQL: Análisis de Datos de Ventas y Desempeño Comercial

## Resumen 

Actualmente, la empresa **SuperStore** no cuenta con un análisis estructurado que permita identificar patrones de ventas, productos más rentables y tiempos de envío. Por ello, mi objetivo es analizar los datos de ventas utilizando **SQL** en **SQL Server Management Studio**, con la finalidad de obtener una visión clara del rendimiento comercial, el comportamiento de los clientes y la rentabilidad de los productos.


## Estructura del Proyecto

- [Sobre los Datos](#sobre-los-datos)
- [Tareas](#tareas)
- [Limpieza de Datos](#limpieza-de-datos)
- [Análisis Exploratorio de Datos e Insights](#análisis-exploratorio-de-datos-e-insights)


## Sobre los Datos

Los datos originales, junto con una explicación de cada columna, se pueden encontrar [aquí](https://www.kaggle.com/datasets/thuandao/superstore-sales-analytics).

El conjunto de datos incluye una tabla que capturan el registro de ventas, pedidos, clientes, productos, enviós distribuidos en más de 25,000 registros y 21 columnas.


![HR Analytics](captura1.png)



## Tareas (Task)


En este análisis, ayudo a responder las siguientes preguntas de negocio sobre ventas, clientes, productos y logística:

1. **Distribución de ventas por categoría:** ¿Cómo se distribuyen las ventas de la categoría Accessories según subcategoría y año en términos porcentuales?

2. **Contribución por prioridad de pedido:** ¿Qué porcentaje de ingresos aporta cada nivel de prioridad de pedido?

3. **Clientes más activos:** ¿Qué clientes compran la mayor cantidad de productos?

4. **Preferencias de envío:** ¿Qué tipos de envío fueron más utilizados en 2014 y cuántos pedidos se realizaron por cada uno?

5. **Desempeño por Viajes:** PENDIENTE

6. **Productos más rentables** ¿Cuáles son los productos que generan mayor ganancia por año?

7. **Relación entre almacenamiento y rentabilidad:** ¿Qué productos tienen un tiempo de almacenamiento superior al promedio y cómo se relaciona esto con su rentabilidad?

## Limpieza de Datos

Antes de realizar el análisis, es fundamental asegurar que los datos estén limpios y listos.

#### Valores Nulos o Faltantes

Primero, verifiqué la existencia de valores faltantes en el campo clave: `order_id`. No se encontraron valores nulos.

```sql
-- Verificar valores faltantes en la tabla Employee --

SELECT COUNT(*) 
FROM SuperStore
WHERE order_id IS NULL;

-- Verificar valores duplicados en la tabla PerformanceRating --

SELECT order_id,COUNT(*) 
FROM SuperStore
GROUP BY order_id 
HAVING COUNT(*)>1
```

## Análisis Exploratorio de Datos (EDA) e Insights

### Pregunta #1: ¿Cómo se distribuyen las ventas de la categoría Accessories según subcategoría y año en términos porcentuales?



























