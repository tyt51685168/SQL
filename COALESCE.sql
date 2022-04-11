Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
| salary      | int     |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the employee ID, employee name, and salary.
 

Write an SQL query to calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee name does not start with the character 'M'. The bonus of an employee is 0 otherwise.

Return the result table ordered by employee_id.

# COALESCE 的用法是回傳傳入參數中第一個非 NULL 值，經常用在當 NULL 發生時該取代為什麼值
# 本題我的解法是先抓出要給 bonus 的人，並產生 sub-query table
# 用原表 left join sub-query 結果後可以得到新的 bonus 欄位，join 不出結果的人就是不發 bonus，透過 COALESCE 語法將 NULL 值改為 0


SELECT a.employee_id, COALESCE(b.bonus, 0) AS bonus
FROM Employees a
LEFT JOIN(                                              # sub-query 抓出 employee_id 為奇數且姓名開頭不為 M 的員工，將他的 bonus 欄位等於 salary
    SELECT employee_id, salary AS bonus
    FROM Employees
    WHERE employee_id %2 = 1 AND
          name NOT LIKE 'M%') b
ON a.employee_id = b.employee_id
ORDER BY a.employee_id
