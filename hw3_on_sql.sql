create schema if not exists store;

set search_path to store;

select current_schema;

create table if not exists customers(
	customer_id serial
	, customer_name varchar(50) 
	, email varchar(250)
	, address text
	, primary key(customer_id)
);

insert into customers (customer_name, address)
select 
	first_name || ' ' || last_name as customer_name 
	, country || ' ' || state || ' ' || city || ' ' || address as address
from public.customer;


create table if not exists products(
	products_id serial
	, product_name varchar(100) 
	, price integer not null
	, primary key(products_id)
);

insert into products(product_name, price)
values 
	('Ноутбук Lenovo Thinkpad', 12000)
	, ('Мышь для компьютера, беспроводная', 90)
	, ('Подставка для ноутбука', 300)
	, ('Шнур электрический для ПК', 160);


create table if not exists sales(
	sale_id serial
	, sale_timestamp timestamp not null default localtimestamp 
	, customer_id integer not null 
	, products_id integer not null 
	, quantity integer not null default 1
	, constraint fk_customers foreign key(customer_id) references customers(customer_id) on delete cascade 
	, constraint fk_products foreign key(products_id) references products(products_id) on delete cascade
	, primary key(sale_id)
);

insert into sales(customer_id, products_id, quantity)
values 
	(3, 4, 1) 
	, (56, 2, 3)
	, (11, 2, 1)
	, (31, 2, 1)
	, (24, 2, 3)
	, (27, 2, 1)
	, (37, 3, 2)
	, (35, 1, 2)
	, (21, 1, 2)
	, (31, 2, 2)
	, (15, 1, 1)
	, (29, 2, 1)
	, (12, 2, 1);


alter table sales 
add column discount integer default 0;

update sales 
set discount = 0.2 
where 
	products_id = 1;

create view v_usa_customers  as 
select 
	customer_id
	, customer_name
	, email
	, address 
from customers 
where 
	address like '%USA%';



























