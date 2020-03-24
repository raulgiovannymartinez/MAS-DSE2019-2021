
-- new Queries 

-- 1. Total sales for each customer
select c.customer_id, c.first_name, c.last_name, coalesce(sum(s.quantity),0) 
    as "quantity sold", coalesce(sum(s.price_paid), cast(0 as decimal(36,2))) as "dollar value"
from customers c
left join sales s
on s.customer_id = c.customer_id
group by c.customer_id
order by "dollar value" desc
;

-- 2. Total sales for each state
select st.state_id, st.name as "state name", coalesce(sum(s.quantity), 0) 
    as "quantity sold", coalesce(sum(s.price_paid), cast(0 as decimal(36,2))) as "dollar value"
from sales s
join customers c
on s.customer_id = c.customer_id
right join states st
on c.state_id = st.state_id
group by st.name, st.state_id
order by "dollar value" desc
;

-- 3. Total sales for each product for a given customer
select c.customer_id, c.first_name, c.last_name, p.name as "product name", 
    sum(s.quantity) as "quantity sold", sum(s.price_paid) as "dollar value"
from sales s
join customers c
on s.customer_id = c.customer_id
join products p
on s.product_id = p.product_id 
-- Define customer and exclude zero entries for qty and price 
where (c.customer_id = 25) and (s.quantity != 0) and (s.price_paid != 0) 
group by p.name, c.customer_id
order by "dollar value" desc
;
 
-- 4. Total sales for each product and customer
select c.customer_id, c.first_name, c.last_name, p.product_id, p.name 
    as "product name", coalesce(sum(s.quantity),0) as "quantity sold", 
    coalesce(sum(s.price_paid), cast(0 as decimal(36,2))) as "dollar value"
from products p
cross join customers c
left join sales s
on (s.product_id = p.product_id) and (c.customer_id = s.customer_id)
group by p.product_id, c.customer_id
order by "dollar value" desc
;

-- 5. Total sales for each product category and state
select cat.category_id, cat.name as "category name", st.state_id, st.name 
    as "state name", coalesce(sum(s.quantity),0) as "quantity sold", 
    coalesce(sum(s.price_paid), cast(0 as decimal(36,2))) as "dollar value"
from categories cat
cross join states st
left join products p
on p.category_id = cat.category_id
left join customers c
on st.state_id = c.state_id
left join sales s
on (s.product_id = p.product_id) and (c.customer_id = s.customer_id)
group by cat.category_id, st.state_id
order by "dollar value" desc
;


-- 6. Tuples for each of the top 20 product categories and top 20 customers
select t5.category_id, t5.name as "top category", t5.customer_id, t5.first_name 
    as "top customer first name", t5.last_name as "top customer last name", 
    coalesce(sum(s.quantity),0) as "quantity sold", coalesce(sum(s.price_paid),0) as "dollar value"
from sales s
join products p
on s.product_id = p.product_id
join categories cat
on cat.category_id = p.category_id
right join (
    select * from (
        -- select top 20 for categories
        select *
        from (
            select cat.category_id, cat.name, dense_rank() over(order by sum(s.price_paid) desc) as rn
            from sales s
            join products p
            on s.product_id = p.product_id
            join categories cat
            on cat.category_id = p.category_id
            group by cat.category_id, cat.name
            ) as t1
            where rn <= 20
            ) as t2
            cross join ( -- find all possible combinations ~400 with cross join
            -- select top 20 for customers
            select *
            from (
            select c.customer_id, c.first_name, c.last_name, dense_rank() over(order by sum(s.price_paid) desc) as rn
            from sales s    
            join customers c
            on s.customer_id = c.customer_id   
            group by c.customer_id
            ) as t3
            where rn <= 20
            ) as t4
        ) as t5
-- join on categories and customers only
on cat.category_id = t5.category_id and s.customer_id = t5.customer_id
group by t5.category_id, t5.name, t5.customer_id, t5.first_name, t5.last_name
order by "dollar value" desc
;









