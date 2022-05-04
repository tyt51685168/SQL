Leetcode 601. Human Traffic of Stadium

Table: Stadium

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the primary key for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
No two rows will have the same visit_date, and as the id increases, the dates increase as well.
 

Write an SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

# Return the result table ordered by visit_date in ascending order.

Input: 
Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
Output: 
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+

# 題目要求找出連續三天以上參訪人數超過 100 人的日期，要把這連續的日期資料都留下
# 我一開始的解法跟 Leetcode 提供的 Solution 一樣，參考 "Consecutive Numbers.sql" 的思路
# 先 self join 後進行 row 跟 row 之間的連續比較

SELECT DISTINCT a.id, a.visit_date, a.people
FROM Stadium a, Stadium b, Stadium c
WHERE a.people >= 100 AND
      b.people >= 100 AND
      c.people >= 100 AND
      ((c.id - a.id = 2 AND b.id - a.id = 1) OR 
       (a.id - b.id = 1 AND c.id - a.id = 1) OR 
       (a.id - b.id = 1 AND a.id - c.id = 2))
ORDER BY a.visit_date


!!!! 這裡我們學習一個新的做法，如何將連續的 ID 值分為同一組，透過 window function 的方式實現 !!!!

WITH t AS(
SELECT t1.id , t1.visit_date , t1.people , 
            id - ROW_NUMBER() OVER(ORDER BY id) AS grp    # 在排除小於 100 人的日期後，這個 CTE 巧妙的使用 id - 重新給予的 row_number 達到連續的日期分為一組的功能
                                                          # 這個表的最終呈現列在下方示意
       FROM stadium t1
       WHERE people >= 100 )

SELECT t.id, t.visit_date ,t.people
FROM t 
WHERE grp IN ( SELECT grp FROM t GROUP BY grp HAVING COUNT(*) >=3 )


CTE 表結果
+------+------------+-----------+-----+
| id   | visit_date | people    | grp |    !!! 連續的日期竟然被自動分成一組了 !!!
+------+------------+-----------+-----+    !!! 這時候只要確認該組的數量是不是 >= 3，就可以得到是不是連續 3 天以上都有超過 100 人參訪 !!!
| 2    | 2017-01-02 | 109       | 1   |
| 3    | 2017-01-03 | 150       | 1   |
| 5    | 2017-01-05 | 145       | 2   |
| 6    | 2017-01-06 | 1455      | 2   |
| 7    | 2017-01-07 | 199       | 2   |
| 8    | 2017-01-09 | 188       | 2   |
+------+------------+-----------+-----+

ID - row_number 的概念示意
+------+------------+-----+
| id   | row_number | grp |
+------+------------+-----+ 
| 2    | 1          | 1   |
| 3    | 2          | 1   |
| 5    | 3          | 2   |  !!! 這裡可以很容易觀察到，一旦跳號的事情發生，那 id - row_number 的結果就會往上加
| 6    | 4          | 2   |
| 7    | 5          | 2   |
| 8    | 6          | 2   |
+------+------------+-----+
