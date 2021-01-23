USE livrariaonline;

CREATE USER 'admin'@'localhost' 
	IDENTIFIED BY 'admin';

GRANT ALL PRIVILEGES ON livrariaonline.* 
	TO 'admin'@'localhost';


/* VIEW E GRANT do dono da livraria sobre o stock dos seus livros */
CREATE VIEW viewDono_livros AS
	SELECT codLivro,Titulo, quantidade
		FROM Livro;
        
-- nao sei se e redundante uma vez que em cima ja lhe dei acesso total ..
GRANT SELECT, DELETE, UPDATE ON livrariaonline.viewDono_livros TO
	'admin'@'localhost';

SELECT *
	FROM viewDono_livros;

/* VIEW E GRANT do dono da livraria em relação aos clientes. */
CREATE VIEW viewDono_Clientes AS
	SELECT NrCliente, Nome, Email, ValorGasto
		FROM Cliente;
        
-- DROP VIEW viewDono_Cliente;

GRANT SELECT, UPDATE ON livrariaonline.viewDono_Clientes TO
	'admin'@'localhost';

SELECT *
	FROM viewDono_Clientes;
    
SELECT *
	FROM viewDono_Clientes
	ORDER BY ValorGasto DESC;
    
SELECT *
	FROM viewDono_Clientes
	ORDER BY Nome ASC;

SELECT *
	FROM viewDono_Clientes
	WHERE Nome LIKE 'J%'
	ORDER BY Nome DESC;

    
/* VIEW E GRANT do dono da livraria e das encomendas */
CREATE VIEW viewDono_Encomendas AS
	SELECT NrEncomenda, TamanhoEncomenda, ValorTotal, NrCliente
		FROM Encomenda;

GRANT SELECT ON livrariaonline.viewDono_Encomendas TO
	'admin'@'localhost';
    
SELECT * 
	FROM viewDono_Encomendas;
   