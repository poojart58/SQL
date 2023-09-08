-- Question 107
-- The Numbers table keeps the value of number and its frequency.

-- +----------+-------------+
-- |  Number  |  Frequency  |
-- +----------+-------------|
-- |  0       |  7          |
-- |  1       |  1          |
-- |  2       |  3          |
-- |  3       |  1          |
-- +----------+-------------+
-- In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.

-- +--------+
-- | median |
-- +--------|
-- | 0.0000 |
-- +--------+
-- Write a query to find the median of all numbers and name the result as median.

--sol1 : 

create table Numbers_tab (
num_val integer,
freq integer

)
insert into Numbers_tab values(0,7);
insert into Numbers_tab values(1,1);
insert into Numbers_tab values(2,3);
insert into Numbers_tab values(3,1);

WITH RECURSIVE IdFrequencyCTE AS (
  SELECT num_val,1 as freq
  FROM PROJECT.SALES.Numbers_tab
  WHERE freq > 0

  UNION ALL

  SELECT cte.num_val, cte.freq+1
  FROM PROJECT.SALES.Numbers_tab as nm
  inner join 
  IdFrequencyCTE as cte
  on nm.num_val=cte.num_val
  where cte.freq<nm.freq
)

SELECT median(num_val)
FROM IdFrequencyCTE
order by 1;

-- Solution
with t1 as(
select *,
sum(frequency) over(order by number) as cum_sum, (sum(frequency) over())/2 as middle
from numbers)

select avg(number) as median
from t1
where middle between (cum_sum - frequency) and cum_sum
