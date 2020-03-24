-- queries

-- Overall Likes
select video_id, "Video Name", "Overall Likes"
from (
    -- select videos with ranked likes
    select l.video_id, v.name as "Video Name", count(l.user_id) 
        as "Overall Likes", dense_rank() over(order by count(l.user_id) desc) as rn
    from likes l
    join videos v
    on l.video_id = v.video_id
    group by l.video_id, v.name
    ) as t
-- filter for top videos
where rn <= 10
;


-- Friend Likes
select video_id, "Video Name", "Overall Likes"
from (
    -- select videos with ranked likes
    select l.video_id, v.name as "Video Name", count(l.user_id) 
        as "Overall Likes", dense_rank() over(order by count(l.user_id) desc) as rn
    from likes l
    join videos v
    on l.video_id = v.video_id
    where user_id in (
        -- select list for friends
        select friend_id 
        from friends
        where user_id = 3 -- specify user X
        )
    group by l.video_id, v.name
) as t
-- filter for top videos
where rn <= 10
;


-- Friends of Friends Likes
select video_id, "Video Name", "Overall Likes"
from (
    -- select videos with ranked likes
    select l.video_id, v.name as "Video Name", count(l.user_id) as "Overall Likes", 
        dense_rank() over(order by count(l.user_id) desc) as rn
    from likes l
    join videos v
    on l.video_id = v.video_id
    where user_id in (
        -- select list for friends
        select friend_id 
        from friends
        where user_id = 3 -- specify user X
        union -- union both lists with user ids
        -- select list for friends of friends
        select friend_id
        from friends
        where user_id in (
            select friend_id 
            from friends
            where user_id = 3 -- specify user X
        )
    )
    group by l.video_id, v.name
) as t
-- filter for top videos
where rn <= 10
;


-- My kind of cats
select video_id, "Video Name", "Overall Likes"
from (
    -- select videos with ranked likes
    select l.video_id, v.name as "Video Name", count(l.user_id) as "Overall Likes", 
        dense_rank() over(order by count(l.user_id) desc) as rn
    from likes l
    join videos v
    on l.video_id = v.video_id
    where user_id in (
        -- select users who have liked at least one cat video liked by X
        select  distinct user_id 
        from likes
        where video_id in (
            -- select videos liked by user X
            select video_id 
            from likes
            where user_id = 3 -- specify user X
            )
        )
        -- exclude videos liked by user X
        and user_id != 3 -- specify user X
    group by l.video_id, v.name
) as t
-- filter for top videos
where rn <= 10
;



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
        ) as t4
    on l.user_id = t4.user_y
    join videos v
    on l.video_id = v.video_id
    group by  l.video_id, v.name
) as t5
-- filter for top videos
where rn <= 10
;
