-- IFBA - Campus Santo Amaro
-- Atividade Banco de Dados - data: 21/07/2k17
-- Estudantes: Carlos Henrique; Matheus Victor
-- Série/Curso: 3° ano de TI


-- Criando o banco e suas tabelas: 
create database loja;
use loja;

create table clientes (
idclientes int unsigned not null auto_increment primary key,
nome varchar (45), 
endereco varchar (45),
cidade varchar (45), 
cep varchar (45)
);

create table local_trabalho(
idlocal_trabalho int unsigned not null auto_increment primary key,
supervisor varchar(45)
);

create table armazenagem (
idarmazenagem int unsigned not null auto_increment primary key,
local_ varchar(45),
qtde_estoque int(3)
);

create table vendedores (
idvendedores int unsigned not null auto_increment primary key,
nome varchar (45), 
datacontrato date, 
salario float, 
comissao float,
idlocal_trabalho int unsigned not null,
foreign key (idlocal_trabalho) references local_trabalho (idlocal_trabalho)
);

create table pecas (
idpecas int unsigned not null auto_increment primary key,
nome varchar(45),
custo float,
idarmazenagem int unsigned not null,
foreign key (idarmazenagem) references armazenagem (idarmazenagem)
);

create table faturas (
idfaturas int unsigned not null auto_increment primary key,
data_ date, 
idclientes int unsigned not null,
idvendedores int unsigned not null,
foreign key (idclientes) references clientes (idclientes),
foreign key (idvendedores) references vendedores (idvendedores)
);

create table itens (
idpecas int unsigned not null,
idfaturas int unsigned not null,
quantidade int,
foreign key (idpecas) references pecas (idpecas),
foreign key (idfaturas) references faturas (idfaturas)
);

-- Questão 1: Para cada tabela, criar Stored procedures de inserção, exclusão e alteração:

-- Tabela Cliente:
-- procedure inserção:
delimiter //
create procedure sp_inserir_cliente(pNome_cliente varchar(45), pEndereco_cliente varchar(45), pCidade varchar(45), pCep varchar(45))
begin
-- o if abaixo vai testar se o paramentro pNome está vazio
	if (pNome_cliente is null || pEndereco_cliente is null || pCidade is null || pCep is null) then
		select 'Faltando dados.'; -- mensagem de erro		
	else
		insert into clientes(nome, endereco, cidade, cep) values
		(pNome_cliente, pEndereco_cliente, pCidade, pCep);
	end if;
end;
//
-- chamada para a procedure:
-- call sp_inserir_cliente(null, null, null, null);
call sp_inserir_cliente('Jack', 'Rua dos Bobos', 'Terra do Nunca', '00.000-000');
select * from clientes; -- conferindo a inserção

-- procedure exclusão:
delimiter //
create procedure sp_delete_cliente(pId_cliente int)
begin
	if(pId_cliente is null) then
		select 'Falta o ID.';
	else
		delete from clientes where idclientes = pId_cliente;
        select 'Excluído com sucesso!';
	end if;
end;
//
-- chamada para a procedure:
-- call sp_delete_cliente(NULL); -- exibirá mensagem de erro
call sp_delete_cliente(2); -- deletará a pessoa de ID = 2
select * from clientes;

-- procedure de alteração:
delimiter //
create procedure sp_update_cliente(pId_cliente int, pNome_cliente varchar(45), pEndereco_cliente varchar(45), pCidade varchar(45), pCep varchar(45))
begin
	if(pId_cliente is null || pNome_cliente is null || pEndereco_cliente is null || pCidade is null || pCep is null) then
		select 'Falta(m) um ou mais parâmetros.';
	else
		update clientes set nome = pNome_cliente, endereco = pEndereco_cliente, cidade = pCidade, cep = pCep
		where idclientes = pId_cliente;
	end if;
end;
//
-- chamada para a procedure:
-- call sp_update_cliente(NULL, NULL, NULL, NULL, NULL); -- exibirá mensagem de erro
call sp_update_cliente(1, 'Novo nome', 'Uma casa muito engraçada', 'NY', '00.000-001'); -- alterará a pessoa de ID = 1
select * from clientes;