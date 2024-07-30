--Join table
SELECT * FROM artists
JOIN albums
ON artists.ArtistId = albums.ArtistID

-- Select column from Join table
SELECT
	artists.Name,
  albums.Title
FROM artists
JOIN albums
ON artists.ArtistId = albums.ArtistID

-- As อ้างอิง table
SELECT
	art.Name,
  alb.Title
FROM artists AS art 
JOIN albums AS alb
ON art.ArtistId = alb.ArtistID
