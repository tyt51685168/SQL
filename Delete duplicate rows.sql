/*
Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. Note that you are supposed to write a DELETE statement and not a SELECT one.

Return the result table in any order.

The query result format is in the following example.
*/

-- My Solution (2261 ms)

DELETE FROM Person WHERE id NOT IN
(SELECT maxID FROM(
    SELECT MIN(id) as maxID
    FROM Person
    GROUP BY email) as t)
    
-- other solutions (over partition by 589 ms)

DELETE FROM PERSON
WHERE id not in
(
select id
from(
SELECT id,email,
RANK() OVER( PARTITION BY email ORDER BY id) as "rank"
from person
) a
where a.rank=1)
