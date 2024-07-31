-- HAVING is filter groups / HAVING can be used after using GROUP BY.
SELECT 
	  genres.name, 
    COUNT(*) AS count_songs 
FROM genres, tracks 
WHERE genres.genreid = tracks.genreid AND genres.name <> 'Rock'
GROUP BY genres.name
HAVING COUNT(*) >= 100 ;

SELECT 
	genres.name, 
	COUNT(*) AS count_songs
FROM genres, tracks
WHERE genres.genreid = tracks.genreid
	AND genres.name <> 'Rock' -- <> คือ ไม่เท่ากับ
GROUP BY genres.name
HAVING COUNT(*) >= 100;
