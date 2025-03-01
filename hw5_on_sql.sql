--Задача №1

select 
	e.employee_id 
	, concat_ws(' ', e.first_name, e.last_name) as full_name 
	, count(c.customer_id) as customer_count
from employee e
	left join customer c 
		on e.employee_id = c.support_rep_id 
group by 
	e.employee_id 
	, concat_ws(' ', e.first_name, e.last_name)
 ;

select 
	e.employee_id 
	, concat_ws(' ', e.first_name, e.last_name) as full_name  
	, count(c.customer_id) as customer_count 
	, round (
		(count(c.customer_id) * 100 / ( 
			select 
				count(*) 
				from customer)), 2 ) as customer_pcnt
from employee e
	left join customer c 
		on e.employee_id = c.support_rep_id 
group by 
	e.employee_id 
	, concat_ws(' ', e.first_name, e.last_name)
;

--Задача №2

select *
from track;

select
	t.name
	, t.composer
from track t
	left join invoice_line il
		on t.track_id = il.track_id
where
	il.track_id is null;

--Задача №3

select
	e1.employee_id
	, e1.last_name
	, count(e2.employee_id) as subordinates_cnt
from employee e1
	left join employee e2
		on e1.employee_id = e2.reports_to
group by
	e1.employee_id
	, e1.last_name
having 
	count(e2.employee_id) = 0
order by
	e1.employee_id
;

--Задача №4

select
	t.track_id
	, t.name
	, t.composer
from track t
	left join invoice_line il
		on t.track_id = il.track_id
	left join invoice i 
		on il.invoice_id  = i.invoice_id
where
	i.billing_country in ('USA', 'Canada')
group by 
	t.track_id 
	, t.name
	, t.composer
having 
	count(distinct case 
		when i.billing_country = 'USA' 
		then i.invoice_id end) > 0 
and 
	count(distinct case 
		when i.billing_country = 'Canada' 
		then i.invoice_id end) > 0
order by 
	t.track_id
;

----Задача №5

select
	t.track_id
	, t.name
from track t
	left join invoice_line il
		on t.track_id = il.track_id
	left join invoice i 
		on il.invoice_id  = i.invoice_id
where
	i.billing_country in ('Canada')
group by 
	t.track_id 
	, t.name
having 
	count(distinct case 
		when i.billing_country = 'Canada' 
		then i.invoice_id end) > 0
order by 
	t.track_id
;









