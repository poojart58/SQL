-- Table: Books

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | book_id        | int     |
-- | name           | varchar |
-- | available_from | date    |
-- +----------------+---------+
-- book_id is the primary key of this table.
-- Table: Orders

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | order_id       | int     |
-- | book_id        | int     |
-- | quantity       | int     |
-- | dispatch_date  | date    |
-- +----------------+---------+
-- order_id is the primary key of this table.
-- book_id is a foreign key to the Books table.
 

-- Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than 1 month from today. Assume today is 2019-06-23.

-- The query result format is in the following example:

-- Books table:
-- +---------+--------------------+----------------+
-- | book_id | name               | available_from |
-- +---------+--------------------+----------------+
-- | 1       | "Kalila And Demna" | 2010-01-01     |
-- | 2       | "28 Letters"       | 2012-05-12     |
-- | 3       | "The Hobbit"       | 2019-06-10     |
-- | 4       | "13 Reasons Why"   | 2019-06-01     |
-- | 5       | "The Hunger Games" | 2008-09-21     |
-- +---------+--------------------+----------------+

-- Orders table:
-- +----------+---------+----------+---------------+
-- | order_id | book_id | quantity | dispatch_date |
-- +----------+---------+----------+---------------+
-- | 1        | 1       | 2        | 2018-07-26    |
-- | 2        | 1       | 1        | 2018-11-05    |
-- | 3        | 3       | 8        | 2019-06-11    |
-- | 4        | 4       | 6        | 2019-06-05    |
-- | 5        | 4       | 5        | 2019-06-20    |
-- | 6        | 5       | 9        | 2009-02-02    |
-- | 7        | 5       | 8        | 2010-04-13    |
-- +----------+---------+----------+---------------+

-- Result table:
-- +-----------+--------------------+
-- | book_id   | name               |
-- +-----------+--------------------+
-- | 1         | "Kalila And Demna" |
-- | 2         | "28 Letters"       |
-- | 5         | "The Hunger Games" |
-- +-----------+--------------------+

create table Books(book_id integer,name varchar(50),available_from  date );

Create table Orders (

 order_id       int ,
 book_id        int ,
 quantity       int ,
 dispatch_date  date);
 
 insert into Books values (1,'Kalila And Demna','2010-01-01');
insert into Books values (2,'28 Letters','2012-05-12');
insert into Books values (3,'The Hobbit','2019-06-10');
insert into Books values (4,'13 Reasons Why','2019-06-01');
insert into Books values (5,'The Hunger Games','2008-09-21');


-- Orders table:

insert into Orders values (1,1,2,'2018-07-26');
insert into Orders values (2,1,1,'2018-11-05');
insert into Orders values (3,3,8,'2019-06-11');
insert into Orders values (4,4,6,'2019-06-05');
insert into Orders values (5,4,5,'2019-06-20');
insert into Orders values (6,5,9,'2009-02-02');
insert into Orders values (7,5,8,'2010-04-13');

-- Write an SQL query that reports the books that have sold less than 10 copies in the last year, 
excluding books that have been available for less than 1 month from today. Assume today is 2019-06-23


    select  Books.book_id
        from (select *
                from Books
                where available_from < dateadd(day,-30,'2019-06-23')) as Books
        left outer join (select book_id,sum(quantity) as quantity
                   from Orders 
                         where dispatch_date > '2018-06-23'
                         group by book_id
                        ) as O
        on Books.book_id=O.BOOK_ID
        where coalesce(O.quantity,0)<10;
