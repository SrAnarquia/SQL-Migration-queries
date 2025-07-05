
/*We begin with the database creation*/
CREATE DATABASE Supply_Chain
GO;

/*We select data base to work on it*/
USE Supply_Chain
GO;

/*Creation the shcemas to work on its*/
CREATE SCHEMA logsInteractionsUsers
GO;

CREATE SCHEMA supplyChainMaster
GO;



/*Create database main and staging for data migration from csv files*/

CREATE TABLE logsInteractionsUsers.userInteractionItemsCopy
(
[Id] INT IDENTITY(1,1) PRIMARY KEY,
[Product] VARCHAR(500),
[Category] VARCHAR(250),
[Date] VARCHAR (250),
[Month] VARCHAR(15),
[Hour] VARCHAR(10),
[Department] VARCHAR(30),
[IP] VARCHAR(200),
[URL] VARCHAR(1000)
)
GO;

CREATE TABLE logsInteractionsUsers.userInteractionItems
(
[Id] INT IDENTITY(1,1) PRIMARY KEY,
[Product] VARCHAR(500),
[Category] VARCHAR(250), 
[Date] DATETIME,
[Month] VARCHAR(15),
[Hour] INT,
[Department] VARCHAR(30),
[IP] VARCHAR(200),
[URL] VARCHAR(1000)
);
GO;



/*We now bulk insert into copy table of logs*/
BEGIN TRAN
BULK INSERT logsInteractionsUsers.userInteractionItemsCopy
FROM 'C:\Users\korpu\OneDrive\Escritorio\Excel to Web development\DataBase Excel\tokenized_access_logs.csv'
WITH
(
	FIRSTROW=2,
	FIELDTERMINATOR=','

);
GO;

--ROLLBACK  /*In case of errors use this rollback*/
--COMMIT    /*In case everything was okay then commit the transaction*/





/*Data insert from copy to main with values converted into correct expected data*/
BEGIN TRAN
INSERT INTO logsInteractionsUsers.userInteractionItems
SELECT 
[Product],
[Category],
CONVERT(DATETIME,[Date]),
CONVERT(INT,[Hour]),
[Hour],
[Department],
[IP],
[URL]
FROM logsInteractionsUsers.userInteractionItemsCopy
GO;

--ROLLBACK  /*In case of errors use this rollback*/
--COMMIT    /*In case everything was okay then commit the transaction*/


/*We begin to create the table for lists of items*/

CREATE TABLE supplyChainMaster.masterListItemsCopy
(
[Id] INT IDENTITY(1,1) PRIMARY KEY,
[Type] VARCHAR(500),
[DaysForShipReal] VARCHAR(30),
[DaysForShipmentScheduled] VARCHAR(30),
[BenefitPerOrder] VARCHAR(50),
[SalesPerCustomer] VARCHAR(50),
[DeliveryStatus] VARCHAR(50),
[LateDelivery] VARCHAR(50),
[CategoryId] VARCHAR(20),
[CategoryName] VARCHAR(50),
[CustomerCity] VARCHAR(100),
[CustomerCountry] VARCHAR(100),
[CustomerEmail] NVARCHAR(100),
[CustomerFName] VARCHAR(100),
[CustomerId] VARCHAR(30),
[CustomerLName] VARCHAR(500),
[CustomerPassword] NVARCHAR(600),
[CustomerSegment] VARCHAR(100),
[CustomerState] VARCHAR(20),
[CustomerStreet] VARCHAR(120),
[CustomerZipCode] VARCHAR(30),
[DepartmentId] VARCHAR(30),
[DepartmentName] VARCHAR(500),
[Latitude] VARCHAR(50),
[Longtude] VARCHAR(50),
[Market] VARCHAR(250),
[OrderCity] VARCHAR(250),
[OrderCountry] VARCHAR(250),
[OrderCustomerId] VARCHAR(30),
[OrderDateDateOrders] VARCHAR(100),
[OrderId] VARCHAR(30),
[OrderCardpordId] VARCHAR(30),
[OrderItemDiscount] VARCHAR(50),
[OrderDiscountRate] VARCHAR(50),
[OrderItemId] VARCHAR(30),
[OrderItemProductPrice] VARCHAR(50),
[OrderItemProfitRatio] VARCHAR(50),
[OrderItemQuantity] VARCHAR(30),
[Sales] VARCHAR(50),
[OrderItemTotal] VARCHAR(30),
[OrderProfitPerOrder] VARCHAR(50),
[OrderRegion] VARCHAR(250),
[OrderState] VARCHAR(250),
[OrderStatus] VARCHAR(250),
[OrderZipCode] VARCHAR(50),
[ProductCardId] VARCHAR(30),
[ProductCategoryId] VARCHAR(30),
[ProductDescription] VARCHAR(3000),
[ProductImage] VARCHAR(1000),
[ProductName] VARCHAR(300),
[ProductPrice] VARCHAR(50),
[ProductStatus] VARCHAR(40),
[ShippingDateDateOrders] DATETIME,
[ShippingMode] VARCHAR(200)
);
GO;



/*We then now create the main table with corrected data from copy table*/
CREATE TABLE supplyChainMaster.masterListItems
(
[Id] INT IDENTITY(1,1) PRIMARY KEY,
[Type] VARCHAR(500),
[DaysForShipReal] INT,
[DaysForShipmentScheduled] INT,
[BenefitPerOrder] DECIMAL(18,2),
[SalesPerCustomer] DECIMAL(18,2),
[DeliveryStatus] VARCHAR(50),
[LateDelivery] BIT,
[CategoryId] INT,
[CategoryName] VARCHAR(50),
[CustomerCity] VARCHAR(100),
[CustomerCountry] VARCHAR(100),
[CustomerEmail] NVARCHAR(100),
[CustomerFName] VARCHAR(100),
[CustomerId] INT,
[CustomerLName] VARCHAR(500),
[CustomerPassword] NVARCHAR(600),
[CustomerSegment] VARCHAR(100),
[CustomerState] VARCHAR(20),
[CustomerStreet] VARCHAR(120),
[CustomerZipCode] INT,
[DepartmentId] INT,
[DepartmentName] VARCHAR(500),
[Latitude] DECIMAL(18,2),
[Longtude] DECIMAL(18,2),
[Market] VARCHAR(250),
[OrderCity] VARCHAR(250),
[OrderCountry] VARCHAR(250),
[OrderCustomerId] INT,
[OrderDateDateOrders] DATETIME,
[OrderId] INT,
[OrderCardpordId] INT,
[OrderItemDiscount] DECIMAL(18,2),
[OrderDiscountRate] DECIMAL(18,2),
[OrderItemId] INT,
[OrderItemProductPrice] DECIMAL(18,2),
[OrderItemProfitRatio] DECIMAL(18,2),
[OrderItemQuantity] INT,
[Sales] DECIMAL(18,2),
[OrderItemTotal] DECIMAL(18,2),
[OrderProfitPerOrder] DECIMAL(18,2),
[OrderRegion] VARCHAR(250),
[OrderState] VARCHAR(250),
[OrderStatus] VARCHAR(250),
[OrderZipCode] INT,
[ProductCardId] INT,
[ProductCategoryId] VARCHAR(30),
[ProductDescription] VARCHAR(3000),
[ProductImage] VARCHAR(1000),
[ProductName] VARCHAR(300),
[ProductPrice] DECIMAL(18,2),
[ProductStatus] BIT,
[ShippingDateDateOrders] DATETIME,
[ShippingMode] VARCHAR(200)

);
GO;

/*We then make the data insert on copy of masterlist*/
BEGIN TRAN 
BULK INSERT supplyChainMaster.masterListItemsCopy
FROM 'C:\Users\korpu\OneDrive\Escritorio\Excel to Web development\DataBase Excel\DataCoSupplyChainDataset.csv'
WITH
(
	FIRSTROW=2,
	FIELDTERMINATOR=','
)
GO;
--ROLLBACK
--COMMIT




/*STILL WORKING ON IT*/

/*We proccess data from copy to masterList*/
BEGIN TRAN
INSERT INTO supplyChainMaster.masterListItems 
SELECT
    [Type],
    CONVERT(INT,[DaysForShipReal]),
    CONVERT(INT,[DaysForShipmentScheduled]),
    CONVERT(DECIMAL(18,2),[BenefitPerOrder]),
    CONVERT(DECIMAL(18,2),[SalesPerCustomer]),
    [DeliveryStatus],
    CONVERT(BIT,[LateDelivery]),
    CONVERT(INT,[CategoryId]),
    [CategoryName],
    [CustomerCity],
    [CustomerCountry],
    [CustomerEmail],
    [CustomerFName],
    CONVERT(INT,[CustomerId]),
    [CustomerLName],
    [CustomerPassword],
    [CustomerSegment],
    [CustomerState],
    [CustomerStreet],
    CONVERT(INT,[CustomerZipCode]),
    CONVERT(INT,[DepartmentId]),
    [DepartmentName],
    CONVERT(DECIMAL(18,2),[Latitude]), 
    CONVERT(DECIMAL(18,2),[Longtude]),
    [Market],
    [OrderCity],
    [OrderCountry],
    CONVERT(INT,[OrderCustomerId]),
    [OrderDateDateOrders],
    CONVERT(INT,[OrderId]),
    CONVERT(INT,[OrderCardpordId]),  -- 
    CONVERT(DECIMAL(18,2),[OrderItemDiscount]),
    CONVERT(DECIMAL(18,2),[OrderDiscountRate]),
    CONVERT(INT,[OrderItemId]),
    CONVERT(DECIMAL(18,2), [OrderItemProductPrice]),
    CONVERT(DECIMAL(18,2),[OrderItemProfitRatio]),
    CONVERT(INT,[OrderItemQuantity]),
    CONVERT(DECIMAL(18,2),[Sales]),
    CONVERT(DECIMAL(18,2),[OrderItemTotal]),
    CONVERT(DECIMAL(18,2),[OrderProfitPerOrder]),
    [OrderRegion],
    [OrderState],
    [OrderStatus],
    CONVERT(INT,[OrderZipCode]),
    CONVERT(INT,[ProductCardId]),
    [ProductCategoryId],
    [ProductDescription],
    [ProductImage],
    [ProductName],
    CONVERT(DECIMAL(18,2),[ProductPrice]),
    CONVERT(BIT,[ProductStatus]),
    CONVERT(DATETIME,[ShippingDateDateOrders]),
    [ShippingMode]
FROM supplyChainMaster.masterListItemsCopy;
GO;

--ROLLBACK
--COMMIT 

/*Once everything was loaded check then original tables*/

-- 1.-Logs
SELECT *FROM logsInteractionsUsers.userInteractionItems

-- 2.- masterList
SELECT *FROM supplyChainMaster.masterListItems