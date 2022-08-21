題目敘述：
當一個人第一天進行 in-app 購買時，從購買後的第二天開始就會對他們投放行銷廣告。
此題目的在計算行銷廣告的成功人數 (率)，意即有多次不同天的購買行為，且買不同種類的商品

注意事項：
1. 由於購買行為出現後的第二天開始才會投放廣告，所以當天若出現多筆購買皆不算成功人次
2. 被投放廣告的對象若重複購買第一天就買過那些商品，也不列入廣告投放成功人次

table: marketing_campaign
   user_id: int
   created_at: datetime
   product_id: int
   quantity: int    
   price: int


My solution:

-- 第一步先做 cte，新增兩個欄位
-- first_pur_dt: 這個 user 第一次購買商品的日期
-- first_pro_dt: 這個 product 第一次被購買的日期

-- 最後我們只要找出一種特徵的資料就可以符合題意：商品第一次被購買的日期與 user 第一次買商品的日期不同
-- 代表這個 user 被廣告投放打到成為回流客，且買了與第一次購物不同的商品

WITH cte AS
(
SELECT user_id, created_at, product_id, 
        MIN(created_at) OVER(PARTITION BY user_id) AS first_pur_dt,
        MIN(created_at) OVER(PARTITION BY user_id, product_id) AS first_pro_dt
FROM marketing_campaign
)


SELECT COUNT(DISTINCT user_id)
FROM cte
WHERE first_pur_dt <> first_pro_dt
