
In social network like Facebook or Twitter, people send friend requests and accept others’ requests as well. Table request_accepted holds the data of friend acceptance, while requester_id and accepter_id both are the id of a person.

| requester_id | accepter_id | accept_date|
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
Write a query to find the the people who has most friends and the most friends number. For the sample data above, the result is:

| id | num |
|----|-----|
| 3  | 3   |

--SQL :
create table request_accepted(requester_id integer,
accepter_id integer,
accept_date date
);


insert into request_accepted values (1,2,'2016-06-03');
insert into request_accepted values (1,3,'2016-06-08');
insert into request_accepted values (2,3,'2016-06-08');
insert into request_accepted values (3,4,'2016-06-09');

Solution :

select sum(cnt) ,id from (
 select count(requester_id) as cnt,requester_id as id
 from request_accepted
 group by requester_id
 union all
 select count(accepter_id) as cnt,accepter_id
 from request_accepted
 group by accepter_id
 order by id
    )
    group by id;
