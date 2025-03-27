-- criar banco de dados para o cenário de e-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente 
create table Clients(
	idClient int auto_increment primary key,
    Fname varchar(15),
    Minit char(2),
    Lname varchar(15),
    CPF char(11) not null,
    Address varchar(45),
    constraint unique_cpf_cliente unique (CPF)
);


-- criar tabela produto
create table Products(
	idProduct int auto_increment primary key,
    Pname varchar(15) not null,
    Classification_kids bool default false,
    Category enum('Eletrônico', 'Vestimenta', 'Brinquedo', 'Alimento', 'Móveis'),
    Avaliacao float default 0,
    Size varchar(10)		-- Size = dimensão do produto
);

-- criar tabela payments
create table Payments(
	idClient int,
    idPayment int,
    typePayment enum('Dinheiro', 'Cartão', 'Dois Cartões'),
    limitAvailable float,
    primary key(idClient, idPayment)
);


-- criar tabela pedido
create table Orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references Clients(idClient)
);

-- criar tabela do armazenamento
create table productStorage (
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0    
);

-- criar tabela do fornecedor
create table Supplier (
	idSupplier int auto_increment primary key,
    SocialName varchar(255)  not null,
    CNPJ char(15) not null,
    contact varchar(15) not null,
    constraint unique_supplier unique (CNPJ)
);


-- criar tabela para vendedores
create table Sellers(
	idSeller int auto_increment primary key,
    SocialName varchar(255)  not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(11),
    location varchar(255) not null,
    contact varchar(15) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);


create table productSeller(
	idPseller int,
    idPProduct int,
    prodQuantity int default 1,
    primary key(idPseller, idPProduct),
    constraint fk_product_seller foreign key (idPseller) references Sellers(idSeller),
    constraint fk_product_product foreign key (idPProduct) references Products(idProduct)
);


create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem Estoque') default 'Disponível',
    primary key(idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references Products(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references Orders(idOrder)
);


create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key(idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references Products(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);


create table productSupplier(
	idPSsupplier int,
    idPSProduct int,
    quantity int not null,
    primary key(idPSsupplier, idPSProduct),
    constraint fk_product_supplier_supplier foreign key (idPSsupplier) references Supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPSProduct) references Products(idProduct)
);

