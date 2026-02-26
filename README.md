🎧 Spotify Advanced SQL Project – P6
🚀 Query Optimization | Window Functions | Analytical SQL
✍ Author: Anand Kumar Pathak
🌌 Project Vision

This project is designed to simulate a real-world data engineering + analytics workflow using a Spotify dataset.

It goes beyond basic querying and focuses on:

Structured Data Cleaning

Exploratory Data Analysis (EDA)

Advanced SQL Techniques

Query Optimization & Performance Engineering

Window Functions & CTE Logic

Analytical Thinking with PostgreSQL

This is not just a SQL project — it is a Database Performance Engineering Case Study.

🧠 Problem Statement

Modern music platforms generate millions of records daily.
Efficient querying and optimization are critical for:

Real-time dashboards

Artist-level analytics

Streaming comparison

Engagement analysis

High-performance backend systems

This project demonstrates how to handle and optimize such datasets using MySQL.

🏗️ Database Architecture
🗄️ Database: spotify
```
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
```
🔍 Phase 1 – Data Cleaning & Validation

Before analysis, we performed strict data validation:

✔ Record Validation

Total rows check

Distinct artist & album validation

Album type verification

✔ Duration Integrity Check
SELECT * FROM spotify WHERE duration_min = 0;
DELETE FROM spotify WHERE duration_min = 0;

Removed corrupted records (songs with 0 duration).

📊 Phase 2 – Exploratory Data Analysis (EDA)

Key exploration queries:

Total tracks count

Distinct artists

Distinct albums

Max & Min duration

Distribution of album types

Most played platforms

This phase ensures complete dataset understanding before moving into analytics.

📈 Phase 3 – SQL Analysis
🟢 Easy Level Queries

Tracks with 1B+ streams

Albums with artists

Licensed track comments

Single album type filter

Artist-wise song count

🟡 Medium Level Queries

Album-wise average danceability

Top 5 highest energy tracks

Official video engagement analysis

Album-level total views

Spotify vs YouTube stream comparison

Example (Platform Comparison Logic):
```
SELECT * FROM
(
SELECT track,
COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS streamed_on_youtube,
COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) AS streamed_on_spotify
FROM spotify
GROUP BY track
) t
WHERE streamed_on_spotify > streamed_on_youtube;
```
🔴 Advanced Level Queries

This section demonstrates real SQL mastery.

🏆 1. Top 3 Tracks per Artist (Window Function)
```
WITH CTE AS (
SELECT artist, track, SUM(views) AS total_views,
DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) AS rank_no
FROM spotify
GROUP BY artist, track
)
SELECT * FROM CTE
WHERE rank_no <= 3;
```
📡 2. Above Average Liveness Detection
```
SELECT track, artist, liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify);
```
⚡ 3. Energy Difference per Album (CTE)
```
WITH CTE AS (
SELECT album,
MAX(energy) AS highest_energy,
MIN(energy) AS lowest_energy
FROM spotify
GROUP BY album
)
SELECT album,
highest_energy - lowest_energy AS energy_diff
FROM CTE
ORDER BY energy_diff DESC;
```
🔥 4. Energy-Liveness Ratio Analysis
```
WITH cte AS (
SELECT track,
(energy * 1.0 / liveness) AS energy_liveness_ratio
FROM spotify
WHERE liveness <> 0
)
SELECT *
FROM cte
WHERE energy_liveness_ratio > 1.2;
```
📊 5. Cumulative Likes (Window Function)
```
SELECT track,
views,
likes,
SUM(likes) OVER(
ORDER BY views
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS cumulative_likes
FROM spotify;
```
⚙ Phase 4 – Query Optimization

Performance engineering was applied using PostgreSQL.

📌 Step 1: Initial EXPLAIN Analysis

Initial performance metrics:

Execution Time: 7 ms

Planning Time: 0.17 ms

📌 Step 2: Index Creation
CREATE INDEX idx_artist ON spotify(artist);
📌 Step 3: Performance After Indexing

Optimized metrics:

Execution Time: 0.153 ms

Planning Time: 0.152 ms

🚀 Performance Improvement:

Nearly 45x faster execution

This demonstrates how indexing dramatically improves performance for large-scale analytical queries.

🛠️ Tech Stack

🐘 MySQL

🧠 Advanced SQL

📊 Window Functions

🔁 CTEs

📈 Query Optimization

🔮 Future Scope

Implement normalization into multiple tables (Star Schema)

Add partitioning for large-scale datasets

Integrate with Power BI / Tableau dashboards

Apply materialized views for faster reporting

Convert into production-ready analytical pipeline

👨‍💻 Author
Anand Kumar Pathak

Data Analytics & SQL Optimization Enthusiast

🌐 Connect With Me
GitHub: https://github.com/unstablelctron

LinkedIn: https://www.linkedin.com/in/anand-kumar-pathak-bb197326b/?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_view_base_contact_details%3BJd0ElX2MRVqycN4%2F%2BBx6Rg%3D%3D

Portfolio: https://github.com/unstablelctron/unstablelctron-unstablelctron

🎯 Why This Project Stands Out

✔ Covers SQL from Beginner → Advanced

✔ Includes Window Functions & CTEs

✔ Real Optimization with EXPLAIN

✔ Performance Comparison

✔ Industry-Oriented Thinking
