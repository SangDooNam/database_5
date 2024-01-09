(base) sangdoonam@SangDoos-iMac postgresql-views-pytech % psql -U postgres
psql (14.10 (Homebrew))
Type "help" for help.

postgres=# \i movies.sql
psql:movies.sql:1: NOTICE:  database "movies" does not exist, skipping
DROP DATABASE
CREATE DATABASE
You are now connected to database "movies" as user "postgres".
SET
CREATE TABLE

INSERT 0 1

movies=# \l
                                    List of databases
        Name        |   Owner    | Encoding | Collate | Ctype |     Access privileges     
--------------------+------------+----------+---------+-------+---------------------------
 artworks           | postgres   | UTF8     | C       | C     | 
 gallery            | postgres   | UTF8     | C       | C     | 
 library_management | postgres   | UTF8     | C       | C     | 
 map                | postgres   | UTF8     | C       | C     | 
 movies             | postgres   | UTF8     | C       | C     | 
 postgres           | sangdoonam | UTF8     | C       | C     | 
 sangdoo            | postgres   | UTF8     | C       | C     | 
 template0          | sangdoonam | UTF8     | C       | C     | =c/sangdoonam            +
                    |            |          |         |       | sangdoonam=CTc/sangdoonam
 template1          | sangdoonam | UTF8     | C       | C     | =c/sangdoonam            +
                    |            |          |         |       | sangdoonam=CTc/sangdoonam
(9 rows)

movies=# \d
                    List of relations
 Schema |           Name           |   Type   |  Owner   
--------+--------------------------+----------+----------
 public | artists                  | table    | postgres
 public | artists_bands            | table    | postgres
 public | artists_bands_id_seq     | sequence | postgres
 public | artists_id_seq           | sequence | postgres
 public | bands                    | table    | postgres
 public | bands_id_seq             | sequence | postgres
 public | genres                   | table    | postgres
 public | genres_id_seq            | sequence | postgres
 public | movies                   | table    | postgres
 public | movies_genres            | table    | postgres
 public | movies_genres_id_seq     | sequence | postgres
 public | movies_id_seq            | sequence | postgres
 public | movies_studios           | table    | postgres
 public | movies_studios_id_seq    | sequence | postgres
 public | people                   | table    | postgres
 public | people_id_seq            | sequence | postgres
 public | posters                  | table    | postgres
 public | posters_id_seq           | sequence | postgres
 public | roles                    | table    | postgres
 public | roles_id_seq             | sequence | postgres
 public | songs                    | table    | postgres
 public | songs_artists            | table    | postgres
 public | songs_artists_id_seq     | sequence | postgres
 public | songs_bands              | table    | postgres
 public | songs_bands_id_seq       | sequence | postgres
 public | songs_id_seq             | sequence | postgres
 public | soundtracks              | table    | postgres
 public | soundtracks_id_seq       | sequence | postgres
 public | soundtracks_songs        | table    | postgres
 public | soundtracks_songs_id_seq | sequence | postgres
 public | studios                  | table    | postgres
 public | studios_id_seq           | sequence | postgres
 public | trailers                 | table    | postgres
 public | trailers_id_seq          | sequence | postgres
(34 rows)

movies=# \d artists
                                      Table "public.artists"
   Column    |         Type          | Collation | Nullable |               Default               
-------------+-----------------------+-----------+----------+-------------------------------------
 id          | integer               |           | not null | nextval('artists_id_seq'::regclass)
 name        | character varying(50) |           | not null | 
 nationality | character varying(50) |           |          | 
Indexes:
    "artists_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "artists_bands" CONSTRAINT "artists_bands_artist_id_fkey" FOREIGN KEY (artist_id) REFERENCES artists(id)
    TABLE "songs_artists" CONSTRAINT "songs_artists_artist_id_fkey" FOREIGN KEY (artist_id) REFERENCES artists(id)

movies=# SELECT * FROM artists;
 id |        name         | nationality 
----+---------------------+-------------
  1 | Thomas Newman       | American
  2 | Nino Rota           | Italian
  3 | Joe Bloggs          | British
  4 | Carmine Coppola     | Italian
  5 | Hans Zimmer         | Germamn
  6 | Hughie Lewis        | American
  7 | Edsel Dope          | American
  8 | Acey Slade          | American
  9 | Racci Shay          | American
 10 | Virus               | American
 11 | John Hurley         | American
 12 | Neil Diamond        | American
 13 | Robert Bell         | American
 14 | Ronald Bell         | American
 15 | George Brown        | American
 16 | Lavell Evans        | American
 17 | Amir Bayyan         | American
 18 | Marilyn Manson      | American
 19 | Liam Howlett        | British
 20 | Keith Flint         | British
 21 | Maxim               | British
 22 | Till Lindemann      | German
 23 | Richard Z. Kruspe   | German
 24 | Paul Landers        | German
 25 | Christoph Schneider | 
 26 | Rob Zombie          | 
 27 | Baauer              | 
 28 | Jim Croce           | 
 29 | David Julyan        | American
 30 | Joe Cuba            | 
 31 | Bo Diddley          | American
 32 | Howlin Wolf         | American
(32 rows)

movies=# \d artists_bands;
                                     Table "public.artists_bands"
  Column   |         Type          | Collation | Nullable |                  Default                  
-----------+-----------------------+-----------+----------+-------------------------------------------
 id        | integer               |           | not null | nextval('artists_bands_id_seq'::regclass)
 role      | character varying(50) |           |          | 
 artist_id | integer               |           |          | 
 band_id   | integer               |           |          | 
Indexes:
    "artists_bands_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "artists_bands_artist_id_fkey" FOREIGN KEY (artist_id) REFERENCES artists(id)
    "artists_bands_band_id_fkey" FOREIGN KEY (band_id) REFERENCES bands(id)

movies=# SELECT * FROM artists_bands;
 id |    role     | artist_id | band_id 
----+-------------+-----------+---------
  1 | lead vocals |         7 |       1
  2 | bass        |         8 |       1
  3 | drums       |         9 |       1
  4 | lead guitar |        10 |       1
  5 | bass        |        13 |       2
  6 | saxophone   |        14 |       2
  7 | drums       |        15 |       2
  8 | lead vocals |        16 |       2
  9 | guitar      |        17 |       2
 10 | Keyboards   |        19 |       3
 11 | dancer      |        20 |       3
 12 | MC          |        21 |       3
 13 | lead vocals |        22 |       4
 14 | lead guitar |        23 |       4
 15 | bass        |        24 |       4
 16 | drums       |        25 |       4
(16 rows)

movies=# SELECT * FROM movies;
 id |          title          |                                                 description                                                 | release_date | runtime | certificate | rating 
----+-------------------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  3 | American Psycho         | A wealthy New York investment banking executive hides his alternate psychopathic ego                        | 2002-04-14   |     102 | 18          |      4
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned                              | 1994-10-14   |     154 | 18          |      4
  5 | The Matrix              | A hacker learns from mysterious rebels about the true nature of his reality                                 | 1999-03-31   |     136 | 18          |      4
  6 | Logan                   | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige            | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                                   | 2013-12-25   |     180 | 18          |      4
(9 rows)

movies=# 
movies=# 
movies=# 
movies=# CREATE VIEW long_movies AS SELECT movies.id, movies.title, movies.description, movies.release_date, movies.runtime, movies.runtime, movies.certificate FROM movies
movies-# WHERE runtime > 150;
ERROR:  column "runtime" specified more than once
movies=# CREATE VIEW long_movies AS SELECT movies.id, movies.title, movies.description, movies.release_date, movies.runtime, movies.runtime, movies.certificate FROM movies
WHERE runtime > 150 ORDER BY runtime DESC;
ERROR:  column "runtime" specified more than once
movies=# CREATE VIEW long_movies AS SELECT id, title, description, release_date, runtime, runtime, certificate FROM movies
WHERE runtime > 150 ORDER BY runtime DESC;
ERROR:  column "runtime" specified more than once
movies=# CREATE VIEW long_movies AS SELECT id, title, description, release_date, runtime, certificate FROM movies
WHERE runtime > 150 ORDER BY runtime DESC;
CREATE VIEW
movies=# SELECT * FROM long_movies ;
 id |          title          |                                         description                                         | release_date | runtime | certificate 
----+-------------------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12
(5 rows)

### Task1

movies=# DROP VIEW long_movies ;
DROP VIEW
movies=# CREATE VIEW long_movies AS SELECT * FROM movies
WHERE runtime > 150 ORDER BY runtime DESC;
CREATE VIEW
movies=# SELECT * FROM long_movies ;
 id |          title          |                                         description                                         | release_date | runtime | certificate | rating 
----+-------------------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
(5 rows)

movies=# \d
                    List of relations
 Schema |           Name           |   Type   |  Owner   
--------+--------------------------+----------+----------
 public | artists                  | table    | postgres
 public | artists_bands            | table    | postgres
 public | artists_bands_id_seq     | sequence | postgres
 public | artists_id_seq           | sequence | postgres
 public | bands                    | table    | postgres
 public | bands_id_seq             | sequence | postgres
 public | genres                   | table    | postgres
 public | genres_id_seq            | sequence | postgres
 public | long_movies              | view     | postgres
 public | movies                   | table    | postgres
 public | movies_genres            | table    | postgres
 public | movies_genres_id_seq     | sequence | postgres
 public | movies_id_seq            | sequence | postgres
 public | movies_studios           | table    | postgres
 public | movies_studios_id_seq    | sequence | postgres
 public | people                   | table    | postgres
 public | people_id_seq            | sequence | postgres
 public | posters                  | table    | postgres
 public | posters_id_seq           | sequence | postgres
 public | roles                    | table    | postgres
 public | roles_id_seq             | sequence | postgres
 public | songs                    | table    | postgres
 public | songs_artists            | table    | postgres
 public | songs_artists_id_seq     | sequence | postgres
 public | songs_bands              | table    | postgres
 public | songs_bands_id_seq       | sequence | postgres
 public | songs_id_seq             | sequence | postgres
 public | soundtracks              | table    | postgres
 public | soundtracks_id_seq       | sequence | postgres
 public | soundtracks_songs        | table    | postgres
 public | soundtracks_songs_id_seq | sequence | postgres
 public | studios                  | table    | postgres
 public | studios_id_seq           | sequence | postgres
 public | trailers                 | table    | postgres
 public | trailers_id_seq          | sequence | postgres
(35 rows)

movies=# SELECT * FROM trailers;
 id | length |                        url                        | movie_id 
----+--------+---------------------------------------------------+----------
  1 |      2 | https://www.youtube.com/watch?v=6hB3S9bIaco       |        1
  2 |      2 | https://www.youtube.com/watch?v=sY1S34973zA       |        2
  3 |      3 | https://www.youtube.com/watch?v=EXeTwQWrcwY       |        3
  4 |      3 | https://www.youtube.com/watch?v=2GIsExb5jJU       |        4
  5 |      2 | https://www.youtube.com/watch?v=s7EdQ4FqbhY       |        5
  6 |      3 | https://www.youtube.com/watch?v=m8e-FF8MsqU       |        6
  7 |      2 | https://www.youtube.com/watch?v=DekuSxJgpbY       |        7
  8 |      3 | https://www.youtube.com/watch?v=o4gHCmTQDVI       |        8
  9 |      3 | https://www.youtube.com/watch?v=zSWdZVtXT7E       |        9
 10 |      3 | https://www.youtube.com/watch?v=vKQi3bBA1y8       |        6
 11 |      3 | https://www.youtube.com/watch?v=5DO-nDW43Ik       |        2
 12 |      2 | https://www.youtube.com/watch?v=ewlwcEBTvcg       |        5
 13 |      2 | https://www.youtube.com/watch?v=Div0iP65aZo&t=15s |        7
 14 |      4 | https://www.youtube.com/watch?v=RH3OxVFvTeg       |        7
(14 rows)

### Task 2

movies=# CREATE VIEW short_trailers AS SELECT * FROM trailers
movies-# WHERE length <= 2 ORDER movie_id ASC;
ERROR:  syntax error at or near "movie_id"
LINE 2: WHERE length <= 2 ORDER movie_id ASC;
                                ^
movies=# CREATE VIEW short_trailers AS SELECT * FROM trailers
WHERE length <= 2 ORDER BY movie_id ASC;
CREATE VIEW
movies=# SELECT * FROM short_trailers;
 id | length |                        url                        | movie_id 
----+--------+---------------------------------------------------+----------
  1 |      2 | https://www.youtube.com/watch?v=6hB3S9bIaco       |        1
  2 |      2 | https://www.youtube.com/watch?v=sY1S34973zA       |        2
  5 |      2 | https://www.youtube.com/watch?v=s7EdQ4FqbhY       |        5
 12 |      2 | https://www.youtube.com/watch?v=ewlwcEBTvcg       |        5
  7 |      2 | https://www.youtube.com/watch?v=DekuSxJgpbY       |        7
 13 |      2 | https://www.youtube.com/watch?v=Div0iP65aZo&t=15s |        7
(6 rows)

movies=# SELECT * FROM long_movies, short_trailers;
 id |          title          |                                         description                                         | release_date | runtime | certificate | rating | id | length |                        url                        | movie_id 
----+-------------------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------+----+--------+---------------------------------------------------+----------
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4 |  1 |      2 | https://www.youtube.com/watch?v=6hB3S9bIaco       |        1
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5 |  1 |      2 | https://www.youtube.com/watch?v=6hB3S9bIaco       |        1
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5 |  1 |      2 | https://www.youtube.com/watch?v=6hB3S9bIaco       |        1
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4 |  1 |      2 | https://www.youtube.com/watch?v=6hB3S9bIaco       |        1
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5 |  1 |      2 | https://www.youtube.com/watch?v=6hB3S9bIaco       |        1
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4 |  2 |      2 | https://www.youtube.com/watch?v=sY1S34973zA       |        2
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5 |  2 |      2 | https://www.youtube.com/watch?v=sY1S34973zA       |        2
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5 |  2 |      2 | https://www.youtube.com/watch?v=sY1S34973zA       |        2
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4 |  2 |      2 | https://www.youtube.com/watch?v=sY1S34973zA       |        2
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5 |  2 |      2 | https://www.youtube.com/watch?v=sY1S34973zA       |        2
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4 |  5 |      2 | https://www.youtube.com/watch?v=s7EdQ4FqbhY       |        5
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5 |  5 |      2 | https://www.youtube.com/watch?v=s7EdQ4FqbhY       |        5
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5 |  5 |      2 | https://www.youtube.com/watch?v=s7EdQ4FqbhY       |        5
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4 |  5 |      2 | https://www.youtube.com/watch?v=s7EdQ4FqbhY       |        5
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5 |  5 |      2 | https://www.youtube.com/watch?v=s7EdQ4FqbhY       |        5
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4 | 12 |      2 | https://www.youtube.com/watch?v=ewlwcEBTvcg       |        5
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5 | 12 |      2 | https://www.youtube.com/watch?v=ewlwcEBTvcg       |        5
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5 | 12 |      2 | https://www.youtube.com/watch?v=ewlwcEBTvcg       |        5
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4 | 12 |      2 | https://www.youtube.com/watch?v=ewlwcEBTvcg       |        5
:


### Task3


movies=# SELECT long_movies.title, short_trailers.url FROM long_movies JOIN short_trailers ON long_movies.id = short_trailers.movie_id;
      title      |                     url                     
-----------------+---------------------------------------------
 The Godfather   | https://www.youtube.com/watch?v=6hB3S9bIaco
 The Dark Knight | https://www.youtube.com/watch?v=sY1S34973zA
(2 rows)



### Task4


movies=# SELECT movies.title, trailers.url FROM movies JOIN trailers ON movies.id = trailers.movie_id WHERE movies.runtime > 150 AND trailers.length <= 2;
      title      |                     url                     
-----------------+---------------------------------------------
 The Godfather   | https://www.youtube.com/watch?v=6hB3S9bIaco
 The Dark Knight | https://www.youtube.com/watch?v=sY1S34973zA
(2 rows)

movies=# 



### Task 5


movies=# SELECT * FROM long_movies;
 id |          title          |                                         description                                         | release_date | runtime | certificate | rating 
----+-------------------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
(5 rows)

movies=# CREATE VIEW top_rated_long_movies AS SELECT * FROM long_movies WHERE rating > 4;
CREATE VIEW
movies=# SELECT * FROM long_movies
long_movies                      long_movies_with_short_trailers  
movies=# SELECT * FROM long_movies
long_movies                      long_movies_with_short_trailers  
movies=# SELECT * FROM long_movies_with_short_trailers ;
      title      |                     url                     
-----------------+---------------------------------------------
 The Godfather   | https://www.youtube.com/watch?v=6hB3S9bIaco
 The Dark Knight | https://www.youtube.com/watch?v=sY1S34973zA
(2 rows)

movies=# SELECT * FROM top_rated_long_movies;
 id |      title      |                                         description                                         | release_date | runtime | certificate | rating 
----+-----------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
(3 rows)

movies=# SELECT * FROM long_movies;
 id |          title          |                                         description                                         | release_date | runtime | certificate | rating 
----+-------------------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
(5 rows)

movies=# SELECT * FROM long_movies_with_short_trailers;
      title      |                     url                     
-----------------+---------------------------------------------
 The Godfather   | https://www.youtube.com/watch?v=6hB3S9bIaco
 The Dark Knight | https://www.youtube.com/watch?v=sY1S34973zA
(2 rows)

movies=# CREATE TRIGGER long_movies INSTEAD OF UPDATE ON long_movies
movies-# ;
ERROR:  syntax error at or near ";"
LINE 2: ;
        ^
movies=# UPDATE long_movies SELECT * FROM moives WHERE runtime >= 120;
ERROR:  syntax error at or near "SELECT"
LINE 1: UPDATE long_movies SELECT * FROM moives WHERE runtime >= 120...
                           ^
movies=# CREATE OR REPLACE VIEW long_movies AS SELECT * FROM movies WHERE runtime >= 120;
CREATE VIEW
movies=# SELECT * FROM top_rated_long_movies;
 id |      title      |                                                 description                                                 | release_date | runtime | certificate | rating 
----+-----------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  6 | Logan           | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige    | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
(5 rows)


### Task 6


movies=# SELECT top_rated_long_movies;
ERROR:  column "top_rated_long_movies" does not exist
LINE 1: SELECT top_rated_long_movies;
               ^
movies=# SELECT * FROM  top_rated_long_movies;
 id |      title      |                                                 description                                                 | release_date | runtime | certificate | rating 
----+-----------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  6 | Logan           | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige    | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
(5 rows)

movies=# DROP VIEW top_rated_long_movies;
DROP VIEW
movies=# CREATE MATERALIZED VIEW top_rated_long_movies AS SELECT * FROM movies WHERE rating > 4;
ERROR:  syntax error at or near "MATERALIZED"
LINE 1: CREATE MATERALIZED VIEW top_rated_long_movies AS SELECT * FR...
               ^
movies=# CREATE MATERIALIZED VIEW top_rated_long_movies AS SELECT * FROM movies WHERE rating > 4;
SELECT 5
movies=# SELECT * FROM top_rated_long_movies;
 id |      title      |                                                 description                                                 | release_date | runtime | certificate | rating 
----+-----------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  6 | Logan           | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige    | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
(5 rows)

movies=# CREATE OR REPLACE long_movies AS SELECT * FROM movies WHERE runtime > 150;
ERROR:  syntax error at or near "long_movies"
LINE 1: CREATE OR REPLACE long_movies AS SELECT * FROM movies WHERE ...
                          ^
movies=# CREATE OR REPLACE VIEW long_movies AS SELECT * FROM movies WHERE runtime > 150;
CREATE VIEW
movies=# SELECT * FROM long_movies WHERE rating > 4;
 id |      title      |                                         description                                         | release_date | runtime | certificate | rating 
----+-----------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
(3 rows)

movies=# SELECT * FROM top_rated_long_movies;
 id |      title      |                                                 description                                                 | release_date | runtime | certificate | rating 
----+-----------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  6 | Logan           | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige    | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
(5 rows)

movies=#  SELECT * FROM long_movie;
ERROR:  relation "long_movie" does not exist
LINE 1: SELECT * FROM long_movie;
                      ^
movies=#  SELECT * FROM long_movies ;
 id |          title          |                                         description                                         | release_date | runtime | certificate | rating 
----+-------------------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4
(5 rows)

movies=# SELECT * FROM top_rated_long_movies;
 id |      title      |                                                 description                                                 | release_date | runtime | certificate | rating 
----+-----------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  6 | Logan           | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige    | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
(5 rows)

movies=# REFRESH MATERIALIZED VIEW top_rated_long_movies;
REFRESH MATERIALIZED VIEW
movies=# SELECT * FROM top_rated_long_movies;
 id |      title      |                                                 description                                                 | release_date | runtime | certificate | rating 
----+-----------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  6 | Logan           | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige    | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
(5 rows)

movies=# SELECT * FROM long_movies;
 id |          title          |                                         description                                         | release_date | runtime | certificate | rating 
----+-------------------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4
(5 rows)

movies=# CREATE OR REPLACE VIEW top_rated_long_movies AS SELECT * FROM long_movies WHERE rating > 4;
ERROR:  "top_rated_long_movies" is not a view
movies=# DROP MATRIALIZED VIEW top_rated_long_movies ;
ERROR:  syntax error at or near "MATRIALIZED"
LINE 1: DROP MATRIALIZED VIEW top_rated_long_movies ;
             ^
movies=# DROP MATERIALIZED VIEW top_rated_long_movies ;
DROP MATERIALIZED VIEW
movies=# CREATE VIEW top_rated_long_movies AS SELECT * FROM long_movies WHERE rating > 4;
CREATE VIEW
movies=# SELECT * FROM top_rated_long_movies;
 id |      title      |                                         description                                         | release_date | runtime | certificate | rating 
----+-----------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
(3 rows)














