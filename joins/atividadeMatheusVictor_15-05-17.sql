-- IFBA - CAMPUS SANTO AMARO
-- CURSO: INFORMÁTICA	SÉRIE: 3ºANO
-- DISICPLINA: BANCO DE DADOS 	PROFESSOR: JORGE LEITE
-- ALUNO: MATHEUS VICTOR S. SANTANA

-- Q1 mostre a qnt de filmes por ator:
select ator.primeiro_nome, ator.ultimo_nome, count(filme_ator.filme_id) as QNT_FILME_ATOR from
ator inner join filme_ator on ator.ator_id = filme_ator.ator_id
group by ator.primeiro_nome, ator.ultimo_nome;

-- Q2 mostre o total de fitas por filme no inventário:
select filme.titulo, count(inventario.filme_id) as TOTAL_FITAS from
filme inner join inventario on filme.filme_id = inventario.filme_id
group by filme.titulo;

-- Q3 mostre os países e, para aqueles cadastrados, suas respectivas cidades:
select pais.pais, cidade.cidade from
pais left join cidade on pais.pais_id = cidade.cidade_id
order by pais.pais;

-- Q4 mostre o valor médio pago por aluguel:
select aluguel.aluguel_id as ID_ALUGUEL, avg(pagamento.valor) as VALOR_MEDIO from aluguel
inner join pagamento on aluguel.aluguel_id = pagamento.aluguel_id
group by aluguel.aluguel_id;

-- Q5 mostre as 3 lojas que têm mais clientes:
select loja.loja_id as ID_LOJA, count(cliente.loja_id) as CLIENTES
from loja inner join cliente on loja.loja_id = cliente.loja_id group by ID_LOJA
order by CLIENTES
limit 3;

-- Q6 mostre o total pago por cliente:
select sum(pagamento.valor) as VALOR_PAGO, cliente.primeiro_nome as NOME, cliente.ultimo_nome as SOBRENOME from cliente
inner join pagamento on cliente.cliente_id = pagamento.cliente_id
group by cliente.cliente_id;

-- Q7 mostre as categorias, seus respectivos filmes e atores:
select categoria.nome as CATEGORIA, filme.titulo as TITULO, ator.primeiro_nome as NOME_ATOR, ator.ultimo_nome as SOBRENOME_ATOR
from ator
inner join filme_ator on ator.ator_id = filme_ator.ator_id
inner join filme on filme_ator.filme_id = filme.filme_id
inner join filme_categoria on filme.filme_id = filme_categoria.filme_id
inner join categoria on filme_categoria.filme_id = filme.filme_id;

-- Q8 mostre o total recebido em pagamentos por funcionário e sua respectiva loja
select sum(pagamento.valor) as TOTAL, funcionario.primeiro_nome as NOME_FUNC, funcionario.ultimo_nome as SOBRENOME_FUNC, loja.loja_id as ID_LOJA
from funcionario
inner join pagamento on funcionario.funcionario_id = pagamento.funcionario_id
inner join loja on funcionario.loja_id = loja.loja_id
group by ID_LOJA;

-- Q9 mostre o faturamento por filme ordenados por titulo e valor
select filme.titulo, sum(pagamento.valor)
from filme inner join inventario
on filme.filme_id = inventario.filme_id
inner join aluguel
on inventario.inventario_id = aluguel.inventario_id
inner join pagamento
on pagamento.pagamento_id = aluguel.aluguel_id
group by filme.filme_id
order by filme.titulo, pagamento.valor;

-- Q10 mostre os dados de uma loja, seu inventário e o título dos filmes
select loja.loja_id as ID_LOJA, loja.ultima_atualiz	acao as ULTIMA_ATT, inventario.inventario_id as ID_IVENT, inventario.ultima_atualizacao as ULTIMA_ATT, filme.titulo as TITULO, endereco.endereco as END_PRINCIPAL
from filme
inner join inventario on filme.filme_id = inventario.filme_id
inner join loja on inventario.loja_id = loja.loja_id
inner join endereco on loja.endereco_id = endereco.endereco_id
order by loja.loja_id;

