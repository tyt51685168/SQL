Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.
id is an autoincrement column.
 

Write an SQL query to find all numbers that appear at least three times consecutively.

Return the result table in any order.

# 找出連續三個 id 的 num 為相同值的結果
# 用 cartesian product 重複 inner join 自己三次即可開始比對

SELECT DISTINCT a.num AS ConsecutiveNums 
FROM Logs a, Logs b, Logs c
WHERE
b.id - a.id = 1 AND
c.id - b.id = 1 AND
a.num = b.num AND
b.num = c.num

# Cartesian product 解題的思路通常用在 row 跟 row 之間要做比較
