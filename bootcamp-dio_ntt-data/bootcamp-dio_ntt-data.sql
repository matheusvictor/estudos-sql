CREATE DATABASE bootcamp_dio;

USE bootcamp_dio;

CREATE TABLE PRODUTOS(
	CODIGO INT NOT NULL,
	DESCRICAO VARCHAR(50) NOT NULL,
	DATA_VALIDADE DATETIME,
	EAN VARCHAR(15) NOT NULL,
	IND_INATIVO INT NOT NULL DEFAULT 0
);

-- alterar tabela adicionando considerando o campo código como uma PK
ALTER TABLE PRODUTOS
ADD CONSTRAINT Pk_PRODUTOS PRIMARY KEY (CODIGO);

-- cria índice para a tabela de produto 
CREATE INDEX IDX_PRODUTOS_EAN ON PRODUTOS(EAN);

-- insere dados na tabela Produtos
INSERT INTO PRODUTOS (CODIGO, DESCRICAO, DATA_VALIDADE, EAN, IND_INATIVO) VALUES (1, 'Descrição do produto', GETDATE(), '0123456789', 0);

INSERT INTO PRODUTOS VALUES (2, 'Descrição do produto 2', GETDATE(), '0123456789', 0); -- aqui os valores serão considerados na mesma ordem que as colunas das tabelas

INSERT INTO PRODUTOS (CODIGO, DESCRICAO, EAN) VALUES (3, 'Descrição do produto 3', '0123456789'); -- serão inseridos só os valores declarados como NOT NULL. 
																								  -- o campo IND_INATIVO vai receber o valor 0, pq foi defenido como default

-- listagem de todos os campos de Produtos
SELECT * FROM PRODUTOS;

-- listagem de todos os campos de Produtos o CODIGO seja igual a 2
SELECT * FROM PRODUTOS WHERE CODIGO = 2;

-- listagem de todos os campos de Produtos o CODIGO seja igual a 2.
-- esse tipo de listagem, por ser não indexada, é mais lenta que a anterior pq tenta fazer essa busca de todos os dados que se aproximem ao valor passado no LIKE
SELECT * FROM PRODUTOS WHERE DESCRICAO LIKE '%Produto%';

-- listagem por agregação, onde o retorno é a contagem dos dados inseridos na tabela Produtos
-- AS QTD_PRODUTOS serve para apelidar o retorno da consulta
SELECT COUNT(*) AS QTD_PRODUTOS FROM PRODUTOS;