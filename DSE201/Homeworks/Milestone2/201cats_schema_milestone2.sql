-- Create tables for 201Cats
CREATE TABLE users (
    user_id         SERIAL PRIMARY KEY NOT NULL,
    first_name      character varying(50) NOT NULL,
    last_name       character varying(50) NOT NULL,
    username        character varying(50) NOT NULL,
    fb_login        character varying(50) NOT NULL
);
CREATE TABLE sessions (
    session_id      SERIAL PRIMARY KEY NOT NULL,
    created_on      TIMESTAMP NOT NULL,
    user_id         INTEGER REFERENCES users (user_id) NOT NULL
);
CREATE TABLE videos (
    video_id        SERIAL PRIMARY KEY NOT NULL,
    name            character varying(50) NOT NULL,
    description     TEXT
);
CREATE TABLE friends (
    user_id         INTEGER REFERENCES users (user_id) NOT NULL,
    friend_id       INTEGER REFERENCES users (user_id) NOT NULL
);
CREATE TABLE suggestions (
    suggestion_id   SERIAL PRIMARY KEY NOT NULL,
    session_id      INTEGER REFERENCES sessions (session_id) NOT NULL,
    video_id        INTEGER REFERENCES videos (video_id) NOT NULL
);
CREATE TABLE likes (
    like_id         SERIAL PRIMARY KEY NOT NULL,
    created_on      TIMESTAMP NOT NULL,
    video_id        INTEGER REFERENCES videos (video_id) NOT NULL,
    user_id         INTEGER REFERENCES users (user_id) NOT NULL,
    CONSTRAINT like_once UNIQUE(user_id,video_id)
);
CREATE TABLE watched (
    watch_id         SERIAL PRIMARY KEY NOT NULL,
    created_on       TIMESTAMP NOT NULL,
    end_time         TIMESTAMP NOT NULL,
    video_id         INTEGER REFERENCES videos (video_id) NOT NULL,
    session_id       INTEGER REFERENCES sessions (session_id) NOT NULL
);


-- users
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (1, 'John', 'Cena', 'JCena', 'J_Cena_Youcantseeme');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (2, 'El', 'Batista', 'EBats', 'El_Batista_Powerful');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (3, 'Elma', 'Canon', 'Ecanon', 'ECnis');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (4, 'Alex', 'FromTarget', 'Atarget', 'Alex_handsome');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (5, 'Elmo', 'DeepLearning', 'Deepelmo', 'Elmo_DeepLearn');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (6, 'Sebastian', 'Yatra', 'SYat', 'Sebas123');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (7, 'King', 'Triton', 'KTriton', 'El_King_T');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (8, 'Lauren', 'Canette', 'LCann', 'L_999');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (9, 'Raul', 'Martinez', 'RMar', 'Raul_C');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (10, 'El', 'Stitch', 'StitchDisney', 'Stitch_567_monster');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (11, 'Danny', 'Sieb', 'D', 'chair');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (12, 'Elja', 'Cotija', '12343PLE', 'Thelala');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (13, 'Mario', 'Sanchez', 'MSanche', 'ElPatron');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (14, 'Hermano', 'Merjo', 'Paraguay', 'Laursula');
INSERT INTO users (user_id, first_name, last_name, username, fb_login) VALUES (15, 'Hermana', 'Perjo', 'Ecuador', 'jajajajapapa');

-- videos
INSERT INTO videos (video_id, name, description) VALUES (1, 'The 400 Blows', 'A young boy, left without attention, delves into a life of petty crime.');
INSERT INTO videos (video_id, name, description) VALUES (2, 'La Haine', '24 hours in the lives of three young men in the French suburbs the day after a violent riot.');
INSERT INTO videos (video_id, name, description) VALUES (3, 'The Godfather', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.');
INSERT INTO videos (video_id, name, description) VALUES (4, 'The Godfather: Part II', 'The early life and career of Vito Corleone in 1920s New York City is portrayed, while his son, Michael, expands and tightens his grip on the family crime syndicate.');
INSERT INTO videos (video_id, name, description) VALUES (5, 'Man Bites Dog', 'A film crew follows a ruthless thief and heartless killer as he goes about his daily routine. But complications set in when the film crew lose their objectivity and begin lending a hand.');
INSERT INTO videos (video_id, name, description) VALUES (6, 'The Departed', 'An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.');
INSERT INTO videos (video_id, name, description) VALUES (7, 'Umberto D.', 'An elderly man and his dog struggle to survive on his government pension in Rome.');
INSERT INTO videos (video_id, name, description) VALUES (8, 'White Heat', 'A psychopathic criminal with a mother complex makes a daring break from prison and leads his old gang in a chemical plant payroll heist.');
INSERT INTO videos (video_id, name, description) VALUES (9, 'Eddie Murphy: Raw', 'Eddie Murphy in a stand-up performance recorded live. For an hour and a half he talks about his favourite subjects: sex and women.');
INSERT INTO videos (video_id, name, description) VALUES (10, 'Jack', 'a');
INSERT INTO videos (video_id, name, description) VALUES (11, 'Parasite', 'b');
INSERT INTO videos (video_id, name, description) VALUES (12, 'Mickey', 'c');
INSERT INTO videos (video_id, name, description) VALUES (13, 'Cenicienta', 's');
INSERT INTO videos (video_id, name, description) VALUES (14, 'Mario lopez', 'd');
INSERT INTO videos (video_id, name, description) VALUES (15, 'Mario Bros The movie', 'e');

-- likes
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (1, '2019-07-21 07:15:10', 15, 3);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (2, '2016-09-18 10:07:53', 9, 6);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (3, '2012-05-27 20:19:51', 8, 4);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (4, '2012-06-26 10:31:17', 2, 11);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (5, '2015-05-09 16:59:44', 6, 10);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (6, '2013-08-24 12:40:21', 13, 5);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (7, '2019-08-05 07:16:16', 11, 3);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (8, '2011-06-24 21:31:55', 15, 1);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (9, '2013-11-30 14:02:39', 5, 12);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (10, '2016-11-17 16:16:06', 1, 2);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (11, '2013-05-24 18:52:22', 2, 6);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (12, '2012-06-24 17:13:16', 4, 9);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (13, '2018-12-01 04:36:44', 3, 10);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (14, '2014-09-10 06:30:55', 2, 7);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (15, '2010-03-27 22:45:04', 8, 10);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (16, '2017-04-27 21:46:13', 10, 11);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (17, '2018-05-25 02:05:46', 14, 8);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (18, '2014-09-07 08:22:34', 7, 6);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (19, '2010-04-09 05:35:11', 15, 7);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (20, '2016-06-19 22:49:56', 15, 9);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (21, '2016-01-04 13:33:27', 13, 12);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (22, '2020-12-01 01:37:07', 3, 13);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (23, '2013-02-10 12:55:33', 4, 4);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (24, '2011-06-05 00:10:28', 14, 1);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (25, '2018-08-07 20:47:22', 6, 12);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (26, '2014-08-19 16:25:00', 12, 10);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (27, '2014-11-23 16:45:52', 10, 7);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (28, '2016-02-20 08:50:20', 10, 1);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (29, '2017-09-24 05:34:21', 15, 6);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (30, '2016-01-30 03:35:09', 15, 8);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (31, '2020-03-23 17:03:40', 9, 10);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (32, '2019-05-31 01:42:04', 2, 13);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (33, '2016-03-16 16:06:46', 3, 9);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (34, '2012-08-07 23:26:43', 10, 2);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (35, '2012-10-07 01:53:01', 7, 15);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (36, '2017-04-21 04:33:23', 14, 15);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (37, '2012-01-12 03:38:16', 10, 13);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (38, '2017-04-08 06:53:08', 5, 6);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (39, '2012-10-05 15:19:00', 1, 13);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (40, '2011-04-27 16:11:56', 7, 11);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (41, '2014-04-21 23:50:24', 10, 10);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (42, '2015-05-16 16:21:13', 15, 4);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (43, '2016-04-18 13:31:59', 1, 3);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (44, '2010-11-28 21:19:53', 5, 13);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (45, '2010-09-02 13:46:14', 9, 9);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (46, '2010-05-09 00:46:44', 8, 1);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (47, '2020-07-20 11:05:19', 4, 12);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (48, '2012-08-27 04:59:53', 14, 10);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (49, '2013-01-27 01:56:25', 3, 4);
INSERT INTO likes (like_id, created_on, video_id, user_id) VALUES (50, '2017-07-23 03:56:24', 5, 9);

-- friends
INSERT INTO friends (user_id, friend_id) VALUES (10, 11);
INSERT INTO friends (user_id, friend_id) VALUES (13, 4);
INSERT INTO friends (user_id, friend_id) VALUES (15, 1);
INSERT INTO friends (user_id, friend_id) VALUES (1, 15);
INSERT INTO friends (user_id, friend_id) VALUES (4, 12);
INSERT INTO friends (user_id, friend_id) VALUES (15, 8);
INSERT INTO friends (user_id, friend_id) VALUES (9, 4);
INSERT INTO friends (user_id, friend_id) VALUES (5, 1);
INSERT INTO friends (user_id, friend_id) VALUES (15, 12);
INSERT INTO friends (user_id, friend_id) VALUES (13, 12);
INSERT INTO friends (user_id, friend_id) VALUES (7, 15);
INSERT INTO friends (user_id, friend_id) VALUES (2, 9);
INSERT INTO friends (user_id, friend_id) VALUES (9, 15);
INSERT INTO friends (user_id, friend_id) VALUES (10, 7);
INSERT INTO friends (user_id, friend_id) VALUES (14, 5);
INSERT INTO friends (user_id, friend_id) VALUES (3, 10);
INSERT INTO friends (user_id, friend_id) VALUES (1, 14);
INSERT INTO friends (user_id, friend_id) VALUES (14, 1);
INSERT INTO friends (user_id, friend_id) VALUES (3, 6);
INSERT INTO friends (user_id, friend_id) VALUES (6, 15);
INSERT INTO friends (user_id, friend_id) VALUES (3, 13);
INSERT INTO friends (user_id, friend_id) VALUES (8, 11);
INSERT INTO friends (user_id, friend_id) VALUES (11, 9);
INSERT INTO friends (user_id, friend_id) VALUES (9, 3);
INSERT INTO friends (user_id, friend_id) VALUES (7, 5);
INSERT INTO friends (user_id, friend_id) VALUES (8, 7);
INSERT INTO friends (user_id, friend_id) VALUES (6, 12);
INSERT INTO friends (user_id, friend_id) VALUES (9, 6);
INSERT INTO friends (user_id, friend_id) VALUES (3, 5);
INSERT INTO friends (user_id, friend_id) VALUES (7, 9);
INSERT INTO friends (user_id, friend_id) VALUES (13, 1);
INSERT INTO friends (user_id, friend_id) VALUES (8, 3);
INSERT INTO friends (user_id, friend_id) VALUES (9, 13);
INSERT INTO friends (user_id, friend_id) VALUES (15, 2);
INSERT INTO friends (user_id, friend_id) VALUES (11, 8);
INSERT INTO friends (user_id, friend_id) VALUES (9, 2);
INSERT INTO friends (user_id, friend_id) VALUES (4, 15);
INSERT INTO friends (user_id, friend_id) VALUES (3, 1);
INSERT INTO friends (user_id, friend_id) VALUES (2, 11);
INSERT INTO friends (user_id, friend_id) VALUES (7, 4);
INSERT INTO friends (user_id, friend_id) VALUES (14, 12);
INSERT INTO friends (user_id, friend_id) VALUES (1, 8);
INSERT INTO friends (user_id, friend_id) VALUES (10, 14);
INSERT INTO friends (user_id, friend_id) VALUES (3, 8);
INSERT INTO friends (user_id, friend_id) VALUES (5, 14);
INSERT INTO friends (user_id, friend_id) VALUES (1, 7);
INSERT INTO friends (user_id, friend_id) VALUES (11, 15);
INSERT INTO friends (user_id, friend_id) VALUES (5, 2);
INSERT INTO friends (user_id, friend_id) VALUES (11, 6);
INSERT INTO friends (user_id, friend_id) VALUES (12, 8);


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






































