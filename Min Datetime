Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write an SQL query to report the first login date for each player.

Return the result table in any order.

# MIN function 可以用在 datetime 的資料上，找出最小日期
# 同樣的 MAX function 可以用來找最大日期


SELECT player_id, MIN(event_date) as first_login
FROM Activity
GROUP BY player_id

# 練習一下 window function
WITH temp AS
( SELECT player_id, event_date, row_number() OVER(PARTITION BY player_id ORDER BY event_date ASC) as r
FROM Activity ) 

SELECT player_id, event_date as first_login
FROM temp
WHERE r = 1
