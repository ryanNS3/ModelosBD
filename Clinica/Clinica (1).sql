
CREATE DATABASE ClinicaB;
USE ClinicaB;

CREATE TABLE sala(
	PK_numero_Sala 	INT UNIQUE PRIMARY KEY NOT NULL,
    andar       	INT UNIQUE NOT NULL,
    CHECK(PK_numero_Sala > 1 & PK_numero_Sala < 50),
    CHECK(andar < 12)
);

CREATE TABLE medicos(
	PK_crm      	VARCHAR(15) UNIQUE PRIMARY KEY NOT NULL,
    FK_matricula	VARCHAR(15) UNIQUE NOT NULL,
    nome     		VARCHAR(40) NOT NULL,
    idade    		int,
    especialidade   CHAR(20) NOT NULL DEFAULT 'Ortopedia',
    cpf      		VARCHAR(15) UNIQUE NOT NULL,
    data_Admissao    DATE NOT NULL,
    FOREIGN KEY(FK_matricula) REFERENCES funcionarios(PK_matricula),
    CHECK(data_Admissao LIKE "--/--/----"),
    CHECK(idade > 23)
	
);

CREATE TABLE pacientes(
	PK_rg				VARCHAR(15) UNIQUE PRIMARY KEY NOT NULL,
    nome			VARCHAR(40) NOT NULL,
    data_Nascimento	DATE NOT NULL,
    cidade			CHAR(30) DEFAULT 'itabuna',
    doenca			VARCHAR(40) NOT NULL,
    plano_Saude		VARCHAR(40) NOT NULL DEFAULT 'SUS',
    CHECK(data_Nascimento LIKE "--/--/----")
    
    
);

CREATE TABLE funcionarios(
	PK_matricula	VARCHAR(15) PRIMARY KEY UNIQUE NOT NULL,
    nome			VARCHAR(40) NOT NULL,
    data_Nascimento	DATE NOT NULL,
    data_Admissao	DATE NOT NULL,
    cargo			VARCHAR(40) NOT NULL DEFAULT 'Assistente Médico',
    salario			FLOAT NOT NULL DEFAULT 510.00,
    CHECK(data_Nascimento LIKE "--/--/----"),
    CHECK(data_Admissao LIKE "--/--/----")
    
);

CREATE TABLE consultas(
	codigo_Consulta		INT UNIQUE PRIMARY KEY NOT NULL,
    FK_crm      		VARCHAR(15) UNIQUE  NOT NULL,
    FK_rg				VARCHAR(15) UNIQUE NOT NULL,
    Fk_numero_sala		INT UNIQUE NOT NULL,
    data_Horario		DATETIME,
    FOREIGN KEY(FK_crm) REFERENCES medicos(PK_crm),
    FOREIGN KEY(FK_rg)  REFERENCES pacientes(PK_rg),
    FOREIGN KEY(FK_numero_sala) REFERENCES sala(PK_numero_sala) 
    
)
