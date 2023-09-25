CREATE DATABASE eShopConect;
USE   eShopConect;

CREATE TABLE users(
	pk_userID			char(10) PRIMARY KEY,
    nome				char(50) NOT NULL,
    PhoneNum			varchar(11) NOT NULL, CHECK(phoneNum LIKE("00 00000-0000"))
	
);

CREATE TABLE buyer(
	fk_userID 			char(10) PRIMARY KEY,
    FOREIGN KEY(fk_userID) REFERENCES users(pk_userID)
);

CREATE TABLE seller(
	fk_userID 			char(10) PRIMARY KEY,
    FOREIGN KEY(fk_userID) REFERENCES users(pk_userID)
);

CREATE TABLE bankCard(
	pk_cardNumber 			varchar(16) PRIMARY KEY,
    bank					char(25) NOT NULL,
    expiryDate				varchar(4) NOT NULL,
    CHECK(expiryDate LIKE("--/--"))
);

CREATE TABLE creditCard(
	fk_cardNumber 			varchar(16) PRIMARY KEY,
    fk_userID				char(10) UNIQUE NOT NULL,
    organizations			char(50) NOT NULL,
    FOREIGN KEY(fk_cardNumber) 	REFERENCES bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userID)		REFERENCES	users(pk_userID) 
);

CREATE TABLE debitCard(
	fk_cardNumber 			varchar(16) PRIMARY KEY,
    fk_userID				char(10) UNIQUE NOT NULL,
    organizations			char(50) NOT NULL,
    FOREIGN KEY(fk_cardNumber) 	REFERENCES bankCard(pk_cardNumber),
    FOREIGN KEY(fk_userID)		REFERENCES	users(pk_userID) 
);


CREATE TABLE Store(
	pk_sid					char(10) PRIMARY KEY,
    nome					char(50) NOT NULL,
    startTime				time	NOT NULL  CHECK(startTime LIKE("--:--")),
	customerGrade			decimal(10,1),
    streetAdr				char(40) NOT NULL,
    city					char(40) NOT NULL,
	province				char(35) NOT NULL
   
);


CREATE TABLE product(
	pk_pid						char(10) PRIMARY KEY,
    fk_sid						char(10) NOT NULL UNIQUE,
    nome						char(50) NOT NULL,
    fk_brandName				char(40) NOT NULL UNIQUE,
    tipo						char(25) NOT NULL,
    amount						int DEFAULT 0,
    price						decimal(10,2) NOT NULL,
    color						char(35) NOT NULL,
    modelNumber					int NOT NULL UNIQUE,
    
    
    FOREIGN KEY(fk_sid)			REFERENCES Store(pk_sid),
    FOREIGN KEY(fk_brandName)	REFERENCES brand(pk_brandName)
);


CREATE TABLE orderItem(
	pk_itemID 						char(10) PRIMARY KEY,
    fk_pid							char(10) NOT NULL UNIQUE,
    price							decimal(10,2) NOT NULL 	CHECK(price > 0),
    creationTime					time NOT NULL CHECK(creationTime LIKE("--:--")),
    
    FOREIGN KEY(fk_pid) REFERENCES product(pk_pid)

);

CREATE TABLE orders(
	pk_orderNumber					int PRIMARY KEY,
    creationTime					time NOT NULL CHECK(creationTime LIKE("--:--")),
    -- o enum impede que o usuário coloque valores diferentes dos pré-estabelecidos
    paymentStatus					enum("pago","pendente","cancelado","reembolsado"),
    totalAmount						decimal(10,2) NOT NULL

);

CREATE TABLE address(
	pk_addrID						char(10) PRIMARY KEY,
    fk_userID						char(10) NOT NULL UNIQUE,
    nome							char(40) NOT NULL,
    city							char(40) NOT NULL,
    postalCode						varchar(8) NOT NULL UNIQUE CHECK(postalCode LIKE("00000-000")),
    streetAddr						char(35) NOT NULL,
    province						char(40) NOT NULL,
    contactPhoneNumber				varchar(11) NOT NULL CHECK(contactPhoneNumber LIKE("00 00000-0000")),
    
    FOREIGN KEY(fk_userID) REFERENCES users(pk_userID)

);

CREATE TABLE brand(
	pk_brandName					char(40) NOT NULL UNIQUE

);

CREATE TABLE comments(
	creationTime					time NOT NULL CHECK(creationTime LIKE("--:--")),
    fk_userID						char(10) NOT NULL UNIQUE,
	fk_pid							char(10) NOT NULL UNIQUE,
    grade							float,
	content							blob(500),
    
	FOREIGN KEY(fk_userID) 	REFERENCES users(pk_userID),
    FOREIGN KEY(fk_pid) 	REFERENCES product(pk_pid)
);

CREATE TABLE servicePoint(
	pk_spid							char(10) PRIMARY KEY,
    streetaddr						char(40) NOT NULL,
    city							char(30) NOT NULL,
    province						char(20) NOT NULL,
    startTime						time  NOT NULL  CHECK( startTime LIKE("--:--")),
    endTime							time  NOT NULL  CHECK(endTime   LIKE("--:--"))

);




CREATE TABLE save_to_shopping_cart(
	fk_userID						char(10) NOT NULL UNIQUE,
    fk_pid							char(10) NOT NULL UNIQUE,
    addTime							datetime NOT NULL CHECK(addTime LIKE("YYYY-MM-DD hh:mm:ss")),
    quantIty						int DEFAULT 0,
    
    
	FOREIGN KEY(fk_userID) 	REFERENCES users(pk_userID),
    FOREIGN KEY(fk_pid) 	REFERENCES product(pk_pid)
);

CREATE TABLE contain(
	fk_orderNumber					int NOT NULL UNIQUE,
    fk_itemID						char(10) NOT NULL UNIQUE,
    quantity						int NOT NULL,
    
    FOREIGN KEY(fk_orderNumber) REFERENCES orders(pk_orderNumber),
    FOREIGN KEY(fk_itemID)		REFERENCES orderItem(pk_itemID)

);

CREATE TABLE payment(
	fk_orderNumber					int NOT NULL UNIQUE,
	fk_creditCardNumber				varchar(16) NOT NULL UNIQUE,
    payTime							date NOT NULL,
    
    FOREIGN KEY(fk_orderNumber)		 REFERENCES orders(pk_orderNumber),
    FOREIGN KEY(fk_creditCardNumber) REFERENCES creditCard(fk_cardNumber)
    
);


CREATE TABLE deliver_To(
	fk_addrID						char(10) NOT NULL UNIQUE,
    fk_orderNumber					int NOT NULL UNIQUE,
    timeDelivery					datetime NOT NULL CHECK(timeDelivery LIKE("YYYY-MM-DD hh:mm:ss")),
	
    FOREIGN KEY(fk_orderNumber)		 REFERENCES orders(pk_orderNumber),
    FOREIGN KEY(fk_addrID)			 REFERENCES address(pk_addrID)
);






CREATE TABLE manager(
	fk_userID						char(10) NOT NULL UNIQUE,
	fk_sid							char(10) NOT NULL UNIQUE,
    setUpTime						date CHECK(setUpTime LIKE("YYYY-MM-DD")),
    
    FOREIGN KEY(fk_userID) 	REFERENCES users(pk_userID),
    FOREIGN KEY(fk_sid)		REFERENCES Store(pk_sid)
);


CREATE TABLE after_Sales_Service_At(
	fk_brandName				char(40) NOT NULL UNIQUE,
	fk_spid						char(10) NOT NULL UNIQUE,
	FOREIGN KEY(fk_brandName)	REFERENCES brand(pk_brandName),
    FOREIGN KEY(fk_spid)		REFERENCES servicePoint(spid)
);





























