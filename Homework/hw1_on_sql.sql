/* 
Назирзода Рахимджон 

Создайте многострочный комментарий со следующей информацией:
ваши имя и фамилия
описание задачи
Напишите код, который вернёт из таблицы track поля name и genre_id
Напишите код, который вернёт из таблицы track поля name, composer, unit_price. Переименуйте поля на song, author и price соответственно. Расположите поля так, чтобы сначало следовало название произведения, далее его цена и в конце список авторов.
Напишите код, который вернёт из таблицы track название произведения и его длительность в минутах. Результат должен быть отсортирован по длительности произведения по убыванию.
Напишите код, который вернёт из таблицы track поля name и genre_id, и только первые 15 строк.
Напишите код, который вернёт из таблицы track все поля и все строки начиная с 50-й строки.
Напишите код, который вернёт из таблицы track названия всех произведений, чей объём больше 100 мегабайт (подсказка: 1mb=1048576 bytes).
Напишите код, который вернёт из таблицы track поля name и composer, где composer не равен "U2". Код должен вернуть записи с 10 по 20-й включительно.
*/

select 
	name
	, genre_id 
from track;

select 
	name as song
	, unit_price as price
	, composer as author
from track;

select 
	name 
	, milliseconds / 60000. as duration_in_mins 
from track 
order by duration_in_mins desc;

select 
	name 
	, genre_id
from track 
limit 15;

select * 
from track 
offset 50;

select 
	name 
from track 
where 
	bytes > 1048576;

select 
	name 
	, composer 
from track 
where 
	composer != 'U2'
offset 9
limit 11;