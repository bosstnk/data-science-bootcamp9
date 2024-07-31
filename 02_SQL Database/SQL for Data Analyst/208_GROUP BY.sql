--GROUP BY
SELECT 
  country, 
  COUNT(*) AS count_country
FROM customers 
GROUP BY country;

--GROUP BY and JOIN using WHERE
SELECT 
	genres.name, 
	COUNT(*) AS count_songs
FROM genres, tracks 
WHERE genres.genreid = tracks.genreid
GROUP BY genres.name;

SELECT 
	genres.name genre_name, 
	tracks.name track_name
FROM genres, tracks
WHERE genres.genreid = tracks.genreid
ORDER BY RANDOM() DESC
LIMIT 10;
