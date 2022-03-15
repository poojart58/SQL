-- Table: Players

-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | player_id   | int   |
-- | group_id    | int   |
-- +-------------+-------+
-- player_id is the primary key of this table.
-- Each row of this table indicates the group of each player.
-- Table: Matches

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | first_player  | int     |
-- | second_player | int     | 
-- | first_score   | int     |
-- | second_score  | int     |
-- +---------------+---------+
-- match_id is the primary key of this table.
-- Each row is a record of a match, first_player and second_player contain the player_id of each match.
-- first_score and second_score contain the number of points of the first_player and second_player respectively.
-- You may assume that, in each match, players belongs to the same group.
 

-- The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, 
-- the lowest player_id wins.

-- Write an SQL query to find the winner in each group.

-- The query result format is in the following example:

-- Players table:
-- +-----------+------------+
-- | player_id | group_id   |
-- +-----------+------------+
-- | 15        | 1          |
-- | 25        | 1          |
-- | 30        | 1          |
-- | 45        | 1          |
-- | 10        | 2          |
-- | 35        | 2          |
-- | 50        | 2          |
-- | 20        | 3          |
-- | 40        | 3          |
-- +-----------+------------+

-- Matches table:
-- +------------+--------------+---------------+-------------+--------------+
-- | match_id   | first_player | second_player | first_score | second_score |
-- +------------+--------------+---------------+-------------+--------------+
-- | 1          | 15           | 45            | 3           | 0            |
-- | 2          | 30           | 25            | 1           | 2            |
-- | 3          | 30           | 15            | 2           | 0            |
-- | 4          | 40           | 20            | 5           | 2            |
-- | 5          | 35           | 50            | 1           | 1            |
-- +------------+--------------+---------------+-------------+--------------+

-- Result table:
-- +-----------+------------+
-- | group_id  | player_id  |
-- +-----------+------------+ 
-- | 1         | 15         |
-- | 2         | 35         |
-- | 3         | 40         |
-- +-----------+------------+

create table Players (
 player_id    int   ,
 group_id     int   
);

Create table Matches(

match_id       int,
first_player   int,
second_player  int, 
first_score    int,
second_score   int
);

select Winner_player_ID,rank() over(partition by group_id order by Winner_player_score desc) as rnk,group_id
from(
select Winner_player_ID,group_id,Winner_player_score from
(
select case when first_score>second_score then first_player else second_player end as Winner_player_ID,
     case when first_score>second_score then first_score else second_score end as Winner_player_score
from Matches
) as Matches
inner join Players
on Matches.Winner_player_ID=Players.player_id
    ) as T
    qualify rnk=1;
