
- Table: Employees

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | employee_id   | int     |
-- | employee_name | varchar |
-- | manager_id    | int     |
-- +---------------+---------+
-- employee_id is the primary key for this table.
-- Each row of this table indicates that the employee with ID employee_id and name employee_name reports his
-- work to his/her direct manager with manager_id
-- The head of the company is the employee with employee_id = 1.
 

-- Write an SQL query to find employee_id of all employees that directly or indirectly report their work to the head of the company.

-- The indirect relation between managers will not exceed 3 managers as the company is small.

-- Return result table in any order without duplicates.

-- The query result format is in the following example:

-- Employees table:
-- +-------------+---------------+------------+
-- | employee_id | employee_name | manager_id |
-- +-------------+---------------+------------+
-- | 1           | Boss          | 1          |
-- | 3           | Alice         | 3          |
-- | 2           | Bob           | 1          |
-- | 4           | Daniel        | 2          |
-- | 7           | Luis          | 4          |
-- | 8           | Jhon          | 3          |
-- | 9           | Angela        | 8          |
-- | 77          | Robert        | 1          |
-- +-------------+---------------+------------+

-- Result table:
-- +-------------+
-- | employee_id |
-- +-------------+
-- | 2           |
-- | 77          |
-- | 4           |
-- | 7           |
-- +-------------+

--SQL 

create Table Employees_Hierarchy
(
employee_id    int    , 
employee_name  varchar(50), 
manager_id     int    
);

insert into Employees_Hierarchy values (1 ,'Boss',1);
insert into Employees_Hierarchy values (3 ,'Alice',3);
insert into Employees_Hierarchy values (2 ,'Bob',1);
insert into Employees_Hierarchy values (4 ,'Daniel',2);
insert into Employees_Hierarchy values (7 ,'Luis',4);
insert into Employees_Hierarchy values (8 ,'Jhon',3);
insert into Employees_Hierarchy values (9 ,'Angela',8);
insert into Employees_Hierarchy values (77,'Robert',1);

--Solution :
with Employee_Level  (employee_id,level_id) as (
select employee_id ,1 as level_id
from Employees_Hierarchy
where employee_id=1
union all
select E1.employee_id,1+level_id as level_id
from Employees_Hierarchy as E1
    inner join Employee_Level as E2
    on E1.manager_id=E2.employee_id
    where E1.employee_id<>1
    )
    select * from Employee_Level
    where employee_id<> 1;
    
