-- Criar base de dados
CREATE DATABASE aula5a;

USE aula5a;

-- Criar tabela de países
CREATE TABLE pais(
    sigla VARCHAR(3) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Criar tabela de clientes
CREATE TABLE cliente(
    bi INT PRIMARY KEY,
    nome NVARCHAR(200) NOT NULL,
    username NCHAR(20) NOT NULL,
    pwd TEXT NOT NULL,
    nacionalidade VARCHAR(3),
    FOREIGN KEY (nacionalidade) REFERENCES pais(sigla)
);

-- Criar tabela de cartões de crédito
CREATE TABLE cartao_credito(
    numero VARCHAR(21) PRIMARY KEY,
    validade DATETIME NOT NULL,
    tipo VARCHAR(20),
    cliente_bi INT,
    FOREIGN KEY (cliente_bi) REFERENCES cliente(bi)
);

-- Inserir países
INSERT INTO pais VALUES
('PT', 'Portugal'),
('ES', 'Espanha'),
('BRA', 'Brasil');

-- Inserir clientes
INSERT INTO cliente VALUES
(11123456, 'António Silva', 'asilva', 'c0f2f05b93e90bd053066857458d9bbb8b918e6eab2d168f4bf353e0c688e90413f9d61fa41b16b082758db329bd0fce436620f0e2cd048a78443995bf2ab30f', 'PT'),
(32132123, 'Maria José', 'majos', 'd404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db', 'BRA');
