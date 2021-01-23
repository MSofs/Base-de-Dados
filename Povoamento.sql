-- Esquema: "Livraria Online"
USE LivrariaOnline;

--
-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;

--
-- Povoamento da tabela "Livro"
INSERT INTO Livro
	(CodLivro, Lingua, Genero, Titulo, ISBN, Edicao, Ano, Preco, Quantidade, IDEditora, IDAutor)
	VALUES 
		(1, 'Português', 'História', 'Guerra Mundial I', '900-0-7334-2609-4', 1 , 2010, 014.99,3,1,1),
        (2, 'Português', 'Matemática', 'MNOL', '901-0-7334-2609-4', 1 , 2012, 030.00,4,1,3),
		(3, 'Português', 'Romance', 'Romeu e Julieta', '902-0-7334-2609-4', 1 , 1999, 023.99,3,5,1),
        (4, 'Francês', 'Francês', 'Le crepe et le baguette', '903-0-7334-2609-4', 2 , 2010, 035.99,2,4,3),
        (5, 'Português', 'Mistério', 'Código Da Vinci', '904-0-7334-2609-4', 2 , 2019, 100.00,1,2,6),
        (6, 'Inglês', 'Classico', 'How To Kill a Mockingbird', '905-0-7334-2609-4', 1 , 1989, 027.99,2,3,2),
        (7, 'Inglês', 'Matemática', 'ISD', '906-0-7334-2609-4', 1 , 2000, 057.00,10,3,4),
        (8, 'Mandarim', 'História', 'História Chinesa', '907-0-7334-2609-4', 3 , 2020, 120.00,1,5,5),
        (9, 'Português', 'Classico', '1984', '908-0-7334-2609-4', 2 , 1999, 040.00,3,2,6),
        (10, 'Inglês', 'Inglês', 'English for Beginners', '909-0-7334-2609-4', 1 , 2020, 010.00,10,3,2)
		;
--
-- DELETE FROM Livro;
-- SELECT * FROM Livro;


-- Povoamento da tabela "Editora"
INSERT INTO Editora
	(IDEditora, Nome, Website, Email)
	VALUES 
        (1,'Porto Editora', 'potoeditora.pt', 'portoeditora@gmail.com'),
        (2,'Raiz', 'raiz.pt', 'raizeditora@gmail.com'),
        (3,'Manchester Editor', 'manchestereditor.com', 'manchestereditor@gmail.com'),
        (4,'Paris Editor', null , 'pariseditor@gmail.com'),
        (5,'Arial', 'arialeditora.pt', 'arialeditora@gmail.com')
		;
--
-- DELETE FROM Editora;
-- SELECT * FROM Editora;


INSERT INTO Telefone
	(IDEditora, Telefone)
	VALUES 
        (1,  678546234),
		(1,  142356429),
		(2,  998765420),
		(3,  675008976),
		(4,  776879332),
		(5,  465423890),
		(5,  866543420),
		(5,  654545218)
		;
--
-- DELETE FROM Telefone;
-- SELECT * FROM Telefone;


-- Povoamento da tabela "Autor"
INSERT INTO Autor
	(IDAutor, Nome, Idade, DataNascimento)
	VALUES 
        (1,'José Amado', 30 , '1990/10/05'),
        (2,'Jack Miller', null , '1956/03/23'),
        (3,'Maria Blanco', 67 , '1953/04/05'),
        (4,'Harry Wilson', null , null),
        (5,'Park Lee', null , '1938/10/31'),
        (6,'Miguel Oliveira', 71 , '1949/10/31')
		;
--
-- DELETE FROM Autor;
-- SELECT * FROM Autor;



-- Povoamento da tabela "Compra"
INSERT INTO Compra
	(Preco, Quantidade, PrecoPQ, NrEncomenda, CodLivro)
	VALUES 
        (100.00, 2, 200.00, 1, 5),
        (010.00, 1, 010.00, 1, 10),
        (030.00, 2, 060.00, 2, 2),
        (014.99, 1, 014.99, 3, 1),
        (023.99, 1, 023.99, 3, 3),
        (057.00, 1, 057.00, 3, 7),
        (057.00, 1, 057.00, 4, 7),
        (010.00, 1, 010.00, 4, 9)
		;
--
-- DELETE FROM Compra;
-- SELECT * FROM Compra;



-- Povoamento da tabela "Encomenda"
INSERT INTO Encomenda
	(NrEncomenda, ValorTotal, TamanhoEncomenda, Data, NrCliente)
	VALUES 
        (1, 210.00, 3, '2020/10/2', 1),
        (2, 060.00, 2, '2020/9/11', 3),
        (3, 095.98, 3, '2020/7/23', 5),
        (4, 067.00, 2, '2020/10/12', 3)
		;
--
-- DELETE FROM Encomenda;
-- SELECT * FROM Encomenda;


-- Povoamento da tabela "Cliente"
INSERT INTO Cliente
    (NrCliente, Nome, NIF, Email, QuantidadeComprada, ValorGasto, RecomendadoPor, Rua, Concelho, CodigoPostal)
    VALUES
    (1, 'José Batista', 44321759, 'jose@gmail.com', 5, 213.89, null, 'Rua Oliveirinha', 'Viana do Castelo', '7255-135'),
    (2, 'Alexandre Pereira', 123785988, 'alexpereira@hotmail.com', 1, 014.99, 1, 'Rua Joao Paulo', 'Guimaraes', '4790-543'),
    (3, 'Pedro Cabral', 987012549, 'pedro99@portugalmail.pt', 7, 327.39, null, 'Rua Dória', 'Braga', '3600-123'),
    (4, 'José Silva', 455653767, 'jose123@gmail.com', 3, 097.99, 2, 'Rua Joao Paulo', 'Guimarães', '4790-534'),
    (5, 'Rita Oliveira', 978098123, 'ritaoliveira2000@hotmail.com', 6, 278.79, null, 'Avenida da Liberdade', 'Lisboa', '3550-123'),
    (6, 'Margarida Miranda', 123677854, 'guidamiranda@gmail.com', 2, 058.99, 2, 'Avenida 25 de Abril', 'Porto', '4300-53')
    ;
--
-- DELETE FROM Cliente;
-- SELECT * FROM Cliente;

-- Povoamento da Tabela "Premium"
INSERT INTO Premium
    (NrCliente, Desconto)
    VALUES
    (3,00.15),
    (5,00.13)
    ;
--
-- DELETE FROM Premium;
-- SELECT * FROM Premium;


