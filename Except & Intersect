# Except 用法為差集，找出左表有但是右表不存在的值回傳結果
# MSSQL 才有 Except，Oracle 為 MINUS

# 此 query 意思即為，回傳僅出現在 employee 表中但沒出現在 departments 表中的 department
SELECT distinct department
FROM employees

EXCEPT

SELECT department
FROM departments


# Intersect 用法為交集，找出左右表都有的值回傳結果

# 此 query 意思即為，回傳同時出現在 employee 表中與 departments 表中的 department
SELECT department
FROM employees

INTERSECT

SELECT department
FROM departments
