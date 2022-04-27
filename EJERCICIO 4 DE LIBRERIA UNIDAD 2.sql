
/*
Problema 4  --- con la base de datos de la libreria




1. Se quiere tener un listado de los vendedores y los barrios donde viven y se 
quieren tener incluidos los barrios, aunque no tengamos vendedores viviendo 
en ellos */

select * 
from vendedores

select b.cod_barrio, b.barrio, v.cod_vendedor, v.ape_vendedor + ', ' + v.nom_vendedor
from barrios b
left join vendedores v
on b.cod_barrio = v.cod_barrio


--2. Genere un reporte con los datos de la facturación (datos de las facturas 
--incluidos los del vendedor y cliente) de los años 2006, 2007, 2009 y 2012. 

select f.nro_factura, year( f.fecha), c.ape_cliente + ', '+ c.nom_cliente 'Cliente' , v.ape_vendedor + ', '+v.nom_vendedor 'Vendedor'
from facturas f
join vendedores v
on f.cod_vendedor = v.cod_vendedor
join clientes c
on f.cod_cliente = c.cod_cliente
where  year( f.fecha) in  (2006,2007,2009,2012)


---3. Liste los datos de la facturación, de los artículos y de la venta de las facturas correspondientes al mes pasado.select  df.nro_factura, df.cod_articulo, df.pre_unitario, a.descripcion 'Articulo', year(f.fecha)'año', month(f.fecha)'Mes'from detalle_facturas df join articulos aon df.cod_articulo= a.cod_articulojoin facturas fon df.nro_factura = f.nro_facturawhere MONTH (f.fecha) = (month (getdate())-1) AND  YEAR(f.fecha) = year(getdate())-----4. Emita un listado con los datos del vendedor y las ventas que ha realizado en 
--lo que va del año. Muestre los vendedores aun así no tengan ventas 
--registradas en el año solicitado.SELECT v.ape_vendedor+', '+ v.nom_vendedor'Vendedor', f.nro_factura, f.fechaFROM vendedores VLEFT JOIN facturas fON V.cod_vendedor=F.cod_vendedorand (YEAR(f.fecha) = year(getdate())) and (MONTH (f.fecha) <= (month (getdate())))order by f.fecha-- 5. Liste descripción, cantidad e importe; aun para aquellos artículos que no  registran ventas.select a.descripcion, df.cantidad, a.pre_unitariofrom articulos aleft join detalle_facturas dfon a.cod_articulo= df.cod_articulo/*--6. Genere un reporte con los datos de la facturación (datos de las facturas 
incluidos los del vendedor y cliente) y de la venta (incluido el importe); para las 
ventas de febrero y marzo de los años 2006 y 2007 y siempre que el artículo 
empiece con letras que van de la “a” a la “m”. Ordene por fecha, cliente y 
artículo*/select f.nro_factura, year(f.fecha) 'Año',month(f.fecha)'Mes'  ,a.descripcion'Articulo', df.pre_unitario, f.fecha, v.ape_vendedor +', ' + v.nom_vendedor 'Vendedor', c.ape_cliente +', '+ c.nom_cliente 'Cliente'from detalle_facturas df join facturas fon f.nro_factura=df.nro_facturajoin vendedores von f.cod_vendedor= v.cod_vendedorjoin articulos aon df.cod_articulo= a.cod_articulojoin clientes con f.cod_cliente=c.cod_clientewhere (YEAR(f.fecha) in (2006,2007) and MONTH(f.fecha) in (2,4)) and a.descripcion like '[a-m]%'order by f.fecha, c.ape_cliente, c.nom_cliente, a.descripcion--7. Liste código de cliente, nombre, fecha y factura para las ventas del año 2007. 
--Muestre los clientes hayan comprado o no en ese año.select f.cod_cliente, c.ape_cliente + ', '+ c.nom_cliente 'Cliente', year(f.fecha) 'Año', month(f.fecha)'Mes' , f.nro_facturafrom facturas fright join clientes con f.cod_cliente= c.cod_clientewhere year(f.fecha) = 2007---------8. Se quiere saber los artículos que compro la cliente Elvira López en lo que va 
-- del año. Liste artículo, observaciones e importe

select a.descripcion 'Articulos', a.observaciones, a.pre_unitario,c.ape_cliente+ ', '+c.nom_cliente 'Clientes', year(f.fecha)'Año',MONTH(f.fecha)'Mes', day(f.fecha)'Dia'
from facturas f
join detalle_facturas df
on f.nro_factura=df.nro_factura
join articulos a
on df.cod_articulo=a.cod_articulo
join clientes c
on f.cod_cliente= c.cod_cliente
where (c.ape_cliente like 'Luque' and c.nom_cliente like 'Elvira%') and (year(f.fecha) = (YEAR(getdate())))
order by f.fecha



/*9. Se quiere saber los artículos que compraron los clientes cuyos apellidos 
empiezan con “p”. Liste cliente, articulo, cantidad e importe. Ordene por cliente 
y artículo, este en forma descendente. Rotule como CLIENTE, ARTICULO, 
CANTIDAD, IMPORTE*/


select F.nro_factura, c.ape_cliente +', '+ nom_cliente 'CLIENTE', A.descripcion'ARTICULO', DF.cantidad'CANTIDAD', DF.pre_unitario, DF.cantidad * DF.pre_unitario 'IMPORTE'
from clientes c
join facturas f
on c.cod_cliente= f.cod_cliente
join detalle_facturas df
on f.nro_factura= df.nro_factura
join articulos a
on df.cod_articulo= a.cod_articulo
WHERE C.ape_cliente LIKE 'P%'
ORDER BY C.ape_cliente, A.descripcion DESC


-------10.Se necesita mostrar el código, nombre, apellido (todo el apellido en 
--mayúsculas) y dirección (calle y altura en una sola columna; para la altura 
--utilice una función de conversión) de todos los clientes cuyo nombre comience 
--con “C” y cuyo apellido termine con “Z”. Rotule como CÓDIGO DE CLIENTE, 
--NOMBRE, DIRECCIÓN.--SELECT CONVERT(varchar(10), field_name)--SELECT UPPER(ProductName) as ProductName FROM Productsselect  cod_cliente'CODIGO DE CLIENTE',  nom_cliente+', '+UPPER(ape_cliente) 'NOMBRE' ,calle+ ' '+convert (varchar(5), altura) 'DIRECCION'from clienteswhere (nom_cliente like 'C%' and ape_cliente like '%z')

-- 11.Ídem al anterior pero el apellido comience con letras que van de la “D” a la “L” 
-- y cuyo nombre no comience con letras que van de la “A” a la “G”.

select  cod_cliente'CODIGO DE CLIENTE',  nom_cliente+', '+UPPER(ape_cliente) 'NOMBRE' ,calle+ ' '+convert (varchar(5), altura) 'DIRECCION'from clienteswhere ape_cliente like '[D-L]%' and nom_cliente not like '[A-G]%'




----12.Muestre los datos de los vendedores (apellido todo en mayúsculas y en la 
--misma columna que el nombre) cuyo nombre no contenga “Z”, haya nacido en 
--la década del 70 y que haya realizado ventas el mes pasado


SELECT UPPER(ape_vendedor)+', ' + nom_vendedor  , fecha
FROM vendedores V
JOIN facturas F
ON V.cod_vendedor = F.cod_vendedor
WHERE nom_vendedor NOT LIKE '%Z%' AND ((YEAR(fec_nac) >= 1970 AND YEAR(fec_nac) <1980)) 
AND ((YEAR(F.fecha) = (YEAR(GETDATE()) ))AND (MONTH(F.fecha) = MONTH(GETDATE())-1))




-----------------------------------


--EJERCICIO 5 

-------------------------------


--10.Se necesita mostrar el código, nombre, apellido (todo el apellido en 
--mayúsculas) y dirección (calle y altura en una sola columna; para la altura 
--utilice una función de conversión) de todos los clientes cuyo nombre comience 
--con “C” y cuyo apellido termine con “Z”. Rotule como CÓDIGO DE CLIENTE, 
--NOMBRE, DIRECCIÓN.

SELECT C.cod_cliente 'CÓDIGO DE CLIENTE', C.nom_cliente +', ' + UPPER( C.ape_cliente) 'NOMBRE' ,  C.calle +'  ' +CONVERT( VARCHAR (5), C.ALTURA) 'DIRECCION'
FROM clientes C
WHERE C.nom_cliente LIKE 'C%' AND C.ape_cliente LIKE '%Z'


--11.Ídem al anterior pero el apellido comience con letras que van de la “D” a la “L” 
--y cuyo nombre no comience con letras que van de la “A” a la “G”. 

SELECT C.cod_cliente 'CÓDIGO DE CLIENTE', C.nom_cliente +', ' + UPPER( C.ape_cliente) 'NOMBRE' ,  C.calle +'  ' +CONVERT( VARCHAR (5), C.ALTURA) 'DIRECCION'
FROM clientes C
WHERE  C.ape_cliente LIKE '[D-L]%' AND C.nom_cliente NOT LIKE '[A-G]%'


--12.Muestre los datos de los vendedores (apellido todo en mayúsculas y en la 
--misma columna que el nombre) cuyo nombre no contenga “Z”, haya nacido en 
--la década del 70 y que haya realizado ventas el mes pasado.SELECT DISTINCT V.cod_vendedor, UPPER(V.ape_vendedor) +', '+V.nom_vendedor, V.calle, V.altura, V.nro_tel, V.[e-mail], V.fec_nacFROM vendedores VJOIN facturas FON V.cod_vendedor= F.cod_vendedorWHERE V.nom_vendedor NOT LIKE '%Z%' AND (YEAR(V.fec_nac) BETWEEN 1970 AND 1979) AND YEAR(F.fecha) = YEAR(GETDATE()) AND MONTH ( F.fecha) = (MONTH(GETDATE())-1)

--13.Mostrar las facturas realizadas entre el 1/1/2007 y el 1/5/2009 y cuyos códigos 
--de vendedor sean 1, 3 y 4 o bien entre el 1/1/2010 y el 1/5/2011 y cuyos 
--códigos de vendedor sean 2 y 4. Mostrar la fecha en formato Dia, Mes, y Año 
--(en ese orden y sin la hora)



select Convert (varchar, f.fecha,10 ),f.nro_factura, f.cod_cliente, f.cod_vendedor
from facturas f
where  (f.fecha between '01/01/2007' and '01/05/2009'  )and (f.cod_vendedor in (1,3,4))
or  (f.fecha between '01/01/2010' and '01/05/2011'  )and (f.cod_vendedor in (2,4))




--14.Se quiere saber el subtotal de todos los artículos vendidos, para ello liste el 
--artículo y multiplique la cantidad por el precio unitario de venta; mostrar el 
--subtotal redondeado a dos decimales (o buscar la forma de dale formato 
--apropiado). Ordene por alfabéticamente por artículo y cuyo subtotal mayor 
--aparezca primero. No muestre datos duplicados.


select DISTINCT a.descripcion, df.cantidad* a.pre_unitario'Subtotal'
from detalle_facturas df
join articulos a
on df.cod_articulo=a.cod_articulo
order by a.descripcion, Subtotal desc



--15.Muestre las ventas (tabla detalle_facturas) de los artículos cuyo precio unitario 
--actual sea mayor o igual a 50 o cuyos códigos de artículos no sea uno de los 
--siguientes: 2,5, 6, 8, 10. En ambos casos los precios unitarios a los que fueron 
--vendidos oscilen entre 10 y 100.select * from detalle_facturas dfjoin articulos aon df.cod_articulo= a.cod_articulowhere (a.pre_unitario>=50  or a.cod_articulo not in (2,5,6,8,10) ) and (df.pre_unitario between 10 and 100)


--16.Listar todos los datos de los artículos cuyo stock mínimo sea superior a 10 o 
--cuyo precio sea inferior a 20. En ambos casos su descripción no debe 
--comenzar con las letras “p” ni la letra “r”.

select *
from articulos a
where (a.stock_minimo > 10 or a.pre_unitario <20 ) 
and ( a.descripcion  not like 'P%' and a.descripcion not like 'R%')
order by descripcion


--17.Listar los datos de los vendedores nacidos en febrero, abril, mayo o 
--septiembre.

select *
from vendedores v
where MONTH( v.fec_nac) in (2,4,5,9)


--18.Liste número de factura, fecha de venta y vendedor (apellido y nombre), para 
--los casos en que los códigos del cliente van del 2 al 6. Ordene por vendedor 
--y fecha, ambas en forma descendente.
select f.nro_factura, f.fecha, v.ape_vendedor +', '+ v.nom_vendedor 'Vendedor'
from facturas f
join vendedores v
on f.cod_vendedor = v.cod_vendedor
where f.cod_cliente like '[2-6]'
order by f.cod_vendedor desc, f.fecha desc


--19.Emitir un reporte con los datos de la factura del cliente y del vendedor de 
--aquellas facturas confeccionadas entre el primero de febrero del 2008 y el 
--primero de marzo del 2010 y que el apellido del cliente no contenga “C”.

select * 
from facturas f
join clientes c
on f.cod_cliente=c.cod_cliente
join vendedores v
on f.cod_vendedor= v.cod_vendedor
where (f.fecha between '01/02/2008' and '01/03/2010')
and c.ape_cliente not like 'C%'


--20.Listar los datos de la factura, los del artículo y el importe (precio por cantidad); 
--para las facturas emitidas en el 2010, 2015 y 2017 y la descripción no 
--comience con “R”. Ordene por número de factura e importe, este en forma 
--descendente. Rotule.


select Convert (varchar, f.fecha,10 ), df.nro_factura, c.ape_cliente +', '+ c.nom_cliente 'Cliente' , v.ape_vendedor +', '+ v.nom_vendedor 'Vendedor',a.descripcion,   df.pre_unitario * df.cantidad 'Precio x cantidad'   
from facturas f
join detalle_facturas df
on f.nro_factura= df.nro_factura
join articulos a
on df.cod_articulo= a.cod_articulo
join clientes c
on f.cod_cliente= c.cod_cliente
join vendedores v
on f.cod_vendedor= v.cod_vendedor
where year(f.fecha) in (2010,2015,2017) and a.descripcion not like 'R%' 
order by f.fecha , [Precio x cantidad] desc




--21.Se quiere saber qué artículos se vendieron, siempre que el precio unitario sin 
--iva al que fue vendido no esté entre $10 y $50. Rotule. 

select df.nro_factura, a.descripcion, convert(float,df.pre_unitario *0.79) 'precio sin iva'
from detalle_facturas df
join articulos a
on df.cod_articulo= a.cod_articulo
where (df.pre_unitario*0.79 ) between 10 and 50



--22.Liste todos los datos de la factura (vendedor, cliente, artículo, incluidos los 
--datos de la venta: cantidad, precio y subtotal); emitidas a clientes con teléfonos 
--o direcciones de e-mail conocidas de aquellas facturas cuyo importe haya sido 
--superior a $250. Agregue rótulos y ordene el listado para darle mejor 
--presentación.


select f.nro_factura, c.ape_cliente +', '+ c.nom_cliente'Cliente', v.ape_vendedor +', '+ v.nom_vendedor'Vendedor', a.descripcion,
 df.pre_unitario,df.cantidad, df.pre_unitario* df.cantidad'Total x art'
from facturas f
join detalle_facturas df
on f.nro_factura= df.nro_factura
join clientes c
on f.cod_cliente= c.cod_cliente
join vendedores v
on f.cod_vendedor= v.cod_vendedor
join articulos a
on df.cod_articulo= a.cod_articulo
where (c.[e-mail] is not null or c.nro_tel is not null) and (df.pre_unitario* df.cantidad)>250



--23.Se quiere saber a qué cliente, de qué barrio, vendedor y en qué fecha se les 
--vendió con los siguientes nros. de factura: 12, 18, 1, 3, 35, 26 y 29.¿El barrio 
--del cliente es el mismo que el barrio del vendedor que les vendío?


select f.fecha, c.ape_cliente+', '+ c.nom_cliente 'Cliente', c.cod_barrio, b.barrio, v.ape_vendedor +', '+ v.nom_vendedor 'Vendedor', v.cod_barrio
from facturas f
join clientes c
on f.cod_cliente=c.cod_cliente
join vendedores v
on f.cod_vendedor= v.cod_vendedor
join barrios b
on c.cod_barrio= b.cod_barrio or v.cod_barrio= b.cod_barrio
where f.nro_factura in  (12,18,1,3,35,26,29)







---------  En esta consulta mmuestro sola las ft que el vendedor y el cliente son del mismo barrio-----------

select f.fecha, c.ape_cliente+', '+ c.nom_cliente 'Cliente', c.cod_barrio, b.barrio, v.ape_vendedor +', '+ v.nom_vendedor 'Vendedor', v.cod_barrio
from facturas f
join clientes c
on f.cod_cliente=c.cod_cliente
join vendedores v
on f.cod_vendedor= v.cod_vendedor
join barrios b
on c.cod_barrio= b.cod_barrio and v.cod_barrio= b.cod_barrio
where f.nro_factura in  (12,18,1,3,35,26,29)







--24.Emitir un reporte para informar qué artículos se vendieron, en las facturas 
--cuyos números no esté entre 17 y 136. Liste la descripción, cantidad e importe
--(Importe=cantidad*pre_unitario). Ordene por descripción y cantidad. No 
--muestre las filas con valores duplicados


select DISTINCT a.descripcion, df.cantidad, df.cantidad*df.pre_unitario 'Importe' 
from facturas f
join detalle_facturas df
on f.nro_factura= df.nro_factura
join articulos a
on df.cod_articulo= a.cod_articulo
where  f.nro_factura not between 17 and 136
order by a.descripcion, df.cantidad


--25.Listar los datos de las facturas (cliente, artículo, incluidos los datos de la venta 
--incluido el importe) emitidas a los clientes cuyos apellidos comiencen con 
--letras que van de la “l” a “s” o los artículos vendidos que tengan descripciones 
--que comiencen con las mismas letras. Ordenar el listado

select f.nro_factura, c. ape_cliente +', '+ c.nom_cliente'Cliente', a.descripcion, df.cantidad, df.pre_unitario,df.cantidad* df.pre_unitario 'Importe'
from facturas f
join detalle_facturas df
on f.nro_factura= df.nro_factura
join articulos a
on df.cod_articulo= a.cod_articulo
join clientes c
on f.cod_cliente= c.cod_cliente
where c.ape_cliente like '[l-s]%' or a.descripcion like '[l-s]%'
order by Cliente asc


--26. Realizar un reporte de los artículos que se vendieron en lo que va del año. 
--(Muestre los datos que sean significativos para el usuario del sistema usando 
--rótulos para que sea más legible y que los artículos no se muestren repetidos).

select f.nro_factura,convert( varchar,f.fecha ,10) 'Fecha',c.ape_cliente +', '+c.nom_cliente 'Cliente'  ,  a.descripcion'Articulo', a.pre_unitario'precio actual'
from facturas f
join detalle_facturas df
on f.nro_factura=df.nro_factura
join articulos a
on df.cod_articulo=a.cod_articulo
join clientes c
on f.cod_cliente=c.cod_cliente
where  year(f.fecha)=year(getdate()) and MONTH(f.fecha) <= MONTH(getdate())




--27. Se quiere saber a qué clientes se les vendió el año pasado, qué vendedor le 
--realizó la venta, y qué artículos compró, siempre que el vendedor que les 
--vendió sea menor de 35 años. 

select c.ape_cliente +', '+ c.nom_cliente'Cliente', v.ape_vendedor +', '+ v.nom_vendedor'Vendedor', f.fecha, a.descripcion,DATEDIFF(day, v.fec_nac, getdate())'Edad en dias'
from facturas f
join detalle_facturas df
on f.nro_factura=df.nro_factura
join articulos a
on df.cod_articulo=a.cod_articulo
join vendedores v
on f.cod_vendedor= v.cod_vendedor
join clientes c
on f.cod_cliente= c.cod_cliente
where (DATEDIFF(day, v.fec_nac, getdate())<12775) and year(f.fecha) = YEAR(getdate())-1 -- 12775= a los dias que hay en 35 años



--28. El usuario de este sistema necesita ver el listado de facturas, de aquellos 
--artículos cuyos precios unitarios a los que fueron vendidos estén entre 50 y 
--100 y de aquellos vendedores cuyo apellido no comience con letras que van 
--de la “l” a la “m”. Ordenado por vendedor, fecha e importe.
select convert(varchar,f.fecha,10) 'Fecha', df.nro_factura, a.descripcion, df.pre_unitario,df.cantidad,df.pre_unitario * df.cantidad 'Importe', 
vendedores.ape_vendedor +', '+ vendedores.nom_vendedor'Vendedor'
from facturas f
join detalle_facturas df
on f.nro_factura=df.nro_factura
join vendedores
on f.cod_vendedor= vendedores.cod_vendedor
join  articulos a
on df.cod_articulo=a.cod_articulo
where df.pre_unitario between 50 and 100 and vendedores.ape_vendedor not like '[l-m]%'
order by Vendedor, f.fecha, Importe




--29.Se desea emitir un listado de clientes que compraron en enero, además saber 
--qué compraron cuánto gastaron (mostrar los datos en forma conveniente)

select f.fecha, df.nro_factura, c.ape_cliente +', '+ c.nom_cliente 'Cliente', a.descripcion, df.pre_unitario,df.cantidad,df.pre_unitario * df.cantidad 'Importe', 
vendedores.ape_vendedor +', '+ vendedores.nom_vendedor'Vendedor'
from facturas f
join detalle_facturas df
on f.nro_factura=df.nro_factura
join vendedores
on f.cod_vendedor= vendedores.cod_vendedor
join  articulos a
on df.cod_articulo=a.cod_articulo
join clientes c
on f.cod_cliente=c.cod_cliente
where MONTH( f.fecha) = '01'




--30.Emitir un reporte de artículos vendidos en el 2010 a qué precios se vendieron
-- y qué precio tienen hoy. Mostrar el porcentaje de incremento

select f.nro_factura, a.descripcion, df.pre_unitario 'precio de venta', a.pre_unitario 'Precio actual', floor(a.pre_unitario/ df.pre_unitario*100)    '% incremento'
from facturas f
join detalle_facturas df 
on f.nro_factura=df.nro_factura
join articulos a
on df.cod_articulo=a.cod_articulo
where YEAR( f.fecha) =2010



--31.Listar los vendedores que hace 10 años les vendieron a clientes cuyos 
--nombres o apellidos comienzan con "C".


select f.fecha, v.ape_vendedor+', '+ v.nom_vendedor 'Vendedor', c.ape_cliente+', '+ c.nom_cliente 'Cliente'
from facturas f
join detalle_facturas df
on f.nro_factura= df.cod_articulo
join vendedores v
on f.cod_vendedor = v.cod_vendedor
join clientes c
on  f.cod_cliente= c.cod_cliente
where YEAR( f.fecha) = year(GETDATE())-14 and (c.ape_cliente like 'C%' or c.nom_cliente like 'C%')
order by f.fecha



--32.El encargado de la librería necesita tener información sobre los artículos que 
--se vendían a menos de $ 20 antes del 2015. Mostrar los datos que se 
--consideren relevantes para el encargado, formatear, rotular y ordenar.


select (f.fecha)  , f.nro_factura,   a.descripcion, df.pre_unitario'precio vendido', a.pre_unitario 'Precio Actual'
from facturas f
join detalle_facturas df
on f.nro_factura= df.cod_articulo
join vendedores v
on f.cod_vendedor = v.cod_vendedor
join clientes c
on  f.cod_cliente= c.cod_cliente
join articulos a
on df.cod_articulo= a.cod_articulo
where YEAR( f.fecha) < 2015 and df.pre_unitario< 20

order by f.fecha
--- revisar el ultimo





