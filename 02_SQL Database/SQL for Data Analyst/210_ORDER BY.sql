-- Order By + Limit 
SELECT 
    genres.name, 
    COUNT(*) 
FROM genres 
JOIN tracks ON genres.genreid = tracks.genreid
GROUP BY genres.name
ORDER BY COUNT(*) DESC LIMIT 5; -- desc = descending order
