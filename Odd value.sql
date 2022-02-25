/*
Table: Cinema

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
 

Write an SQL query to report the movies with an odd-numbered ID and a description that is not "boring".

Return the result table ordered by rating in descending order.

The query result format is in the following example.
*/

-- 當想要找奇數列的時候，通常會用取餘數 = 1 的做法，取餘數 = 0 則為偶數列
-- 用 mod() 函數的 performance 比 %2 計算還來得快
-- My Solution

SELECT *
FROM Cinema
WHERE id %2 = 1
AND description NOT Like 'boring' -- 照原題目說明寫 <> 或 != 即可
ORDER BY rating desc
