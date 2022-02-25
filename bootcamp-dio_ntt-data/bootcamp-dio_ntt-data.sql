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

-- insere dados na tabela Produtos
INSERT INTO PRODUTOS (CODIGO, DESCRICAO, DATA_VALIDADE, EAN, IND_INATIVO) VALUES (1, 'Descri��o do produto', GETDATE(), '0123456789', 0);

INSERT INTO PRODUTOS VALUES (2, 'Descri��o do produto 2', GETDATE(), '0123456789', 0); -- aqui os valores ser�o considerados na mesma ordem que as colunas das tabelas

INSERT INTO PRODUTOS (CODIGO, DESCRICAO, EAN) VALUES (3, 'Descri��o do produto 3', '0123456789'); -- ser�o inseridos s� os valores declarados como NOT NULL. 
																								  -- o campo IND_INATIVO vai receber o valor 0, pq foi defenido como default
-- listagem de todos os campos de Produtos
SELECT * FROM PRODUTOS;

-- listagem de todos os campos de Produtos onde o CODIGO seja igual a 2
SELECT * FROM PRODUTOS WHERE CODIGO = 2;

-- listagem da descri��o de Produtos onde o CODIGO seja igual a 2
SELECT DESCRICAO FROM PRODUTOS WHERE CODIGO = 2;

-- listagem de todos os campos de Produtos o CODIGO seja igual a 2.
-- esse tipo de listagem, por ser n�o indexada, � mais lenta que a anterior pq tenta fazer essa busca de todos os dados que se aproximem ao valor passado no LIKE
SELECT * FROM PRODUTOS WHERE DESCRICAO LIKE '%Produto%';

-- listagem por agrega��o, onde o retorno � a contagem dos dados inseridos na tabela Produtos
-- AS QTD_PRODUTOS serve para apelidar o retorno da consulta
SELECT COUNT(*) AS QTD_PRODUTOS FROM PRODUTOS;

-- cria tabela Loja j� com uma chave-prim�ria
CREATE TABLE LOJA (
	CODIGO INT NOT NULL,
	NOME VARCHAR(50) NOT NULL,
	IND_INATIVO INT NOT NULL DEFAULT 0,
	CONSTRAINT LOJA_PK PRIMARY KEY(CODIGO)
);

-- popula tabela Loja
INSERT INTO LOJA (CODIGO, NOME) VALUES (1000, 'Tabajara');
INSERT INTO LOJA (CODIGO, NOME) VALUES (2000, 'Filial Dolly');
INSERT INTO LOJA (CODIGO, NOME) VALUES (3000, 'Loja do Adelino');


-- cria tabela Estoque com chave-prim�ria composta
CREATE TABLE ESTOQUE (
	CODIGO_PRODUTO INT NOT NULL,
	CODIGO_FILIAL INT NOT NULL,
	QUANTIDADE DECIMAL NOT NULL DEFAULT 0,
	CONSTRAINT ESTOQUE_PK PRIMARY KEY(CODIGO_PRODUTO, CODIGO_FILIAL)
);

-- insere, propocitalmente, dados n�o normalizados
INSERT INTO ESTOQUE(CODIGO_FILIAL, CODIGO_PRODUTO, QUANTIDADE) VALUES (99, 10, 1); -- n�o existe uma filial com c�digo 99, por exemplo

-- exclui todos os dados da tabela ESTOQUE
DELETE FROM ESTOQUE;

-- altera tabela ESTOQUE e adiciona FK para relacionar as tabelas ESTOQUE e LOJA
ALTER TABLE ESTOQUE ADD CONSTRAINT FK_ESTOQUE_LOJA 
FOREIGN KEY (CODIGO_PRODUTO)
REFERENCES PRODUTOS(CODIGO);

-- altera tabela ESTOQUE e exclui coluna espec�fica
ALTER TABLE ESTOQUE DROP CONSTRAINT FK_ESTOQUE_LOJA;

ALTER TABLE ESTOQUE ADD CONSTRAINT FK_ESTOQUE_LOJA 
FOREIGN KEY (CODIGO_FILIAL)
REFERENCES LOJA(CODIGO);

-- altera tabela ESTOQUE e adiciona FK para relacionar as tabelas ESTOQUE e PRODUTOS
ALTER TABLE ESTOQUE ADD CONSTRAINT FK_ESTOQUE_PRODUTOS 
FOREIGN KEY (CODIGO_PRODUTO)
REFERENCES PRODUTOS(CODIGO);

-- a inser��o n�o ser� mais v�lida pois � feito a valida��o dos valores de acordo com a rela��o das tabelas
-- o c�digo do produto n�o existe
INSERT INTO ESTOQUE(CODIGO_PRODUTO, CODIGO_FILIAL, QUANTIDADE) VALUES (99, 1, 1);

-- a inser��o n�o ser� mais v�lida pois � feito a valida��o dos valores de acordo com a rela��o das tabelas
-- o c�digo da filial n�o existe
INSERT INTO ESTOQUE(CODIGO_PRODUTO, CODIGO_FILIAL, QUANTIDADE) VALUES (1, 10, 1);

-- o c�digo da filial e do produto n�o existem
INSERT INTO ESTOQUE(CODIGO_PRODUTO, CODIGO_FILIAL, QUANTIDADE) VALUES (99, 10, 1);

-- inser��o com sucesso
INSERT INTO ESTOQUE(CODIGO_PRODUTO, CODIGO_FILIAL, QUANTIDADE) VALUES (1, 1000, 1);

-- consulta relacionando tabelas
SELECT ESTOQUE.CODIGO_FILIAL, LOJA.NOME, ESTOQUE.CODIGO_PRODUTO, PRODUTOS.DESCRICAO
FROM ESTOQUE
	INNER JOIN LOJA ON ESTOQUE.CODIGO_FILIAL = LOJA.CODIGO 
	INNER JOIN PRODUTOS ON ESTOQUE.CODIGO_PRODUTO = PRODUTOS.CODIGO;
