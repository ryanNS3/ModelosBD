
CREATE DATABASE IF NOT EXISTS EShop_Connect;
USE EShop_Connect;

-- Desabilita as verificações de Fks
SET FOREIGN_KEY_CHECKS = 0;
-- Habilita as verificações de Fks
SET FOREIGN_KEY_CHECKS = 1;
-- DROP TABLE Users;
-- DROP TABLE Buyer;
-- DROP TABLE Seller;
-- DROP TABLE BankCard;
-- DROP TABLE CreditCard;
-- DROP TABLE DebitCard;
-- DROP TABLE Store;
-- DROP TABLE Product;
-- DROP TABLE OrderItem;
-- DROP TABLE Orders;
-- DROP TABLE Address;
-- DROP TABLE Brand;
-- DROP TABLE Comments;
-- DROP TABLE ServicePoint;
-- DROP TABLE SaveToShoppingCart;
-- DROP TABLE Contain;
-- DROP TABLE Payment;
-- DROP TABLE DeliverTo;
-- DROP TABLE Manage;
-- DROP TABLE After_Sales_Service_At;

-- Tabela Users
CREATE TABLE IF NOT EXISTS Users (
    pk_userID INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phoneNumber VARCHAR(15)
);

-- Tabela Buyer
CREATE TABLE IF NOT EXISTS Buyer (
    fk_userID INT PRIMARY KEY,
    FOREIGN KEY (fk_userID) REFERENCES Users(pk_userID)
);

-- Tabela Seller
CREATE TABLE IF NOT EXISTS Seller (
    fk_userID INT PRIMARY KEY,
    FOREIGN KEY (fk_userID) REFERENCES Users(pk_userID)
);

-- Tabela Bank Card
CREATE TABLE IF NOT EXISTS BankCard (
    pk_cardNumber CHAR(19) PRIMARY KEY,
    expiryDate DATE NOT NULL,
	bank VARCHAR(40)
);

-- Tabela Credit Card
CREATE TABLE IF NOT EXISTS CreditCard (
    fk_cardNumber CHAR(19) PRIMARY KEY,
    fk_userID INT,
    organization VARCHAR(50),
    FOREIGN KEY (fk_userID) REFERENCES Users(pk_userID),
    FOREIGN KEY (fk_cardNumber) REFERENCES BankCard(pk_cardNumber)
);

-- Tabela Debit Card
CREATE TABLE IF NOT EXISTS DebitCard (
    fk_cardNumber CHAR(19) PRIMARY KEY,
    fk_userID INT,
    organization VARCHAR(50),
    FOREIGN KEY (fk_userID) REFERENCES Users(pk_userID),
    FOREIGN KEY (fk_cardNumber) REFERENCES BankCard(pk_cardNumber)
);

-- Tabela Store
CREATE TABLE IF NOT EXISTS Store (
    pk_SID INT PRIMARY KEY,
    name VARCHAR(50),
	province VARCHAR(50),
    city VARCHAR(50),
    streetAddr VARCHAR(50),
    customerGrade FLOAT,
	startTime TIME
);

-- Tabela Brand
CREATE TABLE IF NOT EXISTS Brand (
    pk_brandName VARCHAR(50) PRIMARY KEY
);

-- Tabela Product
CREATE TABLE IF NOT EXISTS Product (
    pk_PID INT PRIMARY KEY,
    fk_SID INT NOT NULL,
	fk_brandName VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(50),
	modelNumber VARCHAR(50),
	color VARCHAR(20),
    amount INT DEFAULT NULL,
    price DECIMAL(7, 2) NOT NULL,

    FOREIGN KEY (fk_SID) REFERENCES Store(pk_SID),
    FOREIGN KEY (fk_brandName) REFERENCES Brand(pk_brandName)
);

-- Tabela Order Item
CREATE TABLE IF NOT EXISTS OrderItem (
    pk_itemID INT PRIMARY KEY,
    fk_PID INT NOT NULL,
    price DECIMAL(7, 2),
    creationTime DATETIME NOT NULL,
    FOREIGN KEY (fk_PID) REFERENCES Product(pk_PID)
);

-- Tabela Orders
CREATE TABLE IF NOT EXISTS Orders (
    pk_orderNumber INT PRIMARY KEY,
    paymentStatus ENUM('Paid', 'Unpaid'),
	creationTime DATETIME,
    totalAmount DECIMAL(10, 2)
);

-- Tabela Address
CREATE TABLE IF NOT EXISTS Address (
    pk_addrID INT PRIMARY KEY,
    fk_userID INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    contactPhoneNumber VARCHAR(15),
    province VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
	streetAddr VARCHAR(50) NOT NULL,
    postalCode VARCHAR(50) NOT NULL,
  
    
    
    FOREIGN KEY (fk_userID) REFERENCES Users(pk_userID)
);

-- Tabela Comments
CREATE TABLE IF NOT EXISTS Comments (
    creationTime DATETIME NOT NULL,
    fk_userID INT NOT NULL,
    fk_PID INT NOT NULL,
    grade FLOAT,
    content VARCHAR(500),
    PRIMARY KEY(fk_userID, fk_PID, creationTime),
    FOREIGN KEY (fk_userID) REFERENCES Users(pk_userID),
    FOREIGN KEY (fk_PID) REFERENCES Product(pk_PID)
);

-- Tabela ServicePoint
CREATE TABLE IF NOT EXISTS ServicePoint (
    pk_SPID INT PRIMARY KEY,
    streetAddr VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    startTime TIME,
    endTime TIME
);

-- Tabela Save to Shopping Cart
CREATE TABLE IF NOT EXISTS SaveToShoppingCart (
    fk_userID INT NOT NULL,
    fk_PID INT NOT NULL,
    addTime DATETIME,
    quantity INT,
    
    PRIMARY KEY(fk_userID, fk_PID),
    FOREIGN KEY (fk_userID) REFERENCES Users(pk_userID),
    FOREIGN KEY (fk_PID) REFERENCES Product(pk_PID)
);

-- Tabela Contain
CREATE TABLE IF NOT EXISTS Contain (
    fk_orderNumber  INT NOT NULL,
    fk_itemid 		INT NOT NULL,
    quantity 		INT,
    
    PRIMARY KEY (fk_orderNumber, fk_itemID),
    FOREIGN KEY (fk_orderNumber) REFERENCES Orders(pk_orderNumber),
    FOREIGN KEY (fk_itemID) 	 REFERENCES OrderItem(pk_itemID)
);

-- Tabela Payment
CREATE TABLE IF NOT EXISTS Payment (
    fk_orderNumber INT NOT NULL,
    fk_creditcardNumber CHAR(19) NOT NULL,
    payTime DATETIME,
    
    PRIMARY KEY (fk_orderNumber, fk_creditcardNumber),
    FOREIGN KEY (fk_orderNumber) REFERENCES Orders(pk_orderNumber),
    FOREIGN KEY (fk_creditcardNumber) REFERENCES bankCard(pk_cardNumber)
);

-- Tabela Deliver To
CREATE TABLE IF NOT EXISTS DeliverTo (
    fk_addrID INT NOT NULL,
    fk_orderNumber INT NOT NULL,
    TimeDelivered DATETIME,
    
    PRIMARY KEY (fk_addrID, fk_orderNumber),
    FOREIGN KEY (fk_addrID) REFERENCES Address(pk_addrID),
    FOREIGN KEY (fk_orderNumber) REFERENCES Orders(pk_orderNumber)
);

-- Tabela Manage
CREATE TABLE IF NOT EXISTS Manage (
    fk_userID INT NOT NULL,
    fk_SID INT NOT NULL,
    SetUpTime DATETIME,
    
    FOREIGN KEY (fk_userID) REFERENCES Users(pk_userID),
    FOREIGN KEY (fk_SID) REFERENCES Store(pk_SID)
);

-- Tabela After_Sales_Service_At
CREATE TABLE IF NOT EXISTS After_Sales_Service_At (
    fk_brandName VARCHAR(20) NOT NULL,
    fk_SPID INT NOT NULL,
    
    PRIMARY KEY(fk_brandName, fk_SPID),
    FOREIGN KEY(fk_brandName) REFERENCES Brand(pk_brandName),
    FOREIGN KEY (fk_SPID) REFERENCES ServicePoint(pk_SPID)
);

-- Remove a coluna "organization"
ALTER TABLE debitCard
DROP COLUMN organization;


ALTER TABLE store
MODIFY startTime DATE;

ALTER TABLE ServicePoint
MODIFY startTime VARCHAR(20),
MODIFY endTime VARCHAR(20);

ALTER TABLE Product
MODIFY name VARCHAR(120);

