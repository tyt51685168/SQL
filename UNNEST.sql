/* UNNEST function 將字串依照特定分隔符號拆解，並將原資料依照拆解的結果分成 n 個 row */

/* 
Question:
      Find the top business categories based on the total number of reviews. 
      Output the category along with the total number of reviews. 
      Order by total reviews in descending order.
*/

/*
原資料集的 categories 為多個標籤以分號分隔串在一起的字串，計算每個 category 的 review count 之前需先將原資料拆解

題目來源：https://platform.stratascratch.com/coding/10049-reviews-of-categories?code_type=1
*/

-- Solution

WITH cte AS(
SELECT UNNEST(STRING_TO_ARRAY(categories, ';')) AS category, review_count
FROM yelp_business)

SELECT category, SUM(review_count) AS review_cnt
FROM cte
GROUP BY category
ORDER BY review_cnt DESC
