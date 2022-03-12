SQL
create table items (order_id integer,
SKU varchar(5));

insert into items values (1,'A');
insert into items values (1,'B');
insert into items values (1,'C');
insert into items values (2,'B');
insert into items values (2,'A');
insert into items values (3,'A');
insert into items values (4,'B');
insert into items values (4,'C');


Write an SQL which displays most two item bought together the most

select First_SKU,Second_SKU from
(
select dense_rank() over(order by cnt desc) as rnk ,First_SKU,Second_SKU
from(
select distinct case when First_SKU < Second_SKU then First_SKU else Second_SKU end as First_SKU,
case when First_SKU > Second_SKU then First_SKU else Second_SKU end as Second_SKU,cnt
from(
select count(*) as cnt, I1.SKU as First_SKU,I2.SKU as Second_SKU
from items as I1
inner join items as I2
on I1.order_id=I2.order_id
and I1.SKU <> I2.SKU
group by  I1.SKU ,I2.SKU
)
    ) as T 

)where rnk=1;
