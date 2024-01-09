# PostgreSQL Views

## Description

When a database has many tables it can sometimes become a bit complex to define queries.

In this exercise, you will use views to define temporary "tables" that will make your future queries a little easier to define and read.

## Data

The data for this exercises is provided in the file [movies.sql](movies.sql).

Execute it using the command line and explore its structure and contents. You can do it using the command line in psql or expanding the tree in DBeaver.

Now that you know SQL, though, the easiest and fastest way for you to understand better the structure and data is probably to simply open the [movies.sql](movies.sql) file and read its SQL statements.

The database contains information about movies and their casting, sound tracks, posters, trailers,...

## Tasks

You can choose to use the command line or DBeaver to execute the SQL statements required to fulfill the following tasks.

> If you use the command line, remember that you can use the `tab` key to auto-complete commands and database objects (table names, field names,...) and the `up` and `down` arrows to navigate through the history of statements executed during the session.
>
> In this exercise this may become very useful.

### Task 1

Create a view named `long_movies` that returns all movies of more than 2:30h (150 minutes) sorted by length of the movie. The longest movies should appear first.

Then, execute the following statement:

```
SELECT * FROM long_movies;
```

**Your result should look like this:**

```
 id |          title          |                                         description                                         | release_date | runtime | certificate | rating
----+-------------------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  9 | The Wolf of Wall Street | Based on the true story of Jordan Belfort                                                   | 2013-12-25   |     180 | 18          |      4
  1 | The Godfather           | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  8 | Interstellar            | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
  4 | Pulp Fiction            | The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned              | 1994-10-14   |     154 | 18          |      4
  2 | The Dark Knight         | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
(5 rows)
```

### Task 2

Now create a view named `short_trailers` that returns the trailers having a length of 2 minutes or lower.

Then, execute the following statement:

```
SELECT * FROM short_trailers;
```

**Your result should look like this:**

```
 id | length |                        url                        | movie_id
----+--------+---------------------------------------------------+----------
  1 |      2 | https://www.youtube.com/watch?v=6hB3S9bIaco       |        1
  2 |      2 | https://www.youtube.com/watch?v=sY1S34973zA       |        2
  5 |      2 | https://www.youtube.com/watch?v=s7EdQ4FqbhY       |        5
  7 |      2 | https://www.youtube.com/watch?v=DekuSxJgpbY       |        7
 12 |      2 | https://www.youtube.com/watch?v=ewlwcEBTvcg       |        5
 13 |      2 | https://www.youtube.com/watch?v=Div0iP65aZo&t=15s |        7
(6 rows)
```

### Task 3

Using the views `long_movies` and `short_trailers` you created in the previous tasks, create a simple SQL statement that shows the long movies having short trailers.

The result should show only the name of the movie and the URL of the trailer.

**Your result should look like this:**

```
 title      |                     url                     
-----------------+---------------------------------------------
 The Godfather   | https://www.youtube.com/watch?v=6hB3S9bIaco
 The Dark Knight | https://www.youtube.com/watch?v=sY1S34973zA
(2 rows)
```

### Task 4

Now, create the same output as before but without using the `long_movies` and `short_trailers` views.

**Your result should look like this:**

```
 title      |                     url                     
-----------------+---------------------------------------------
 The Godfather   | https://www.youtube.com/watch?v=6hB3S9bIaco
 The Dark Knight | https://www.youtube.com/watch?v=sY1S34973zA
(2 rows)
```

**Compare this SQL with the one from the previous task and answer the following questions:**

- Which SQL is more readable? and which more specific?

### Task 5

Take the SQL you defined in **Task 3** and save it as a view named `long_movies_with_short_trailers`.

Execute the following statement.

```
SELECT * FROM long_movies_with_short_trailers;
```

**Your result should look like this:**

```
      title      |                     url                     
-----------------+---------------------------------------------
 The Godfather   | https://www.youtube.com/watch?v=6hB3S9bIaco
 The Dark Knight | https://www.youtube.com/watch?v=sY1S34973zA
(2 rows)
```

Now, create a new view named `top_rated_long_movies` that uses the view `long_movies` to return the list of long movies with a rating grater than 4.

Execute the following statement.

```
SELECT * FROM top_rated_long_movies;
```

**Your result should look like this:**

```
 id |      title      |                                         description                                         | release_date | runtime | certificate | rating
----+-----------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
(3 rows)
```

Then, replace the view `long_movies` with a new one that returns all movies lasting 2 hours or more.

Execute the following statement, again.

```
SELECT * FROM long_movies_with_short_trailers;
```

**Your result should look like this:**

```
      title      |                        url                        
-----------------+---------------------------------------------------
 The Godfather   | https://www.youtube.com/watch?v=6hB3S9bIaco
 The Dark Knight | https://www.youtube.com/watch?v=sY1S34973zA
 The Matrix      | https://www.youtube.com/watch?v=s7EdQ4FqbhY
 The Prestige    | https://www.youtube.com/watch?v=DekuSxJgpbY
 The Matrix      | https://www.youtube.com/watch?v=ewlwcEBTvcg
 The Prestige    | https://www.youtube.com/watch?v=Div0iP65aZo&t=15s
(6 rows)
```

Finally, execute again the following statement.

```
SELECT * FROM top_rated_long_movies;
```

**Your result should look like this:**

```
 id |      title      |                                                 description                                                 | release_date | runtime | certificate | rating
----+-----------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  6 | Logan           | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige    | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
(5 rows)
```

**Compare the result of the views `long_movies_with_short_trailers` and `top_rated_long_movies` at the beginning and at the end of this task. Answer the following questions:**

- What has changed? why?

## Task 6

Now, remove the view `top_rated_long_movies` and create a **materialized** view with the same name and the same query.

Execute the following statement.

```
SELECT * FROM top_rated_long_movies;
```

**Your result should look like this:**

```
 id |      title      |                                                 description                                                 | release_date | runtime | certificate | rating
----+-----------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  6 | Logan           | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige    | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
(5 rows)
```

Now, redefine again the `long_movies` view as it initially was (returning all movies longer than 150 minutes).

Execute the following statement.

```
SELECT * FROM long_movies WHERE rating > 4;
```

**Your result should look like this:**
```
 id |      title      |                                         description                                         | release_date | runtime | certificate | rating
----+-----------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
(3 rows)
```

Now, execute the following statement.

```
SELECT * FROM top_rated_long_movies;
```

**Your result should look like this:**

```
 id |      title      |                                                 description                                                 | release_date | runtime | certificate | rating
----+-----------------+-------------------------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
  1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son                              | 1972-03-24   |     175 | 18          |    4.5
  2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                                   | 2028-07-18   |     152 | 12          |    4.5
  6 | Logan           | In a near future, a weary Logan cares for an ailing professor x                                             | 2017-03-03   |     135 | 18          |      5
  7 | The Prestige    | Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion | 2026-10-20   |     135 | 12          |      5
  8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race                 | 2014-11-07   |     169 | 12          |      5
(5 rows)
```

**Answer the following questions:**

- What happened now? why?

Finally, write a statement that processes again the query defined in the `top_rated_long_movies` view.

Execute the following statement.

```
SELECT * FROM top_rated_long_movies;
```

**Your result should look like this:**

```
id |      title      |                                         description                                         | release_date | runtime | certificate | rating
----+-----------------+---------------------------------------------------------------------------------------------+--------------+---------+-------------+--------
 1 | The Godfather   | The aging patriarch of an organized crime dynasty transfers control to his son              | 1972-03-24   |     175 | 18          |    4.5
 2 | The Dark Knight | The menace known as the joker wreaks havoc on Gotham City                                   | 2028-07-18   |     152 | 12          |    4.5
 8 | Interstellar    | A team of explorers travel through a wormhole in space in an attempt to save the human race | 2014-11-07   |     169 | 12          |      5
(3 rows)
```
