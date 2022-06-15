-- postgresql 14

/*
table schema 如下
cookies: cookie的唯一識別碼
session_id: session的識別碼，非唯一值
url: 瀏覽的網頁
created_at: 網頁瀏覽發生時間

目的是透過此表算出所有 url 的 bounce rate

bounce rate 公式為：該工作階段只有那一個網頁的數量 (意即點完網頁就跳出的事件，沒有後續瀏覽其他網頁) / landing page 為該網頁的數量

思路為分別計算分子與分母
1. 分母：所有 landing page count
2. 分子：該工作階段只有一個網頁的所有 landing page count

第一個 cte 要能夠協助辨識哪一個是 landing page & 該工作階段共瀏覽幾個網頁
*/

-- cte_1: 將原表新增兩個欄位
-- 1. rk: 透過 window function 以 cookies & session_id 分組，以 created_at 升冪排序後給 row_number，這樣 rk = 1 的就是 landing page
-- 2. cnt: 透過 window function 以 cookies & session_id 分組，計算每個組內的總數量，後續就知道該工作階段是不是只有 1 個頁面瀏覽

with cte_1 as(
select *,
		row_number() over(partition by cookies, session_id order by created_at asc) as rk ,
		count(*) over(partition by cookies, session_id) as cnt
from website),

-- 第二個 cte 計算分子，以 url 分組，當 rk = 1 and cnt = 1 時，我們給他值 1 並加總，代表此次事件為 bounce

bounce_count as(
select url, SUM(CASE 
					WHEN rk = 1 AND cnt = 1 THEN 1
					ELSE 0
				END) as bounce_count
from cte_1
group by url),

-- 第三個 cte 計算分母，以 url 分組，僅計算 rk = 1，langing page 的數量

landing_page_count as(
select url, count(*) as landing_page_count
from cte_1
where rk = 1
group by url)

-- main query: 計算 bounce rate
-- 以主表 bounce_count left join landing_page_count
-- 因為 landing_page_count 有做過 filter where rk = 1，所以 url 非完整

select a.url, COALESCE(a.bounce_count / b.landing_page_count :: float, -1)   /* -1 means no landing page exists */
from bounce_count a
left join landing_page_count b
on a.url = b.url
