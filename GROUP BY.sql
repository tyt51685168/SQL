Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key of this table.
Each row of this table indicates the name and the price of each product.

Table: Sales

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+-------------+---------+
This table has no primary key, it can have repeated rows.
product_id is a foreign key to the Product table.
Each row of this table contains some information about one sale.
 

Write an SQL query that reports the products that were only sold in the spring of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.

Return the result table in any order.


# 題目要從 Sales Table 中找出該商品"僅在2019年春天"有訂單
# 解題想法就從把訂單 group by 起來開始，該類商品最早不可早於 2019-01-01；最晚不可晚於 2019-03-31

SELECT a.product_id, b.product_name
FROM Sales a
LEFT JOIN Product b
ON a.product_id = b.product_id
GROUP BY a.product_id
HAVING MIN(a.sale_date) >= '2019-01-01' AND 
       MAX(a.sale_date) <= '2019-03-31'

# 題外話是，一開始我還想著要先找出所有在春天的訂單再去跟全年度只有一筆訂單的結果 join，這樣的搜尋結果會跟題意完全不同
