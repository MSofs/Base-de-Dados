-- FUNCTIONS
USE LivrariaOnline;

-- 1 Dado um codLivro retorna o seu preco
DELIMITER $$
CREATE FUNCTION getPrecoLivro (idLivro INT)
	RETURNS DECIMAL(5,2)
    DETERMINISTIC
BEGIN
	DECLARE precoLivro DECIMAL(5,2);
    SELECT preco INTO precolivro FROM Livro
		WHERE livro.codLivro = idLivro;
RETURN precoLivro;
END 
$$

-- DROP FUNCTION fuPrecoLivro;
SELECT getPrecoLivro(5);

-- 2 Dado um NrCliente retorna se é premium ou nao
-- 1 = TRUE, 0 = FALSE
DELIMITER $$
CREATE FUNCTION isPremium (idCliente INT)
	RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
    RETURN (idCliente IN (SELECT nrCliente FROM Premium)); 
END
$$

-- DROP FUNCTION isPremium;
SELECT isPremium(1);
SELECT isPremium(5);

-- 3 dado um NrCliente retorna o valorGasto
DELIMITER $$
CREATE FUNCTION getValorGastoCliente (idCliente INT)
	RETURNS DECIMAL(5,2)
    DETERMINISTIC
BEGIN
	DECLARE faturacao DECIMAL(5,2);
    SELECT valorGasto INTO faturacao FROM Cliente
	WHERE Cliente.nrCliente = idCliente;
    RETURN faturacao;
END
$$
-- DROP FUNCTION getValorGastoCliente;
SELECT getValorGastoCliente(2);

-- 4 dado um NrCliente retorna o quantidadeComprada
DELIMITER $$
CREATE FUNCTION getQuantidadeCompradaCliente (idCliente INT)
	RETURNS INT
    DETERMINISTIC
BEGIN
	DECLARE quantidade INT;
    SELECT quantidadeComprada INTO quantidade FROM Cliente
	WHERE Cliente.nrCliente = idCliente;
    RETURN quantidade;
END $$

-- DROP FUNCTION getQuantidadeCompradaCliente;
SELECT getQuantidadeCompradaCliente(5);


-- 5 dado um NrCliente retorna o desconto (verifica 1º se é premium)
DELIMITER $$
CREATE FUNCTION getDesconto (idCliente INT)
	RETURNS DECIMAL(3,2)
    DETERMINISTIC
BEGIN
	DECLARE discount DECIMAL (3,2);
    SET discount = 0;
    IF (isPremium(idCliente))
	THEN
		SELECT desconto INTO discount FROM Premium
        WHERE Premium.nrCliente = idCliente;
	END IF;
    RETURN discount;
END $$

-- DROP FUNCTION getDesconto;
SELECT getDesconto(3);
SELECT getDesconto(1);

-- 6 dado um ano retorna o total Faturado
DELIMITER $$
CREATE FUNCTION getFaturacaoAno (ano INT)
	RETURNS DECIMAL (7,2)
    DETERMINISTIC
BEGIN
	DECLARE faturacao DECIMAL (7,2);
	SELECT sum(Encomenda.valorTotal) INTO Faturacao FROM Encomenda
    WHERE year(Encomenda.data) = ano;
	RETURN faturacao;
END $$
-- DROP FUNCTION getFaturacaoAno;
	SELECT getFaturacaoAno(2020);


-- 7 dado um mes e um ano retorna o total faturado
DELIMITER $$
CREATE FUNCTION getFaturacaoMesAno (mes INT, ano INT)
	RETURNS DECIMAL (7,2)
    DETERMINISTIC
BEGIN
	DECLARE faturacao DECIMAL (7,2);
	SELECT sum(Encomenda.valorTotal) INTO Faturacao FROM Encomenda
    WHERE month(Encomenda.data) = mes AND year(Encomenda.data) = ano;
	RETURN faturacao;
END $$
-- DROP FUNCTION getFaturacaoMesAno;
SELECT getFaturacaoMesAno(7,2020);

-- 8 dado um codLivro retorna retorna a quatidadeVendida
DELIMITER $$
CREATE FUNCTION getQuantidadeVendidaLivro (idLivro INT)
	RETURNS INT
    DETERMINISTIC
BEGIN
	DECLARE quantidade INT;
	SELECT sum(Compra.quantidade) INTO quantidade FROM Compra
    WHERE Compra.codLivro = idLivro;
	RETURN quantidade;
END $$
-- DROP FUNCTION getQuantidadeVendidaLivro;
SELECT getQuantidadeVendidaLivro(7);

-- 8 dado um idAutor retorna o nº de livros vendidos
DELIMITER $$
CREATE FUNCTION getQuantidadeVendidaAutor (idAutor INT)
	RETURNS INT
    DETERMINISTIC
BEGIN
	DECLARE quantidade INT;
	SELECT sum(Compra.quantidade) INTO quantidade FROM Compra
    JOIN Livro ON Compra.codLivro = Livro.codLivro
    JOIN Autor ON Livro.idAutor = Autor.idAutor
    
    WHERE Autor.idAutor = idAutor;
	RETURN quantidade;
END $$

-- DROP FUNCTION getQuantidadeVendidaAutor;
SELECT getQuantidadeVendidaAutor(6);