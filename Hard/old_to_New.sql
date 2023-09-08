create table latest_emp (
    empid integer,
    ename varchar(50),
    salary integer
);

create table history_emp (
    empid integer,
    ename varchar(50),
    salary integer
);

insert into latest_emp values (1,'pooja',10000);
insert into latest_emp values(2,'rachit',200000);
insert into latest_emp values(3,'surya',30000);
insert into latest_emp values(4,'sai',40000);

insert into history_emp values(8,'niki',200);
insert into history_emp values(9,'tina',300);
insert into history_emp values(3,'surya',400);
insert into history_emp values(4,'sai',500);

select coalesce(E1.empid,E2.empid) as emp_id,
coalesce(E1.ename,E2.ename) as emp_name,
coalesce(E1.salary,E2.salary) as emp_sal
from latest_emp as E1
full outer join history_emp as E2
on E1.empid=E2.empid
order by emp_id;
