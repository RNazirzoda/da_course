-- Задача №1
select * 
from invoice;

with month_sales as ( 
	select 
		c.customer_id 
		, c.first_name || ' ' || c.last_name as full_name  
		, date_part('year', i.invoice_date) as sale_year 
		, date_part('month', i.invoice_date) as monthkey 
		, sum(i.total) as total
	from invoice i
	left join customer c 
		on i.customer_id = c.customer_id
	group by 
		c.customer_id 
		, full_name 
		, sale_year
		, monthkey
) 
,pcnt_sales as ( 
	select 
		ms.* 
		, round((ms.total / sum(ms.total) over (
			partition by ms.sale_year 
			, ms.monthkey) * 100), 2) as pcnt_total
	from month_sales ms
)
,cumulative_sales as ( 
	select 
		pcnt.* 
		, sum(pcnt.total) over(
			partition by pcnt.customer_id 
			, pcnt.sale_year 
			order by pcnt.monthkey 
			) as cumulative_total
	from pcnt_sales pcnt
)
, moving_avg_sales as (
	select
		cs.*
		, round(avg(cs.total) over(
			partition by cs.customer_id 
			order by cs.sale_year 
			, cs.monthkey 
			rows between 2 preceding and current row
			), 2) as moving_avg
	from cumulative_sales cs
)
select 
	mas.*
	, coalesce(ms.total - lag(ms.total) over(
		partition by ms.customer_id 
		order by ms.sale_year 
		, ms.monthkey
		),0) as period_difference
from moving_avg_sales mas
	left join month_sales ms 
		on mas.customer_id = ms.customer_id 
		and mas.sale_year = ms.sale_year 
		and mas.monthkey = ms.monthkey 
order by 
	mas.customer_id 
	, mas.sale_year 
	, mas.monthkey
;
	
--Задача №2
select * 
from invoice_line;

with album_sales as ( 
	select 
		date_part('year', invoice_date) as sale_year 
		, al.title as album_title 
		, ar.name as artist_name 
		, count(il.track_id) as tracks_sold
	from invoice_line il 
		left join invoice i 
			on il.invoice_id = i.invoice_id 
		left join track t 
			on il.track_id = t.track_id
		left join album al 
			on t.album_id = al.artist_id
		left join artist ar 
			on al.artist_id = ar.artist_id
	group by 
		sale_year 
		, album_title 
		, artist_name
), 
ranked_album as (
	select 
		sale_year 
		, album_title 
		, artist_name 
		, tracks_sold 
		, rank() over(
			partition by sale_year 
			order by tracks_sold desc) as rank
	from album_sales
)
select 
	sale_year 
	, album_title 
	, artist_name 
	, tracks_sold
from ranked_album
where 
	rank <= 3
order by 
	sale_year 
	, rank 
;
	

-- Задача №3

select * 
from employee;

with employee_clients as (
	select 
		e.employee_id 
		, e.first_name || ' ' || e.last_name as full_name 
		, count(c.customer_id) as client_count 
	from employee e
	left join customer c
		on e.employee_id = c.support_rep_id
	group by 
		e.employee_id 
		, full_name
),
total_clients as (
	select
		sum(client_count) as total_count
	from employee_clients
)
select 
	ec.employee_id 
	, ec.full_name 
	, ec.client_count
	, round((ec.client_count::numeric / tc.total_count)*100, 2) as pcnt_total
from employee_clients ec
cross join total_clients tc
order by 
	ec.employee_id
;

-- Задача №4
select 
	i.customer_id 
	, min(i.invoice_date) as first_purchase_date 
	, max(i.invoice_date) as last_purchase_date 
	, extract(year from age (
		max(i.invoice_date) 
		, min(i.invoice_date))) as years_difference
from invoice i
group by 
	i.customer_id
order by
	i.customer_id
;



