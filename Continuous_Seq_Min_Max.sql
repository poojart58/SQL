Input : 

-- +-------------+-------------+
-- | DEPT_NO     | EMP_SEQ      |
-- +-------------+-------------+
-- | 10           | 1           |
-- | 10           | 2           |
-- | 10           | 3           |
-- | 10           | 5           |
-- | 10           | 6           |
-- | 10           | 8           |
-- | 10           | 9           |
-- | 10           | 11          |
-- | 10           | 1           |
-- | 10           | 2           |
-- +-------------+-------------+

Output :
-- +-------------+---------------+--------------+
-- | DEPT_ID        | Min_SEQ    |    Min_SEQ   | 
-- +-------------+---------------+---------------
-- | 10           | 1            | 3            |
-- | 10           | 5            | 6            |
-- | 10           | 8            | 9            |
-- | 10           | 11           |11            |
-- | 20           | 1            | 2            |
-- +-------------+---------------+---------------+

SQL statement : 

create table order_tab(
dept_id integer,
emp_seq integer);

insert into order_tab values(10,1);
insert into order_tab values(10,2);
insert into order_tab values(10,3);
insert into order_tab values(10,5);
insert into order_tab values(10,6);
insert into order_tab values(10,8);
insert into order_tab values(10,9);
insert into order_tab values(10,11);
insert into order_tab values(20,1);
insert into order_tab values(20,2);
''''''''''''''''''''''''''''''''''''''''''''''''''''

Solution 1 :
SELECT DEPT_ID, MIN(EMP_SEQ) MIN_SEQ, MAX(EMP_SEQ) MAX_SEQ
FROM
(
SELECT DEPT_ID, EMP_SEQ, EMP_SEQ-ROW_NUMBER() OVER (PARTITION BY DEPT_ID ORDER BY EMP_SEQ) DEPT_SPLIT
FROM ORDER_TAB
) A
GROUP BY DEPT_ID, DEPT_SPLIT;

Solution 2 :

select dept_id,min(emp_seq) as min_num,max(emp_seq) as max_num from (
select dept_id,emp_seq,sum(group_col) over (partition by dept_id order by emp_seq ) as final_group from (
select dept_id,emp_seq, case when diff_num=1 then 0 else 1 end as group_col from (
select dept_id,emp_seq,lag(emp_seq,1,0) over(partition by dept_id order by emp_seq),emp_seq-lag(emp_seq,1,0) over(partition by dept_id order by emp_seq) as diff_num
from order_tab
) as t
  )
  ) as T1
  group by final_group,dept_id;


