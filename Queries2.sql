USE livrariaonline;

SELECT * FROM Autor;
SELECT * FROM Cliente;
SELECT * FROM Compra;
SELECT * FROM Editora;
SELECT * FROM Encomenda;
SELECT * FROM Livro;
SELECT * FROM Premium;
SELECT * FROM Telefone;


SELECT titulo FROM Livro
WHERE genero = "Romance";

SELECT * FROM Cliente
ORDER BY nome;

SELECT titulo FROM Livro
WHERE lingua = 'Português';

-- 1 Seleciona os livros organizados por autor
SELECT Livro.titulo, Autor.nome AS Autor
FROM Livro JOIN Autor ON Livro.IDAutor = autor.IDAutor;

-- 2 Seleciona os livros organizados por genero
SELECT titulo, genero FROM Livro
ORDER BY genero ASC;

-- 3 Seleciona os livros organizados por idioma
SELECT titulo, lingua AS idioma FROM Livro
ORDER BY idioma ASC;

-- 4 Seleciona os livros organizados por preco
-- PROCEDURE FEITO
SELECT titulo, preco FROM Livro
ORDER BY preco ASC;

-- 5 Seleciona os livros de um autor (id = 1) dado organizados por preço
-- PROCEDURE FEITO
SELECT Autor.nome,Livro.titulo,Livro.preco
FROM Livro JOIN Autor ON Livro.idAutor = autor.idAutor
WHERE Livro.idAutor =1
ORDER BY preco ASC;

-- 5 Seleciona os livros de um autor (id = 1) dado organizados por ano
-- PROCEDURE FEITO
SELECT Autor.nome,Livro.titulo,Livro.ano
FROM Livro JOIN Autor ON Livro.idAutor = autor.idAutor
WHERE Livro.idAutor =1
ORDER BY ano ASC;

-- Seleciona os livros de cada autor organizados por preço
SELECT Livro.titulo, Autor.nome AS Autor, Livro.preco
FROM Livro JOIN Autor ON Livro.IDAutor = autor.IDAutor
ORDER BY preco ASC;

-- Seleciona os livros de cada autor organizados pelo nome do autor e posteriormente pelo preço do livro
SELECT Livro.titulo, Autor.nome AS Autor, Livro.preco
FROM Livro JOIN Autor ON Livro.IDAutor = autor.IDAutor
ORDER BY autor.nome ASC, preco ASC;

-- 6 Lista de livros ordenados por mais vendidos e em caso de empate pelo preço total
SELECT Titulo, sum(compra.quantidade) AS QtdVendida, compra.Preco*sum(compra.quantidade) AS PrecoTotal
	FROM livro
    JOIN Compra ON livro.CodLivro = compra.CodLivro
    GROUP BY livro.titulo
    ORDER BY QtdVendida DESC, PrecoTotal DESC;

-- Livro mais vendido (em caso de empate, desempata pelo preço)
SELECT Titulo, sum(compra.quantidade) AS QtdVendida, compra.Preco*sum(compra.quantidade) AS PrecoTotal
	FROM livro
    JOIN Compra ON livro.CodLivro = compra.CodLivro
    GROUP BY livro.titulo
    ORDER BY QtdVendida DESC, PrecoTotal DESC
    LIMIT 1;

-- Autores mais vendidos por ordem decrescente de quantidade vendida
SELECT Autor.nome, sum(compra.quantidade) AS QtdVendida FROM livro
    JOIN Compra ON livro.CodLivro = compra.CodLivro
    JOIN Autor ON livro.idAutor = Autor.idAutor
    GROUP BY autor.idAutor
    ORDER BY QtdVendida DESC;
    
-- Autor mais vendido 
SELECT Autor.nome, sum(Compra.quantidade) AS QtdVendida FROM livro
    JOIN Compra ON livro.CodLivro = compra.CodLivro
    JOIN Autor ON livro.idAutor = Autor.idAutor
    GROUP BY autor.idAutor
    ORDER BY QtdVendida DESC
    LIMIT 1;
    
-- 7 Autor mais vendido num mes dado
-- PROCEDURE FEITO
SELECT Autor.nome , Encomenda.data, sum(compra.quantidade) AS QtdVendida FROM livro
    JOIN Compra ON livro.CodLivro = compra.CodLivro
    JOIN Autor ON livro.idAutor = Autor.idAutor
    JOIN Encomenda ON compra.nrEncomenda = Encomenda.nrEncomenda
    WHERE MONTH(Encomenda.data) = 12
    GROUP BY Autor.nome
    ORDER BY QtdVendida DESC
	LIMIT 1;

-- 8 Clientes que mais compraram por quantidade de livros
SELECT nome, quantidadeComprada FROM Cliente
Group by nome
Order BY quantidadeComprada DESC;

-- 8 Clientes que mais compraram por valor gasto
SELECT nome, valorGasto FROM Cliente
 Group by nome
 Order BY valorGasto DESC;

-- 9 - Ordenar Clientes por Concelho
SELECT nome, concelho, rua, codigoPostal FROM Cliente
ORDER BY concelho ASC, nome ASC;

-- 9.1 Ordenar os Concelhos com mais clientes
SELECT concelho, COUNT(nome) AS NrClientes FROM Cliente
GROUP BY concelho
ORDER BY nrClientes DESC;

-- 9.2 Ordenar os Concelhos por quantidade de livros vendidos
SELECT concelho, sum(quantidadeComprada) FROM Cliente
GROUP BY concelho
ORDER BY quantidadeComprada DESC;

-- 9.3 Ordenar os Concelhos por ValorGasto (Faturacao)
SELECT concelho, sum(valorGasto) AS Faturacao FROM Cliente
GROUP BY concelho
ORDER BY Faturacao DESC;

-- 10.1 Apresentar os meses ordenados por quantidade de livros vendidos
SELECT month(Encomenda.data) AS Mes, sum(Encomenda.tamanhoEncomenda) AS QuantidadeVendida
FROM Encomenda JOIN Cliente ON encomenda.nrCliente = cliente.nrCliente
Group BY Mes
ORDER BY quantidadeVendida DESC;

-- 10.2 Apresentar os meses ordenados por ValorGasto (Faturacao)
SELECT month(Encomenda.data) AS Mes, sum(Encomenda.valorTotal) AS Faturacao
FROM Encomenda JOIN Cliente ON encomenda.nrCliente = cliente.nrCliente
GROUP BY Mes
ORDER BY Faturacao DESC;

-- 11 Apresentar o total faturado por mes/ano
SELECT year(Encomenda.data) AS Ano, month(Encomenda.data) AS Mes, sum(Encomenda.valorTotal) AS Faturacao
FROM Encomenda
GROUP BY ano, mes
ORDER BY ano DESC, mes;

-- 11.2 Apresenta o total faturado por ano
SELECT year(Encomenda.data) AS Ano, sum(Encomenda.valorTotal) AS Faturacao
FROM Encomenda
GROUP BY ano
ORDER BY ano DESC;

-- 12 Apresenta os clientes de cada Editora ordendados por valor gasto nessa editora
SELECT Editora.nome AS Editora, Cliente.nome AS Cliente, sum(Compra.precoPQ) AS ValorGasto
From Editora JOIN Livro ON Editora.IDEditora = Livro.IDEditora
JOIN Compra ON Livro.CodLivro = Compra.CodLivro
JOIN Encomenda ON Compra.NrEncomenda = Encomenda.NrEncomenda
JOIN Cliente ON Encomenda.NrCliente = Cliente.NrCliente
Group BY Editora.nome, Cliente.nome
Order By  Editora, Cliente.valorGasto Desc;