
-- calculate and select the vector for parameterized user X			
CREATE TABLE calculate_userX AS
	select v.video_id, u.user_id, (case when l.like_id is null then 0 else 1 end) as liked
    from videos v
    cross join users u
    left join likes l
    on u.user_id = l.user_id and  v.video_id = l.video_id
    where u.user_id = 3 -- specify user X
;

-- calculate and select the vector for all users Y
CREATE TABLE calculate_userY AS
	select v.video_id, u.user_id, (case when l.like_id is null then 0 else 1 end) as liked
	from videos v
	cross join users u
	left join likes l
	on u.user_id = l.user_id and  v.video_id = l.video_id
	where u.user_id != 3 -- exclude user X
;


-- Cats: New Query with Precomputed Tables
-- My kind of cats - with preference
select video_id, "Video Name", "Sum Weighted Likes"
from (
    -- selectect videos with ranked log cosine
    select l.video_id, v.name as "Video Name", cast(sum(t4.lc) as decimal(36,4)) as "Sum Weighted Likes", 
        dense_rank() over(order by sum(t4.lc) desc) as rn
    from likes l
    join(
        -- calculate inner product and log cosine
        select user_y, log(sum(product)+1) as lc
        from(
            -- calculate and select multiplication from inner product
            select t1.video_id, t1.user_id as user_x, t2.user_id as user_y, t1.liked as liked_x, t2.liked 
                as liked_y, (t1.liked * t2.liked) as product
            from calculate_userX t1 -- use precomputed table
            left join calculate_userY t2 -- use precomputed table
            on t1.video_id = t2.video_id
            ) as t3
        group by user_y
        ) as t4
    on l.user_id = t4.user_y
    join videos v
    on l.video_id = v.video_id
    group by  l.video_id, v.name
) as t5
-- filter for top videos
where rn <= 10
;


-- calculate the log cosine for user X and all users Y
CREATE TABLE calculate_logcosine AS
    -- calculate inner product and log cosine
    select user_y, log(sum(product)+1) as lc
    from(
        -- calculate and select multiplication from inner product
        select t1.video_id, t1.user_id as user_x, t2.user_id as user_y, t1.liked as liked_x, t2.liked 
            as liked_y, (t1.liked * t2.liked) as product
        from (
            -- calculate and select the vector for parameterized user X
            select v.video_id, u.user_id, (case when l.like_id is null then 0 else 1 end) as liked
            from videos v
            cross join users u
            left join likes l
            on u.user_id = l.user_id and  v.video_id = l.video_id
            where u.user_id = 3 -- specify user X
        ) as t1
        left join (
            -- calculate and select the vector for all users Y
            select v.video_id, u.user_id, (case when l.like_id is null then 0 else 1 end) as liked
            from videos v
            cross join users u
            left join likes l
            on u.user_id = l.user_id and  v.video_id = l.video_id
            where u.user_id != 3 -- exclude user X
            ) as t2
        on t1.video_id = t2.video_id
        ) as t3
    group by user_y
;


-- Cats: New Query with Precomputed Tables
-- My kind of cats - with preference
select video_id, "Video Name", "Sum Weighted Likes"
from (
    -- selectect videos with ranked log cosine
    select l.video_id, v.name as "Video Name", cast(sum(t4.lc) as decimal(36,4)) as "Sum Weighted Likes", 
        dense_rank() over(order by sum(t4.lc) desc) as rn
    from likes l
    join calculate_logcosine t4
    on l.user_id = t4.user_y
    join videos v
    on l.video_id = v.video_id
    group by  l.video_id, v.name
) as t5
-- filter for top videos
where rn <= 10
;