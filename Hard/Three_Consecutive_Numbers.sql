
-- Write a SQL query to find all numbers that appear at least three times consecutively.

-- +----+-----+
-- | Id | Num |
-- +----+-----+
-- | 1  |  1  |
-- | 2  |  1  |
-- | 3  |  1  |
-- | 4  |  2  |
-- | 5  |  1  |
-- | 6  |  2  |
-- | 7  |  2  |
-- +----+-----+
-- For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+

--SQL Statements
create table logs(
Id  integer,
Num  integer
);

insert into logs values(1,1);
insert into logs values(2,1);
insert into logs values(3,1);
insert into logs values(4,2);
insert into logs values(5,1);
insert into logs values(6,2);
insert into logs values(7,2);

--Solution : 
select distinct num from (
select num,lead(num) over(order by ID) as Next_Num,
lag(num) over(order by ID) as Prev_Num
from logs)
where num=Next_Num and num=Prev_Num
;
