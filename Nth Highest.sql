Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

# 題目要求建立一個 function 供使用者輸入 N，query 結果便會回傳第 N 高的薪水
# 如果沒有第 N 高的薪水，則回傳 NULL

# 我第一時間想到的解法是用 window function 作排序，之後取出 rank = N 的值

CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        /* Write your T-SQL query statement below. */
        SELECT(
                SELECT DISTINCT salary
                FROM(
                     SELECT id, salary, DENSE_RANK() OVER(ORDER BY salary DESC) AS rank
                     FROM Employee) t
                     WHERE rank = @N) getNthHighestSalary # 再下一個 select，當 WHERE 結果回傳 row = 0 時，便可以將最終結果呈現為 NULL
                                                          # 可以不用包這層，大概是因為寫 function 的原因，所以回傳 0 row 就會自動變 NULL 了
    );
END


# 網友的解法更精妙，先把薪水作 DISTINCT，排序薪水後直接抓第 N 的結果回傳就好，MSSQL 的做法可以用 LIMIT 搭配 OFFSET(略過多少回傳rows)

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE M INT;
SET M=N-1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT DISTINCT Salary
      FROM Employee 
      ORDER BY Salary DESC 
      LIMIT M, 1 # 各家版本不同，這裡 MySQL 直接逗號後面就可以接 offset 參數
  );
END

