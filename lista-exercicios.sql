create database Exercicios;

 

USE Exercicios; -- habilitar o banco de dados
-- exercicion 1
CREATE TABLE paises(
	country_id varchar(2),
    country_name varchar(40),
    region_id decimal(10,0)
);

 

-- Exercicio 2
-- Vai criar a tabela se não houver uma com o mesmo nome
CREATE TABLE IF NOT EXISTS paises(
	country_id varchar(2),
    country_name varchar(40),
    region_id decimal(10,0)
);

 

-- Exercicio 04
-- Criar uma cópia idêntica á tabela paises, copiando o tipo 
CREATE TABLE IF NOT EXISTS dup_countries
LIKE paises;

 

-- Exercicio 05

 
CREATE TABLE IF NOT EXISTS countries(
-- a função not nul impede que valores nulos sejam atribuidos
	country_id      varchar(2) NOT NULL,
    country_name    varchar(40) NOT NULL,
    region_id        decimal(10,0) NOT NULL
);
-- a função check serve verificar uma condição,
-- Exercicio 06
CREATE TABLE jobs(
	job_id        varchar(10) NOT NULL,
    job_title     varchar(35) NOT NULL,
    min_salary    decimal(6,0),
    max_salary    decimal(6,0),
    CHECK(max_salary <= 25000)
);

 

-- Exercicio 07
-- Operador IN vai verificar se esses valores são os mesmo indicados
CREATE TABLE contrie(
	country_id       varchar(2),
    country_name     varchar(40),
    region_id        decimal(10,0),
    CHECK(country_name 	IN('Italy', 'India', 'China'))

);

 
-- Exercicio 08
CREATE TABLE IF NOT EXISTS job_history(
	EMPLOYEE_ID decimal(6,0) NOT NULL,
    START_DATE DATE NOT NULL,
    END_DATE DATE NOT NULL
    CHECK (END_DATE LIKE "--/--/----"),
    JOB_ID VARCHAR(10) NOT NULL, 
    DEPARTMENT_ID DECIMAL(4,0) NOT NULL
);

 

-- Exercicio 09
-- UNIQUE  não permite a inserção de dados duplicados no campo

 

CREATE TABLE IF NOT EXISTS paises2(
	country_id VARCHAR(2) NOT NULL,
    country_name VARCHAR(40) NOT NULL,
    region_id DECIMAL(10,0) NOT NULL,
    UNIQUE(country_id)
);
-- Exercicio 10
CREATE TABLE jobs2(
	job_id        varchar(10) NOT NULL UNIQUE,
    -- Defindo o valor padraão em branco caso nada seja digitado
    job_title     varchar(35) DEFAULT '',
    -- O valor padrão de salrio minimo como 8000
    min_salary    decimal(6,0) DEFAULT 8000 NOT NULL,
    -- Por padrão o salário minimo é null
    max_salary    decimal(6,0) DEFAULT NULL

 

);

 

 

-- Exercicio 11
-- O cmando primary key é o responsável por criar uma chave primaria
CREATE TABLE IF NOT EXISTS paises3(
	country_id VARCHAR(2) NOT NULL PRIMARY KEY,
    country_name VARCHAR(40) NOT NULL,
    region_id DECIMAL(10,0) NOT NULL,
    UNIQUE(country_id)
);

 

-- Exercicio 12
CREATE TABLE IF NOT EXISTS paises4(
-- a instrução AUTO_INCREMENT atribui um valor unico automaticamente(por padrão 1 em 1)
	country_id int NOT NULL AUTO_INCREMENT  PRIMARY KEY,
    country_name VARCHAR(40) NOT NULL,
    region_id DECIMAL(10,0) NOT NULL,
    UNIQUE(country_id)
);
ALTER TABLE country_id AUTO_INCREMENT=1;

-- EXERCICIO 13

 

CREATE TABLE paises5(
	country_id    char(4) NOT NULL UNIQUE DEFAULT '',
    country_name  varchar(50) DEFAULT NULL,
    region_id char(10) NOT NULL,
-- CRIAR UMA CHAVE PRIMARIA COMBINANDO OS CAMPOS country_id e region_id
	PRIMARY KEY(country_id,region_id)


);

 

-- 	EXERCICIO 14

 

CREATE TABLE jobs3(
	pk_job_id     char(4) NOT NULL PRIMARY KEY,
    job_name  	 	varchar(40) NOT NULL
);

 

CREATE TABLE job_history3(
	pk_employee_id  char(4) NOT NULL PRIMARY KEY,
    start_date		DATE NOT NULL,
    end_date		DATE NOT NULL,
    fk_job_id 		char(4) NOT NULL,
    department_id	char(4) DEFAULT NULL,
-- Definição da chave estrangeira
	FOREIGN KEY(fk_job_id) REFERENCES jobs3(pk_job_id)
);

 

-- exercicio 15
CREATE TABLE funcionarios1(
	pk_employee_id  	char(4)  NOT NULL PRIMARY KEY,
    first_name			char(40) NOT NULL,
    email				char(30) NOT NULL,
    phone_number		varchar(11) NOT NULL,
    hire_date			date NOT NULL,
    fk_department_id	char(2),
	fk_manager_id		char(2),
    FOREIGN KEY(fk_department_id,fk_manager_id) REFERENCES departamentos1(pk_department_id, pk_manager_id),
    CHECK (hire_date LIKE "--/--/----")
);

 

CREATE TABLE departamentos1(
	pk_department_id	char(2),
    pk_manager_id		char(2),
    -- combinação das duas colunas para chave primaria
    PRIMARY KEY(pk_department_id, pk_manager_id)
);

 

 

-- Exercicio 16
CREATE TABLE departamentos2(
	pk_departament_id 	char(2) PRIMARY KEY	
);
CREATE TABLE empregos2(
	pk_job_id			char(5) PRIMARY KEY
);

 

CREATE TABLE funcionarios2(
	pk_employee_id  	char(4) NOT NULL PRIMARY KEY,
    first_name			char(80) NOT NULL,
    last_name			char(80) NOT NULL,
    Email				char(40) NOT NULL,
    phone_number		varchar(11) NOT NULL,
    fk_job_id			char(5) NOT NULL,
	salary				float(10,3) NOT NULL,
    commission			float(5,2),
    manager_id			char(40),
    fk_department_id 	char(2),
	FOREIGN KEY(fk_job_id) 		  REFERENCES empregos2(pk_job_id),
    FOREIGN KEY(fk_department_id) REFERENCES departamentos2(pk_departament_id)
);

 

-- Exercicio 17

CREATE TABLE funcionarios3(
	pk_employee_id  	char(4) NOT NULL PRIMARY KEY,
    first_name			char(80) NOT NULL,
    last_name			char(80) NOT NULL,
	fk_job_id			char(5) NOT NULL,
    salary				float(10,3) NOT NULL,
    FOREIGN KEY(fk_job_id) 		  REFERENCES empregos3(pk_job_id)

);
CREATE TABLE empregos3(
	pk_job_id			char(5) PRIMARY KEY
);

 

-- Exercicio 18

CREATE TABLE funcionarios4(
	pk_employee_id  	char(4) NOT NULL PRIMARY KEY,
    first_name			char(80) NOT NULL,
    last_name			char(80) NOT NULL,
	fk_job_id			char(5) NOT NULL,
    salary				float(10,3) NOT NULL,
    FOREIGN KEY(fk_job_id )		  REFERENCES empregos4(pk_job_id) on update restrict
    -- o engine InnoDB é o mecanismo padrão que melhora o desempenho do banco de dados
) engine = InnoDB;

CREATE TABLE empregos4(
	pk_job_id			char(5) NOT NULL PRIMARY KEY
);

-- Exercicio 19

CREATE TABLE employees(
	pk_employee_id  	char(4) NOT NULL PRIMARY KEY,
    first_name			char(80) NOT NULL,
    last_name			char(80) NOT NULL,
	fk_job_id			char(5),
    salary				float(10,3) NOT NULL,
    -- o on delete set null fara com que se o valor da tabela pai for excluido o valor da chave estrangeira será nulo
	FOREIGN KEY(fk_job_id )		  REFERENCES empregos5(pk_job_id) ON DELETE SET NULL
) engine = InnoDB;


CREATE TABLE empregos5(
	pk_job_id			char(5) NOT NULL PRIMARY KEY
);

-- Exercício 20

CREATE TABLE funcionarios6(
	pk_employee_id  	char(4) NOT NULL PRIMARY KEY,
    first_name			char(80) NOT NULL,
    last_name			char(80) NOT NULL,
	fk_job_id			char(5) NOT NULL,
    salary				float(10,3) NOT NULL,
    -- O on delete no action impede que excluem a chave estrangeira e o on update no action impede que o valor seja atualizado
    FOREIGN KEY(fk_job_id )		  REFERENCES empregos6(pk_job_id) ON DELETE NO ACTION ON UPDATE NO ACTION
	
);

CREATE TABLE empregos6(
	pk_job_id			char(5) NOT NULL PRIMARY KEY
);