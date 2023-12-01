## Challenge

Infer the table schema from these user stories.

```
As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of movies with their title and release date.

As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of my cinemas with their city name (e.g 'London' or 'Manchester').

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which cinemas are showing a specific movie.

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which movies are being shown a specific cinema.
```

1. Copy the [Many-to-Many Design
   Recipe](../resources/two_tables_many_to_many_design_recipe_template.md) and
   use it to design the schema for the two tables and their join table.
2. Create the tables by loading the SQL file in `psql`.



# Two Tables (Many-to-Many) Design Recipe Template

_Copy this recipe template to design and create two related database tables having a Many-to-Many relationship._

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORIES:

As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of movies with their title and release date.

As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of my cinemas with their city name (e.g 'London' or 'Manchester').

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which cinemas are showing a specific movie.

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which movies are being shown a specific cinema.
```

```
Nouns:

movies: movie_id, movie_title, movie_release_date
cinemas: cinema_id, cinema_city_name
movies_cinemas: movie_id, cinema_id
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                   | Properties                                |
| ------------------------ | ----------------------------------------- |
| movies                   | movie_id, movie_title, movie_release_date |
| cinemas                  | cinema_id, cinema_city_name               |

1. Name of the first table (always plural): `movies` 

    Column names: `movie_id`, `movie_title`, `movie_release_date`

2. Name of the second table (always plural): `cinemas` 

    Column names: `cinema_id`, `cinema_city_name`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: movies
movie_id: SERIAL
movie_title: text
movie_release_date: date

Table: cinemas
cinema_id: SERIAL
cinema_city_name: text
```


## 4. Design the Many-to-Many relationship

Make sure you can answer YES to these two questions:

1. Can one movie have many cinemas? YES
2. Can one cinema have many movies? YES
```

_If you would answer "No" to one of these questions, you'll probably have to implement a One-to-Many relationship, which is simpler. Use the relevant design recipe in that case._

## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is `table1_table2`.

```
# EXAMPLE

Join table for tables: movies and cinemas
Join table name: movies_cinemas
Columns: movie_id, cinema_id
```


## 6. Write the SQL.

```sql
-- EXAMPLE
-- file: cinema_manager.sql

-- Replace the table name, columm names and types.


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

```

## 7. Create the tables.

```bash
psql -h 127.0.0.1 cinema_manager < seeds/cinema_manager.sql
```
