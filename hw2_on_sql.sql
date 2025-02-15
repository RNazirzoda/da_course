

select * 
from invoice; 

select 
	min(invoice_date) as first_purchase 
	, max(invoice_date) as second_purchase 
from invoice;

select 
	avg(total) as avg_bill 
from invoice
where 
	billing_country = 'USA';

select 
	billing_city 
from  invoice 
group by billing_city 
having count(distinct customer_id) > 1;

select * 
from customer;

select 
	phone
from customer
where 
	phone  not like '%(%' 
	or phone  not like '%)%';

select 
upper 
	(left('lorem ipsum', 1)) || lower (substring('lorem ipsum' from 2));

select 
	name
from track 
where 
	name ilike '%run%';

select *
from customer 
where 
	email like '%gmail.%';

select *
from track;

select 
	name 
	, length(name) 
from track;

select 
	extract(month from invoice_date) as month_id
	, sum(total) as sales_sum
from invoice
where 
	extract(year from invoice_date) = 2021
group by month_id
order by month_id;

select 
	extract(month from invoice_date) as month_id
	, to_char(invoice_date, 'Month') as month_name
	, sum(total) as sales_sum
from invoice
where 
	extract(year from invoice_date) = 2021
group by month_id, month_name
order by month_id;


select * 
from employee;

select
	employee_id
	, concat(first_name, ' ', last_name) as full_name 
	, extract(year from age(localtimestamp, birth_date)) as age_now
from employee
order by age_now desc;

select 
	avg(extract(year from age(localtimestamp + interval '3 years 4 months', birth_date))) as ave_age_future
from employee;

select 
	extract(year from invoice_date) as sales_year
	, billing_country
	, sum(total) as sales_sum
from invoice
group by extract(year from invoice_date), billing_country
having sum(total) > 20
order by sales_year asc, sales_sum desc;














