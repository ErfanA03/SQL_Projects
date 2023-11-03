CREATE DATABASE db_movies
GO

USE db_movies;


/* Creating the tables */
CREATE TABLE tbl_movies (
    movie_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
    movie_title VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_directors (
    director_id INT PRIMARY KEY NOT NULL IDENTITY (5000,1),
    director_name VARCHAR(50) NOT NULL,
    movie_id INT,
    FOREIGN KEY (movie_id) REFERENCES tbl_movies(movie_id)
);

CREATE TABLE tbl_actors (
    actor_id INT PRIMARY KEY NOT NULL IDENTITY (2000,1),
    actor_name VARCHAR(50) NOT NULL,
    movie_id INT,
    FOREIGN KEY (movie_id) REFERENCES tbl_movies(movie_id)
);

/* Inserting Values */
INSERT INTO tbl_movies
	(movie_title)
	VALUES
	('Pulp Fiction'),
	('Alice in Wonderland'),
	('Oppenheimer'),
	('Raiders of the Lost Ark'),
	('Back to the Future')
;

INSERT INTO tbl_directors
	(director_name, movie_id)
	VALUES
	('Tim Burton', 2),
	('Quentin Tarantino', 1),
	('Steven Spielberg', 4),
	('Christopher Nolan', 3),
	('Robert Zemeckis', 5)
;

INSERT INTO tbl_actors
	(actor_name, movie_id)
	VALUES
	('Robert Downey Jr.', 3),
	('Michael J. Fox', 5),
	('Harrison Ford', 4),
	('Samuel L. Jackson', 1),
	('Johnny Depp', 2)
;


SELECT
    m.movie_title,
    d.director_name,
    a.actor_name
FROM
    tbl_movies m
INNER JOIN
    tbl_directors d ON m.movie_id = d.movie_id
INNER JOIN
    tbl_actors a ON m.movie_id = a.movie_id;
