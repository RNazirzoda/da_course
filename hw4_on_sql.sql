select * 
from employee;

select 
	employee.employee_id
	, employee.first_name || ' ' || employee.last_name as full_name 
	, employee.title 
	, employee.reports_to 
	, manager.first_name || ' ' || manager.last_name || ' , ' || manager.title as manager
from employee 
left join employee manager on employee.reports_to = manager.employee_id;

select * 
from invoice;

with avg_invoice_2023 as (
	select avg(total) as avg_total
	from invoice 
	where 
		invoice_date between '2023-01-01' and '2023-12-31'
)
select 
	invoice_id 
	, invoice_date 
	, extract(year from invoice_date) * 100 + extract(month from invoice_date) as monthkey
	, customer_id 
	, total
from 
	invoice
	, avg_invoice_2023 
where 
	total > avg_total;

with avg_invoice_2023 as (
	select avg(total) as avg_total
	from invoice 
	where 
		invoice_date between '2023-01-01' and '2023-12-31'
)
select 
	invoice.invoice_id 
	, invoice.invoice_date 
	, extract(year from invoice_date) * 100 + extract(month from invoice_date) as monthkey
	, invoice.customer_id 
	, invoice.total 
	, customer.email
from 
	invoice
join customer on invoice.customer_id = customer.customer_id
where invoice.total > ( 
	select 
	avg_total 
	from avg_invoice_2023);

with avg_invoice_2023 as (
	select avg(total) as avg_total
	from invoice 
	where 
		invoice_date between '2023-01-01' and '2023-12-31'
)
select 
	invoice.invoice_id 
	, invoice.invoice_date 
	, extract(year from invoice_date) * 100 + extract(month from invoice_date) as monthkey
	, invoice.customer_id 
	, invoice.total 
	, customer.email
from 
	invoice
join customer on invoice.customer_id = customer.customer_id
where invoice.total > ( 
	select 
	avg_total 
	from avg_invoice_2023)
	and customer.email not like '%gmail%';

select 
	invoice_id 
	, customer_id
	, invoice_date 
	, total 
	, round(total / (select sum(total) from invoice), 4) as pct_sum
from invoice
where invoice_date between '2024-01-01' and '2024-12-31';


select 
	customer_id
	, sum(total) as customer_revenue
	, round(sum(total) / (select sum(total) from invoice), 4) as pct_revenue
from invoice
where invoice_date between '2024-01-01' and '2024-12-31'
group by customer_id;
	
	
	
	
	
	
	