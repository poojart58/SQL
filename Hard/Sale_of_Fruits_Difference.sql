
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | sale_date     | date    |
-- | fruit         | enum    | 
-- | sold_num      | int     | 
-- +---------------+---------+
-- (sale_date,fruit) is the primary key for this table.
-- This table contains the sales of "apples" and "oranges" sold each day.
 
-- Write an SQL query to report the difference between number of apples and oranges sold each day.

-- Return the result table ordered by sale_date in format ('YYYY-MM-DD').

-- The query result format is in the following example:

-- Sales table:
-- +------------+------------+-------------+
-- | sale_date  | fruit      | sold_num    |
-- +------------+------------+-------------+
-- | 2020-05-01 | apples     | 10          |
-- | 2020-05-01 | oranges    | 8           |
-- | 2020-05-02 | apples     | 15          |
-- | 2020-05-02 | oranges    | 15          |
-- | 2020-05-03 | apples     | 20          |
-- | 2020-05-03 | oranges    | 0           |
-- | 2020-05-04 | apples     | 15          |
-- | 2020-05-04 | oranges    | 16          |
-- +------------+------------+-------------+

-- Result table:
-- +------------+--------------+
-- | sale_date  | diff         |
-- +------------+--------------+
-- | 2020-05-01 | 2            |
-- | 2020-05-02 | 0            |
-- | 2020-05-03 | 20           |
-- | 2020-05-04 | -1           |
-- +------------+--------------+

--SQL
create Table fruit_sale
(
sale_date    date    , 
fruit  varchar(50), 
sold_num     int    
);

insert into fruit_sale values('2020-05-01','apples',10);
insert into fruit_sale values('2020-05-01','oranges',8 );
insert into fruit_sale values('2020-05-02','apples',15);
insert into fruit_sale values('2020-05-02','oranges',15);
insert into fruit_sale values('2020-05-03','apples',20);
insert into fruit_sale values('2020-05-03','oranges',0 );
insert into fruit_sale values('2020-05-04','apples',15);
insert into fruit_sale values('2020-05-04','oranges',16);


--Solution
select (Apple_sale-Orange_Sale) as sale_Difference,sale_date
from(
select lead(sold_num) over(order by sale_date,fruit) as Orange_Sale,
sold_num as Apple_sale,
sale_date,fruit
from fruit_sale
) as Tab
where fruit='apples';
