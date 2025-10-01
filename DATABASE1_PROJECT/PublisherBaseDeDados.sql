use master 
if exists(select * from sys.databases where name = 'Trabalho') drop database Trabalho
create database Trabalho
USE [Trabalho]

CREATE TABLE Pessoa (
    id INT PRIMARY KEY NOT NULL,
	nome VARCHAR(50) NOT NULL,
    dataNascimento DATE NOT NULL,
    dataFalecimento DATE,
    contacto VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE Autor (
    id INT PRIMARY KEY NOT NULL,
    pessoa_id INT NOT NULL,
    FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id)
);

CREATE TABLE Tradutor (
    id INT PRIMARY KEY NOT NULL,
    pessoa_id INT NOT NULL,
    FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id)
);

CREATE TABLE Pais (
    id INT PRIMARY KEY NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Livro (
    id INT PRIMARY KEY NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    ano INT,
    lingua VARCHAR(50) NOT NULL,
    autor_id INT NOT NULL,
    FOREIGN KEY (autor_id) REFERENCES Autor(id)
);

CREATE TABLE Traducao (
    id INT PRIMARY KEY NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    ano INT,
    lingua VARCHAR(50) NOT NULL,
    custo DECIMAL(10, 2) NOT NULL,
    
);

CREATE TABLE Edicao (
    id INT PRIMARY KEY NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    num INT NOT NULL,
    valorVendas DECIMAL(10, 2),
    custoProducao DECIMAL(10, 2) NOT NULL,
    livro_id INT NOT NULL,
	traducao_id INT NOT NULL,
    FOREIGN KEY (traducao_id) REFERENCES Traducao(id),
    FOREIGN KEY (livro_id) REFERENCES Livro(id)
);

CREATE TABLE ListaPodePublicar (
    livro_id INT NOT NULL,
    pais_id INT NOT NULL,
    custoDireitoPublicacao DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (livro_id, pais_id),
    FOREIGN KEY (livro_id) REFERENCES Livro(id),
    FOREIGN KEY (pais_id) REFERENCES Pais(id)
);

CREATE TABLE ListaPodeVender (
    edicao_id INT NOT NULL,
    pais_id INT NOT NULL,
    PRIMARY KEY (edicao_id, pais_id),
    FOREIGN KEY (edicao_id) REFERENCES Edicao(id),
    FOREIGN KEY (pais_id) REFERENCES Pais(id)
);

CREATE TABLE TradutorTraducao (
    id INT PRIMARY KEY NOT NULL,
    tradutor_id INT NOT NULL,
	traducao_id INT NOT NULL,
	
    FOREIGN KEY (tradutor_id) REFERENCES Tradutor(id),
	FOREIGN KEY (traducao_id) REFERENCES Traducao(id)
);

CREATE TABLE EdicaoPublicacao (
	id INT PRIMARY KEY NOT NULL,
	edicao_id INT NOT NULL,
	pais_id INT NOT NULL,

	FOREIGN KEY (edicao_id) REFERENCES Edicao(id),
	FOREIGN KEY (pais_id) REFERENCES Pais(id)
);



