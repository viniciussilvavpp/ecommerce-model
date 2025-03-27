use ecommerce;

desc Clients;

insert into Clients(Fname, Minit, Lname, CPF, Address)
	values('Rafael', 'F', 'Costa', 121546784, 'Rua do Campo 14, Centro - Açailândia'),
		  ('Ana', 'M', 'Silva', 987654321, 'Avenida Brasil 25, Jardim - São Paulo'),
          ('Pedro', 'H', 'Santos', 456789123, 'Rua das Flores 78, Bairro Novo - Recife'),
          ('Mariana', 'F', 'Oliveira', 321654987, 'Travessa da Paz 10, Centro - Belo Horizonte'),
          ('Lucas', 'H', 'Pereira', 654123987, 'Rua Sol 33, Vila Esperança - Curitiba'),
          ('Julia', 'F', 'Almeida', 789456123, 'Avenida 50, Praia Grande - Salvador');
          
desc Products;
-- 'Category', 'enum(\'Eletrônico\',\'Vestimenta\',\'Brinquedo\',\'Alimento\',\'Móveis\')
insert into Products(Pname, Classification_kids, Category, Avaliacao, Size) values
					('Fone de Ouvido', false, 'Eletrônico', '4', null),
					('Barbie Tinker', true, 'Brinquedo', '3', null),
                    ('Body carters', true, 'Vestimenta', '5', null),
                    ('Microfone Vedo', false, 'Eletrônico', '4', null),
					('Sofá Retrátil', false, 'Móveis', '3', '3x57x80');


desc Orders;
insert into Orders(idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
				  (1, default, 'compra via aplicativo', null, 1),
                  (2, default, 'compra via aplicativo', 50, 0),
                  (3, 'Confirmado', null, null, 1),
                  (4, default, 'compra via web site', 150, 0);
                  

desc productOrder;
insert into productOrder(idPOproduct, idPOorder, poQuantity, poStatus) values
						(1,1,2, null),
                        (2,1,1, null),
                        (3,2,1, null);
                  
desc productStorage;                  
insert into productStorage(storageLocation, quantity) values
						  ('Rio de Janeiro', 1000),
						  ('Rio de Janeiro', 500),
                          ('São Paulo', 10),
                          ('São Paulo', 100),
                          ('São Paulo', 10),
                          ('São Paulo', 20),
                          ('Brasília', 60);
                          
desc storageLocation;
insert into storageLocation(idLproduct, idLstorage, location) values
						   (1,2,'RJ'),
                           (2,6,'GO');

desc Supplier;
insert into Supplier(SocialName, CNPJ, contact) values
					('Almeida e filhos', 12345678945, '9985465825'),
                    ('João e Maria', 95175365418, '9115428765'),
                    ('Costa e Silva', 78912365478, '8192658435'),
                    ('Deodoro da Fonseca', 74136985234, '8898546824');

select * from Supplier;
desc productSupplier;
insert into productSupplier(idPSsupplier, idPSProduct, quantity) values
						   (5,1,500),
                           (5,2,400),
						   (6,2,400),
                           (7,2,400),
                           (8,2,400);
                           
desc Sellers;
insert into Sellers(SocialName, AbstName, CNPJ, CPF, location, contact) values
				   ('Tech Eletronics', null, 159687456216521, null, 'Ceará', 8891256485),
                   ('Claudia Closet', null, null, 60389821322, 'Paraíba', 9284256435),
                   ('Kids Fun', null, 874596589215456, null, 'Piauí', 8193256475),
                   ('Boutique Virginia', null, 1597563578456, null, 'Rio Grande do Norte', 9681456582);

                   
desc productSeller;
insert into productSeller(idPseller, idPProduct, prodQuantity) values
						 (1,6,20),
                         (2,7,10);
                         
                         
select count(*) from Clients;

select Fname, Lname, idOrder, orderStatus from Clients c, Orders o where c.idClient = idOrderClient;

select concat(Fname,' ', Lname) as ClientName, idOrder as Request, orderStatus as Order_Status 
	from Clients c, Orders o 
	where c.idClient = idOrderClient;
    
select Pname, Avaliacao, Size 
from Products 
where Category = 'Eletrônico' and Avaliacao > 4;

-- Listar clientes e seus pedidos confirmados (usando JOIN)
select c.Fname, c.Lname, o.idOrder, o.orderStatus, o.orderDescription 
from Clients c
join Orders o on c.idClient = o.idOrderClient
where o.orderStatus = 'Confirmado';

-- Contar quantos produtos cada fornecedor fornece
select s.SocialName, s.CNPJ, COUNT(ps.idPSProduct) AS total_produtos 
from Supplier s
join productSupplier ps on s.idSupplier = ps.idPSsupplier
group by s.idSupplier, s.SocialName, s.CNPJ;

-- Listar vendedores e os produtos que eles vendem com quantidade maior que 5
select s.SocialName, p.Pname, ps.prodQuantity 
from Sellers s
join productSeller ps on s.idSeller = ps.idPseller
join Products p on ps.idPProduct = p.idProduct
where ps.prodQuantity > 5;

-- Listar fornecedores e a soma da quantidade de produtos fornecidos
select s.SocialName, s.contact, SUM(ps.quantity) as total_quantidade 
from Supplier s
join productSupplier ps on s.idSupplier = ps.idPSsupplier
group by s.idSupplier, s.SocialName, s.contact
order by total_quantidade desc;