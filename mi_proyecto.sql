-----------------------------------------------------------------------
-----------------MI PRIMER PROYECTO COMO DATA ANALYST------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
create database comercio_business;
use comercio_business;

IF OBJECT_ID('SuperStore', 'U') IS NOT NULL
    DROP TABLE SuperStore;

create table SuperStore (

order_id NVARCHAR(50) PRIMARY KEY,
order_date DATE,
ship_date DATE,
ship_mode NVARCHAR(50),
customer_name NVARCHAR(100),
segment NVARCHAR(50),
state NVARCHAR(100),
country NVARCHAR(100),
market NVARCHAR(50),
region NVARCHAR(50),
product_id NVARCHAR(50),
category NVARCHAR(50),
sub_category NVARCHAR(50),
product_name NVARCHAR(MAX),
sales INT,
quantity INT,
discount DECIMAL(5,2),
profit DECIMAL(10,2),
shipping_cost DECIMAL(10,2),
order_priority NVARCHAR(50),
year INT

);


BULK INSERT SuperStore
FROM 'C:\SuperStore.csv' 
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,           
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n' 
  
);


--creamos una columna adicional, esto con la finalidad de saber cuanto se tardan en
--despachar el pedido por medio de view

create view basetotal as
select *, DATEDIFF(day,order_date,ship_date) as 'Dias de almacén'
from SuperStore


-- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Analisis exploratorio de datos e insights--
-- -- -- -- -- -- -- -- -- -- -- -- -- -- --


-- Pregunta #1: ¿Cómo se distribuyen las ventas de Accessories por categoría y año en porcentaje?


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
where sub_category ='Accessories'

order by category desc;



-- Pregunta #2: ¿Qué porcentaje de ingresos aporta cada nivel de prioridad de pedido?


with ingresos_categoria as(
select 
        order_priority,
        sum(sales) 'Ingreso Totales', 
        concat(format(sum(sales) *100.0/SUM(sum(sales))over (),'N2'),'%') as 'Porcentaje'
from basetotal
group by order_priority
)
select 
      * from ingresos_categoria
order by [Ingreso Totales] desc;


-- Pregunta #3: ¿Qué clientes compran la mayor cantidad de productos?


select TOP 10
      sum(quantity) as 'Productos_vendidos',
      customer_name from basetotal
where quantity > 0
group by customer_name
order by sum(quantity) desc


-- Pregunta #4: ¿Qué tipos de envío fueron más 
-- utilizados en 2014 y cuántos pedidos se realizaron por cada uno?


with tipo_clase_viaje as(
select 
      year,
	  ship_mode,
	  count(order_id) as 'cantidad_pedidos' 
from basetotal
group by year,ship_mode
)

select *
from tipo_clase_viaje
where year='2014'
order by cantidad_pedidos desc,year ;













-- Pregunta #6: ¿Cuáles son los productos con mayor ganancia por año?

with top_ganancia_producto as (
    select top 10
           year,
           product_name,
           format(sum(profit),'N2') as 'total_ganancia'
    from basetotal
    group by year,product_name
    order by sum(profit) desc
)
select * from top_ganancia_producto;


-- Pregunta #7: ¿Qué productos se almacenan por encima del promedio y qué tan rentables son?


WITH ganancias_promedio_producto AS (
    SELECT 
        product_name,
        AVG([Dias de almacén]) AS Dias_almacen,
        AVG(profit) AS promedio_ganancias
    FROM basetotal
    GROUP BY product_name
    HAVING AVG([Dias de almacén]) > (
        SELECT AVG([Dias de almacén]) FROM basetotal
    )
)
SELECT *
FROM ganancias_promedio_producto
ORDER BY promedio_ganancias desc;















































