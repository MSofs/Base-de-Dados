USE livrariaonline

DELIMITER $$
CREATE PROCEDURE infoLivro (IN codL int)
BEGIN
	SELECT * 
		FROM Livro
			WHERE codLivro = codL;
END
$$

-- Teste procedure infoAnimal
CALL infoLivro(2);


DELIMITER $$
CREATE PROCEDURE infoCliente (IN idCli int)
BEGIN
	SELECT * 
		FROM Cliente
			WHERE nrCliente = idCli;
END
$$

CALL infoCliente(1);

DELIMITER $$
CREATE PROCEDURE infoEncomenda (IN nrEnc int)
BEGIN
	SELECT * 
		FROM Encomenda
			WHERE nrEncomenda = nrEnc;
END
$$

CALL infoEncomenda(1);


DELIMITER $$
CREATE PROCEDURE atualizarLivroStock (IN codL Int, IN stock Int)
BEGIN
	DECLARE antigoStock INT ;
    
    SELECT quantidade INTO antigoStock
		FROM Livro
			WHERE codLivro = codL;
	
    IF(stock > 0) THEN
		UPDATE Livro
			SET quantidade = antigoStock + stock
				WHERE codLivro = codL;
     ELSE
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Stock Invalido';
	END IF;
END
$$

-- testar
SELECT * FROM Livro
Where codLivro = 1;

CALL atualizarLivroStock(1,3);
CALL atualizarLivroStock(1,0);
CALL atualizarLivroStock(1,-1);
CALL atualizarLivroStock(5,3);
-- testar
SELECT * FROM Livro
Where codLivro = 1;
SELECT * FROM Livro
Where codLivro = 5;

-- REQUISITOS DE EXPLIRAÇÃO

-- 1 DADO UM AUTOR, APRESENTA OS SEUS LIVROS (usamos o idAutor pois pode haver nomes de autores iguais)
DELIMITER $$
CREATE PROCEDURE livrosPorAutor (IN idAutor INT)
BEGIN
	SELECT Livro.codLivro, Livro.titulo
	FROM Livro JOIN Autor ON Livro.IDAutor = autor.IDAutor
    WHERE Autor.idAutor = idAutor;
END
$$
-- DROP PROCEDURE livrosPorAutor;
CALL livrosPorAutor(1);

-- 2 Seleciona os livros de um dado genero
DELIMITER $$
CREATE PROCEDURE livrosPorGenero (IN genero VARCHAR(25))
BEGIN
	SELECT codLivro, titulo FROM Livro
    WHERE Livro.genero = genero;
END
$$
-- DROP PROCEDURE livrosPorGenero ;
CALL livrosPorGenero('RoMaNcE');

-- 3 Seleciona os livros de um ididoma
DELIMITER $$
CREATE PROCEDURE livrosPorIdioma (IN idioma VARCHAR(25))
BEGIN
	SELECT codLivro, titulo FROM Livro
    WHERE Livro.lingua = idioma;
END
$$
-- DROP PROCEDURE livrosPorIdioma ;
CALL livrosPorIdioma('portugues');


-- 4 AGRUPAR OS LIVROS DADA UMA GAMA DE PRECO
DELIMITER $$
CREATE PROCEDURE livrosPorGamaPreco (IN precoInicial DECIMAL, IN precoFinal DECIMAL)
BEGIN
	IF (precoInicial < 0 OR precoInicial >= precoFinal OR precoFinal < 0) THEN
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Gama de precos invalida';
    ELSE
		SELECT codLivro, titulo, preco FROM Livro
		WHERE preco >= precoInicial AND preco <= precoFinal
		ORDER BY preco;
	END IF;
END
$$

-- DROP PROCEDURE livrosPorGamaPreco;
CALL livrosPorGamaPreco(5, 10);

-- 5 AGRUPAR OS LIVROS POR ANO, DADO UM AUTOR
DELIMITER $$
CREATE PROCEDURE livroAutorAno (IN autor VARCHAR(60))
BEGIN
	SELECT Autor.nome,Livro.CodLivro, Livro.titulo, Livro.ano
	FROM Livro JOIN Autor ON Livro.idAutor = autor.idAutor
	WHERE Autor.nome = autor
	ORDER BY ano ASC;
END
$$

-- DROP PROCEDURE livroAutorAno;

CALL livroAutorAno("jack miller");
CALL livroAutorAno("Cristiano Ronaldo");

-- 5 AGRUPAR OS LIVROS POR PRECO, DADO UM AUTOR
DELIMITER $$
CREATE PROCEDURE livroAutorPreco (IN autor VARCHAR(60))
BEGIN
	SELECT Autor.nome, Livro.CodLivro, Livro.titulo, Livro.preco
	FROM Livro JOIN Autor ON Livro.idAutor = autor.idAutor
	WHERE Autor.nome = autor
	ORDER BY preco ASC;
END
$$

-- DROP PROCEDURE livroAutorPreco;
CALL livroAutorPreco("jack miller");

-- 6 (TOP 3) dos Livros mais vendidos
DELIMITER $$
CREATE PROCEDURE top3LivrosMaisVendidos ()
BEGIN
	SELECT Titulo, sum(compra.quantidade) AS QtdVendida, compra.Preco*sum(compra.quantidade) AS PrecoTotal
	FROM livro
    JOIN Compra ON livro.CodLivro = compra.CodLivro
    GROUP BY livro.titulo
    ORDER BY QtdVendida DESC, PrecoTotal DESC
    LIMIT 3;
END
$$

-- DROP PROCEDURE top3LivrosMaisVendidos;
CALL top3LivrosMaisVendidos();


-- 7 (TOP 3) de autores bestsellers
DELIMITER $$
CREATE PROCEDURE top3AutoresBestseller (IN mes INT)
BEGIN
	SELECT Autor.nome , Encomenda.data, sum(compra.quantidade) AS QtdVendida FROM livro
    JOIN Compra ON livro.CodLivro = compra.CodLivro
    JOIN Autor ON livro.idAutor = Autor.idAutor
    JOIN Encomenda ON compra.nrEncomenda = Encomenda.nrEncomenda
    WHERE MONTH(Encomenda.data) = mes
    GROUP BY Autor.nome
    ORDER BY QtdVendida DESC
	LIMIT 3;
END
$$

-- DROP PROCEDURE top3AutoresBestseller;
CALL top3AutoresBestseller(12);

-- 8 (TOP 5) Melhores clientes (com maior ValorGasto)
DELIMITER $$
CREATE PROCEDURE top5MelhoresClientes ()
BEGIN
	SELECT nome, valorGasto FROM Cliente
	Group by nome
	Order BY valorGasto DESC
    LIMIT 5;
END
$$
-- DROP PROCEDURE top5MelhoresClientes;
CALL top5MelhoresClientes();

-- 10 TOP 5 de meses em que se vende mais (Faturacao)
DELIMITER $$
CREATE PROCEDURE top5melhoresMeses ()
BEGIN
	SELECT month(Encomenda.data) AS Mes, sum(Encomenda.valorTotal) AS Faturacao, sum(Encomenda.tamanhoEncomenda) AS QtdVendida
	FROM Encomenda
	GROUP BY Mes
	ORDER BY Faturacao DESC, qtdVendida DESC
    LIMIT 5;
END
$$

-- DROP PROCEDURE top5melhoresMeses;
CALL top5melhoresMeses ();

-- 10.1 TOP 5 de meses em que se vende mais (Faturacao) num dado ano
DELIMITER $$
CREATE PROCEDURE top5melhoresMesesPorAno (IN nrAno INT)
BEGIN
	SELECT year(Encomenda.data) AS Ano, month(Encomenda.data) AS Mes, sum(Encomenda.valorTotal) AS Faturacao
	FROM Encomenda
	WHERE year(Encomenda.data) = nrAno
    GROUP BY mes
	ORDER BY Faturacao DESC;
END
$$

-- DROP PROCEDURE top5melhoresMesesPorAno;
CALL top5melhoresMesesPorAno (2020);


-- NOVAS NOVAS NOVAS NOVAS NOVAS NOVAS NOVAS NOVAS NOVAS NOVAS  NOVAS NOVAS NOVAS NOVAS NOVAS NOVAS NOVAS NOVAS NOVAS

-- NOVA -> Apresentar os Clientes dado uma letra inicial
DELIMITER $$
CREATE PROCEDURE clientePorIniciais (IN letras VARCHAR(70))
BEGIN
	SELECT * FROM Cliente
    WHERE nome LIKE CONCAT(letras, '%')
    ORDER BY nome;
END
$$

-- DROP PROCEDURE clientePorIniciais;

CALL clientePorIniciais ('j');
CALL clientePorIniciais ('mar');
CALL clientePorIniciais ('jose s');
CALL clientePorIniciais ('ba');

-- NOVA -> Dado 1 nrCliente mostra os livros comprados
DELIMITER $$
CREATE PROCEDURE clienteLivros (IN idCliente INT)
BEGIN
	SELECT Cliente.nome, Livro.codLivro, Livro.titulo FROM Livro
    JOIN Compra ON Livro.CodLivro = Compra.CodLivro
    JOIN Encomenda ON Compra.NrEncomenda = Encomenda.NrEncomenda
    JOIN Cliente ON Encomenda.NrCliente = Cliente.NrCliente
    
    WHERE Cliente.nrCliente = idCliente
    ORDER BY codLivro;
END
$$

-- DROP PROCEDURE clienteLivros;
CALL clienteLivros (3);

-- TOP 10 de livros mais vendidos (por quantidade)
DELIMITER $$
CREATE PROCEDURE top10Livros ()
BEGIN
	SELECT Livro.codLivro, Livro.titulo, sum(compra.Quantidade) AS qtdVendida
    FROM Livro
    JOIN Compra ON Livro.codLivro = Compra.CodLivro
    GROUP BY livro.titulo
    ORDER BY qtdVendida DESC
    LIMIT 10;
END
$$

-- DROP PROCEDURE top10Livros;
CALL top10Livros ();