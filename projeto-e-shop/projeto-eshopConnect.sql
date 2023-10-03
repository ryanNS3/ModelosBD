-- Exclusão de entidades

 

DROP TABLE users;
DROP TABLE buyer;
DROP TABLE seller;
DROP TABLE adress;
DROP TABLE credit_card;
DROP TABLE debit_card;
DROP TABLE bank_card;
DROP TABLE comments;
DROP TABLE save_to_shopping_cart;
DROP TABLE product;
DROP TABLE manage;
DROP TABLE store;
DROP TABLE deliver_to;
DROP TABLE payment;
DROP TABLE orders;
DROP TABLE contain;
DROP TABLE order_item;
DROP TABLE brand;
DROP TABLE after_sale_services_at;
DROP TABLE service_point;


DROP DATABASE eshopconect;
 

-- Criação do banco de dados

 

CREATE DATABASE eShopConnect;

 

USE eShopConnect;

 

-- Criação de entidades

 

CREATE TABLE users(
    pk_userId INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL,
    phoneNum VARCHAR(12),

    PRIMARY KEY(pk_userId)
);

 

CREATE TABLE buyer(
    pk_userId INT NOT NULL AUTO_INCREMENT,

    PRIMARY KEY(pk_userId),
    FOREIGN KEY(pk_userId) REFERENCES users(pk_userId)
);

 

CREATE TABLE seller(
    pk_userId INT NOT NULL AUTO_INCREMENT,

    PRIMARY KEY(pk_userId),
    FOREIGN KEY(pk_userId) REFERENCES users(pk_userId)
);

 

CREATE TABLE bankCard(
    pk_cardNumber CHAR(16) NOT NULL,
    expiryDate DATE NOT NULL,
    bank VARCHAR (20),

    PRIMARY KEY(pk_cardNumber)
);

 

CREATE TABLE creditCard(
    pk_cardNumber CHAR(16) NOT NULL,
    fk_userId INT NOT NULL,
    organization VARCHAR(50),

    PRIMARY KEY(pk_cardNumber),
    FOREIGN KEY(pk_cardNumber) REFERENCES bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userId) REFERENCES users(pk_userId)
);

 

CREATE TABLE debitCard(
    pk_cardNumber CHAR(16) NOT NULL,
    fk_userId INT NOT NULL,
    organization VARCHAR(50),

    PRIMARY KEY(pk_cardNumber),
    FOREIGN KEY(pk_cardNumber) REFERENCES bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userId) REFERENCES users(pk_userId)
);

 

CREATE TABLE store(
    pk_sid INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    province VARCHAR(35) NOT NULL,
    city VARCHAR(40) NOT NULL,
    streetAddr VARCHAR(20),
    customerGrade INT,
    startTime TIME,

    PRIMARY KEY(pk_sid)
);

 

CREATE TABLE brand(
    pk_brandName VARCHAR(50) NOT NULL,

    PRIMARY KEY(pk_brandName)
);

 

CREATE TABLE product(
    pk_pid INT NOT NULL,
    fk_sid INT NOT NULL,
    name VARCHAR(120) NOT NULL,
    fk_brandName VARCHAR(50) NOT NULL,
    type VARCHAR(50),
	modelNumber VARCHAR(50),
	color VARCHAR(20),
    amount INT DEFAULT NULL,
    preco DECIMAL(6, 2) NOT NULL,
   
   

    PRIMARY KEY(pk_pid),
    FOREIGN KEY(fk_sid) REFERENCES store(pk_sid),
    FOREIGN KEY(fk_brandName) REFERENCES brand(pk_brandName)
);

 

CREATE TABLE orderItem(
    pk_itemId INT NOT NULL AUTO_INCREMENT,
    fk_pid INT NOT NULL,
    price DECIMAL(6, 2),
    creationTime TIME NOT NULL,

    PRIMARY KEY(pk_itemId),
    FOREIGN KEY(fk_pid) REFERENCES product(pk_pid)
);

 

CREATE TABLE orders(
    pk_orderNumber INT NOT NULL,
    paymentStatus ENUM('Paid', 'Unpaid'),
    creationTime TIME NOT NULL,
    totalAmout DECIMAL(10, 2),

    PRIMARY KEY(pk_orderNumber)
);

 

CREATE TABLE address(
    pk_addrId INT NOT NULL,
    fk_userId INT NOT NULL,
    name VARCHAR(50),
    contactPhoneNumber VARCHAR(20),
    province VARCHAR(100),
    city VARCHAR(100),
    streetAddr VARCHAR(100),
    postCode VARCHAR(12),

    PRIMARY KEY(pk_addrId),
    FOREIGN KEY(fk_userId) REFERENCES users(pk_userId)
);

 

CREATE TABLE comments( -- Entidade fraca
    creationTime DATE NOT NULL,
    fk_userId INT NOT NULL,
    fk_pid INT NOT NULL,
    grade FLOAT,
    content VARCHAR(500),

    PRIMARY KEY(creationTime, fk_userId, fk_pid),
    FOREIGN KEY(fk_userId) REFERENCES users(pk_userId),
    FOREIGN KEY(fk_pid) REFERENCES product(pk_pid)
);

 

CREATE TABLE servicePoint(
    pk_spid INT NOT NULL,
    streetAddr VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    province VARCHAR(50),
    startTime VARCHAR(20),
    endTime VARCHAR(20),

    PRIMARY KEY(pk_spid)
);

 

CREATE TABLE saveToShoppingCart(
    fk_userId INT NOT NULL,
    fk_pid INT NOT NULL,
    addTime DATE,
    quantity INT,

    PRIMARY KEY(fk_userId, fk_pid),
    FOREIGN KEY(fk_userId) REFERENCES buyer(pk_userId),
    FOREIGN KEY(fk_pid) REFERENCES product(pk_pid)
);

 

CREATE TABLE contain(
    fk_orderNumber INT NOT NULL,
    fk_itemId INT NOT NULL,
    quantity INT,
   

    PRIMARY KEY(fk_orderNumber, fk_itemId),
    FOREIGN KEY(fk_orderNumber) REFERENCES orders(pk_orderNumber),
    FOREIGN KEY(fk_itemId) REFERENCES orderItem(pk_itemId)
);

 

CREATE TABLE payment(
    fk_orderNumber INT NOT NULL,
    fk_cardNumber CHAR(16) NOT NULL,
    payTime DATE,

    PRIMARY KEY(fk_orderNumber, fk_cardNumber),
    FOREIGN KEY(fk_orderNumber) REFERENCES contain(fk_orderNumber),
    FOREIGN KEY(fk_cardNumber) REFERENCES bankCard(pk_cardNumber)
);

 

CREATE TABLE deliverTo(
    fk_addrId INT NOT NULL,
    fk_orderNumber INT NOT NULL,
    timeDelivered DATE,

    PRIMARY KEY(fk_addrId, fk_orderNumber),
    FOREIGN KEY(fk_addrId) REFERENCES address(pk_addrId),
    FOREIGN KEY(fk_orderNumber) REFERENCES orders(pk_orderNumber)
);

 

CREATE TABLE manage(
    fk_userId INT NOT NULL,
    fk_sid INT NOT NULL,
    setUpTime DATE,

    PRIMARY KEY(fk_userId, fk_sid),
    FOREIGN KEY(fk_userId) REFERENCES seller(pk_userId),
    FOREIGN KEY(fk_sid) REFERENCES store(pk_sid)
);

 

CREATE TABLE afterSalesServicesAt(
    fk_brandName VARCHAR(50) NOT NULL,
    fk_spid INT NOT NULL,

    PRIMARY KEY(fk_brandName, fk_spid),
    FOREIGN KEY(fk_brandName) REFERENCES brand(pk_brandName),
    FOREIGN KEY(fk_spid) REFERENCES servicePoint(pk_spid)
);