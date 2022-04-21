# UNION 為取聯集，取聯集時系統會自動排除重複的值

SELECT distinct department
FROM employees

UNION

SELECT department
FROM departments

# 如果要保留重複的值，則使用 UNION ALL

SELECT distinct department
FROM employees

UNION ALL

SELECT department
FROM departments
