CREATE DATABASE lavoura;
USE lavoura;

CREATE TABLE cliente(
id INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(255) NOT NULL,
cpf VARCHAR(11) NOT NULL,
telefone VARCHAR(20) NOT NULL,
endereco VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE produtos(
id INT NOT NULL AUTO_INCREMENT,
produto VARCHAR(50) NOT NULL,
valor DECIMAL(9,2) NOT NULL,
peso VARCHAR(20) NOT NULL,
PRIMARY KEY (id)
); 

CREATE TABLE vendas(
id INT NOT NULL AUTO_INCREMENT,
produtos_venda_id INT NOT NULL,
delivery CHAR(1),
dataVenda DATE NOT NULL,
cliente_id INT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY (cliente_id) REFERENCES cliente(id),
FOREIGN KEY (produtos_venda_id) REFERENCES produtos_venda(id)
);

CREATE TABLE produtos_venda(
id INT NOT NULL AUTO_INCREMENT,
venda_id INT NOT NULL,
produto_id INT NOT NULL,
quantidade INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (venda_id) REFERENCES vendas(id),
FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO produtos (produto, valor, peso) 
VALUES  ('Pão semi folhado recheado com liguicinha e queijo', '24.00', '400g'),
        ('Pão semi folhado recheado com espinafre e ricota', '23.00', '400g'),
        ('Pão semi folhado recheado com tomates secos', '25.00', '400g'),
        ('Pão semi folhado recheado com beringela', '25.00', '400g'),
        ('Pão semi folhado recheado com goiabada e queijo', '23.00', '400g'),
        ('Pão semi folhado recheado com goiabada', '21.00', '400g'),
        ('Pão semi folhado recheado com chocolate', '22.00', '400g'),
        ('Pão com canela', '26.00', '400g'),
        ('Pão italiano', '25.00', '500g'),
        ('Pão massinha', '26.00', '800g'),
        ('Conserva de tomates secos', '19.00', '130g'),
        ('Pão Dágua', '23.00', '500g');

INSERT INTO clientes (nome,cpf,telefone,endereco, email) 
VALUES  ('Gabriela Simone Simone da Cunha', '05222059090' , '55984078665', 'Rua Doutor Maia, 687', 'gabriela-dacunha@cielo.com.br'),     
        ('Gabriel Diogo da Silva', '10088399060' , '51981660575', 'Travessa Timbauva, 940', 'gabriel_silva@aichele.com.br'), 
        ('Cláudia Evelyn Pires', '53456234066' , '51982210219', 'Avenida Califórnia, 435/301', 'claudia_evelyn_pires@caej.com.br'), 
        ('Daiane Isadora Clara Porto', '51719155046' , '51993081802', 'Rua Santa Catarina, 538/205', 'daiane_porto@milimoveis.com.br'), 
        ('Sarah Maria Tereza Campos', '17841651074' , '51991680635', 'Rua São Sebastião, 496', 'sarah_campos@silnave.com.br'),
        ('Aline Analu Fogaça', '14059316040' , '55992948424', 'Rua João Mendes de Assis, 341', 'aline-fogaca@solpro.biz'), 
        ('Pietra Tânia Campos', '10224043005' , '53991353412', 'Rua B, 344', 'pietra_campos@solpro.biz', 'pietra-campos@silnave.com.br'), 
        ('Miguel Carlos Eduardo Pietro Lopes', '87483197080' , '51996874429', 'Rua Esperança, 951', 'miguel_lopes@cernizza.com.br'), 
        ('Juan Noah Fogaça', '72793096075' , '51999917823', 'Rua Juvenal Cruz, 510', 'juan_noah@zf.com'), 
        ('Oliver Sérgio Leandro Aparício', '47710792006' , '51997238819', 'Rua das Violetas, 987/ 810', 'oliver-aparicio@marcati.com');


INSERT INTO vendas (delivery, dataVenda, cliente_id)
VALUES ('s', '2022-03-10', '5'),
       ('n', '2022-04-13', '8'),
       ('n', '2022-02-01', '3'),
       ('n', '2022-03-22', '1'),
       ('s', '2021-12-22', '2'),
       ('s', '2021-08-15', '6'),
       ('n', '2021-11-09', '9'),
       ('n', '2022-05-23', '5'), 
	   ('n', '2022-06-29', '2'),
       ('s', '2022-06-28', '10'),
       ('s', '2021-10-11', '4'),
       ('n', '2022-07-25', '7');
       
INSERT INTO produtos_venda (venda_id, produto_id, quantidade)
VALUES ('1', '2', '2'),
       ('1', '6', '1'),
       ('2', '1', '1'),
       ('2', '9', '1'),
       ('3', '11', '1'),
       ('3', '8', '3'),
       ('4', '7', '2'),
       ('4', '12', '1'),
       ('5', '3', '1'),
       ('5', '5', '1'),
       ('6', '7', '1'),
	   ('6', '11', '3'),
       ('7', '4', '2'),
       ('7', '10', '2'),
       ('8', '3', '1'),
       ('8', '5', '1'),
       ('9', '6', '1'),
       ('9', '8', '2'),
       ('10', '1', '1'),
       ('10', '8', '1');
       
     /*Criação de usuários*/  
	CREATE USER 'usuario'@'endereco' IDENTIFIED BY 'senha';
    CREATE USER 'natalia'@'localhost' IDENTIFIED BY '02111967';
	GRANT ALL PRIVILEGES ON *.* TO 'natalia'@'localhost';
    CREATE USER 'marcus'@'localhost' IDENTIFIED BY '12041984';
    GRANT SELECT, UPDATE ON *.* TO 'marcus'@'localhost';
    FLUSH PRIVILEGES;
	SELECT * FROM mysql.user;
    
CREATE VIEW compra_cliente AS
	SELECT c.nome, v.id, v.dataVenda, pv.quantidade, p.produto
	FROM clientes AS c
	INNER JOIN vendas AS v ON c.id=v.cliente_id
	INNER JOIN produtos_venda AS pv ON v.id=pv.venda_id
	INNER JOIN produtos AS p ON pv.produto_id=p.id
	ORDER BY c.nome;
SELECT * FROM compra_cliente;

CREATE VIEW paesMaisVendidos AS
	SELECT p.produto, pv.quantidade
	FROM produtos AS p
	INNER JOIN produtos_venda AS pv ON p.id=pv.produto_id
	INNER JOIN vendas AS v ON pv.venda_id=v.id
	ORDER BY p.produto DESC;
SELECT * FROM paesMaisVendidos WHERE pv.quantidade>2;

DROP VIEW produto_dataVenda;
CREATE VIEW produto_dataVenda AS
	SELECT p.produto, v.dataVenda, pv.venda_id
	FROM produtos AS p
	INNER JOIN produtos_venda AS pv ON pv.id=pv.venda_id
	INNER JOIN vendas AS v ON pv.venda_id = v.id
	ORDER BY p.produto;
SELECT * FROM produto_dataVenda;

DROP PROCEDURE dados_cliente;
DELIMITER //
CREATE PROCEDURE dados_cliente ()
BEGIN
    DECLARE v_dataVenda DATE;
    DECLARE c_telefone VARCHAR (20);
    DECLARE c_nome VARCHAR(255);
    SELECT nome, telefone INTO c_nome, c_telefone
	FROM clientes WHERE id = 3;
    SELECT c_nome, c_telefone, v_dataVenda;
END//
DELIMITER ;

CALL dados_cliente;

CREATE INDEX info_cliente ON clientes (nome, telefone);
SHOW INDEX FROM clientes;

CREATE INDEX info_produtos ON produtos (produto, valor);
SHOW INDEX FROM produtos;