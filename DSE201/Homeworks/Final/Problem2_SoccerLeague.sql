CREATE TABLE Teams (
    name        character varying(50) PRIMARY KEY NOT NULL,
    coach       character varying(50) NOT NULL
);
CREATE TABLE Matches (
    hTeam       character varying(50) REFERENCES Teams (name) NOT NULL,
    vteam       character varying(50) REFERENCES Teams (name) NOT NULL,
    hScore      INTEGER NOT NULL,
    vScore      INTEGER NOT NULL,
    CONSTRAINT hTeam_vTeam_pk PRIMARY KEY (hTeam, vteam)
);



-- count number of wins for specified team
select count(*) as wins
from Matches
-- find wins as a home or visitor team
where (hTeam = 'San Diego Sockers' and hScore > vScore) 
    or (vTeam = 'San Diego Sockers' and hScore < vScore) 
;



-- combine home and visitor subqueries and sum points
select name, sum(points) as points
from (
    -- count points for home team
    select hteam as name,
        (case 
             when hscore = vscore then 1 
             when hscore > vscore then 2 
             else 0 
         end) as points
    from Matches
    union all
    -- count points for visitor team
    select vteam as name,   
        (case 
             when hscore = vscore then 1 
             when hscore < vscore then 3
             else 0 
         end) as points
    from Matches
) as pts_tb
-- aggregate by name and order points descending
group by name
order by points desc
;



-- find coach from the teams with no defeat
select coach
from (
    -- find the number of defeats for each team
    select name, sum(defeat) as num_defeats
    from (
        -- count defeats for home teams
        select hteam as name,
            (case 
                 when hscore < vscore then 1  
                 else 0 
             end) as defeat
        from Matches
        union all
        -- count defeats for visitor teams
        select vteam as name,
            (case 
                 when hscore > vscore then 1  
                 else 0 
             end) as defeat
        from Matches
    ) as defeats_tb
    group by name
) as num_defeats_tb
-- join teams data to get coach's name
join teams t
on num_defeats_tb.name = t.name
where num_defeats = 0 -- keep teams with no loses
;


-- create materialized view Scoreboard
create table Scoreboard (name, points) as
    -- combine home and visitor subqueries and sum points
    select name, sum(points) as points
    from (
        -- count points for home team
        select hteam as name,
            (case 
                 when hscore = vscore then 1 
                 when hscore > vscore then 2 
                 else 0 
             end) as points
        from Matches
        union all
        -- count points for visitor team
        select vteam as name,   
            (case 
                 when hscore = vscore then 1 
                 when hscore < vscore then 3
                 else 0 
             end) as points
        from Matches
    ) as pts_tb
    -- aggregate by name and order points descending
    group by name
    order by points desc
;



-- get teams defeated only by scoreboard leaders and those undefeated
select name 
from teams
where name not in (
    -- find teams that lost against others but not the leaders
    select t.name
    from teams t, Matches m
    where t.name = m.vteam and m.vScore < m.hScore and m.hteam not in (
        -- get scoreboard leaders
        select name
        from Scoreboard s1
        where not exists(
            select * 
            from scoreboard s2 
            where s1.points < s2.points
        )
    ) or t.name = m.hteam and m.hScore < m.vScore and m.vteam not in (
        -- get scoreboard leaders
        select name
        from Scoreboard s1
        where not exists(
            select * 
            from scoreboard s2 
            where s1.points < s2.points
        ) 
    )
)
;



-- create trigger procedure
create or replace function process_match_scoreboard() returns trigger as $scoreboard$
    begin
        -- add points when tied, one to each
        if (new.hScore = new.vScore) then
            update scoreboard 
            set points = points + 1
            where (name = new.hTeam) or (name = new.vteam)
            ;
        -- add points when home wins, add 2 points to winner
        elsif (new.hScore > new.vScore) then
            update scoreboard 
            set points = points + 2
            where name = new.hTeam
            ;
        -- add points when visitor wins, add 3 points to winner
        elsif (new.hScore < new.vScore) then
            update scoreboard 
            set points = points + 3
            where name = new.vTeam
            ;
        end if;
        return null;
    end;        
$scoreboard$ language plpgsql
;

-- create trigger
create trigger tr_match_scoreboard
after insert on matches
    for each row execute procedure process_match_scoreboard()
;





select *
from pg_indexes
where tablename not like 'pg%';





