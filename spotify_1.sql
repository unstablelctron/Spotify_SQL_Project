use spotify;

-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EDA
select count(*) from spotify;
select count(distinct artist) from spotify;
select count(distinct album) from spotify;
select distinct album_type from spotify;
select max(duration_min) from spotify;
select min(duration_min) from spotify;
-- checking for songs which have 0 duration
select * from spotify
where duration_min = 0;
-- removing songs which have 0 duration
delete  from spotify
where duration_min = 0;
-- confirming delete
select * from spotify
where duration_min = 0;


select distinct channel from spotify;

select distinct most_played_on from spotify;

-- Data Analysis

-- 1-Retrieve the names of all tracks that have more than 1 billion streams.

select * from spotify
where stream = 1000000000;

-- 2-List all albums along with their respective artists.
select * from spotify;
select distinct album , artist
from spotify
order by 1;

-- 3-Get the total number of comments for tracks where licensed = TRUE.

select sum(comments) as total_comments
from spotify
where licensed = 'true';

-- 4-Find all tracks that belong to the album type single.

select * from spotify
where album_type = 'single';

-- 5-Count the total number of tracks by each artist.
select 
artist,
count(*) as total_songs
from spotify
group by artist
order by total_songs;

-- 6-Calculate the average danceability of tracks in each album.
select album,
avg(danceability) as avg_danceability
from spotify
group by album
order by avg_danceability desc;

-- 7- Find the top 5 tracks with the highest energy values.
select track,
max(energy) as energy_max
from spotify
group by track
order by energy_avg desc
limit 5;

-- 8- List all tracks along with their views and likes where official_video = TRUE.
select track,
sum(views) as total_views , sum(likes) as total_likes 
from spotify
where official_video = 'true'
group by track
order by total_views , total_likes;

-- 9- For each album, calculate the total views of all associated tracks.
select album , track,
sum(views) as total_views
from spotify
group by album , track
order by total_views;

-- 10-Retrieve the track names that have been streamed on Spotify more than YouTube.

select * from
(select track,
coalesce(sum(case when most_played_on = 'Youtube' then stream end),0) as streamed_on_youtube,
coalesce(sum(case when most_played_on = 'Spotify' then stream end),0) as streamed_on_spotify
from spotify
group by track) as t1
where streamed_on_spotify > streamed_on_youtube
and streamed_on_youtube <> 0;  



-- 11- Find the top 3 most-viewed tracks for each artist using window functions.
with CTE as (select artist , track ,sum(views) as total_views,
dense_rank() over(partition by artist order by sum(views) desc) as rank_no
from spotify 
group by 1,2
order by 1,3) 
select * from CTE 
where rank_no <= 3;

-- 12-Write a query to find tracks where the liveness score is above the average.
select track , artist , liveness
from spotify
where liveness > (select avg(liveness) from spotify);

-- 13- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
with CTE as(
select album , 
max(energy) as highest_energy,
min(energy) as lowest_enrgy
from spotify
group by 1)
select album , highest_energy - lowest_enrgy as energy_diff
from CTE
order by 2 desc;

-- 14- Find tracks where the energy-to-liveness ratio is greater than 1.2.
WITH cte AS (
    SELECT
        track,
        (energy * 1.0 / liveness) AS energy_liveness_ratio
    FROM spotify
    WHERE liveness <> 0
)
SELECT track,
       energy_liveness_ratio
FROM cte
WHERE energy_liveness_ratio > 1.2;

-- 15-Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

SELECT
    track,
    views,
    likes,
    SUM(likes) OVER (
        ORDER BY views
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_likes
FROM spotify;
































select * from spotify;


















































































