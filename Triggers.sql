-- TRIGGERS
USE LivrariaOnline;

-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;

-- Verificar se é possivel efetuar uma compra (se temos stock suficiente do livro)
DELIMITER $$
CREATE TRIGGER tgVerificaStock
	BEFORE INSERT ON Compra
	FOR EACH ROW
BEGIN
	DECLARE quantity INT;
    SELECT Livro.quantidade INTO quantity FROM Livro
    WHERE Livro.codLivro = NEW.codLivro;
	IF (quantity < NEW.quantidade)
	THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Stock insuficiente';
	END IF;
END
$$
-- DROP TRIGGER tgVerificaStock;
INSERT INTO Compra
	(codLivro, preco, quantidade, precoPQ, nrEncomenda)
	VALUES (2, 30.00, 4, 60.00, 9); 
    
    
    

-- Updtade a quantidadeComprada e valorGasto de um cliente após efetuar uma Encomenda(dps de cada compra)
DELIMITER $$
CREATE TRIGGER tgAtualizaCliente
	AFTER UPDATE ON Encomenda
    FOR EACH ROW
BEGIN
	UPDATE cliente
		SET quantidadeComprada = quantidadeComprada + (NEW.tamanhoEncomenda - OLD.tamanhoEncomenda),
        valorGasto = valorGasto + (NEW.valorTotal - OLD.valorTotal)
		WHERE NrCliente = NEW.NrCliente;
END $$

-- DROP TRIGGER tgAtualizaCliente;


-- Atualiza a encomenda apos a inserção de 1 compra
-- (valorTotal, tamanhoEncomenda e aplica promocao para os preimium)
DELIMITER $$
CREATE TRIGGER tgAtualizaEncomenda
	AFTER INSERT ON Compra
    FOR EACH ROW
BEGIN
	DECLARE promo DECIMAL(5,2);
    DECLARE idCliente INT;
    SELECT nrCliente INTO idCLiente FROM Encomenda
    WHERE Encomenda.nrEncomenda = NEW.nrEncomenda;
    
	IF (idCliente IN
		(SELECT nrCliente FROM Premium))
	THEN
		SELECT Premium.desconto INTO promo FROM Premium
        WHERE Premium.nrCliente = idCliente;
		UPDATE Encomenda
			SET valorTotal = valorTotal + (NEW.precoPQ * (1 - promo)),
            tamanhoEncomenda = tamanhoEncomenda + NEW.quantidade
            WHERE nrEncomenda = NEW.nrEncomenda;
            
	ELSE
		UPDATE ENCOMENDA
		SET valorTotal = valorTotal + NEW.precoPQ,
            tamanhoEncomenda = tamanhoEncomenda + NEW.quantidade
            WHERE nrEncomenda = NEW.nrEncomenda;
	END IF;	
END $$


-- DROP TRIGGER tgAtualizaEncomenda;
-- cliente 3 -> PREMIUM
INSERT INTO Compra
	(codLivro, preco, quantidade, precoPQ, nrEncomenda)
	VALUES (5, 100.00, 1, 100, 13); 

-- cliente _ -> NORMAL
-- encomenda nr 14 
INSERT INTO Encomenda 
	VALUES (null, 0, 0, '2019/10/04', 1);

INSERT INTO Compra
	(codLivro, preco, quantidade, precoPQ, nrEncomenda)
	VALUES (5, 100.00, 1, 100, 14); 	



-- atualizar o stock do livro após uma Compra
DELIMITER $$
CREATE TRIGGER tgAtualizaStock
	AFTER INSERT ON Compra
    FOR EACH ROW
BEGIN
	UPDATE Livro
		SET quantidade = quantidade - NEW.quantidade
		WHERE CodLivro = NEW.CodLivro;
END $$

-- DROP TRIGGER tgAtualizaStock;

-- TESTES

SELECT * FROM Cliente
WHERE nrCliente = 1;

INSERT INTO Encomenda
	VALUES (null, 0, 0, '2020/12/01', 1);

INSERT INTO Compra
	(codLivro, preco, quantidade, precoPQ, nrEncomenda)
	VALUES (2, 30.00, 1, 60.00, 9); 
	
    
-- encomenda nr 13    
INSERT INTO Encomenda 
	VALUES (null, 0, 0, '2020/12/01', 3);

INSERT INTO Compra
	VALUES (8, 120.00, 1, 120.00, 9); 
	

INSERT INTO Encomenda 
	(NrEncomenda, ValorTotal, TamanhoEncomenda, Data, NrCliente)
	VALUES (5, 010.00, 2, '2020/12/01', 1);

INSERT INTO Encomenda 
	-- (NrEncomenda, ValorTotal, TamanhoEncomenda, Data, NrCliente)
	VALUES (null, 010.00, 2, '2020/12/01', 1);


DELETE FROM Encomenda
WHERE NrEncomenda = 5;

SELECT * FROM ENCOMENDA;
SELECT * FROM Livro;
SELECT * FROM Premium;