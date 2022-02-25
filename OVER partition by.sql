/*
Table: Courses

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key column for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.
 

Write an SQL query to report all the classes that have at least five students.

Return the result table in any order.

The query result format is in the following example.
*/

-- 這是一道很基本的 SQL 題目，直覺想到的做法一定是分組計算後用 sub query 的結果回傳給主查詢的 WHERE 當條件式使用
-- 1. 分組計算每種 class 在此表的出現次數，形成一個 sub query
-- 2. 主查詢 WHERE 篩選次數超過 5 次的 class

-- 當然這類基本的 GROUP BY 查詢都可以用 HAVING 直接在最後篩選出那些出現次數超過 5 次的 class
-- 1. GROUP BY class, 分組完畢
-- 2. HAVING 這邊要接著做篩選與計算
-- 3. WHERE 跟 HAVING 的差別在於使用時機，WHERE 子句無法接在 GROUP BY 後面但 HAVING 可以

-- My Solution (Window function Over Partition by)
-- 這種做法也要做子查詢，多練習 window function 在未來有需要生成組查詢結果作為新欄位的時候，就不用一直產 sub query 再 join 了

SELECT class
FROM(
SELECT class, RANK() OVER(partition by class ORDER BY student) as rank
FROM Courses) a
WHERE rank = 5


-- GROUP BY 接 HAVING 的寫法

SELECT class
FROM Courses
GROUP BY class
HAVING count(class) >= 5

