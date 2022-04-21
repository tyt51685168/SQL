# 目標是從 employee 表中，找出薪水大於部門平均薪水的員工
# 第一時間的想法是先做一張表得出部門的平均薪水 -> join 回原表再做篩選，這一部我用 windows function 達成


SELECT employee_id
FROM (SELECT employee_id, department,salary, salary > AVG(salary) OVER(partition by department) AS aaa
FROM employees) a
WHERE aaa = true


# 使用 Correlation subquery 的話就可以直接跟同部門的人比較薪水


SELECT employee_id
FROM employees e1
WHERE salary > (SELECT ROUND(AVG(salary))
				FROM employees e2 WHERE e1.department = e2.department) # correlation subquery，指定 where e1.department = e2.department
                                                               # 表示子查詢的 ROUND(AVG(salary)) 結果會分部門計算，主查詢的 salary > subquery salary 則也是依據部門比較
