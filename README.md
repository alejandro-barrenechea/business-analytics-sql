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

1. **Distribución de ventas por categoría:** ¿Cómo se distribuyen las ventas según subcategoría y año en términos porcentuales?

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
-- Verificar valores faltantes en la tabla SuperStoree --

SELECT COUNT(*) 
FROM SuperStore
WHERE order_id IS NULL;

-- Verificar valores duplicados en la tabla SuperStore --

SELECT order_id,COUNT(*) 
FROM SuperStore
GROUP BY order_id 
HAVING COUNT(*)>1
```

## Análisis Exploratorio de Datos (EDA) e Insights

### Pregunta #1: ¿Cómo se distribuyen las ventas de la subcategoría y año en términos porcentuales?

Calculé el total de ventas por año y subcategoría utilizando SUM(sales) y luego obtuve el porcentaje que representa cada año dentro de su subcategoría usando SUM() OVER (PARTITION BY sub_category). Esto me permite ver qué proporción de las ventas corresponde a cada subcategoría en cada año. Además, formateé el porcentaje con dos decimales para mayor claridad.


```sql

with analisis_subcategoria as(
select
      year,
      category,
      sub_category,
      SUM(sales) as'suma_total',
	  concat(format(sum(sales) *100.0/sum(sum(sales)) over ( partition by sub_category),'N2'),'%') as '%ventas'
from basetotal
group by year,category,sub_category
)
select * from analisis_subcategoria

order by sub_CATEGORY,year desc;

```
![HR Analytics](PREGUNTA1.png)

_Distribución porcentual de ventas por subcategoría y año_

El análisis muestra que la participación de ventas varía entre subcategorías y años, evidenciando que algunas subcategorías concentran una mayor proporción de ingresos dentro del total.

La empresa podria aplicar diferentes estrategias comerciales en las subcategorías con mayor participación de ventas, ya que representan el mayor aporte al ingreso


### Pregunta #2: ¿Qué porcentaje de ingresos aporta cada nivel de prioridad de pedido?








```sql

with ingresos_categoria as(
select 
        order_priority,
        sum(sales) 'Ingreso Totales', 
        concat(format(sum(sales) *100.0/SUM(sum(sales))over (),'N2'),'%') as 'Porcemtaje'
from basetotal
group by order_priority
)
select 
      * from ingresos_categoria
order by [Ingreso Totales] desc;

```

![HR Analytics](PREGUNTA2.png)

















