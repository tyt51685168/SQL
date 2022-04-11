Table Activities:

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| sell_date   | date    |
| product     | varchar |
+-------------+---------+
There is no primary key for this table, it may contain duplicates.
Each row of this table contains the product name and the date it was sold in a market.
 

Write an SQL query to find for each date the number of different products sold and their names.

The sold products names for each date should be sorted lexicographically.

Return the result table ordered by sell_date.

# 題目很簡單，分天 group by 並將該天銷售的產品種類 (不重複) 產生兩個新欄位：銷售種類數量 & 所有銷售種類的字串合併
# MSSQL 這裡需要用 STRING_AGG 將 grouping 的字串接起來，但原題目要求字串要照字典順序排列，所以需要想怎麼在 grouping 的過程中針對特定欄位做排序
# 這裡介紹一個慣用接在 STRING_AGG 後面的寫法 WITHIN GROUP (ORDER BY column)，完整範例如下

SELECT sell_date, COUNT(DISTINCT product) AS num_sold, STRING_AGG(product, ',') WITHIN GROUP(ORDER BY product) AS products
FROM 
    (SELECT DISTINCT sell_date,  product
    FROM Activities) a                    # sub-query 要先用 DISTINCT 過濾產品類型
GROUP BY sell_date
