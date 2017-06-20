-- IFBA - CAMPUS SANTO AMARO
-- CURSO: INFORMÁTICA	SÉRIE: 3º T.I.
-- DISCIPLINA: BANCO DE DADOS	PROFESSOR: JORGE LEITE
-- ESTUDANTES: CARLOS HENRIQUE CERQUEIRA SANTOS; MATHEUS VICTOR SALES SANTANA

-- Parte 1 CRIANDO O BANCO E SUAS TABELAS: 
create database Clinicas;
use Clinicas;
-- TABELA AMBULATORIOS --
create table Ambulatorios (
nroa int unsigned auto_increment primary key, 
andar int (3) not null, 
capacidade smallint 
);
-- TABELA MEDICOS --
create table Medicos (
codm int unsigned auto_increment primary key, 
nome varchar(45), 
idade smallint, 
especialidade char (20),
cpf varchar(45) unique,
cidade varchar (30),
nroa int unsigned, 
foreign key (nroa) references Ambulatorios(nroa)
);
-- TABELA PACIENTES --
create table Pacientes (
codp int unsigned auto_increment primary key, 
nome varchar(40), 
idade int, 
cidade char(30), 
CPF varchar (45) unique, 
doenca varchar(40)
);
-- TABELA FUNCIONARIOS --
create table Funcionarios (
codf int unsigned auto_increment primary key, 
nome varchar(40), 
idade smallint, 
CPF varchar (45) unique, 
cidade varchar(30), 
salario double, 
cargo varchar(20)
);
-- TABELA CONSULTAS -- 
create table Consultas (
codp int unsigned, 
codm int unsigned,
foreign key (codp) references Pacientes(codp),
foreign key (codm) references Medicos (codm),
datacon date, 
hora time
);

-- Parte 2 MANIPULANDO O BANCO:
-- Crie a coluna nroa (int) na tabela Funcionarios
alter table Funcionarios add nroa int unsigned not null;
-- Tornando o atributo anterior uma chave estrangeira:
alter table Funcionarios add foreign key (nroa) references Ambulatorios (nroa); 

-- Crie os seguintes índices: 1. Medicos: CPF (único), nroa 2. Pacientes: doenca
create index Indice2 on Pacientes (doenca);
create index Indice3 on Medicos (cpf, nroa); 
-- Remover o índice doenca em Pacientes
drop index Indice2 on Pacientes; 
-- Remover as colunas cargo e nroa da tabela de Funcionarios
alter table Funcionarios drop cargo; 
-- alter table Funcionarios drop nroa; -- NÃO REMOVE

-- Parte 3 PREENCHENDO O BANCO:
insert into Ambulatorios(andar, capacidade) values (1, 30);
insert into Ambulatorios(andar, capacidade) values (1, 50);
insert into Ambulatorios(andar, capacidade) values (2, 40);
insert into Ambulatorios(andar, capacidade) values (2, 25);
insert into Ambulatorios(andar, capacidade) values (2, 55);

insert into Medicos(nome, idade, especialidade, cpf, cidade, nroa) values ('Joao', 40, 'ortopedia', '10000100000', 'Florianópolis', 1);
insert into Medicos(nome, idade, especialidade, cpf, cidade, nroa) values ('Maria', 42, 'traumatologia', '10000110000', 'Blumenau', 2);
insert into Medicos(nome, idade, especialidade, cpf, cidade, nroa) values ('Pedro', 51, 'pediatria', '11000100000', 'São José', 2);
insert into Medicos(nome, idade, especialidade, cpf, cidade) values ('Carlos', 28, 'ortopedia', '11000110000', 'Joinville');
insert into Medicos(nome, idade, especialidade, cpf, cidade, nroa) values ('Marcia', 33, 'neurologia', '11000111000', 'Biguacu', 3);

insert into Pacientes (nome, idade, cidade, cpf, doenca) values ('Ana', 20, 'Florianópolis', '20000200000', 'gripe');
insert into Pacientes (nome, idade, cidade, cpf, doenca) values ('Paulo', 24, 'Palhoca', '20000220000', 'fratura');
insert into Pacientes (nome, idade, cidade, cpf, doenca) values ('Lucia', 30, 'Biguacu', '22000200000', 'tendinite');
insert into Pacientes (nome, idade, cidade, cpf, doenca) values ('Carlos', 28, 'Joinville', '11000110000', 'sarampo');

insert into funcionarios (nome, idade, cidade, salario, cpf, nroa) values ('Rita', 32, 'Sao Jose', 1200, '20000100000', 1);
insert into funcionarios (nome, idade, cidade, salario, cpf, nroa) values ('Maria', 55, 'Palhoca', 1220, '30000110000', 2);
insert into funcionarios (nome, idade, cidade, salario, cpf, nroa) values ('Caio', 45, 'Florianópolis', 1100, '40000100000', 3);
-- UM PACIENTE PRECISA DE UM CODIGO DE AMBULATORIO, COMO NO BLOG NÃO HAVIA NENHUM SINALIZADO, ATRIBUIMOS UM:
insert into funcionarios (nome, idade, cidade, salario, cpf, nroa) values ('Carlos', 44, 'Florianópolis', 1200, '50000100000', 4);
insert into funcionarios (nome, idade, cidade, salario, cpf, nroa) values ('Paula', 33, 'Florianópolis', 2500, '60000100000', 5);

insert into consultas(codm, codp, datacon, hora) values (1, 1, '2006-06-12', '14:00');
insert into consultas(codm, codp, datacon, hora) values (1, 4, '2006-06-13', '10:00');
insert into consultas(codm, codp, datacon, hora) values (2, 1, '2006-06-13', '09:00');
insert into consultas(codm, codp, datacon, hora) values (2, 2, '2006-06-13', '11:00');
insert into consultas(codm, codp, datacon, hora) values (2, 3, '2006-06-14', '14:00');
insert into consultas(codm, codp, datacon, hora) values (2, 4, '2006-06-14', '17:00');
insert into consultas(codm, codp, datacon, hora) values (3, 1, '2006-06-19', '18:00');
insert into consultas(codm, codp, datacon, hora) values (3, 3, '2006-06-12', '10:00');
insert into consultas(codm, codp, datacon, hora) values (3, 4, '2006-06-19', '13:00');
insert into consultas(codm, codp, datacon, hora) values (4, 4, '2006-06-20', '13:00');
insert into consultas(codm, codp, datacon, hora) values (4, 4, '2006-06-22', '19:30');

-- Parte 4 REALIZANDO AS CONSULTAS PEDIDAS
-- Q1 Mostre a quantidade consultas atendidas por médico:
select count(consultas.codm), medicos.nome from medicos left join consultas on medicos.codm = consultas.codm group by medicos.codm;
-- Q2 Mostre o nome dos medicos e pacientes em consulta realizadas pela manhã:
select medicos.nome, pacientes.nome, consultas.hora from medicos inner join consultas on medicos.codm = consultas.codm inner join pacientes on consultas.codp = pacientes.codp where consultas.hora between '07:00' and '12:00';
-- Q3 Mostre o nome dos médicos e para aqueles que tiverem consultas, os dados do paciente:
select medicos.nome, pacientes.* from medicos left join consultas on medicos.codm = consultas.codm left join pacientes on consultas.codp = pacientes.codp;
-- Q4 Mostre o total de  medicos por ambulatório:
select count(codm) from medicos group by nroa;
-- Q5 Mostre a especialidade do médico,  a doenca do paciente para cada atendimento em consultas:
select medicos.nome, medicos.especialidade, pacientes.doenca from medicos left join consultas on medicos.codm = consultas.codm left join pacientes on consultas.codp = pacientes.codp;
-- Q6 mostre a média de idade dos pacientes atendidos pelos médicos, por ambulatório:
select avg(pacientes.idade), medicos.nroa from consultas inner join pacientes on consultas.codp = pacientes.codp inner join medicos on consultas.codm = medicos.codm group by nroa;
-- Q7 Mostre o nome do médico com o menor número de atendimentos em consultas:
select min(consultas.codp), medicos.nome as Nome_Medico from medicos left join consultas on medicos.codm = consultas.codm left join pacientes on  consultas.codp = pacientes.codp group by medicos.nome order by min(consultas.codp);
-- Q8 Mostre  a quantidade de médicos por especialidade:
select count(codm) from medicos group by especialidade;
-- Q9 Mostre os dados do médico que não atendeu qualquer consulta:
select medicos.nome from medicos left join consultas on medicos.codm = consultas.codm where consultas.codm is null;
-- Q10 mostre a soma das idades dos pacientes atendidos por médico, do maior para o menor:
select sum(pacientes.idade) as SOMA_IDADES, medicos.nome from pacientes inner join consultas on pacientes.codp = consultas.codp inner join medicos on consultas.codm = medicos.codm group by medicos.codm order by SOMA_IDADES desc;