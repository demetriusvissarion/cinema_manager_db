DROP TABLE IF EXISTS movies CASCADE;
CREATE TABLE movies (
  movie_id SERIAL PRIMARY KEY,
  movie_title VARCHAR(255),
  movie_release_date DATE
);

DROP TABLE IF EXISTS cinemas CASCADE;
CREATE TABLE cinemas (
  cinema_id SERIAL PRIMARY KEY,
  cinema_city_name VARCHAR(255)
);

DROP TABLE IF EXISTS movies_cinemas CASCADE;
CREATE TABLE movies_cinemas (
  movie_id int,
  cinema_id int,
  constraint fk_movie foreign key(movie_id) references movies(movie_id) on delete cascade,
  constraint fk_cinema foreign key(cinema_id) references cinemas(cinema_id) on delete cascade,
  PRIMARY KEY (movie_id, cinema_id)
);

-- | Record                   | Properties                                |
-- | ------------------------ | ----------------------------------------- |
-- | movies                   | movie_id, movie_title, movie_release_date |
-- | cinemas                  | cinema_id, cinema_city_name               |
-- | movies_cinemas           | movie_id, cinema_id                       |

-- Finally, we add any records that are needed for the tests to run
INSERT INTO movies (movie_title, movie_release_date) VALUES ('Movie 1', '2023-12-20');
INSERT INTO movies (movie_title, movie_release_date) VALUES ('Movie 2', '2023-12-21');
INSERT INTO movies (movie_title, movie_release_date) VALUES ('Movie 3', '2023-12-22');
INSERT INTO movies (movie_title, movie_release_date) VALUES ('Movie 4', '2023-12-23');
INSERT INTO movies (movie_title, movie_release_date) VALUES ('Movie 5', '2023-12-24');
INSERT INTO movies (movie_title, movie_release_date) VALUES ('Movie 6', '2023-12-25');
INSERT INTO movies (movie_title, movie_release_date) VALUES ('Movie 7', '2023-12-26');
INSERT INTO movies (movie_title, movie_release_date) VALUES ('Movie 8', '2023-12-27');
INSERT INTO movies (movie_title, movie_release_date) VALUES ('Movie 9', '2023-12-28');


INSERT INTO cinemas (cinema_city_name) VALUES ('London');
INSERT INTO cinemas (cinema_city_name) VALUES ('Paris');
INSERT INTO cinemas (cinema_city_name) VALUES ('Berlin');
INSERT INTO cinemas (cinema_city_name) VALUES ('Oslo');


INSERT INTO movies_cinemas (movie_id, cinema_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 2),
(7, 1),
(6, 3),
(2, 4),
(3, 4);

ALTER TABLE movies_cinemas ADD FOREIGN KEY (movie_id) REFERENCES movies(movie_id);
ALTER TABLE movies_cinemas ADD FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id);