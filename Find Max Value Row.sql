Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key for this table.
This table contains information about the order ID and the customer ID.
 

Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

# 要找出此表中擁有最多紀錄的 ID 一定要先做 sub-query

# Leetcode 上官方解答有點偷懶的使用 group by 之後排序 count 值，並將搜尋結果 LIMIT 1
# 這樣在一種情況下會出錯，如果擁有最多紀錄的 ID 不只一個呢？

# 所以還是先確保最多筆的資料是幾筆，再拿這個幾筆去做 WHERE 的搜尋條件比較妥當
# 我一樣練習先把 sub-query 用 with 建出 temp table

WITH MAX_VALUE AS
(SELECT COUNT(order_number) cnt
FROM orders
GROUP BY customer_number
ORDER BY cnt DESC
LIMIT 1)

SELECT customer_number
FROM orders
GROUP BY customer_number
HAVING COUNT(order_number) = (
    SELECT cnt
    FROM MAX_VALUE)
