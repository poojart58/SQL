-- Write an SQL query to find the id and the name of active users.

-- Active users are those who logged in to their accounts for 5 or more consecutive days.

-- Return the result table ordered by the id.


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
