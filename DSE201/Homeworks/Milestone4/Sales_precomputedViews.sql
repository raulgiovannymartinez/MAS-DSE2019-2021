
-- joing tables for sales, products, and categories
CREATE TABLE sales_customerandcategories AS
    select s.price_paid, s.customer_id, cat.category_id, s.quantity
    from sales s
    join products p
    on s.product_id = p.product_id
    join categories cat
    on cat.category_id = p.category_id
;

-- select top 20 for categories
CREATE TABLE top20_categories AS
    select *
    from (
        select cat.category_id, cat.name, dense_rank() over(order by sum(s.price_paid) desc) as rn
        from sales s
        join products p
        on s.product_id = p.product_id
        join categories cat
        on cat.category_id = p.category_id
        group by cat.category_id, cat.name
    ) as temp_t
    where rn <= 20
;

-- select top 20 for customers
CREATE TABLE top20_customers AS
    select *
    from (
        select c.customer_id, c.first_name, c.last_name, dense_rank() over(order by sum(s.price_paid) desc) as rn
        from sales s    
        join customers c
        on s.customer_id = c.customer_id
        group by c.customer_id
    ) as temp_t
    where rn <= 20
;


-- Sales: New Query with Precomputed Tables
-- 6. Tuples for each of the top 20 product categories and top 20 customers
select t5.category_id, t5.name as "top category", t5.customer_id, t5.first_name 
    as "top customer first name", t5.last_name as "top customer last name", 
    coalesce(sum(s_cc.quantity),0) as "quantity sold", coalesce(sum(s_cc.price_paid),0) as "dollar value"
from sales_customerandcategories s_cc -- use precomputed table
right join (
    select * 
    from top20_categories -- use precomputed table
    cross join top20_customers -- use precomputed table
) as t5
-- join on categories and customers only
on s_cc.category_id = t5.category_id and s_cc.customer_id = t5.customer_id
group by t5.category_id, t5.name, t5.customer_id, t5.first_name, t5.last_name
order by "dollar value" desc
;