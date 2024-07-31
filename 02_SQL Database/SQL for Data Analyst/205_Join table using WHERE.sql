--Difference JOIN ON vs WHERE

SELECT * FROM artists, albums
WHERE artists.artistid = albums.artistid;

SELECT * FROM artists JOIN albums
ON artists.artistid = albums.artistid;

---------------------------------------------------------

-- join table with WHERE clause, two tables
SELECT
	artists.artistid,
  artists.name AS artist_name,
  albums.title AS album_name
FROM artists, albums
WHERE artists.artistid = albums.artistid -- PK = FK
  AND artists.artistid IN (8, 100, 120);

---------------------------------------------------------

-- join table with WHERE clause, three tables
SELECT
	artists.artistid,
  artists.name AS artist_name,
  albums.title AS album_name,
  tracks.name  AS song_name
FROM artists, albums, tracks  
WHERE artists.artistid = albums.artistid -- PK = FK
  AND albums.albumid = tracks.albumid
  AND artists.artistid IN (8, 100, 120);
