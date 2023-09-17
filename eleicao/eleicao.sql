CREATE DATABASE eleicao;
USE eleicao;

CREATE TABLE cargo(
	pk_codigo_cargo	int PRIMARY KEY,
    nome_cargo		varchar(40) UNIQUE NOT NULL CHECK(nome_cargo NOT IN('Prefeito','Vereador')),
    salario			float NOT NULL DEFAULT 17000,
    numero_Vagas	int  UNIQUE NOT NULL
);

CREATE TABLE candidato(
	numero_candidato	int PRIMARY KEY,
    nome				varchar(40) UNIQUE NOT NULL,
    fk_codigo_cargo		int NOT NULL,
    fk_codigo_partido	int NOT NULL,
    FOREIGN KEY(fk_codigo_cargo) REFERENCES cargo(pk_codigo_cargo),
    FOREIGN KEY(fk_codigo_partido) REFERENCES partido(pk_codigo_partido)
    
);

CREATE TABLE partido(
	pk_codigo_partido	int  PRIMARY KEY,
    sigla				varchar(8) UNIQUE NOT NULL,
    numero				int UNIQUE NOT NULL
);

CREATE TABLE eleitor(
	pk_titulo_eleitor		varchar(30) PRIMARY KEY,
    zona_eleitoral			varchar(5) NOT NULL,
    sessao_eleitoral		varchar(5) NOT NULL,
    nome					varchar(40) NOT NULL
    
);

CREATE TABLE voto(
	fk_titulo_eleitor		varchar(30) NOT NULL,
    pk_numero_candidato		int PRIMARY KEY
)







