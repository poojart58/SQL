Table: Candidate

-- +-----+---------+
-- | id  | Name    |
-- +-----+---------+
-- | 1   | A       |
-- | 2   | B       |
-- | 3   | C       |
-- | 4   | D       |
-- | 5   | E       |
-- +-----+---------+  
-- Table: Vote

-- +-----+--------------+
-- | id  | CandidateId  |
-- +-----+--------------+
-- | 1   |     2        |
-- | 2   |     4        |
-- | 3   |     3        |
-- | 4   |     2        |
-- | 5   |     5        |
-- +-----+--------------+
-- id is the auto-increment primary key,
-- CandidateId is the id appeared in Candidate table.
-- Write a sql to find the name of the winning candidate, the above example will return the winner B.

-- +------+
-- | Name |
-- +------+
-- | B    |
-- +------+

--SQL :
Create table Candidate
(
id integer,
Name varchar(50)
);


insert into Candidate values (1,'A');
insert into Candidate values (2,'B');
insert into Candidate values (3,'C');
insert into Candidate values (4,'D');
insert into Candidate values (5,'E');


Create table Vote
(
id integer,
CandidateId integer
);

insert into Vote values (1,2);        
insert into Vote values (2,4);        
insert into Vote values (3,3);        
insert into Vote values (4,2);        
insert into Vote values (5,5);  


--Solution :
select CandidateId,Name from (
select rank() over(order by count_Vote desc) as rank_CandidateId,CandidateId
from(
select count(*) as count_Vote,CandidateId
from Vote
group by CandidateId
)
) as C1
inner join Candidate as C2
on C1.CandidateId=C2.id
where rank_CandidateId=1;

