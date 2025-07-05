/*These are the queries that we need to create userDataTables*/

--1. We first select the database to use

USE Supply_Chain
GO;


--1.1 Creating Schema for users information

CREATE SCHEMA usersInfo;
GO;



--2. This is main table of webapp users, basic information and credentials
CREATE TABLE usersInfo.usersAccessInfo
(
	[Id] INT IDENTITY(1,1) PRIMARY KEY,
	[idUser] VARCHAR(250),
	[name] VARCHAR(250),
	[lastName] VARCHAR(250),
	[passwordSalt] VARCHAR(800),
	[passwordHashing] VARCHAR(800),
	[userType] INT,
	[userEmail] NVARCHAR(500) UNIQUE,
	[userEmailConfirm] BIT,

);

GO;

--3 This is the main table of the webappLogs}
CREATE TABLE usersInfo.userLogs
(
	[id] INT IDENTITY(1,1) PRIMARY KEY,
	[idUserInfo] INT,
	[logDateStart] INT,
	[logsDateEnd] INT,
	[logActive] BIT,
	[logTryOk] BIT,
	CONSTRAINT Fk_usersAccessInfo FOREIGN KEY(idUserInfo)
		REFERENCES usersInfo.usersAccessInfo(Id)
);
GO;

--4.- We then create the schema for items

CREATE SCHEMA supplyItems;
GO;

--5.- This is table with items on list


CREATE TABLE supplyItems.inventoryItems
(
    Id INT IDENTITY(1,1) PRIMARY KEY,         -- ID único del producto
    ItemName VARCHAR(400) NOT NULL,           -- Nombre del producto
    ItemDescription VARCHAR(1000),            -- Descripción del producto
    ItemPrice DECIMAL(18,2) NOT NULL,         -- Precio unitario
    ItemImage VARCHAR(1000),                  -- Ruta/URL de imagen
    CategoryName VARCHAR(100),                -- Categoría del producto
    DepartmentName VARCHAR(100),              -- Departamento (opcional)
	ProductImage VARCHAR(1000),				  -- Esta es la ruta de la imagen
    Stock INT NOT NULL DEFAULT 0,             -- Cantidad disponible
    IsActive BIT NOT NULL DEFAULT 1,          -- Producto activo o no
    CreatedAt DATETIME DEFAULT GETDATE()      -- Fecha de creación
);
GO;



-- 6.- We now insert data from masterList to inventory table


BEGIN TRAN
INSERT INTO supplyItems.inventoryItems (ItemName,  ItemDescription,ItemPrice, ItemImage, CategoryName, DepartmentName,ProductImage)
SELECT 
	
    DISTINCT ProductName,
	ProductDescription,
    ProductPrice,
    ProductImage,
    CategoryName,
    DepartmentName,
	ProductImage
	
FROM supplyChainMaster.masterListItems















