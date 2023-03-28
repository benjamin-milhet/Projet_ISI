-- Creation de la base

-- 3)
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS movies;

-- 1)
-- activée la gestion des clés étrangères
PRAGMA foreign_keys = ON;

-- Creation de la table movies
-- je n'ai pas mis le titre d'un film unique car possibilité d'avoir le meme nom
CREATE TABLE movies (
  movieId INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  genres TEXT NOT NULL
);

-- Creation de la table ratings
CREATE TABLE ratings (
  userId INTEGER NOT NULL,
  movieId INTEGER NOT NULL,
  rating REAL NOT NULL,
  timestamp INTEGER NOT NULL,
  PRIMARY KEY (userId, movieId),
  FOREIGN KEY (movieId) REFERENCES movies(movieId) ON DELETE CASCADE
);

-- Creation de la table tags
CREATE TABLE tags (
  userId INTEGER NOT NULL,
  movieId INTEGER NOT NULL,
  tag TEXT NOT NULL,
  timestamp INTEGER NOT NULL,
  PRIMARY KEY (userId, movieId, tag, timestamp),
  FOREIGN KEY (movieId) REFERENCES movies(movieId) ON DELETE CASCADE
);

-- 2)
-- .tables

-- .schema
-- .schema movies
-- .schema tags
-- .schema ratings

-- 4)
-- .separator ,
-- .import movies.csv movies
-- .import ratings.csv ratings
-- .import tags.csv tags -- la première posait probleme

-- 5)
SELECT * FROM movies LIMIT 5;



-- SQL

--1)
SELECT * FROM tags WHERE LOWER(tag) LIKE '%funny%';

-- 2)
SELECT * FROM movies INNER JOIN ratings ON movies.movieId = ratings.movieId GROUP BY movies.movieId HAVING AVG(ratings.rating) = 5 ;

-- 3)
-- a)
SELECT DISTINCT tag, COUNT(tag) AS nb_tag FROM tags GROUP BY tag ORDER BY nb_tag DESC LIMIT 30;
-- b)
SELECT userId FROM tags WHERE tag IN (SELECT DISTINCT tag AS nb_tag FROM tags GROUP BY tag ORDER BY nb_tag DESC LIMIT 2); 

-- 4)
CREATE VIEW funny_movies (movieId, title, genre, tag)
AS SELECT movies.movieId, movies.title, movies.genres, tags.tag FROM movies INNER JOIN tags ON movies.movieId = tags.movieId WHERE LOWER(tag) LIKE '%funny%';

SELECT * FROM funny_movies;

-- 5)
CREATE TABLE avg_rating AS 
SELECT movieId, AVG(rating) as moyenne_note 
FROM ratings
GROUP BY movieId;

SELECT * FROM avg_rating LIMIT 10;

CREATE TRIGGER updateTableInsert
AFTER INSERT
ON ratings
BEGIN
UPDATE avg_rating SET moyenne_note=(SELECT AVG(ratings.rating) as moyenne_note FROM ratings GROUP BY ratings.movieId) WHERE avg_rating.movieId = new.movieId;
END;

INSERT INTO ratings VALUES(8446515441, 1, 0, 2);
SELECT * FROM avg_rating LIMIT 10;

CREATE TRIGGER updateTableDelete
AFTER DELETE
ON ratings
BEGIN
UPDATE avg_rating SET moyenne_note=(SELECT AVG(ratings.rating) as moyenne_note FROM ratings GROUP BY ratings.movieId) WHERE avg_rating.movieId = old.movieId;
END;

DELETE FROM `ratings` WHERE userId = 8446515441;
SELECT * FROM avg_rating LIMIT 10;

CREATE TRIGGER updateTableUpdate
AFTER UPDATE
ON ratings
BEGIN
UPDATE avg_rating SET moyenne_note=(SELECT AVG(ratings.rating) as moyenne_note FROM ratings GROUP BY ratings.movieId) WHERE avg_rating.movieId = new.movieId;
END;

UPDATE ratings SET rating = 5 WHERE userId = 8446515441;
SELECT * FROM avg_rating LIMIT 10;


-- Python
-- Voir le fichier MILHET.py

