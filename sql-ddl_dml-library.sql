create schema livraria;
set search_path = livraria;

/*
drop table
	genero,
	editora,
	livro,
	autor,
	ranking,
	livro_autor,
	classificacao;
*/

--Criação das tabelas
create table
	genero(
		id_genero smallint not null,
		descricao varchar (10) not null,
		primary key (id_genero)
	);
	
create table
	editora(
		id_editora smallint not null,
		nome varchar (30) not null,
		primary key (id_editora)
	);
	
create table
	livro(
		id_livro smallint not null,
		titulo varchar (50) not null,
		preco numeric(10,2),
		id_editora smallint not null,
		id_genero smallint not null,
		primary key (id_livro),
		foreign key (id_editora) references editora (id_editora),
		foreign key (id_genero) references genero (id_genero)
	);
	
create table
	autor(
		id_autor smallint not null,
		nome varchar (30) not null,
		primary key (id_autor)
	);
	
create table
	ranking(
		id_ranking smallint not null,
		data_inicial date not null,
		data_final date,
		primary key (id_ranking)
	);
	
create table
	livro_autor(
		id_livro smallint not null,
		id_autor smallint not null,
		primary key (id_livro, id_autor),
		foreign key (id_livro) references livro (id_livro),
		foreign key (id_autor) references autor (id_autor)
	);
	
create table
	classificacao(
		id_livro smallint not null,
		id_ranking smallint not null,
		posicao smallint,
		primary key (id_livro, id_ranking),
		foreign key (id_livro) references livro (id_livro),
		foreign key (id_ranking) references ranking (id_ranking)
	);
	
--inserção dos dados:
insert into genero (id_genero, descricao) values
	(1, 'infantil'),
	(2, 'Ficção'),
	(3, 'Romance'),
	(4, 'Auto-ajuda'),
	(5, 'Negócios'),
	(6, 'História');

insert into editora (id_editora, nome) values
	(1, 'Ática'),
	(2, 'Macron Books'),
	(3, 'Rocco'),
	(4, 'Scipione'),
	(5, 'Sagra Luzato');
	
insert into livro (id_livro, titulo, preco, id_editora, id_genero) values
	(1, 'A', 25.30, 1, 1),
	(2, 'B', 32.45, 1, 4),
	(3, 'C', 122.00, 4, 2),
	(4, 'D', 100.99, 4, 3),
	(5, 'E', 16.16, 1, 5),
	(6, 'F', 4.56, 3, 1),
	(7, 'G', 85.20, 2, 5),
	(8, 'H', 89.90, 5, 5),
	(9, 'I', 63.36, 2, 2),
	(10, 'J', 41.40, 3, 3),
	(11, 'K', 200.30, 4, 6),
	(12, 'L', 99.99, 2, 4);
	
insert into autor (id_autor, nome) values
	(1, 'Pedro'),
	(2, 'Marcos'),
	(3, 'Felipe'),
	(4, 'Ana'),
	(5, 'Maria'),
	(6, 'Francisco'),
	(7, 'Antônio'),
	(8, 'Beatriz');

insert into ranking (id_ranking, data_inicial, data_final) values
	(1, '2003-08-17', '2003-08-17'),
	(2, '2003-08-24', '2003-08-30'),
	(3, '2003-08-31', '2003-09-06'),
	(4, '2003-09-07', '2003-09-13');

insert into livro_autor (id_livro, id_autor) values
	(1,1),
	(1,8),
	(2,6),
	(3,5),
	(3,1),
	(3,4),
	(4,4),
	(5,1),
	(6,5),
	(6,3),
	(7,3),
	(8,2),
	(9,8),
	(10,8),
	(10,1),
	(11,2),
	(12,2);

insert into classificacao (id_livro, id_ranking, posicao) values
	(1, 1, 4),
	(1, 2, 5),
	(2, 3, 1),
	(2, 4, 1),
	(3, 1, 2),
	(3, 2, 2),
	(3, 3, 8),
	(3, 4, 10),
	(4, 1, 1),
	(5, 2, 1),
	(5, 3, 2),
	(5, 4, 9),
	(6, 4, 8),
	(7, 3, 5),
	(7, 4, 5),
	(8, 1, 3),
	(8, 2, 3),
	(8, 3, 3),
	(8, 4, 4),
	(9, 2, 7),
	(9, 3, 7),
	(10, 1, 8),
	(10, 2, 9),
	(11, 3, 9),
	(12, 1, 6),
	(12, 2, null); 
	
--Pesquisas:

--i. Mostre todos os atributos dos autores cadastrados;
select * from autor
	
--ii. Mostre apenas os nomes dos autores cujos códigos estão entre 2 e 5, inclusive;
select * from autor
where id_autor between 2 and 5;

--iii. Mostre o nome e o código do autor, modificando o nome dos atributos para “Nome do autor” e “Identificação do autor”, nesta ordem;
select autor.nome as Nome_do_autor, autor.id_autor as Identificação_do_autor from autor;

--iv. Mostre todos os atributos dos autores em ordem alfabética;
select * from autor
order by autor.nome;

--v. Mostre, em ordem alfabética, os autores que começam com A;
select * from autor
where autor.nome like 'A%'
order by autor.nome;

--vi. Mostre, em ordem alfabética decrescente, os autores que não começam com L;
select * from autor
where autor.nome not like 'L%'
order by autor.nome desc;

--vii. Mostre todos os autores cujo nome tem 5 caracteres;
select * from autor
where autor.nome like '_____';

--viii. Liste o título dos livros das editoras 1 e 5;
select livro.titulo, editora.id_editora
from livro left join editora
on livro.id_editora = editora.id_editora
where editora.id_editora in (1, 5);

--ix. Liste o título dos livros das editoras “Ática” e “Sagra Luzato”;
select livro.titulo, editora.nome
from livro left join editora
on livro.id_editora = editora.id_editora
where editora.nome in ('Ática', 'Sagra Luzato');

--x. Mostre os livros de ficção das editoras 1 e 5;
select livro.titulo, genero.descricao, editora.id_editora
from livro left join genero
on livro.id_genero = genero.id_genero
join editora
on livro.id_editora = editora.id_editora
where editora.id_editora in (1,5)
order by livro.titulo;

--xi. Mostre os livros de ficção das editoras “Ática” e “Sagra Luzato”;
select livro.titulo, genero.descricao, editora.nome
from livro left join genero
on livro.id_genero = genero.id_genero
join editora
on livro.id_editora = editora.id_editora
where editora.nome in ('Ática', 'Sagra Luzato')
order by livro.titulo;

--xii. Mostre os códigos e os títulos dos livros, com seus respectivos preços, mas somente dos livros que custam mais de R$ 100,00;
select livro.id_livro, livro.titulo, livro.preco
from livro
where livro.preco > '100.00';

--xiii. Liste todos os livros, ordenando-os do mais caro ao mais barato;
select * from livro
order by livro.preco desc;

--xiv. Mostre o preço do livro mais barato e do livro mais caro da editora 1;
select max(livro.preco), min (livro.preco), editora.id_editora
from livro left join editora
on livro.id_editora = editora.id_editora
where editora.id_editora = 1
group by editora.id_editora;

--xv. Mostre o preço do livro mais barato e do livro mais caro da editora “Ática”;
select max(livro.preco), min (livro.preco), editora.nome
from livro left join editora
on livro.id_editora = editora.id_editora
where editora.nome = 'Ática'
group by editora.nome;

--xvi. Mostre apenas os livros de “Auto-ajuda”, na ordem crescente de preço;
select genero.descricao, livro.preco, livro.titulo
from genero left join livro
on genero.id_genero = livro.id_genero
where genero.descricao = 'Auto-ajuda'
order by livro.preco;

--xvii. Mostre todos os livros com seus respectivos nomes de editoras e gêneros;
select livro.titulo, genero.descricao, editora.nome
from livro left join genero
on livro.id_genero = genero.id_genero
join editora
on livro.id_editora = editora.id_editora
order by livro.titulo;

--xviii. Mostre quantos autores estão cadastrados;
select count (autor.nome)
from autor;

--xix. Mostre quantos livros custam menos de R$ 100,00;
select count(livro.titulo) from livro
where livro.preco < '100.00';

--xx. Liste a média de preços dos livros de “Ficção” da editora “Makron Books”;
select avg(preco) 
from livro inner join editora using (id_editora) 
inner join genero using (id_genero) 
where editora.nome = 'Makron Books' and genero.descricao = 'Ficção';

--xxi.	Liste todos os livros, mostrando o título de cada um, bem como o(s) nome(s) do(s) autor(es);
select livro.titulo, autor.nome 
from livro, livro_autor, autor 
where livro.id_livro = livro_autor.id_livro and livro_autor.id_autor = autor.id_autor;

--xxii.	Liste o nome e a quantidade de vezes que cada livro apareceu no ranking semanal;
select livro.titulo, count(classificacao.id_livro) 
from livro left outer join classificacao on livro.id_livro = classificacao.id_livro 
group by livro.id_livro;

--xxiii.	Liste o título dos livros e a quantidade de vezes que cada um deles apareceu no ranking semanal, na primeira posi��o;
select livro.titulo, count(classificacao.id_livro) 
from livro left outer join classificacao on livro.id_livro = classificacao.id_livro 
where classificacao.posicao = 1 group by livro.id_livro;

--xxiv.	Liste o nome dos autores e a quantidade de vezes que cada um deles apareceu no ranking semanal, na primeira posi��o;
select autor.nome, count(classificacao.id_livro) 
from autor left outer join livro_autor using (id_autor) 
left outer join livro using (id_livro)
left outer join classificacao using (id_livro) 
where classificacao.posicao = 1 
group by autor.nome;

--xxv.	Liste o número de livros existentes por gênero: nome do gênero, quantidade de livros;
select genero.descricao as "Nome do Gênero", count(livro.id_genero) as "Quantidade de livros" 
from livro inner join genero using (id_genero) 
group by genero.descricao;

--xxvi.	Liste o título dos livros que estão sem posição definida na tabela de classificação;
select livro.titulo 
from livro inner join classificacao using (id_livro) 
where classificacao.posicao is null;

/*03 Implemente as operações de SQL listadas abaixo atrav�s do PostgreSql:*/

--i.	Atualize o preço do livro, cujo título é "C", para R$ 111,00;
update livro set preco = 111.00 where titulo = 'C';

--ii.	Insira um registro novo na tabela "ranking";
insert into ranking (id_ranking, data_inicial, data_final) values (5, to_date('14/09/2015','DD/MM/YYYY'), to_date('21/09/2015','DD/MM/YYYY'));

--iii.	Exclua da tabela classificacao todos os registros com posições maiores do que 5;
delete from classificacao where posicao > 5;

--iv.	Exclua o registro do autor cujo nome é "Beatriz";
delete from livro_autor where id_autor = (select id_autor from autor where nome = 'Beatriz');
delete from autor where nome = 'Beatriz';

--v.	Apague a tabela de autor;
 drop table autor cascade;