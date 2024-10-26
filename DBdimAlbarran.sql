-- tabla de Dimensión de Tiempo (DimTiempo)
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DimTIempo')
	CREATE TABLE DimTiempo (
		ID_Tiempo INT PRIMARY KEY,
		Fecha DATE NOT NULL,
		Dia INT NOT NULL,
		Mes INT NOT NULL,
		Año INT NOT NULL,
		Trimestre INT NOT NULL
);

-- tabla de Dimensión de Producto (DimProducto)
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DimProducto')
	CREATE TABLE DimProducto (
		ID_Producto INT PRIMARY KEY,
		Nombre_Producto NVARCHAR(100) NOT NULL,
		Categoria_Producto NVARCHAR(50) NOT NULL,
		Precio_Producto INT NOT NULL
	);

-- tabla de Dimensión de Cliente (DimCliente)
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DimCliente')
	CREATE TABLE DimCliente (
		ID_Cliente INT PRIMARY KEY,
		Nombre_Cliente NVARCHAR(100) NOT NULL,
		Fechanac_Cliente DATE NOT NULL,
		Sexo_Cliente CHAR(1) NOT NULL
	);

-- tabla de Dimensión de Empleado (DimEmpleado)
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DimEmpleado')
	CREATE TABLE DimEmpleado (
		ID_Empleado INT PRIMARY KEY ,
		Nombre_Empleado NVARCHAR(100) NOT NULL,
		Cargo NVARCHAR(50) NOT NULL
	);

-- tabla de Dimensión de Sucursal (DimSucursal)
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DimSucursal')
CREATE TABLE DimSucursal (
    ID_Sucursal INT PRIMARY KEY ,
    Nombre_Sucursal NVARCHAR(100) NOT NULL,
    Ubicacion_Sucursal NVARCHAR(100) NOT NULL
);

-- tabla de hechos (FactVentas)
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'FactVentas')
CREATE TABLE FactVentas (
    ID_Venta INT PRIMARY KEY,
    ID_Tiempo INT NOT NULL,
    ID_Producto INT NOT NULL,
    ID_Cliente INT NOT NULL,
    ID_Empleado INT NOT NULL,
    ID_Sucursal INT NOT NULL,
    Cantidad_Vendida INT NOT NULL,
    Total_Venta INT NOT NULL
	-- claves foráneas
	FOREIGN KEY (ID_Tiempo) REFERENCES DimTiempo(ID_Tiempo),
	FOREIGN KEY (ID_Producto) REFERENCES DimProducto(ID_Producto),
	FOREIGN KEY (ID_Cliente) REFERENCES DimCliente(ID_Cliente),
	FOREIGN KEY (ID_Empleado) REFERENCES DimEmpleado(ID_Empleado),
	FOREIGN KEY (ID_Sucursal) REFERENCES DimSucursal(ID_Sucursal)
);

