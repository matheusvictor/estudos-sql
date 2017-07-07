-- IFBA - CAMPUS SANTO AMARO
-- CURSO: INFORMÁTICA	SÉRIE: 3º T.I.
-- DISCIPLINA: BANCO DE DADOS	PROFESSOR: JORGE LEITE
-- ESTUDANTES: CARLOS HENRIQUE CERQUEIRA SANTOS; MATHEUS VICTOR SALES SANTANA

-- Q1: Crie as procedures de inserção, exclusão e alteração para a tabela socios:
-- criando procedure de inserção:
delimiter //
create procedure sp_inserir_socio(pNome_socio varchar(45), pCpf varchar(11), pTelefone varchar(15), pId_tipo_socio int(11))
begin
-- o if abaixo vai testar se o paramentro pNome está vazio
	if (pNome_socio is null || pCpf is null || pTelefone is null || pId_tipo_socio is null) then
		select 'Faltando dados.'; -- mensagem de erro		
	else
		insert into socios(nomesocio, cpf, telefone, idtipo_socio) values
		(pNome_socio, pCpf, pTelefone, pId_tipo_socio);
	end if;
end;
//
-- chamada para a procedure:
call sp_inserir_socio(null, null, null, null);
call sp_inserir_socio('Jack', '19980602', '(00) 99999-9999', 1);
select * from socios; -- conferindo a inserção

-- criando procedure de exclusão:
delimiter //
create procedure sp_delete_socio(pId_socio int)
begin
	if(pId_socio is null) then
		select 'Falta o id.';
	else
		delete from socios where idsocios = pId_socio;
        select 'Excluído com sucesso!';
	end if;
end;
//
-- chamada para a procedure:
call sp_delete_socio(NULL); -- exibirá mensagem de erro
call sp_delete_socio(10); -- deletará a pessoa de ID = 10
select * from socios;

-- criando procedure de alteração:
delimiter //
create procedure sp_update_socio(pId_socio int, pNome_socio varchar(45), pCpf varchar(11), pTelefone varchar(15), pId_tipo_socio int(11))
begin
	if(pId_socio is null || pNome_socio is null || pCpf is null || pTelefone is null || pId_tipo_socio is null) then
		select 'Falta(m) um ou mais parâmetros.';
	else
		update socios set nomesocio = pNome_socio, cpf = pCpf, telefone = pTelefone, idtipo_socio = pId_tipo_socio
		where idsocios = pId_socio;
	end if;
end;
//
-- chamada para a procedure:
call sp_update_socio(NULL, NULL, NULL, NULL, NULL); -- exibirá mensagem de erro
call sp_update_socio(9, 'Novo nome', '19980603', '(00) 99999-9999', 2); -- alterará a pessoa de ID = 9
select * from socios;

-- Q2: Crie as procedures de inserção, exclusão e alteração para a tabela atendentes:
-- criando procedure de inserção:
delimiter //
create procedure sp_inserir_atendente(pNome_atendente varchar(45), pCodigo varchar(4))
begin
-- o if abaixo vai testar se o paramentro pNome está vazio
	if (pNome_atendente is null || pCodigo is null) then
		select 'Faltando dados.'; -- mensagem de erro		
	else
		insert into atendentes(nomeatendente, codigo) values
		(pNome_atendente, pCodigo);
        select 'Atendente cadastrado.';
	end if;
end;
//
-- chamada para a procedure:
call sp_inserir_atendente(null, null);
call sp_inserir_atendente('Halls', '0000');
select * from atendentes; -- conferindo a inserção

-- criando procedure de exclusão:
delimiter //
create procedure sp_delete_atendente(pId_atendente int)
begin
	if(pId_atendente is null) then
		select 'Falta o id.';
	else
		delete from atendentes where idatendentes = pId_atendente;
        select 'Excluído com sucesso!';
	end if;
end;
//
-- chamada para a procedure:
call sp_delete_atendente(NULL); -- exibirá mensagem de erro
call sp_delete_atendente(6); -- deletará a pessoa de ID = 6
select * from atendentes;

-- criando procedure de alteração:
delimiter //
create procedure sp_update_atendente(pId_atendente int, pNome_atendente varchar(45), pCodigo varchar(4))
begin
	if(pId_atendente is null || pNome_atendente is null || pCodigo is null) then
		select 'Falta(m) um ou mais parâmetros.';
	else
		update atendentes set nomeatendente = pNome_atendente, codigo = pCodigo
		where idatendentes = pId_atendente;
	end if;
end;
//
-- chamada para a procedure:
call sp_update_atendente(NULL, NULL, NULL); -- exibirá mensagem de erro
call sp_update_atendente(5, 'Novo nome', '199'); -- alterará a pessoa de ID = 5
select * from atendentes;

-- Q3: Além disso, crie as procedures a seguir:
-- busca por pedidos pelo nome do cliente:
delimiter //
create procedure sp_pedidos_por_cliente(pNome_socio varchar(45))
begin
	if(pNome_socio is null) then
		select 'Falta o nome do cliente.';
	else
		select pedidos.idpedidos as ID_PEDIDO, pedidos.datapedido as DATA_PEDIDO, pedidos.valor_total as VALOR,
        socios.nomesocio as CLIENTE, atendentes.nomeatendente as ATENDENTE from atendentes
        inner join pedidos on atendentes.idatendentes = pedidos.idatendentes
        inner join socios  on pedidos.idsocios = socios.idsocios
        where socios.nomesocio = pNome_socio;
	end if;
end;
//
-- chamada para a procedure:
call sp_pedidos_por_cliente(NULL); -- exibirá mensagem de erro
call sp_pedidos_por_cliente('Flavia'); -- buscará os pedidos do cliente cujo nome é Flavia

-- lista de socios por tipo (parâmetro = tipo de socio):
delimiter //
create procedure sp_listar_socios(pTipo_socio varchar(45))
begin
	if(pTipo_socio is null) then
		select 'Falta o tipo do socio.';
	else
		select tipo_socios.tipo_socio as TIPO, tipo_socios.idtipo_socio as ID_TIPO, socios.nomesocio as CLIENTE
        from tipo_socios inner join socios on tipo_socios.idtipo_socio = socios.idtipo_socio
        where tipo_socios.tipo_socio = pTipo_socio;
	end if;
end;
//
-- chamada para a procedure:
call sp_listar_socios(NULL); -- exibirá mensagem de erro
call sp_listar_socios('ouro'); -- buscará os socios do tipo ouro, por exemplo

-- lista de atendimentos de um atendente e de seu sócio (parâmentro = nome do atendente):
delimiter //
create procedure sp_listar_atendimentos(pNome_atendente varchar(45))
begin
	if(pNome_atendente is null) then
		select 'Falta o nome do atendente.';
	else
		select atendentes.idatendentes as ID_ATENDENTE, atendentes.nomeatendente as ATENDENTE, atendentes.codigo as COD, socios.nomesocio as SOCIO,
		pedidos.datapedido as DATA_PEDIDO, pedidos.valor_total as VALOR
        from atendentes inner join pedidos on atendentes.idatendentes = pedidos.idatendentes
        inner join socios on pedidos.idsocios = socios.idsocios
        where atendentes.nomeatendente = pNome_atendente;
	end if;
end;
//
-- chamada para a procedure:
call sp_listar_atendimentos(NULL); -- exibirá mensagem de erro
call sp_listar_atendimentos('jorge'); -- buscará os atendimentos do atendente jorge, por exemplo