+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the name and the ID of a student.
id is a continuous increment.
 
Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
Return the result table ordered by id in ascending order.

Example 1:

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last one's seat.

--SQL
create table Seat(id integer,student varchar(10));

insert into seat values(1,'Abbot'); 
insert into seat values(2,'Doris'); 
insert into seat values(3,'Emerson'); 
insert into seat values(4,'Green'); 
insert into seat values(5,'Jeames'); 


--Solution :
select id,coalesce(case when id%2=0 then lag(student) over(order by id) else lead(student) over(order by id)
end,student) as student
from Seat
order by id;
