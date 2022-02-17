#Write SQL which displays a word name the number of times present in the column "freq"


Input : 

-- +-------------+-------------+
-- | Name        | Freq          |
-- +-------------+-------------+
-- | Bus           | 5           |
-- +-------------+-------------+

Output :
-- +-------------+-------------+
-- | Name        | Freq          |
-- +-------------+-------------+
-- | Bus           | 5           |
-- | Bus           | 5           |
-- | Bus           | 5           |
-- | Bus           | 5           |
-- | Bus           | 5           |
-- +-------------+-------------+

create table frequency(
name varchar(50),
freq integer);

insert into frequency values ('bus',10);
insert into frequency values ('car',2);
insert into frequency values ('scooter',3);
insert into frequency values ('van',5);



with freq_table(name,freq,num) as (
select name,freq,1 as num
from frequency
where freq<>0
union all
select f1.name,f1.freq,num+1
from frequency as f1
inner join freq_table as f2
on f1.name=f2.name
where f2.num <f1.freq)
select name,freq
from freq_table;
