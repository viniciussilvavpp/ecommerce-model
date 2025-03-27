# Banco de Dados para E-commerce

Bem-vindo ao projeto de modelagem de um banco de dados relacional para um sistema de e-commerce, desenvolvido em MySQL. Este repositório contém a estrutura completa do banco, incluindo scripts SQL para criação de tabelas e exemplos de consultas.

## Descrição do Projeto

Este banco de dados foi projetado para suportar as operações de um sistema de comércio eletrônico, gerenciando informações essenciais como clientes, produtos, pedidos, pagamentos, fornecedores, vendedores e controle de estoque. A modelagem utiliza chaves primárias e estrangeiras para garantir integridade e eficiência nos relacionamentos.

### Principais Entidades
- **Clients**: Dados dos clientes (nome, CPF, endereço).  
- **Products**: Informações dos produtos (nome, categoria, avaliação, tamanho).  
- **Orders**: Registro de pedidos (status, descrição, valor de envio).  
- **Payments**: Formas de pagamento associadas aos clientes.  
- **Suppliers**: Dados de fornecedores (razão social, CNPJ, contato).  
- **Sellers**: Informações de vendedores (nome, localização, contato).  
- **productStorage**: Controle de estoque e locais de armazenamento.

## Funcionalidades
- Suporte a consultas variadas, como listagem de pedidos confirmados, produtos em estoque e análise de fornecedores.  
- Estrutura escalável para atender às necessidades de um e-commerce em crescimento.  
- Relacionamentos bem definidos para garantir consistência dos dados.

## Como Usar
1. Execute o script SQL fornecido (`ecommerce.sql`) em um servidor MySQL para criar o banco de dados e as tabelas.  
2. Popule as tabelas com dados fictícios ou reais conforme necessário.  
3. Utilize as queries de exemplo para explorar as funcionalidades do sistema.

## Exemplo de Query
```sql
SELECT c.Fname, c.Lname, o.idOrder, o.orderStatus
FROM Clients c
JOIN Orders o ON c.idClient = o.idOrderClient
WHERE o.orderStatus = 'Confirmado';
