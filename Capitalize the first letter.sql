Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 

Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.

# 題目為把字串第一個字母改為大寫其餘為小寫
# 邏輯是將字串拆分為第一個跟剩下其他字元，將第一個字元用 UPPER function 改為大寫，剩下其他字元則用 LOWER 改為小寫
# 使用 SUBSTRING 配上 LEN 即可從第二個字元開始取到最後一個字元

SELECT user_id, 
       UPPER(LEFT(name,1)) + LOWER(SUBSTRING(name,2,LEN(name))) AS name # 要用 + 或用 concat 把字串連接都可以
FROM Users
ORDER BY 1
