select * 
from employee;

select 
	e.employee_id
	, e.first_name || ' ' || e.last_name as full_name 
	, e.title 
	, e.reports_to 
	, m.first_name || ' ' || m.last_name || ' , ' || m.title as manager
from employee e
	left join employee m 
		on e.reports_to = m.employee_id;

select * 
from invoice;

with avg_invoice_2023 as (
	select avg(total) as avg_total
	from invoice 
	where 
		invoice_date 
		between '2023-01-01' 
			and '2023-12-31'
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
		invoice_date 
		between '2023-01-01' 
			and '2023-12-31'
)
select 
	i.invoice_id 
	, i.invoice_date 
	, extract(year from invoice_date) * 100 + extract(month from invoice_date) as monthkey
	, i.customer_id 
	, i.total 
	, customer.email
from 
	invoice i
		join customer 
			on i.customer_id = customer.customer_id
where i.total > ( 
	select 
	avg_total 
	from avg_invoice_2023);

with avg_invoice_2023 as (
	select avg(total) as avg_total
	from invoice 
	where 
		invoice_date 
		between '2023-01-01' 
			and '2023-12-31'
)
select 
	i.invoice_id 
	, i.invoice_date 
	, extract(year from invoice_date) * 100 + extract(month from invoice_date) as monthkey
	, i.customer_id 
	, i.total 
	, customer.email
from 
	invoice i
		join customer 
			on i.customer_id = customer.customer_id
where i.total > ( 
	select 
	avg_total 
	from avg_invoice_2023)
		and customer.email 
			not like '%gmail%';

select 
	invoice_id 
	, customer_id
	, invoice_date 
	, total 
	, round(total / (select sum(total) from invoice), 4) as pct_sum
from invoice
where 
	invoice_date 
		between '2024-01-01' 
			and '2024-12-31';


select 
	customer_id
	, sum(total) as customer_revenue
	, round(sum(total) / (select sum(total) from invoice), 4) as pct_revenue
from invoice
where 
	invoice_date 
		between '2024-01-01' 
			and '2024-12-31'
group by customer_id;
	
	
	
	
	
	
	