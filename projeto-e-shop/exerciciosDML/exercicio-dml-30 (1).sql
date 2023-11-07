-- atividade relampago
-- 1 s
SELECT name as nome,
phoneNumber as telefone
FROM users;

-- 2. liste os nomes dos compradores

SELECT 
	nome as NAME
FROM users
WHERE pk_userID IN (SELECT * FROM buyer);


-- 3.
SELECT name AS NOME
FROM users
WHERE pk_userid IN (SELECT * FROM seller);


-- 4.1
SELECT 
	bank.pk_cardNumber,
	bank.expiryDate,
	bank.bank,
    credito.fk_userid,
    credito.organization
FROM 
	bankcard as bank
    JOIN creditcard as credito
    ON bank.pk_cardNumber = credito.fk_cardNumber;



-- 4.2
	SELECT 
    bank.pk_cardNumber,
    bank.expiryDate,
    bank.bank,
    
    debit.fk_userid,
    debit.organization
    
    FROM
    bankcard as bank
    JOIN debitcard as debit
    ON bank.pk_cardNumber = debit.fk_cardNumber;
    
    
    
-- 5 selecione os nomes dos produtos e seus preços


SELECT name AS nome,
 price AS preco
 FROM product ;
 
 
-- 6. Liste todos os produtos de uma determinada marca (por exemplo, "Micrisoft)

SELECT 
	name AS NOME,
    price AS VALOR_UNITARIO,
    fk_brandName AS MARCA
FROM product
WHERE fk_brandName = "Microsoft";


-- 7 Encontre o número de itens em cada pedido

SELECT * FROM contain;
SELECT fk_orderNumber AS Ordem, SUM(quantity) AS Qtde_Itens FROM contain

GROUP BY Ordem
-- query em ordem decrescente
ORDER BY Qtde_Itens DESC;


-- 8. Calcule o total de vendas por loja

SELECT * FROM store, product,orderitem; 
    
SELECT s.name AS store_name,
SUM(o.price) AS total_sales
FROM store AS s
INNER JOIN product AS p ON s.pk_sid = p.fk_SID
INNER JOIN orderitem AS o ON p.pk_PID = o.fk_PID
GROUP BY store_name;


-- 9 Liste as avaliações dos produtos (grade)alter
-- com seus nomes e conteúdo de usuário.

SELECT * FROM product,comments;

SELECT product.name AS nomeProduto,
comments.grade AS avaliacao,
comments.content AS comentario
FROM product 
JOIN comments
ON product.pk_PID = comments.fk_PID;

-- 10 Selecione os nomes dos compradores que fizeram pedidos.

SELECT
-- o distinct tem como funcionalidade mostrar apenas itens não repeditos
 DISTINCT u.name  
FROM buyer AS b
JOIN users u ON b.fk_userID = u.pk_userID
JOIN creditcard c ON u.pk_userID = c.fk_userID
JOIN payment p ON c.fk_cardNumber = p.fk_creditcardNumber; 


-- 11 encontre os vendedores que gerenciam vários lojas
SELECT u.name,COUNT(u.pk_userID) AS qtd
FROM manage AS m
JOIN users AS u ON u.pk_userID = m.fk_userID
JOIN store AS s ON s.pk_SID = m.fk_SID
GROUP BY  u.name
HAVING  qtd > 1; 

-- 12 Liste os nomes das lojas que oferecem produtos de uma determinada marca
SELECT * FROM product;
SELECT * FROM store;
SELECT store.name,store.city,store.streetAddr, product.fk_brandName FROM store
JOIN  product ON store.pk_SID = product.fk_SID 
WHERE product.fk_brandName = "Microsoft"  ;


-- 13 

SELECT * FROM DeliverTo;
SELECT * FROM  Address;

SELECT  fk_orderNumber,Address.city,Address.streetAddr,Address.name FROM DeliverTo
JOIN Address ON Address.pk_addrID = DeliverTo.fk_addrID
WHERE DeliverTo.fk_orderNumber = 12992012;  


-- 14
SELECT AVG(totalAmount) AS total
FROM orders
JOIN deliverTo ON orders.pk_orderNumber = deliverTo.fk_orderNumber
JOIN address ON deliverTo.fk_addrID =  address.pk_addrID
JOIN users ON address.fk_userID = pk_userID 
JOIN buyer ON buyer.fk_userID = users.pk_userID
;


-- 15
SELECT After_Sales_Service_At.fk_brandName
FROM ServicePoint
JOIN After_Sales_Service_At ON ServicePoint.pk_SPID =  After_Sales_Service_At.fk_SPID
WHERE ServicePoint.city = "Montreal";


-- 16

SELECT name,province,city,streetAddr
FROM store
WHERE customerGrade > 4;


-- 17 
SELECT * FROM  product;
SELECT name,amount 
FROM product
WHERE amount < 1;

-- 18
SELECT max(price) AS preço
FROM product;



-- 19
SELECT c.fk_cardNumber,count(p.fk_orderNumber) AS quantidadeItens
FROM creditCard AS c
JOIN bankCard AS b ON b.pk_cardNumber = c.fk_cardNumber 
JOIN payment AS p ON p.fk_creditcardNumber = b.pk_cardNumber
JOIN orders AS o ON o.pk_orderNumber = p.fk_orderNumber
WHERE fk_cardNumber = "4902 9212 3402 8831"
GROUP BY c.fk_cardNumber;

-- 20

SELECT u.name,u.phoneNumber
FROM users AS u
LEFT OUTER JOIN creditCard AS c ON c.fk_userID = u.pk_userID
LEFT OUTER JOIN bankCard AS bank ON bank.pk_cardNumber = c.fk_cardNumber
LEFT OUTER JOIN payment AS p ON p.fk_creditCardNumber = bank.pk_cardNumber
LEFT OUTER JOIN orders AS o ON o.pk_orderNumber = p.fk_orderNumber
WHERE fk_orderNumber IS NULL;


-- 21
SELECT name AS nomeProduto, c.grade AS nota
FROM product AS p
JOIN comments AS c ON c.fk_PID = p.pk_PID
WHERE c.grade > 4 
;

-- 22


SELECT name AS nomeVendedor
FROM users AS u
JOIN seller AS s ON s.fk_userID = u.pk_userID
LEFT JOIN manage AS m ON m.fk_userID = s.fk_userID 
WHERE m.fk_userID IS NULL;


-- 23


SELECT COUNT(b.fk_userID) AS contador, u.name
FROM buyer AS b
JOIN users AS u ON u.pk_userID = b.fk_userID
JOIN creditCard c ON c.fk_userID = u.pk_userID
JOIN BankCard bank ON bank.pk_cardNumber = c.fk_cardNumber
JOIN payment p ON p.fk_creditCardNumber = bank.pk_cardNumber
JOIN orders o ON o.pk_orderNumber = p.fk_orderNumber
WHERE contador > 3
GROUP BY u.name ;


-- 24

SELECT fk_cardNumber FROM debitCard AS d
JOIN bankCard AS b ON  b.pk_cardNumber = d.fk_cardNumber
JOIN payment AS p ON p.fk_creditCardNumber = b.pk_cardNumber;


SELECT fk_cardNumber FROM creditCard AS c
JOIN bankCard AS b ON  b.pk_cardNumber = c.fk_cardNumber
JOIN payment AS p ON p.fk_creditCardNumber = b.pk_cardNumber;

-- 25

SELECT b.pk_brandName,p.pk_PID
FROM store AS s
JOIN product AS p ON p.fk_sid = 1 AND s.pk_sid = 1
RIGHT JOIN brand AS b ON b.pk_brandName = p.fk_brandName
WHERE p.pk_PID IS NULL;   


-- 26

SELECT AVG(p.amount) 
FROM store AS s
JOIN product AS p ON p.fk_sid = s.pk_sid;

-- 27 

SELECT s.name ,p.amount
FROM store AS s
JOIN product AS p ON p.fk_sid = s.pk_sid
WHERE p.amount = 0;


-- 28 

SELECT u.name,store.city
FROM users AS u
JOIN seller AS s ON s.fk_userID = u.pk_userID
JOIN manage AS m ON m.fk_userID = s.fk_userID
JOIN store ON store.pk_sid = m.fk_sid
WHERE store.city = "São Paulo";

-- 29 

SELECT name AS nomeProduto,modelNumber AS modelo,fk_brandName AS marca
FROM product
WHERE fk_brandName = "DELL";

-- 30
SELECT * FROM buyer;
SELECT u.name, SUM(o.totalAmount) AS Total
FROM buyer AS b
JOIN users AS u ON u.pk_userID = 5
JOIN creditCard AS c ON c.fk_userID = u.pk_userID
JOIN bankCard AS bank ON bank.pk_cardNumber = c.fk_cardNumber
JOIN payment AS p ON p.fk_creditCardNumber = bank.pk_cardNumber
JOIN orders AS o ON o.pk_orderNumber = p.fk_orderNumber
GROUP BY u.name
;

