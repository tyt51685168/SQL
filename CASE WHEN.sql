/*
Table: Salary

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| name        | varchar  |
| sex         | ENUM     |
| salary      | int      |
+-------------+----------+
id is the primary key for this table.
The sex column is ENUM value of type ('m', 'f').
The table contains information about an employee.
 

Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temporary tables.

Note that you must write a single update statement, do not write any select statement for this problem.

The query result format is in the following example.
*/

-- case when 為一般程式語言都有的 switch case 概念，當 ... 符合條件時則執行 ... 的事情

-- My Solution

UPDATE salary
SET sex =
    CASE sex 
        when 'f' then 'm' 
        when 'm' then 'f' 
    END
    
-- case when 也有在一般查詢時，把資料內容做處理的功能，範例如下

select Name, case Answer
  when 1 then '喜歡'
  when 2 then '不喜歡'
  when 3 then '還OK'
END
FROM questionnaire

-- 以下這種寫法也可以

select Name, case
  when Answer=1 then '喜歡'
  when Answer=2 then '不喜歡'
  when Answer=3 then '還OK'
END
AS Answer
FROM questionnaire;
