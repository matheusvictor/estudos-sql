CREATE DATABASE bootcamp_dio;

USE bootcamp_dio;

CREATE TABLE PRODUTOS(
	CODIGO INT NOT NULL,
	DESCRICAO VARCHAR(50) NOT NULL,
	DATA_VALIDADE DATETIME,
	EAN VARCHAR(15) NOT NULL,
	IND_INATIVO INT NOT NULL DEFAULT 0
);

-- alterar tabela adicionando considerando o campo c�digo como uma PK
ALTER TABLE PRODUTOS
ADD CONSTRAINT Pk_PRODUTOS PRIMARY KEY (CODIGO);

-- cria �ndice para a tabela de produto 
CREATE INDEX IDX_PRODUTOS_EAN ON PRODUTOS(EAN);