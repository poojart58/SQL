-- Table: Views

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | article_id    | int     |
-- | author_id     | int     |
-- | viewer_id     | int     |
-- | view_date     | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may have duplicate rows.
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
-- Note that equal author_id and viewer_id indicate the same person.
 

-- Write an SQL query to find all the people who viewed more than one article on the same date, sorted in ascending order by their id.

-- The query result format is in the following example:

-- Views table:
-- +------------+-----------+-----------+------------+
-- | article_id | author_id | viewer_id | view_date  |
-- +------------+-----------+-----------+------------+
-- | 1          | 3         | 5         | 2019-08-01 |
-- | 3          | 4         | 5         | 2019-08-01 |
-- | 1          | 3         | 6         | 2019-08-02 |
-- | 2          | 7         | 7         | 2019-08-01 |
-- | 2          | 7         | 6         | 2019-08-02 |
-- | 4          | 7         | 1         | 2019-07-22 |
-- | 3          | 4         | 4         | 2019-07-21 |
-- | 3          | 4         | 4         | 2019-07-21 |
-- +------------+-----------+-----------+------------+

-- Result table:
-- +------+
-- | id   |
-- +------+
-- | 5    |
-- | 6    |
-- +------+


--SQL
Create table Views (
 article_id     int     ,
 author_id      int     ,
 viewer_id      int     ,
 view_date      date    );

insert into Views values(1,3,5,'2019-08-01');
insert into Views values(3,4,5,'2019-08-01');
insert into Views values(1,3,6,'2019-08-02');
insert into Views values(2,7,7,'2019-08-01');
insert into Views values(2,7,6,'2019-08-02');
insert into Views values(4,7,1,'2019-07-22');
insert into Views values(3,4,4,'2019-07-21');
insert into Views values(3,4,4,'2019-07-21');

Solution : 

select viewer_id from (
select count(distinct article_id) as cnt,viewer_id,view_date
from Views
group by viewer_id,view_date
having cnt > 1
    );
