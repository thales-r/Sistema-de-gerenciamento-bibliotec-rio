# 📚 Sistema de Gerenciamento de Biblioteca

Sistema CRUD desenvolvido em **C# (.NET 8)** com banco de dados **MySQL**, aplicando os três pilares da Orientação a Objetos: **herança**, **polimorfismo** e **encapsulamento**. O sistema permite gerenciar alunos, funcionários, livros e empréstimos via menu interativo no terminal.

---

## 👥 Integrantes

| Nome | GitHub |
|---|---|
| Integrante 1 | @usuario1 |
| Integrante 2 | @usuario2 |

---

## 🗂️ Estrutura do Projeto

```
biblioteca/
├── models/                      # Classes de domínio (regras de negócio)
│   ├── Pessoa.cs                # Classe base abstrata
│   ├── Aluno.cs                 # Herda de Pessoa (matrícula, curso)
│   ├── Funcionario.cs           # Herda de Pessoa (cargo, salário)
│   ├── Livro.cs                 # Entidade livro com controle de estoque
│   └── Emprestimo.cs            # Relaciona Aluno ↔ Livro
├── repositories/                # Camada de acesso a dados (SQL isolado aqui)
│   ├── AlunoRepository.cs
│   ├── FuncionarioRepository.cs
│   ├── LivroRepository.cs
│   └── EmprestimoRepository.cs
├── database/
│   └── DatabaseConnection.cs    # Gerencia conexão com MySQL via .env
├── migrations/
│   └── criar_banco.sql          # Script SQL para criar banco e tabelas
├── Program.cs                   # Menu de terminal — ponto de entrada
├── Biblioteca.csproj            # Configuração do projeto e dependências
├── .env.example                 # Modelo de configuração (sem senha real)
├── .gitignore                   # Ignora .env, bin/, obj/
└── README.md
```

---

## 🧱 Diagrama de Classes

```
              ┌──────────────────────────┐
              │         Pessoa           │  ← abstrata
              │──────────────────────────│
              │ - _id : int              │
              │ - _nome : string         │
              │ - _email : string        │
              │ - _telefone : string     │
              │──────────────────────────│
              │ + ObterTipo() : string   │  ← abstract
              │ + ToString() : string    │
              └────────────┬─────────────┘
                           │  herança
             ┌─────────────┴──────────────┐
             │                            │
  ┌──────────┴─────────┐    ┌─────────────┴──────────┐
  │        Aluno       │    │       Funcionario       │
  │────────────────────│    │─────────────────────────│
  │ - _matricula       │    │ - _cargo : string       │
  │ - _curso           │    │ - _salario : decimal    │
  │────────────────────│    │─────────────────────────│
  │ + ObterTipo()      │    │ + ObterTipo()           │
  └────────────────────┘    └─────────────────────────┘

  ┌──────────────────────┐    ┌────────────────────────────┐
  │        Livro         │    │         Emprestimo         │
  │──────────────────────│    │────────────────────────────│
  │ - _titulo : string   │    │ - _alunoId : int           │
  │ - _autor : string    │    │ - _livroId : int           │
  │ - _isbn : string     │    │ - _dataEmprestimo : DateTime│
  │ - _qtdDisponivel:int │    │ - _dataDevolucao : DateTime?│
  │──────────────────────│    │ - _status : string         │
  │ + EstaDisponivel()   │    │────────────────────────────│
  └──────────────────────┘    │ + Devolver()               │
                              └────────────────────────────┘
```

---

## ✅ Pilares de OO aplicados

| Pilar | Como foi aplicado |
|---|---|
| **Herança** | `Aluno` e `Funcionario` herdam de `Pessoa`, reaproveitando `Nome`, `Email` e `Telefone` |
| **Polimorfismo** | `ObterTipo()` é `abstract` em `Pessoa` e retorna descrições diferentes em cada subclasse |
| **Encapsulamento** | Todos os atributos são `private`, acessados por `Properties` com validações nos setters |

### Exemplo de polimorfismo no código

```csharp
// Pessoa é abstrata — ObterTipo() se comporta diferente em cada subclasse
Pessoa p1 = new Aluno("João", "joao@email.com", "99999", "2024001", "Engenharia");
Pessoa p2 = new Funcionario("Maria", "maria@email.com", "88888", "Bibliotecária", 3500);

Console.WriteLine(p1.ObterTipo());
// Saída: Aluno | Matrícula: 2024001 | Curso: Engenharia

Console.WriteLine(p2.ObterTipo());
// Saída: Funcionário | Cargo: Bibliotecária | Salário: R$ 3500,00
```

---

## 🖥️ Funcionalidades do Sistema

### Alunos
- Cadastrar novo aluno (nome, email, telefone, matrícula, curso)
- Listar todos os alunos
- Buscar aluno por ID
- Atualizar dados do aluno
- Excluir aluno

### Funcionários
- Cadastrar novo funcionário (nome, email, telefone, cargo, salário)
- Listar todos os funcionários
- Buscar funcionário por ID
- Atualizar dados do funcionário
- Excluir funcionário

### Livros
- Cadastrar novo livro (título, autor, ISBN, quantidade disponível)
- Listar todos os livros
- Buscar livro por ID
- Atualizar dados do livro
- Excluir livro

### Empréstimos
- Registrar empréstimo (valida se livro está disponível e deduz estoque)
- Listar todos os empréstimos
- Listar apenas empréstimos ativos
- Registrar devolução (atualiza status e devolve exemplar ao estoque)
- Excluir registro de empréstimo

---

## 🚀 Como rodar o projeto

### Pré-requisitos
- [.NET 8 SDK](https://dotnet.microsoft.com/download)
- [MySQL](https://dev.mysql.com/downloads/installer/) instalado e rodando

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/biblioteca.git
cd biblioteca
```

### 2. Configure as credenciais do banco

Crie um arquivo `.env` na raiz do projeto com base no `.env.example`:

```
DB_HOST=localhost
DB_PORT=3306
DB_NAME=biblioteca
DB_USER=root
DB_PASSWORD=sua_senha_aqui
```

> ⚠️ O arquivo `.env` está no `.gitignore` e **nunca deve ser commitado**.

### 3. Crie o banco de dados e as tabelas

Abra o **MySQL Workbench**, cole o conteúdo do arquivo `migrations/criar_banco.sql` e execute. Ou pelo terminal:

```bash
mysql -u root -p < migrations/criar_banco.sql
```

### 4. Instale as dependências

```bash
dotnet restore
```

### 5. Execute o sistema

```bash
dotnet run
```

O menu vai aparecer no terminal:

```
╔══════════════════════════════════╗
║   SISTEMA DE GERENCIAMENTO       ║
║         DE BIBLIOTECA            ║
╚══════════════════════════════════╝

  1. Gerenciar Alunos
  2. Gerenciar Funcionários
  3. Gerenciar Livros
  4. Gerenciar Empréstimos
  0. Sair
```

---

## 🔒 Segurança

- Credenciais ficam no `.env` local — fora do repositório
- Todas as queries usam **prepared statements** (`Parameters.AddWithValue`), prevenindo SQL Injection
- Conexões com o banco são fechadas automaticamente com `using`

---

## 🛠️ Tecnologias utilizadas

| Tecnologia | Versão | Para quê |
|---|---|---|
| C# / .NET | 8.0 | Linguagem e runtime |
| MySQL | 8.x | Banco de dados relacional |
| MySql.Data | 8.3.0 | Driver de conexão C# ↔ MySQL |
| Visual Studio Community | 2022 | IDE de desenvolvimento |

---

## 🤝 Convenção de commits

| Prefixo | Uso |
|---|---|
| `feat:` | Nova funcionalidade |
| `fix:` | Correção de bug |
| `docs:` | Alteração na documentação |
| `refactor:` | Refatoração sem mudança de comportamento |

Exemplos:
```
feat: implementa crud de alunos
feat: adiciona repositório de empréstimos
fix: corrige validação de quantidade negativa em Livro
docs: atualiza README com instruções de execução
```
