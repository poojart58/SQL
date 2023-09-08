Write an SQL query which displays all the managers which has atleast 3 or mre direct reportees under them


--SQL
create table    hier_Table_Employee (id integer,Name varchar(10),Department varchar(10) ,ManagerId integer);

insert into hier_Table_Employee values (101,'John','A',null);
insert into hier_Table_Employee values (102,'Dan','A',101);
insert into hier_Table_Employee values (103,'James','A',101);
insert into hier_Table_Employee values (104,'Amy','A',101);
insert into hier_Table_Employee values (105,'Anne','A',101);
insert into hier_Table_Employee values (106,'Rone','A',101);
insert into hier_Table_Employee values (107,'Hiny','A',102);
insert into hier_Table_Employee values (108,'Dony','A',102);
insert into hier_Table_Employee values (109,'Jimmy','A',102);
insert into hier_Table_Employee values (110,'Alima','A',102);
insert into hier_Table_Employee values (111,'Nima','A',103);
insert into hier_Table_Employee values (112,'Rontin','B',103);


--Solution
select E1.Name,count(*) as cnt
from hier_Table_Employee as E1
inner join hier_Table_Employee as E2
on E1.id=E2.ManagerId
group by E1.Name
having count(*) > 3;
