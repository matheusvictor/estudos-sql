create database aula_sp;
use aula_sp;

create table pessoa(
idpessoa int unsigned not null auto_increment,
nome varchar(50) not null,
data_nascimento date not null,
telefone varchar(20),
email varchar(50),
primary key(idpessoa)
);

delimiter //
create procedure sp_ins_pessoa(pNome varchar(50), pData_nascimento date, pTelefone varchar(20), pEmail varchar(50))
begin
-- o if abaixo vai testar se o paramentro pNome está vazio
	if (pNome = '' || pData_nascimento = '') then
		select 'Faltando dados.'; -- mensagem de erro		
	else
		insert into pessoa (nome, data_nascimento, telefone, email) values
		(pNome, pData_nascimento, pTelefone, pEmail);
	end if;
end;
//

-- chama para a procedure:
call sp_ins_pessoa('Jack', '1998-06-02', '(00) 99999-9999', 'teste@gmail.com');

select * from pessoa;

delimiter //
create procedure sp_del_pessoa(pIdpessoa int)
begin
	if(pIdpessoa is null) then
		select 'Falta o id.';
	else
		delete from pessoa where idpessoa = pIdpessoa;
        select 'Excluído com sucesso!';
	end if;
end;
//

-- chama para a procedure:
call sp_del_pessoa(); -- exibirá mensagem de erro
call sp_del_pessoa(1); -- deletará a pessoa de ID = 1

select * from pessoa;

delimiter //
create procedure sp_update_pessoa(pIdpessoa int, pNome varchar(50), pData_nascimento date, pTelefone varchar(20), pEmail varchar(50))
begin
	if(pIdpessoa is null || pNome is null || pData_nascimento is null) then
		select 'Falta parâmetros.';
	else
		update pessoa set nome = pNome, data_nascimento = pData_nascimento, telefone = pTelefone, email = pEmail
		where idpessoa = pIdpessoa;
	end if;
end;
//

-- chama para a procedure:
call sp_update_pessoa(NULL, NULL, NULL, NULL, NULL); -- exibirá mensagem de erro
call sp_update_pessoa(2, 'Novo nome', '1998-06-03', '(00) 99999-9999', 'outro@gmail.com'); -- alterará a pessoa de ID = 2

select * from pessoa;