/* 
Назирзода Рахимджон 
В локальном репозитории da_course создайте ветку hw26. Переключитесь на новую ветку. 
В DBeaver выберите команду Open SQL console и сохраните файл в репозитории под именем hw1_on_sql.sql.

Напишите код, который вернёт из таблицы track поля name и genre_id
Напишите код, который вернёт из таблицы track поля name, composer, unit_price. Переименуйте поля на song, author и price соответственно. Расположите поля так, чтобы сначало следовало название произведения, далее его цена и в конце список авторов.
Напишите код, который вернёт из таблицы track название произведения и его длительность в минутах. Результат должен быть отсортирован по длительности произведения по убыванию.
Напишите код, который вернёт из таблицы track поля name и genre_id, и только первые 15 строк.
Напишите код, который вернёт из таблицы track все поля и все строки начиная с 50-й строки.
Напишите код, который вернёт из таблицы track названия всех произведений, чей объём больше 100 мегабайт (подсказка: 1mb=1048576 bytes).
Напишите код, который вернёт из таблицы track поля name и composer, где composer не равен "U2". Код должен вернуть записи с 10 по 20-й включительно.
*/

select *
from track;

select
	name
	, genre_id
from track;

select 
	name as song
	, unit_price as price
	, composer as author
from track
;

select
	name   
	, round(milliseconds / 60000. ,2) as duration_in_min
from track
order by duration_in_min desc
;

select
	name
	, genre_id
from track
limit 15
;

select *
from track
offset 50
;

select *
from track 
where
	bytes > 1048576
;

select
	name 
	, composer
from track
where 
	 composer != 'U2'
limit 11 
offset 9
;




	