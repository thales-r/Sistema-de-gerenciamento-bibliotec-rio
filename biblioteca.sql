CREATE DATABASE IF NOT EXISTS biblioteca
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE biblioteca;

CREATE TABLE IF NOT EXISTS alunos (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(100) NOT NULL,
    email     VARCHAR(100) NOT NULL UNIQUE,
    telefone  VARCHAR(20),
    matricula VARCHAR(20) NOT NULL UNIQUE,
    curso     VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS funcionarios (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    nome     VARCHAR(100)   NOT NULL,
    email    VARCHAR(100)   NOT NULL UNIQUE,
    telefone VARCHAR(20),
    cargo    VARCHAR(100)   NOT NULL,
    salario  DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS livros (
    id                    INT AUTO_INCREMENT PRIMARY KEY,
    titulo                VARCHAR(200) NOT NULL,
    autor                 VARCHAR(100) NOT NULL,
    isbn                  VARCHAR(20)  NOT NULL UNIQUE,
    quantidade_disponivel INT NOT NULL DEFAULT 1
);

CREATE TABLE IF NOT EXISTS emprestimos (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    aluno_id        INT         NOT NULL,
    livro_id        INT         NOT NULL,
    data_emprestimo DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_devolucao  DATETIME,
    status          VARCHAR(20) NOT NULL DEFAULT 'ativo',
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (livro_id) REFERENCES livros(id)
);