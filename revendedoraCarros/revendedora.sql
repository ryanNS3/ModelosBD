CREATE DATABASE RevendedoraCarro;
USE RevendedoraCarro;


CREATE TABLE automovel(
	pk_renavam			char(9) PRIMARY KEY,
    placa				char(7) UNIQUE NOT NULL,
    marca				varchar(40) NOT NULL,
    modelo				varchar(40) NOT NULL,
    ano_fabricacao		DATE,
    ano_modelo			DATE,
    cor					varchar(60) NOT NULL,
    motor				varchar(80) NOT NULL,
    numero_portas		int NOT NULL CHECK(numero_portas > 6 ),
    tipo_combustivel	varchar(40) NOT NULL,
    preco				decimal(14,2),
    CHECK(ano_fabricacao LIKE("--/--/----")),
    CHECK(ano_modelo LIKE("--/--/----"))
);


CREATE TABLE clientes(
	pk_codigo_cli	varchar(9) PRIMARY KEY,
    nomeCompleto	varchar(80) NOT NULL,
    telefone		char(9) NOT NULL UNIQUE,
    rua				varchar(50) NOT NULL,
    numero			int NOT NULL,
    complemento		varchar(30) NOT NULL,
    bairro			varchar(50) NOT NULL,
    cidade			varchar(80) NOT NULL,
    estado			varchar(80) NOT NULL,
    cep				char(8) NOT NULL
);

CREATE TABLE vendedor(
	data_admi		DATE NOT NULL,
    salario_fixo	decimal(8,2) NOT NULL,
    pk_codigo_ven	varchar(9) PRIMARY KEY,
	CHECK(data_admi LIKE("--/--/----"))
);

CREATE TABLE venda(
	data_venda 		DATE NOT NULL,
    preco			decimal(14,2),
    fk_codigo_cli	varchar(9),
    fk_codigo_ven	varchar(9),
    CHECK(data_venda LIKE("--/--/----")),
    FOREIGN KEY(fk_codigo_cli) 	REFERENCES 	clientes(pk_codigo_cli),
    FOREIGN KEY(fk_codigo_ven) 	REFERENCES	vendedor(pk_codigo_ven)
    
);