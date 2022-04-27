
-- 1 Listado de los clientes de la empresa, mostrando solo el código, apellido y 
-- nombre, ordenado por código.
SELECT  cod_cliente , APELLIDO, NOMBRE
FROM CLIENTES
ORDER BY  cod_cliente	desc

-- 2 

--. Ídem al anterior pero rotule los campos como Código de Cliente, Apellido, 
-- Nombre. Ordenar por apellido y nombre en forma ascendente

SELECT  cod_cliente 'Codigo de cliente', APELLIDO, NOMBRE
FROM CLIENTES
ORDER BY   APELLIDO asc, NOMBRE asc

-- 3. Listado de las plantas que se venden, mostrando el código, descripción y 
--precio, ordenadas por código en forma descendente.

select  COD_PLANTA, DESCRIPCION, PRECIO 
from PLANTAS
order by COD_PLANTA desc

--4 Mostrar el stock de cada planta, ordenadas por la descripción de las plantas. 
-- Rotular: Nombre Planta, Stock Actual.
select DESCRIPCION 'Nombre Planta', STOCK ' Stock Actual' 
from PLANTAS
order by [Nombre Planta]

-- 5 Listado de las localidades que compran a la empresa, ordenados por orden 
--alfabético
select *
from LOCALIDADES
order by NOMBRE

-- 6 Mostrar apellido y nombre del cliente en una sola columna, además de su 
-- código


select APELLIDO + ', ' + NOMBRE 'Nombre completo', COD_CLIENTE
from CLIENTES




--7 Mostrar todos los datos de las plantas y además calcular el precio con un 
-- descuento del 10%.


select cod_planta,DESCRIPCION, COD_TIPO_PLANTA  ,precio 'Precio regular', precio*0.1 'descuento',precio*0.9 'Precio con descuento', STOCK
from PLANTAS

--8 Mostrar el precio total de stock de cada planta.
select cod_planta,DESCRIPCION, COD_TIPO_PLANTA, precio, stock , STOCK* PRECIO 'precio total stock'
from PLANTAS
order by [precio total stock] desc

--  Test de Comparación
-- 9. Mostrar todos los clientes deudores (deudor=’S’), solo su código, nombre,  apellido.

select COD_CLIENTE, NOMBRE, APELLIDO
from CLIENTES
where deudor='s'



-- 10.Mostrar todas las plantas cuyo stock sea mayor a 20, ordenadas por stock.

select *
from PLANTAS
where STOCK>20
order by STOCK 

--11.Mostrar todas las plantas cuyo stock no sea 30, ordenados por código.


select *
from PLANTAS
where STOCK!=30
order by COD_PLANTA 


--12.Mostrar todas las facturas cuyas fechas sean mayores al 01/06/09.

select *
from FACTURAS
where FECHA > '01/06/09'
order by FECHA


--13.Listar todas las plantas cuyo stock es menor a 10 unidades.

select *
from PLANTAS
where STOCK<10


--Test de Rango: Between
--14.Ídem a la consulta anterior pero las fechas oscilen entre 01/06/08 y 01/03/10. // puede que sea a la de las facturas // las facturas van apartir del 2013

select *
from FACTURAS
where FECHA between '01/06/08' and '01/03/19'

--15.Listar los datos de las plantas cuyo precio esté entre 20 y 70.  /// las plantas comienzan en 115.5 y van hasta los 906

select *
from PLANTAS
where PRECIO between 20 and 70

--16.Mostrar la descripción, stock y precio de las plantas cuyo stock oscile entre 5  y 10

select DESCRIPCION, STOCK, PRECIO
from PLANTAS
where STOCK between 5 and 10


--Test de correspondencia con patrón de búsqueda: Like 
-- 17.Todos los clientes cuyo apellido comience con “f”.

select *
from CLIENTES
where APELLIDO like 'f%'


-- 18.Todos los clientes cuyo nombre contenga una “u”.

select *
from CLIENTES
where NOMBRE like '%u%'


--19.Todos los clientes cuyo apellido no comience con letras que van de la “a” a la  “c”.
select *
from CLIENTES
where APELLIDO  not like '[a-c]%'

--20.Todos los clientes cuyo apellido termine con “ez”.
select *
from CLIENTES
where APELLIDO   like '%ez'


-- 21.Listar todos los clientes cuyo apellido no comience con “p”.
select *
from CLIENTES
where APELLIDO not like 'p%'

--22.Ídem al anterior pero que no comience ni con “p” ni con “z”.
select *
from CLIENTES
where APELLIDO not like 'p%' and APELLIDO not like 'z%'



--Test de valor nulo: is Null
-- 23.Mostrar todos los clientes que no tengan teléfono.

select *
from clientes
where TELEFONO is null

-- 24.Listar apellido, nombre, e-mail de los clientes cuyos direcciones de mail sea conocidas.
select *
from clientes
where EMAIL is not null


--25.Listar apellido, nombre, teléfono de los clientes cuyos teléfono sea conocido.
select APELLIDO, NOMBRE , TELEFONO
from CLIENTES
where TELEFONO is not null

-- Varias condiciones de búsqueda
--26.Listar todas las plantas que comiencen con R y precio superior a $7.

select *
from PLANTAS
where DESCRIPCION like 'p%' and PRECIO > 7

--27.Mostrar todas las plantas cuyo precio sean menor a $ 50 o mayor a $ 100, 
--Mostrar también su precio con un aumento del 10%

select COD_PLANTA, DESCRIPCION, precio 'precio regular', precio*1.10 'nuevo precio'
from PLANTAS
where PRECIO <50 or precio>100

--28.Listar apellido, nombre, teléfono e e-mail de los clientes cuyos direcciones de mail o teléfono sean conocidos.
select APELLIDO, NOMBRE, TELEFONO, EMAIL
from CLIENTES
where EMAIL is not null or TELEFONO is not null


--29.Listar los datos de las plantas cuyos nombres  no comiencen ni con 
--“m” ni con “n” ni con “p” o su precio sea mayor a 50 con una valoración de 
--stock menor a $ 1.000 

select COD_PLANTA, DESCRIPCION, PRECIO, STOCK, STOCK*PRECIO 'valoracion stock'
from PLANTAS
where DESCRIPCION  not like 'M%' and DESCRIPCION  not like 'N%' and  DESCRIPCION  not like 'P%' and PRECIO>50 and STOCK*PRECIO<1000
--- o de esta otra forma
select COD_PLANTA, DESCRIPCION, PRECIO, STOCK, STOCK*PRECIO 'valoracion stock'
from PLANTAS
where DESCRIPCION  not like '[M,N,P]%' and (PRECIO>50 and (STOCK*PRECIO)<5000)







--30.Mostrar todas las plantas cuyo stock sea mayor a 5 y menor a 50 o bien su 
-- precio aumentado en un 15% esté entre 50 y 100. ordenr por descripción

select DESCRIPCION, precio, STOCK,precio*1.5 'precio aumentado'
from PLANTAS
where STOCK > 5 and STOCK<50 or (PRECIO*1.5>50 and PRECIO*1.5<100)



-- 31 .Listado de clientes mostrando apellido y nombre, calle y número.

select c.APELLIDO  +  ',  ' +c.NOMBRE, ca.NOMBRE  , c.ALTURA
from CLIENTES c, CALLES ca
where c.COD_CALLE= ca.COD_CALLE


-- 32.Listado de clientes mostrando apellido, nombre y localidad a la que pertenece
select c.NOMBRE + ',  ' + c.APELLIDO 'Nombre completo', l.NOMBRE 'nombre de localidad'
from CLIENTES c , LOCALIDADES l
where c.COD_LOCALIDAD= l.COD_LOCALIDAD



--33.Listado de clientes mostrando apellido, nombre y barrio al que pertenece.
select c.NOMBRE + ',  ' + c.APELLIDO 'Nombre completo', b.NOMBRE
from CLIENTES c , BARRIOS b
where c.COD_BARRIO= b.COD_BARRIO


--34.Todas las facturas abonadas en efectivo, ordenada por código de cliente.
select C.APELLIDO + ',  ' + C.NOMBRE 'nombre completo', f.NRO_FACTURA, f.COD_FORMA_PAGO, fp.DESCRIPCION,f.COD_CLIENTE 
from FACTURAS f, FORMAS_PAGO fp, CLIENTES C
where f.COD_FORMA_PAGO= fp.COD_FORMA_PAGO
and f.COD_CLIENTE=c.COD_CLIENTE

AND FP.DESCRIPCION='EFECTIVO'
order by COD_CLIENTE


-- 35.Listar todas plantas donde el tipo de planta sea Flores.


select p.DESCRIPCION , tp.NOMBRE 'Tipo de planta'
from PLANTAS p, TIPOS_PLANTAS tp
where p.COD_TIPO_PLANTA=tp.COD_TIPO_PLANTA and tp.NOMBRE='FLORES'



--36.Todos los clientes cuya localidad sea AREQUITO.

SELECT C.APELLIDO, C.NOMBRE, L.NOMBRE
FROM CLIENTES C, LOCALIDADES L
WHERE C.COD_LOCALIDAD=L.COD_LOCALIDAD AND L.NOMBRE='AREQUITO'


--37.Todos los registros completos de clientes cuyo IVA sea igual a Monotributo, ordenado por localidad

SELECT *
FROM CLIENTES C, CONDICIONES_IVA CIVA , LOCALIDADES L
WHERE C.COD_CONDICION_IVA=CIVA.COD_CONDICION_IVA
AND CIVA.DESCRIPCION='MONOTRIBUTISTA'
ORDER BY L.NOMBRE


--38.Listar todos los datos de los clientes que viven en la localidad de Córdoba o  su apellido comience con la letra ‘A’

SELECT  C.APELLIDO, C.NOMBRE,L.NOMBRE 'NOMBRE LOCALIDAD'
FROM CLIENTES C, LOCALIDADES L
WHERE C.COD_LOCALIDAD=L.COD_LOCALIDAD
AND (L.NOMBRE='CORDOBA' OR C.APELLIDO LIKE 'A%' )


-- 39.Listar clientes que viven en la localidad de Carlos Paz, Alta Gracia y Cba  Capital.

SELECT C.APELLIDO, C.NOMBRE , L.NOMBRE 'LOCALIDAD'
FROM CLIENTES C, LOCALIDADES L
WHERE C.COD_LOCALIDAD= L.COD_LOCALIDAD
AND  L.NOMBRE IN ('CARLOS PAZ','ALTA GRACIA','CORDOBA' )


-- 40.Mostrar todos los clientes que no viven en las localidades de AREQUITO y  MERLO.
SELECT C.APELLIDO, C.NOMBRE , L.NOMBRE 'LOCALIDAD'
FROM CLIENTES C, LOCALIDADES L
WHERE C.COD_LOCALIDAD= L.COD_LOCALIDAD
AND  L.NOMBRE NOT IN ('AREQUITO','MERLO' )


--41.Mostrar nombre, apellido y barrio de los clientes de Cba. Capital o de aquellos 
-- cuyos apellidos no comiencen con letras de la ‘D’a la ‘P’. Ordenar por barrio.

select c.APELLIDO, c.NOMBRE, l.NOMBRE 'localidad', b.NOMBRE 'barrio'
from CLIENTES c, BARRIOS b, LOCALIDADES l
where (c.COD_BARRIO=b.COD_BARRIO 
and c.COD_LOCALIDAD= l.COD_LOCALIDAD)
and (l.NOMBRE='cordoba' )
or (c.APELLIDO not like '[d-p]%')
order by b.NOMBRE


--42.Listar el detalle de la factura calculando la cantidad por el precio.
select f.NRO_FACTURA, df.COD_DETALLE, df.CANTIDAD, p.PRECIO, PRECIO*CANTIDAD 'Precio por item'
from DETALLES_FACTURAS df, PLANTAS p, FACTURAS f
where (f.NRO_FACTURA= df.NRO_FACTURA)
and (df.COD_PLANTA= p.COD_PLANTA)

order by f.NRO_FACTURA


--43.Listar todos los clientes que vivan en provincias que comiencen con 'San' y  que sea Monotributista.select c.APELLIDO, c.NOMBRE, l.NOMBRE 'localidad', iva.DESCRIPCION 'condicion IVA'from CLIENTES c, LOCALIDADES l, CONDICIONES_IVA ivawhere (c.COD_LOCALIDAD=l.COD_LOCALIDADand c.COD_CONDICION_IVA=iva.COD_CONDICION_IVA)and l.NOMBRE like 'SAN%' and iva.DESCRIPCION like 'MONOTRIBUTISTA'-- 44.Listar todos los clientes que viven en barrio Alberdi, Alta Córdoba y que además posean teléfonoSELECT C.APELLIDO + ',  '+C.NOMBRE 'CLIENTE', C.TELEFONO, B.NOMBRE 'BARRIO'  FROM CLIENTES C, BARRIOS BWHERE C.COD_BARRIO= B.COD_BARRIOAND B.NOMBRE IN ('ALTO ALBERDI','ALTA CORDOBA')AND C.TELEFONO IS NOT NULLORDER BY B.NOMBRE----------------- del 31 al 44 con FULL JOIN--31.Listado de clientes mostrando apellido y nombre, calle y número.

select c.APELLIDO, c.NOMBRE CLIENTE, ca.NOMBRE 'calle', c.ALTURA
from CLIENTES c
join CALLES ca
on c.COD_CALLE = ca.COD_CALLE




-- 32.Listado de clientes mostrando apellido, nombre y localidad a la que pertenece

select c.APELLIDO, c.NOMBRE, l.NOMBRE 'Localidad'
from clientes c
join LOCALIDADES l
on c.COD_LOCALIDAD = l.COD_LOCALIDAD



----33.Listado de clientes mostrando apellido, nombre y barrio al que pertenece.

select c.APELLIDO, c.NOMBRE, b.NOMBRE 'Barrio'
from CLIENTES c
join BARRIOS b
on c.COD_BARRIO= b.COD_BARRIO

--34.Todas las facturas abonadas en efectivo, ordenada por código de cliente.

select f.NRO_FACTURA,f.COD_CLIENTE,fp.DESCRIPCION
from FACTURAS f
join FORMAS_PAGO fp
on f.COD_FORMA_PAGO= fp.COD_FORMA_PAGO
where DESCRIPCION like 'efectivo'
order by DESCRIPCION




--35.Listar todas plantas donde el tipo de planta sea Flores
select P.COD_PLANTA, P.DESCRIPCION, P.PRECIO, TP.NOMBRE 'TIPO DE PLANTA'
from PLANTAS p
join TIPOS_PLANTAS tp
on p.COD_TIPO_PLANTA= tp.COD_TIPO_PLANTA
where tp.NOMBRE like 'FLORES'


--36.Todos los clientes cuya localidad sea AREQUITO.

SELECT C.APELLIDO, C.NOMBRE, L.NOMBRE 'LOCALIDAD'
FROM CLIENTES C
JOIN LOCALIDADES L
ON C.COD_LOCALIDAD= L.COD_LOCALIDAD
WHERE L.NOMBRE LIKE 'AREQUITO'


--37.Todos los registros completos de clientes cuyo IVA sea igual a Monotributo, ordenado por localidad.

SELECT *
FROM CLIENTES C
JOIN CONDICIONES_IVA IVA 
ON  C.COD_CONDICION_IVA= IVA.COD_CONDICION_IVA 
JOIN LOCALIDADES L
ON C.COD_LOCALIDAD= l.COD_LOCALIDAD
WHERE IVA.DESCRIPCION LIKE 'MONOTRIBUTISTA'
ORDER BY L.NOMBRE


------ ver el 37 del join comunhaceun fill join

--38.Listar todos los datos de los clientes que viven en la localidad de Córdoba o su apellido comience con la letra ‘A’


select *
from CLIENTES c
join LOCALIDADES l
on c.COD_LOCALIDAD= l.COD_LOCALIDAD
where ( l.NOMBRE='CORDOBA' OR C.APELLIDO LIKE 'A%')



---39.Listar clientes que viven en la localidad de Carlos Paz, Alta Gracia y Cba  Capital.

select *
from CLIENTES c
join LOCALIDADES l
on c.COD_LOCALIDAD= l.COD_LOCALIDAD
WHERE  l.NOMBRE IN ('CORDOBA','ALTA GRACIA', 'CARLOS PAZ')


--40.Mostrar todos los clientes que no viven en las localidades de AREQUITO y  MERLO.


select *
from CLIENTES c
join LOCALIDADES l
on c.COD_LOCALIDAD= l.COD_LOCALIDAD
WHERE  l.NOMBRE NOT IN ('AREQUITO', 'MERLO')



-- 41.Mostrar nombre, apellido y barrio de los clientes de Cba. Capital o de aquellos 
--cuyos apellidos no comiencen con letras de la ‘D’a la ‘P’. Ordenar por barrio.
select c.nombre, c.apellido, b.NOMBRE 'BARRIO'
FROM CLIENTES C
JOIN BARRIOS b
on c.COD_BARRIO= b.COD_BARRIO
where (B.NOMBRE='CORDOBA') OR (C.APELLIDO NOT LIKE '[D-P]%')


--42.Listar el detalle de la factura calculando la cantidad por el precio

SELECT DF.NRO_FACTURA, DF.COD_DETALLE, DF.CANTIDAD, P.PRECIO, DF.CANTIDAD* P.PRECIO 'PRECIO POR ITEM FACTURADO'
FROM DETALLES_FACTURAS DF
JOIN PLANTAS P
ON DF.COD_PLANTA= P.COD_PLANTA
JOIN FACTURAS F
ON DF.NRO_FACTURA = F.NRO_FACTURA



--43.Listar todos los clientes que vivan en provincias que comiencen con 'San' y que sea Monotributista.
SELECT C.APELLIDO, C.NOMBRE, L.NOMBRE 'LOCALIDAD', IVA.DESCRIPCION 'CONDICION IVA'
FROM CLIENTES C
JOIN LOCALIDADES L
ON C.COD_PROVINCIA= L.COD_LOCALIDAD
JOIN CONDICIONES_IVA IVA
ON C.COD_CONDICION_IVA= IVA.COD_CONDICION_IVA
WHERE (L.NOMBRE LIKE 'SAN%') AND (IVA.DESCRIPCION  LIKE 'MONOTRIBUTISTA')



--44.Listar todos los clientes que viven en barrio Alberdi, Alta Córdoba y que además posean teléfono
SELECT *
FROM CLIENTES C
JOIN BARRIOS B
ON C.COD_BARRIO= B.COD_BARRIO
WHERE B.NOMBRE IN ('ALBERDI', 'ALTA CORDOBA') AND C.TELEFONO IS NOT NULL



---Problema N° 4: Resuelva utilizando JOIN los siguientes reportes

--2. Genere un reporte con los datos de la facturación (datos de las facturas 
--incluidos los del vendedor y cliente) de los años 2006, 2007, 2009 y 2012.

select *
from FACTURAS




