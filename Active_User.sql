-- Table Accounts:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- the id is the primary key for this table.
-- This table contains the account id and the user name of each account.
 

-- Table Logins:

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | login_date    | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may contain duplicates.
-- This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 

-- Write an SQL query to find the id and the name of active users.

-- Active users are those who logged in to their accounts for 5 or more consecutive days.

-- Return the result table ordered by the id.

-- The query result format is in the following example:

-- Accounts table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 1  | Winston  |
-- | 7  | Jonathan |
-- +----+----------+

-- Logins table:
-- +----+------------+
-- | id | login_date |
-- +----+------------+
-- | 7  | 2020-05-30 |
-- | 1  | 2020-05-30 |
-- | 7  | 2020-05-31 |
-- | 7  | 2020-06-01 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-02 |
-- | 7  | 2020-06-03 |
-- | 1  | 2020-06-07 |
-- | 7  | 2020-06-10 |
-- +----+------------+

-- Result table:
-- +----+----------+
-- | id | name     |
-- +----+----------+
-- | 7  | Jonathan |
-- +----+----------+
-- User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
-- User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, so, Jonathan is an active user.

--SQL

create table Accounts( id integer,name varchar(50));
create table login( id integer,login_date date);


insert into Accounts values (  1  ,' Winston');
insert into Accounts values (  7  ,' Jonathan');

insert into login values (  7 ,' 2020-05-30');
insert into login values (  1 ,' 2020-05-30');
insert into login values (  7 ,' 2020-05-31');
insert into login values (  7 ,' 2020-06-01');
insert into login values (  7 ,' 2020-06-02');
insert into login values (  7 ,' 2020-06-02');
insert into login values (  7 ,' 2020-06-03');
insert into login values (  1 ,' 2020-06-07');
insert into login values (  7 ,' 2020-06-10');

--Solution
with lead_value as (
select id,login_date,cast(lead(login_date,4) over(partition by id order by login_date) as date) as day_5_value
from (select distinct * from login)
order by id,login_date
    )
    select A.ID,A.Name
    from Accounts as A
    inner join lead_value as L
    on A.id=L.id
    where datediff(day,login_date,day_5_value)=4
