-- IFBA - Campus Santo Amaro
-- Atividade Banco de Dados - data: 21/07/2k17
-- Estudantes: Carlos Henrique; Matheus Victor
-- Série/Curso: 3° ano de TI

-----------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------

-- Questão 1: Para cada tabela, criar Stored procedures de inserção, exclusão e alteração:

-----------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- Tabela armazenagem:

-- procedure de inserção:
delimiter //
create procedure sp_inserir_armazenagem(pLocal_armazenagem varchar(45), pQtde_estoque_armazenagem int)
begin
	if(pLocal_armazenagem is null || pQtde_estoque_armazenagem is null) then
		select 'Está faltando parâmetros.';    
    else
		insert into armazenagem (local_, qtde_estoque) values
        (pLocal_armazenagem, pQtde_estoque_armazenagem); 
        select 'Inserido com sucesso!';
    end if;
end;
//
-- chamada para a procedure:
-- call sp_inserir_armazenagem(NULL, NULL); -- exibirá mensagem de erro
call sp_inserir_armazenagem('Fazenda do Sr. Jones', 200);
select * from armazenagem;

-- procedure de exclusão:
delimiter //
create procedure sp_delete_armazenagem(pIdarmazenagem int)
begin
	if(pIdarmazenagem is null) then
		select 'Está faltando o ID';
	else
		delete from armazenagem where idarmazenagem = pIdarmazenagem;
        select 'Excluído com sucesso!';
	end if;
end;
//
-- chamada para a procedure:
-- call sp_delete_armazenagem(NULL); -- exibirá mensagem de erro
call sp_delete_armazenagem(2); -- deletará a pessoa de ID = 2
select * from armazenagem;

-- procedure de alteração:
delimiter //
create procedure sp_update_armazenagem(pId_armazenagem int, pLocal_armazenagem varchar(45), pQtde_estoque_armazenagem int)
begin
	if(pId_armazenagem is null || pLocal_armazenagem is null || pQtde_estoque_armazenagem is null) then
		select 'Está faltando um ou mais parâmetros.';
    else
		update armazenagem set local_ = pLocal_armazenagem, qtde_estoque = pQtde_estoque_armazenagem
        where idarmazenagem = pId_armazenagem;
        select 'Alterado com sucesso!';
    end if;
end;
//
-- call sp_update_armazenagem(NULL, NULL, NULL);
call sp_update_armazenagem(1, 'Townsville ', 300); -- alterará a armazenagem de ID = 1
select * from armazenagem; -- conferindo...
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- Tabela local_trabalho:

-- procedure de inserção:
delimiter //
create procedure sp_inserir_local_trabalho(pSupervisor varchar(45))
begin
	if(pSupervisor is null) then
		select 'Está faltando parâmetro.';
	else
		insert into local_trabalho (supervisor) values (pSupervisor);
        select 'Inserido com sucesso!';
	end if;
end;
//
-- chamada da procedure:
-- call sp_inserir_local_trabalho(null); -- msg de erro
call sp_inserir_local_trabalho('Dr. Octopus');
select * from local_trabalho; -- conferindo...

-- procedure de exclusão:
delimiter //
create procedure sp_delete_local_trabalho(pId_local_trabalho int)
begin
	if(pId_local_trabalho is null) then
		select 'Está faltando o ID.';
	else
		delete from local_trabalho where idlocal_trabalho = pId_local_trabalho;
        select 'Excluído com sucesso!';
	end if;
end;
//
-- chamada da procedure:
-- call sp_delete_local_trabalho(null); -- msg de erro
call sp_delete_local_trabalho(2); -- excluirá local de trabalho com id = 2
select * from local_trabalho; -- conferindo...

-- procedure de alteração:
delimiter //
create procedure sp_update_local_trabalho(pId_local_trabalho int, pSupervisor varchar(45))
begin
	if(pId_local_trabalho is null || pSupervisor is null) then
		select 'Está faltando parâmetros.';
	else
		update local_trabalho set supervisor = pSupervisor where idlocal_trabalho = pId_local_trabalho;
        select 'Alterado com sucesso!';
	end if;
end;
//
-- chamada da procedure:
-- call sp_update_local_trabalho(1, null); -- msg de erro
call sp_update_local_trabalho(1, 'Tony Stark'); -- alterará local de trabalho com id = 1
select * from local_trabalho; -- conferindo...
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- Tabela pecas:

-- procedure de inserção:
delimiter //
create procedure sp_inserir_peca(pNome_peca varchar(45), pCusto_peca float, pId_armazenagem int)
begin
	if(pNome_peca is null || pCusto_peca is null || pId_armazenagem is null) then
		select 'Está faltando um ou mais parâmetros.';
	else
		insert into pecas (nome, custo, idarmazenagem) values (pNome_peca, pCusto_peca, pId_armazenagem);
        select 'Inserido com sucesso!';
    end if;
end;
//
-- chamada da procedure:
-- call sp_inserir_peca(null, null, null); -- msg de erro
call sp_inserir_peca('Parafuso', 10, 1); -- inserindo peça no armazem com id = 1
select * from pecas; -- conferindo...

-- procedure de exclusão:
delimiter //
create procedure sp_delete_peca(pId_peca int)
begin
	if(pId_peca is null) then
		select 'Está faltando o ID.';
	else
		delete from pecas where idpecas = pId_peca;
        select 'Excluído com sucesso!';
    end if;
end;
//
-- chamada da procedure:
-- call sp_delete_peca(null); -- msg de erro
call sp_delete_peca(2); -- inserindo peça no armazem com id = 2
select * from pecas; -- conferindo...

-- procedure de alteração:
delimiter //
create procedure sp_update_peca(pId_peca int, pNome_peca varchar(45), pCusto_peca float, pId_armazenagem int)
begin
	if(pId_peca is null || pNome_peca is null || pCusto_peca is null || pId_armazenagem is null) then
		select 'Está faltando um ou mais parâmetros.';
	else
		update pecas set nome = pNome_peca, custo = pCusto_peca, idarmazenagem = pId_armazenagem
        where idpecas = pId_peca;
        select 'Alterado com sucesso!';
    end if;
end;
//
-- chamada da procedure:
call sp_update_peca(null, null, null, null); -- msg de erro
call sp_update_peca(1, 'Cimento', 5, 1);
select * from pecas; -- conferindo...
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- Tabela vendedores:

-- procedure de inserção:
delimiter //
create procedure sp_inserir_vendedor(pNome_vendedor varchar (45), pDatacontrato_vendedor date, pSalario_vendedor float, pComissao_vendedor float, pIdlocal_trabalho_vendedor int)
begin
	if (pNome_vendedor is null || pDatacontrato_vendedor is null || pSalario_vendedor is null || pComissao_vendedor is null || pIdlocal_trabalho_vendedor is null) then
		select 'Faltando dados.'; -- mensagem de erro		
	else
		insert into vendedores(nome, datacontrato, salario, comissao, idlocal_trabalho) values
		(pNome_vendedor, pDatacontrato_vendedor, pSalario_vendedor, pComissao_vendedor, pIdlocal_trabalho_vendedor);
	end if;
end;
//
-- chamada para a procedure:
-- call sp_inserir_vendedor(NULL, NULL, NULL, NULL, NULL); -- exibirá mensagem de erro
call sp_inserir_vendedor('Halls', '2017-07-22', 200, 100, 1);
select * from vendedores;

-- procedure de exclusão:
delimiter //
create procedure sp_delete_vendedor(pId_vendedor int)
begin
	if (pId_vendedor is null) then
		select 'Faltando o ID.'; -- mensagem de erro		
	else
		delete from vendedores where idvendedores = pId_vendedor;
	end if;
end;
//
-- chamada para a procedure:
-- call sp_delete_vendedor(NULL); -- exibirá mensagem de erro
call sp_delete_vendedor(2);
select * from vendedores;

-- procedure de alteração:
delimiter //
create procedure sp_update_vendedor(pId_vendedor int, pNome_vendedor varchar(45), pData_contrato_vendedor date, pSalario_vendedor float, pComissao_vendedor float, pId_local_trabalho int)
begin
	if (pId_vendedor is null || pNome_vendedor is null || pData_contrato_vendedor is null || pSalario_vendedor is null || pComissao_vendedor is null || pId_local_trabalho is null) then
		select 'Faltando um ou mais parâmetros.'; -- mensagem de erro		
	else
		update vendedores set nome = pNome_vendedor, datacontrato = pData_contrato_vendedor, salario = pSalario_vendedor, comissao = pComissao_vendedor, idlocal_trabalho = pId_local_trabalho
        where idvendedores = pId_vendedor;
        select 'Alterado com sucesso!';
	end if;
end;
//
-- chamada para a procedure:
-- call sp_update_vendedor(1, NULL, NULL, NULL, NULL, NULL); -- exibirá mensagem de erro
call sp_update_vendedor(1, 'Fulano', '2017-07-21', 300, 150, 1);
select * from vendedores;
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- Tabela faturas:

-- procedure de inserção:
delimiter //
create procedure sp_inserir_fatura(pData_ date, pId_cliente int, pId_vendedor int)
begin
	if(pData_ is null || pId_cliente is null || pId_vendedor is null) then
		select 'Faltam um ou mais parâmetros.';
	else
		insert into faturas (data_, idclientes, idvendedores) values (pData_, pId_cliente, pId_vendedor);
        select 'Inserido com sucesso!';
	end if;
end;
//
-- chamada da procedure:
-- call sp_inserir_fatura(NULL, NULL, NULL); -- msg de erro
call sp_inserir_fatura('2017-07-22', 1, 1);
select * from faturas;

-- procedure de exclusão:
delimiter //
create procedure sp_delete_fatura(pId_fatura int)
begin
	if(pId_fatura is null) then
		select 'Falta o ID.';
	else
		delete from faturas where idfaturas = pId_fatura;
        select 'Excluído com sucesso!';
	end if;
end;
//
-- chamada da procedure:
-- call sp_delete_fatura(NULL); -- msg de erro
call sp_delete_fatura(2); -- excluirá a fatura com id = 2
select * from faturas; -- conferindo...

-- procedure de alteração:
delimiter //
create procedure sp_update_fatura(pId_fatura int, pData_ date, pId_cliente int, pId_vendedor int)
begin
	if(pId_fatura is null || pData_ is null || pId_cliente is null || pId_vendedor is null) then
		select 'Faltam um ou mais parâmetros.';
	else
		update faturas set data_ = pData_, idclientes = pId_cliente, idvendedores = pId_vendedor
        where idfaturas = pId_fatura;
        select 'Alterado com sucesso!';
	end if;
end;
//
-- chamada da procedure:
-- call sp_update_fatura(NULL, NULL, NULL, NULL); -- msg de erro
call sp_update_fatura(1, '2016-07-22', 1, 1); -- alterará a fatura com id = 1
select * from faturas;
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- Tabela itens:

-- procedure de inserção:
delimiter //
create procedure sp_inserir_item(pId_peca int, pId_fatura int, pQuantidade int)
begin
	if(pId_peca is null || pId_fatura is null || pQuantidade is null) then
		select 'Faltam um ou mais parâmetros.';
	else
		insert into itens (idpecas, idfaturas, quantidade) values (pId_peca, pId_fatura, pQuantidade);
        select 'Inserido com sucesso!';
	end if;
end;
//
-- chamada da procedure:
-- call sp_inserir_item(NULL, NULL, NULL); -- msg de erro
call sp_inserir_item(1, 1, 100);
select * from itens;

-- procedure de exclusão:
delimiter //
create procedure sp_delete_item(pId_peca int, pId_fatura int)
begin
	if(pId_peca is null || pId_fatura is null) then
		select 'Faltam um ou mais parâmetros.';
	else
		delete from itens where idpecas =  pId_peca and idfaturas = pId_fatura;
        select 'Excluído com sucesso!';
	end if;
end;
//
-- chamada da procedure:
-- call sp_delete_item(NULL, NULL); -- msg de erro
call sp_delete_item(1, 1);
select * from itens;

-- procedure de alteração:
delimiter //
create procedure sp_update_item(pId_peca int, pId_fatura int, pQuantidade int)
begin
	if(pId_peca is null || pId_fatura is null || pQuantidade is null) then
		select 'Faltam um ou mais parâmetros.';
	else
		update itens set idpecas = pId_peca, idfaturas = pId_fatura, quantidade = pQuantidade
        where idpecas = pId_peca and idfaturas = pId_fatura;
        select 'Alterado com sucesso!';
	end if;
end;
//
-- chamada da procedure:
-- call sp_update_item(NULL, NULL, NULL); -- msg de erro
call sp_update_item(1, 3, 100); -- alterará a item com id = 3
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-- Questão 2: Além disso, faça relatórios por meio de visões contendo o seguinte:

-----------------------------------------------------------------------------------

-- vendedores e seus locais de trabalho:
create view v_vendedor_localtrabalho as
select vendedores.nome as VENDEDOR, local_trabalho.idlocal_trabalho as ID_LOCAL_TRABALHO, local_trabalho.supervisor as SUPERVISOR
from local_trabalho inner join vendedores on local_trabalho.idlocal_trabalho = vendedores.idlocal_trabalho;

SELECT * FROM v_vendedor_localtrabalho; -- chamando a view

-- nome dos itens contidos em faturas, com os dados do cliente:
create view v_item_fatura_cliente as
select pecas.nome as NOME_ITEM, clientes.nome as CLIENTE, clientes.endereco as ENDERECO, clientes.cidade as CIDADE, clientes.cep as CEP
from pecas inner join itens on pecas.idpecas = itens.idpecas
inner join faturas on faturas.idfaturas = itens.idfaturas
inner join clientes on clientes.idclientes = faturas.idclientes;

SELECT * FROM v_item_fatura_cliente; -- chamando a view

-- total de faturas por cliente:
create view v_fatura_cliente as
select clientes.nome as CLIENTE, count(faturas.idfaturas) as TOTAL_FATURAS
from faturas inner join clientes on faturas.idclientes = clientes.idclientes
group by CLIENTE;

SELECT * FROM v_fatura_cliente;

-- total de vendas de um vendedor:
create view v_vendas_vendedor as
select vendedores.nome as VENDEDOR, count(faturas.idfaturas) as TOTAL_VENDAS
from faturas inner join vendedores on faturas.idvendedores = vendedores.idvendedores
group by VENDEDOR;

select * from v_vendas_vendedor ;

-- lista de peças por local de armazenagem:
create view v_pecas_armazenagem as
select pecas.nome as PECA, armazenagem.idarmazenagem as ID_ARMAZEM, armazenagem.local_ as LOCAL_ARMAZENAGEM, armazenagem.qtde_estoque as ESTOQUE
from armazenagem inner join pecas on pecas.idarmazenagem = armazenagem.idarmazenagem
order by LOCAL_ARMAZENAGEM;

select * from v_pecas_armazenagem;

-- valor total de uma fatura:
create view v_valortotal_fatura as
select faturas.idfaturas as ID_FATURA, pecas.idpecas as ID_PECA, pecas.custo as CUSTO_PECA, itens.quantidade as QUANTIDADE, (pecas.custo * itens.quantidade) as VALOR_FATURA
from pecas inner join itens on pecas.idpecas = itens.idpecas
inner join faturas on itens.idfaturas = faturas.idfaturas;

select * from v_valortotal_fatura;

-- listar peças que não foram vendidas:
create view v_pecas_nao_vendidas as
select pecas.nome as PECA from pecas
left join itens on pecas.idpecas = itens.idpecas
left join faturas on faturas.idfaturas = itens.idfaturas;

select * from v_pecas_nao_vendidas;

-- Nome do vendedores que venderam a peça "pneu":
create view v_vendedores_peca_pneu as
select vendedores.nome as VENDEDOR from vendedores
inner join faturas on faturas.idvendedores = vendedores.idvendedores
inner join itens on itens.idfaturas = faturas.idfaturas
inner join pecas on pecas.idpecas = itens.idpecas
where pecas.nome = 'pneu';

select * from v_vendedores_peca_pneu;