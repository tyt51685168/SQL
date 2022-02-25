/*
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
 

Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The query result format is in the following example.
*/


SELECT a.id
FROM Weather a, Weather b
WHERE DATEDIFF(day, b.recordDate, a.recordDate) = 1  -- Be careful about the cartesian product output, otherwise, use join instead or sorting first.
AND a.temperature > b.temperature
