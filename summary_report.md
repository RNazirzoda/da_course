# Case Study по модулю SQL
## Аналитическая записка по результатам анализа

### Введение
В рамках данного анализа были проведены различные расчёты и сегментации для оценки продаж и понимания ключевых факторов, влияющих на результаты бизнеса. Основные задачи включают в себя:

- Сегментацию клиентов по доходу и семейному положению
- Определение самых продаваемых продуктов
- Анализ маржи от продаж


### Методы

Для выполнения анализа использовались SQL-запросы, которые включают следующие действия:

1. **Сегментация по доходу**: Мы посчитали средний годовой доход клиентов в разбивке по роду деятельности. Для этого был использован запрос с агрегацией по полю `occupation` и подсчётом среднего значения `yearly_income`.

2. **Анализ семейного положения**: Были рассчитаны доли клиентов с детьми и без детей. Для этого использовался запрос с условным вычислением по полю `number_of_children` и расчётом процента от общего числа клиентов.

3. **Определение самых продаваемых продуктов**: Были выделены топ 5 продуктов с наибольшей суммой продаж. Для этого применялась агрегация по полям `product_key` и `sales_amount`.

4. **Анализ маржи от продаж**: Рассчитана разница между суммой продаж и себестоимостью товаров, налогами и доставкой. Также была вычислена маржа как процент от общей суммы продаж.

5. **Анализ квартального роста**: Мы рассчитали процентное изменение продаж по кварталам для двух самых продаваемых категорий продуктов.

6. **Сравнение будних и выходных дней**: Были проведены вычисления по продажам в разбивке по дням недели, а также проанализирован сравнительный эффект будних и выходных дней.

### Результаты

#### 1. Сегментация по доходу
- **Результат**: Средний годовой доход клиентов в разбивке по профессии показал, что клиенты, занимающиеся техническими и медицинскими профессиями, имеют значительно более высокие доходы по сравнению с другими категориями.
- **Вывод**: Профессия влияет на доход, что может быть полезно для более точной таргетированной рекламы и предложения продуктов.

#### 2. Семейный профиль
- **Результат**: Доля клиентов с детьми составила 40%, а без детей — 60%.
- **Вывод**: Это может помочь при планировании маркетинговых кампаний, так как клиенты с детьми могут иметь другие предпочтения при выборе продуктов.

#### 3. Самые продаваемые продукты
- **Результат**: Топ 5 продуктов, с наибольшими суммами продаж, включают товары из категории электроники и бытовой техники.
- **Вывод**: Это указывает на высокий интерес к технике и электронике, что может повлиять на решения по расширению ассортимента.

#### 4. Маржа от продаж
- **Результат**: Маржа от продаж значительно варьируется в зависимости от продукта. Товары с высокой маржей часто сопровождаются большими затратами на доставку и налоги.
- **Вывод**: Для увеличения маржи стоит обратить внимание на оптимизацию затрат на логистику и налоги, а также на улучшение ценообразования.

#### 5. Квартальный рост
- **Результат**: Квартальные продажи показывают стабильный рост для двух наиболее продаваемых категорий. Однако, процентное изменение в одном квартале значительно выше, чем в других.
- **Вывод**: Рост продаж является стабильным, однако могут быть определенные сезонные колебания, которые нужно учитывать при планировании на следующий год.

#### 6. Сравнение будних и выходных дней
- **Результат**: Продажи в выходные дни в среднем значительно выше, чем в будние дни.
- **Вывод**: Это подтверждает потребность в увеличении рекламных и маркетинговых усилий на выходных, а также в улучшении ассортимента для выходных.

## Заключение

Проведённый анализ позволил выявить ключевые тренды в продажах и предложениях для клиентов, а также дал рекомендации по оптимизации бизнес-процессов. Основные выводы заключаются в том, что сегментация клиентов по доходу и семейному положению позволяет более точно настроить маркетинг, а анализ продаж по дням недели помогает лучше планировать акции и предложения. Учет этих факторов может способствовать улучшению результатов продаж и увеличению прибыли компании.
