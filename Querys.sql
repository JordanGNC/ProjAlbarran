--Querys

--DimTiempo
	SELECT venta_id, fecha, DAY(fecha) dia, MONTH(fecha) mes, YEAR(fecha) anio, DATEPART(QUARTER, fecha) trimestre  FROM Albarran..ventas

--DimProducto
	SELECT producto_id, productos.nombre, cat.categoria, productos.precio FROM Albarran..Productos
	JOIN Albarran..categorias cat ON productos.categoria_id = cat.categoria_id;

--DimCliente
	SELECT cliente_id ,nombre + ' ' + appaterno + ' ' + apmaterno nombre_cli, fecha_nacimiento, sexo FROM Albarran..clientes

--DimEmpleado
	SELECT empleado_id, empleados.nombre + ' ' + appaterno + ' ' + apmaterno nombre_emp, c.nombre cargo FROM Albarran..empleados
	JOIN Albarran..cargos c ON empleados.cargo_id = c.cargo_id

--DimSucursal
	SELECT sucursal_id, sucursal, com.comuna FROM Albarran..sucursales
	JOIN Albarran..comunas com ON sucursales.comuna_id = com.comuna_id
	
--FactVentas
	SELECT dv.venta_id, t.ID_Tiempo, dv.producto_id, c.ID_Cliente, e.ID_Empleado, s.ID_Sucursal, dv.cantidad, dv.ptotal
		FROM(SELECT v.venta_id, v.fecha, v.cliente_id,v.vendedor_id, d.producto_id, d.cantidad, v.sucursal_id, (d.cantidad*d.precio_unitario) ptotal FROM Albarran..ventas v
		INNER JOIN Albarran..detalle_ventas d ON v.venta_id = d.venta_id) dv
	INNER JOIN DimProducto p ON dv.producto_id = p.ID_Producto
	JOIN DimTiempo t ON dv.venta_id = t.ID_Tiempo
	JOIN DimCliente c ON dv.cliente_id = c.ID_Cliente
	JOIN DimEmpleado e ON dv.vendedor_id = e.ID_Empleado
	JOIN DimSucursal s ON dv.sucursal_id = s.ID_Sucursal