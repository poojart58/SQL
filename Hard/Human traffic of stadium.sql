-- Question 99
-- X city built a new stadium, each day many people visit it and the stats are saved as these columns: id, visit_date, people

-- Please write a query to display the records which have 3 or more consecutive rows and the amount of people more than 100(inclusive).

-- For example, the table stadium:
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 1    | 2017-01-01 | 10        |
-- | 2    | 2017-01-02 | 109       |
-- | 3    | 2017-01-03 | 150       |
-- | 4    | 2017-01-04 | 99        |
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-08 | 188       |
-- +------+------------+-----------+
-- For the sample data above, the output is:

-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-08 | 188       |
-- +------+------------+-----------+
-- Note:
-- Each day only have one row record, and the dates are increasing with id increasing.

--SQL

Create table stadium (id  integer,   visit_date date, people    integer);

insert into stadium values (1,'2017-01-01',10  );
insert into stadium values (2,'2017-01-02',109 );
insert into stadium values (3,'2017-01-03',150 );
insert into stadium values (4,'2017-01-04',99  );
insert into stadium values (5,'2017-01-05',145 );
insert into stadium values (6,'2017-01-06',1455);
insert into stadium values (7,'2017-01-07',199 );
insert into stadium values (8,'2017-01-08',188 );

-- Solution

select id,visit_date,people from (
select id,visit_date,people,lead(visit_date,2) over(order by visit_date) as consecutive_3 from stadium
where people >=100
    )
    where consecutive_3-visit_date=2 or consecutive_3-visit_date is null;
