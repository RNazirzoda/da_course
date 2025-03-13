--Секция 1. Анализ клиентов

-- Сегментация по доходу
select * 
from adv_works.customers c;

select 
    occupation,
    count(*) as number_of_customers,
    round(avg(yearly_income), 2) as avg_income
from adv_works.customers
group by 
	occupation
order by 
	avg_income desc;


--Семейный профиль
select 
    has_children,
    round(100.0 * count(*) / total.count, 2) as pct_of_customer_base
from (
    select 
        case 
            when number_of_children > 0 then 1
            else 0
        end as has_children
    from adv_works.customers
) as subquery,
(
    select count(*) as count from adv_works.customers
) as total
group by 
	has_children, total.count;

--Высокодоходные клиенты
select * 
from adv_works.sales s;
select 
    c.customer_key,
    c.full_name,
    round(sum(s.sales_amount), 2) as total_purchase
from adv_works.customers c
join adv_works.sales s 
	on c.customer_key = s.customer_key
group by 
	c.customer_key, c.full_name
order by 
	total_purchase desc
limit 10;

--Влияние семейного положения:
select * 
from adv_works.sales s;

select 
    extract(year from s.order_date) as year,
    c.marital_status,
    round(avg(s.sales_amount), 2) as avg_sales_amount
from adv_works.customers c
join adv_works.sales s 
	on c.customer_key = s.customer_key
group by year, c.marital_status
order by year, avg_sales_amount desc;

--Секция 2. Анализ продаж

--Ежемесячные продажи
select * 
from adv_works.sales s;

select 
    extract(year from s.order_date) as year,
    to_char(s.order_date, 'YYYYMM') as monthkey,
    to_char(s.order_date, 'Month') as month_name,
    count(*) as sales_count,
    round(sum(s.sales_amount), 2) as sales_amount
from adv_works.sales s
where extract(year from s.order_date) in (2003, 2004)
group by year, monthkey, month_name
order by year, monthkey;

--Продажи по регионам

select 
    t.region,
    count(*) as sales_count,
    round(sum(s.sales_amount), 2) as sales_amount
from adv_works.sales s
join adv_works.territory t on s.territory_key = t.territory_key
group by t.region
order by sales_amount desc;

--Секция 3. Анализ продуктов

--Доля продаж

select 
    extract(year from s.order_date) as year,
    p.product_key,
    pc.category_key as product_category_key,
    pc.category_name,
    round(sum(s.sales_amount), 2) as sales_amount,
    round(100.0 * sum(s.sales_amount) / total.total_sales, 2) as pct_of_total_sales
from adv_works.sales s
join adv_works.products p on s.product_key = p.product_key
join adv_works.product_subcategory psc on p.subcategory_key = psc.subcategory_key
join adv_works.product_category pc on psc.category_key = pc.category_key
cross join (
    select sum(sales_amount) as total_sales from adv_works.sales
) as total
group by year, p.product_key, pc.category_key, pc.category_name, total.total_sales
order by year, pct_of_total_sales desc;

--Самые продаваемые продукты

select 
    p.product_key,
    p.product_name,
    pc.category_name,
    round(sum(s.sales_amount), 2) as sales_amount
from adv_works.sales s
join adv_works.products p on s.product_key = p.product_key
join adv_works.product_subcategory psc on p.subcategory_key = psc.subcategory_key
join adv_works.product_category pc on psc.category_key = pc.category_key
group by p.product_key, p.product_name, pc.category_name
order by sales_amount desc
limit 5;

--Маржа от продаж

select 
    extract(year from s.order_date) as year,
    to_char(s.order_date, 'YYYYMM') as monthkey,
    to_char(s.order_date, 'Month') as month_name,
    p.product_key,
    p.product_name,
    round(sum(s.sales_amount), 2) as sales_amount,
    round(sum(s.total_product_cost), 2) as total_product_cost,
    round(sum(s.tax_amount), 2) as tax_amt,
    round(sum(s.freight), 2) as freight,
    round(sum(
    	s.sales_amount - s.total_product_cost - s.tax_amount - s.freight
    	), 2) as margin,
    round(100.0 * sum(
    				s.sales_amount - s.total_product_cost - s.tax_amount - s.freight
    				) / sum(
    				s.sales_amount
    				), 2) as margin_pct
from adv_works.sales s
join adv_works.products p on s.product_key = p.product_key
group by year, monthkey, month_name, p.product_key, p.product_name
order by year, monthkey, margin desc;


--Секция 4

--Квартальный рост



