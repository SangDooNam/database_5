DROP DATABASE IF EXISTS movies;
CREATE DATABASE movies;

\c movies

-- Setting date styles to match original dataset
SET datestyle TO "ISO, YMD";

CREATE TABLE movies(
    id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(150),
    release_date DATE,
    runtime INT CHECK (runtime > 25),
    certificate VARCHAR(4) CHECK (certificate in ('N/A','PG','12','12A','15','15A','16','18')),
    rating NUMERIC CHECK (rating > 0 AND rating <= 5)
);

CREATE TABLE posters(
    id SERIAL PRIMARY KEY,
    link VARCHAR(500) DEFAULT 'https://via.placeholder.com/150/FF0/FFFFFF',
    movie_id INT REFERENCES movies ON DELETE SET NULL
);

CREATE TABLE trailers(
    id SERIAL PRIMARY KEY,
    length INT NOT NULL,
    url VARCHAR(150),
    movie_id INT REFERENCES movies
);

CREATE TABLE studios(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50)
);


CREATE TABLE movies_studios(
    id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies,
    studio_id INT REFERENCES studios
);

CREATE TABLE genres(
    id SERIAL PRIMARY KEY,
    genre_type VARCHAR(25) NOT NULL,
    description TEXT
);

CREATE TABLE movies_genres(
    id SERIAL PRIMARY KEY,
    movie_id INT REFERENCES movies,
    genre_id INT REFERENCES genres    
);

CREATE TABLE people(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    nationality VARCHAR(50),
    picture varchar (150)
);

CREATE TABLE roles(
    id SERIAL PRIMARY KEY,
    description VARCHAR(25) NOT NULL,
    movie_id INT REFERENCES movies,
    person_id INT REFERENCES people -- A play on plurals and singular form of table names (in English)    
);

CREATE TABLE soundtracks(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    track_size INT NOT NULL,
    movie_id INT REFERENCES movies
);

CREATE TABLE songs(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    length INT,
    url VARCHAR(150)
) ;

CREATE TABLE soundtracks_songs(
    id SERIAL PRIMARY KEY,
    soundtrack_id INT REFERENCES soundtracks,
    song_id INT REFERENCES songs    
);

CREATE TABLE artists(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    nationality VARCHAR(50)
);

CREATE TABLE songs_artists(
    id SERIAL PRIMARY KEY,
    song_id INT REFERENCES songs,
    artist_id INT REFERENCES artists
);

CREATE TABLE bands(
    id SERIAL PRIMARY KEY,
    name VARCHAR(130) NOT NULL
) ;

CREATE TABLE songs_bands(
    id SERIAL PRIMARY KEY,
    song_id INT REFERENCES songs,
    band_id INT REFERENCES bands    
);

CREATE TABLE artists_bands(
    id SERIAL PRIMARY KEY,
    role VARCHAR(50),
    artist_id INT REFERENCES artists,
    band_id INT REFERENCES bands    
);


--  Data Insertion

-- movie inserts 
INSERT INTO movies(title, description, release_date, runtime, certificate, rating) VALUES ('The Godfather', 'The aging patriarch of an organized crime dynasty transfers control to his son', '1972-3-24', 175, '18', '4.5');
INSERT INTO movies(title, description, release_date, runtime, certificate, rating) VALUES ('The Dark Knight','The menace known as the joker wreaks havoc on Gotham City', '28-7-18', 152, '12', '4.5');
INSERT INTO movies(title, description, release_date, runtime, certificate, rating) VALUES ('American Psycho', 'A wealthy New York investment banking executive hides his alternate psychopathic ego', '2-4-14', 102, '18', '4');
INSERT INTO movies(title, description, release_date, runtime, certificate, rating) VALUES ('Pulp Fiction', 'The lives of two mod hit men, a boxer, a gangster`s wife are all inter twinned', '1994-10-14', 154, '18', 4);
INSERT INTO movies(title, description, release_date, runtime, certificate, rating) VALUES ('The Matrix', 'A hacker learns from mysterious rebels about the true nature of his reality', '1999-3-31', 136, '18', 4);
INSERT INTO movies(title, description, release_date, runtime, certificate, rating) VALUES ('Logan', 'In a near future, a weary Logan cares for an ailing professor x', '2017-3-3', 135, '18', 5);
INSERT INTO movies(title, description, release_date, runtime, certificate, rating) VALUES ('The Prestige', 'Two stage magicians engage in competitive one-upmanship in an attempt to create the ultimate stage illusion', '26-10-20', 135, '12', 5);
INSERT INTO movies(title, description, release_date, runtime, certificate, rating) VALUES ('Interstellar', 'A team of explorers travel through a wormhole in space in an attempt to save the human race', '2014-11-7', 169, '12', '5');
INSERT INTO movies(title, description, release_date, runtime, certificate, rating) VALUES ('The Wolf of Wall Street', 'Based on the true story of Jordan Belfort', '2013-12-25',  180, '18', 4);

-- -- poster inserts
INSERT INTO posters(link, movie_id) VALUES (NULL, 1);
INSERT INTO posters(link, movie_id) VALUES (NULL,2);
INSERT INTO posters(link, movie_id) VALUES ('https://images-na.ssl-images-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX3.jpg',3);
INSERT INTO posters(link, movie_id) VALUES ('https://images-na.ssl-images-amazon.com/images/M/MV5BMjIyMTYwMTI0N15BMl5BanBnXkFtZTgwNTU2NTYxMTE@._V1_SX3.jpg',4);
INSERT INTO posters(link, movie_id) VALUES ('https://images-na.ssl-images-amazon.com/images/M/MV5BMTkxMTA5OTAzMl5BMl5BanBnXkFtZTgwNjA5MDc3NjE@._V1_SX3.jpg',5);
INSERT INTO posters(link, movie_id) VALUES (NULL, 6);
INSERT INTO posters(link, movie_id) VALUES ('https://images-na.ssl-images-amazon.com/images/M/MV5BMjI1MjkzMjczMV5BMl5BanBnXkFtZTgwNDk4NjYyMTI@._V1_SX3.jpg',7);
INSERT INTO posters(link, movie_id) VALUES ('https://images-na.ssl-images-amazon.com/images/M/MV5BMjA4NDI0MTIxNF5BMl5BanBnXkFtZTYwNTM0MzY2._V1_SX3.jpg', 8);
INSERT INTO posters(link, movie_id) VALUES ('https://images-na.ssl-images-amazon.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX3.jpg', 9);

-- -- trailer inserts
INSERT INTO trailers(length, url, movie_id) VALUES (2, 'https://www.youtube.com/watch?v=6hB3S9bIaco', 1);
INSERT INTO trailers(length, url, movie_id) VALUES (2 , 'https://www.youtube.com/watch?v=sY1S34973zA', 2);
INSERT INTO trailers(length, url, movie_id) VALUES (3, 'https://www.youtube.com/watch?v=EXeTwQWrcwY', 3);
INSERT INTO trailers(length, url, movie_id) VALUES (3, 'https://www.youtube.com/watch?v=2GIsExb5jJU', 4);
INSERT INTO trailers(length, url, movie_id) VALUES (2, 'https://www.youtube.com/watch?v=s7EdQ4FqbhY', 5);
INSERT INTO trailers(length, url, movie_id) VALUES (3, 'https://www.youtube.com/watch?v=m8e-FF8MsqU', 6);
INSERT INTO trailers(length, url, movie_id) VALUES (2, 'https://www.youtube.com/watch?v=DekuSxJgpbY', 7);
INSERT INTO trailers(length, url, movie_id) VALUES (3, 'https://www.youtube.com/watch?v=o4gHCmTQDVI', 8);
INSERT INTO trailers(length, url, movie_id) VALUES (3, 'https://www.youtube.com/watch?v=zSWdZVtXT7E', 9);
INSERT INTO trailers(length, url, movie_id) VALUES (3, 'https://www.youtube.com/watch?v=vKQi3bBA1y8', 6);
INSERT INTO trailers(length, url, movie_id) VALUES (3, 'https://www.youtube.com/watch?v=5DO-nDW43Ik', 2);
INSERT INTO trailers(length, url, movie_id) VALUES (2, 'https://www.youtube.com/watch?v=ewlwcEBTvcg', 5);
INSERT INTO trailers(length, url, movie_id) VALUES (2, 'https://www.youtube.com/watch?v=Div0iP65aZo&t=15s', 7);
INSERT INTO trailers(length, url, movie_id) VALUES (4, 'https://www.youtube.com/watch?v=RH3OxVFvTeg', 7);

-- -- studio inserts
INSERT INTO studios(name, address) VALUES ('Castle Rock Studios', 'America');
INSERT INTO studios(name, address) VALUES ('Paramount Pictures', 'America');
INSERT INTO studios(name, address) VALUES ('Warner Bros', 'America');
INSERT INTO studios(name, address) VALUES ('Lionsgate Studios', 'America');
INSERT INTO studios(name, address) VALUES ('Miramax Films', 'America');
INSERT INTO studios(name, address) VALUES ('Road Show Entertainment', 'Australia');
INSERT INTO studios(name, address) VALUES ('Marvel Studios', 'America');


-- -- movie-studio inserts
INSERT INTO movies_studios(movie_id, studio_id) VALUES (1, 1);
INSERT INTO movies_studios(movie_id, studio_id) VALUES (2, 2);
INSERT INTO movies_studios(movie_id, studio_id) VALUES (3, 3);
INSERT INTO movies_studios(movie_id, studio_id) VALUES (4, 4);
INSERT INTO movies_studios(movie_id, studio_id) VALUES (5, 5);
INSERT INTO movies_studios(movie_id, studio_id) VALUES (6, 3);
INSERT INTO movies_studios(movie_id, studio_id) VALUES (6, 6);
INSERT INTO movies_studios(movie_id, studio_id) VALUES (7, 7);
INSERT INTO movies_studios(movie_id, studio_id) VALUES (8, 3);
INSERT INTO movies_studios(movie_id, studio_id) VALUES ( 9, 3);

-- -- genre inserts
INSERT INTO genres(genre_type, description) VALUES ('Drama', 'Drama film is a genre that relies on the emotional and relational development of realistic characters');
INSERT INTO genres(genre_type, description) VALUES ('Crime', 'Films that focus on crime');
INSERT INTO genres(genre_type, description) VALUES ('Action', 'Action film is a film genre in which the protagonist or protagonists end up in a series of challenges that typically include violence, extended fighting, physical feats, and frantic chases.');
INSERT INTO genres(genre_type, description) VALUES ('Comic Book', 'Film adaptions from comic books and graphic novels');
INSERT INTO genres(genre_type, description) VALUES ('Sci-Fi', 'Films of speculative fiction, typically dealing with imaginative concepts such as futuristic science and tech');
INSERT INTO genres(genre_type, description) VALUES ('Mystery', 'Is a type of fiction in which a detective, or other professional, solves a crime or series of crimes');
INSERT INTO genres(genre_type, description) VALUES ('Adventure', 'An adventure is an event or series of events that happens outside the course of the protagonist''s ordinary life, usually accompanied by danger, often by physical action.');
INSERT INTO genres(genre_type, description) VALUES ('Comedy', 'Comedy is a genre of film in which the main emphasis is on humor. ');

-- -- movie-genre inserts
INSERT INTO movies_genres(movie_id, genre_id) VALUES (1, 1);
INSERT INTO movies_genres(movie_id, genre_id) VALUES (2, 2);
INSERT INTO movies_genres(movie_id, genre_id) VALUES (2, 1);
INSERT INTO movies_genres(movie_id, genre_id) VALUES (3, 2);
INSERT INTO movies_genres(movie_id, genre_id) VALUES (3, 3);
INSERT INTO movies_genres(movie_id, genre_id) VALUES (3, 4);
INSERT INTO movies_genres(movie_id, genre_id) VALUES (4, 2);
INSERT INTO movies_genres(movie_id, genre_id) VALUES (4, 1);
INSERT INTO movies_genres(movie_id, genre_id) VALUES (5, 1);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 5, 2);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 6, 3);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 6, 5);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 7, 4);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 7, 3);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 7, 5);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 8, 1);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 8, 6);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 9, 7);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 9, 1);
INSERT INTO movies_genres(movie_id, genre_id) VALUES ( 9, 5);


-- -- people inserts
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ('Morgan', 'Freeman', 'American', 'http://www.imdb.com/name/nm0151/mediaviewer/rm3587479040?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ('Tim', 'Robbins', 'American', 'http://www.imdb.com/name/nm0209/mediaviewer/rm3789593344?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ('Frank', 'Darabont', 'American', 'http://www.imdb.com/name/nm1104/mediaviewer/rm3402598144?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ('Stephen' , 'King' , 'American', 'http://www.imdb.com/name/nm0175/mediaviewer/rm2162726912?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ('Al', 'Pacino', 'American', 'http://www.imdb.com/name/nm0199/mediaviewer/rm3894385408?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ('Marlon', 'Brando', 'American', 'http://www.imdb.com/name/nm8/mediaviewer/rm1238402304?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ('Francis Ford', 'Coppola', 'Italian', 'http://www.imdb.com/name/nm0338/mediaviewer/rm604472576?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ('Christian', 'Bale' , 'American', 'http://www.imdb.com/name/nm0288/mediaviewer/rm3114052352?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ('Heath', 'Ledger', 'American', 'http://www.imdb.com/name/nm5132/mediaviewer/rm13084384?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Christopher', 'Nolan', NULL, 'http://www.imdb.com/name/nm0634240/mediaviewer/rm2047771392?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Jonathan', 'Nolan', NULL, 'http://www.imdb.com/name/nm06343/mediaviewer/rm3593121792?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Mary', 'Harron', NULL, 'http://www.imdb.com/name/nm03664/mediaviewer/rm1540923392?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Justin', 'Theroux', NULL, 'http://www.imdb.com/name/nm0857620/mediaviewer/rm605539840?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'John', 'Travolta', 'American', 'http://www.imdb.com/name/nm0237/mediaviewer/rm3504714496?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Tim', 'Roth', 'American', NULL);
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Quentin', 'Tarantino', 'American', 'http://www.imdb.com/name/nm0233/mediaviewer/rm41469632?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Keanu', 'Reeves', 'American', 'http://www.imdb.com/name/nm0206/mediaviewer/rm3751520256?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Laurence', 'Fishburne', NULL, 'http://www.imdb.com/name/nm0401/mediaviewer/rm19256832?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Lana', 'Wachowski', 'American', 'http://www.imdb.com/name/nm0905154/mediaviewer/rm3382618368?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Lilly', 'Wachowski', NULL, 'http://www.imdb.com/name/nm0905152/mediaviewer/rm1928797184?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Hugh', 'Jackman', 'Australian', 'http://www.imdb.com/name/nm0413168/mediaviewer/rm772779264?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Paddy', 'Stewart', 'American', NULL);
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Matthew', 'McConaughey', 'American', 'http://www.imdb.com/name/nm0190/mediaviewer/rm477213952?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Ellen', NULL, 'American', 'http://www.imdb.com/name/nm0995/mediaviewer/rm577411584?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Leonardo', 'DiCaprio', 'American', 'http://www.imdb.com/name/nm0138/mediaviewer/rm487490304?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Jonah', 'Hill', 'American', 'http://www.imdb.com/name/nm1706767/mediaviewer/rm4139364608?ref_=nm_ov_ph');
INSERT INTO people (first_name, last_name, nationality, picture) VALUES ( 'Martin', 'Scorsese', 'American', 'http://www.imdb.com/name/nm0217/mediaviewer/rm1221431040?ref_=nm_ov_ph');


-- -- role inserts
INSERT INTO roles(description, movie_id, person_id) VALUES ('co-actor', 1, 1);
INSERT INTO roles(description, movie_id, person_id) VALUES ('lead actor', 1, 2);
INSERT INTO roles(description, movie_id, person_id) VALUES ('director' , 1, 3);
INSERT INTO roles(description, movie_id, person_id) VALUES ('writer', 1, 4);
INSERT INTO roles(description, movie_id, person_id) VALUES ('lead actor', 2, 6);
INSERT INTO roles(description, movie_id, person_id) VALUES ('co-actor', 2, 5);
INSERT INTO roles(description, movie_id, person_id) VALUES ('director', 2, 7);
INSERT INTO roles(description, movie_id, person_id) VALUES ('director', 3, 10);
INSERT INTO roles(description, movie_id, person_id) VALUES ('writer', 3, 11);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'screenplay', 3, 10);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'lead actor', 3, 8);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'co-actor', 3, 9);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'lead actor', 4, 8);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'director', 4, 12);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'co-actor', 4, 13);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'co-actor', 5, 14);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'co-actor', 5, 15);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'co-actor', 5, 16);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'director', 5, 16);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'writer', 5, 16);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'lead actor', 6, 17);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'co-actor', 6, 18);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'director', 6, 19);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'director', 6, 20);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'writer', 6, 19);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'writer', 6, 20);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'lead actor', 7, 21);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'co-actor', 7, 22);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'lead actor', 8, 21);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'co-actor', 8, 8);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'director', 8, 10);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'lead actor', 9, 23);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'co-actor', 9, 24);
INSERT INTO roles(description, movie_id, person_id) VALUES ( 'director', 9, 10);


-- -- sound track inserts 
INSERT INTO soundtracks(name, track_size, movie_id) VALUES ('The Shawshank Redemption Soundtrack', 5, 1);
INSERT INTO soundtracks(name, track_size, movie_id) VALUES ('The Godfather Soundtrack', 6, 2);
INSERT INTO soundtracks(name, track_size, movie_id) VALUES ('The Dark Knight', 5, 3);
INSERT INTO soundtracks(name, track_size, movie_id) VALUES ('American Psycho: Music from the Controversial movie picture', 10, 4);
INSERT INTO soundtracks(name, track_size, movie_id) VALUES ('Music from the Motion Picture Pulp Fiction', 16, 5);
INSERT INTO soundtracks(name, track_size, movie_id) VALUES ('The Matrix, Music, Music from the Motion Picture', 13, 6);
INSERT INTO soundtracks(name, track_size, movie_id) VALUES ('Logan Music', 16, 7);
INSERT INTO soundtracks(name, track_size, movie_id) VALUES ('The Prestige: Original Score', 17, 8);
INSERT INTO soundtracks(name, track_size, movie_id) VALUES ('Interstellar Soundtrack', 16, 9);

-- -- song inserts
INSERT INTO songs(name, length, url) VALUES ('May' , 1 , 'www.youtube.com/may');
INSERT INTO songs(name, length, url) VALUES ('Shawshank Prison', 2, 'www.youtube.com/shawshankprison');
INSERT INTO songs(name, length, url) VALUES ('New Fish', 3, 'www.youtube.com/newfish');
INSERT INTO songs(name, length, url) VALUES ('Rock Hammer', 3, 'www.youtube.com/rockhammer');
INSERT INTO songs(name, length, url) VALUES ('An Inch of his life', 2, 'www.youtube.com/aninchofhislife');
INSERT INTO songs(name, length, url) VALUES ('The Godfather Waltz', 4, 'www.youtube.com/thewaltz');
INSERT INTO songs(name, length, url) VALUES ('I have but one heart', 3, 'www.youtube.com/ihavebutoneheart');
INSERT INTO songs(name, length, url) VALUES ('The Pickup', 2, 'www.youtube.com/thepickup');
INSERT INTO songs(name, length, url) VALUES ('Connies Wedding', 3, 'www.youtube.com/connieswedding');
INSERT INTO songs(name, length, url) VALUES ( 'Miller Compilation', 20, 'www.youtube.com/millercompilation');
INSERT INTO songs(name, length, url) VALUES ( 'Hip to be Square', 3, 'www.youtube.com/hiptobesquare');
INSERT INTO songs(name, length, url) VALUES ( 'You Spin me Round', 2, 'www.youtube.com/youspinmeround');
INSERT INTO songs(name, length, url) VALUES ( 'Jungle Boogie', 3, 'www.youtube.com/jungleboogie');
INSERT INTO songs(name, length, url) VALUES ( 'Son of a Preacher Man', 4, 'www.youtube.com/sonofapreacherman');
INSERT INTO songs(name, length, url) VALUES ( 'Girl, Youll be a Woman Soon', 3, 'www.youtube.com/youllbeawomansoon');
INSERT INTO songs(name, length, url) VALUES ( 'Rock is Dead', 3, 'www.youtube.com/rockisdead');
INSERT INTO songs(name, length, url) VALUES ( 'Mindfields', 5, 'www.youtube.com/mindfields');
INSERT INTO songs(name, length, url) VALUES ( 'Du Hast', 4, 'https://www.youtube.com/watch?v=hN4OXPZtHtI');
INSERT INTO songs(name, length, url) VALUES ( 'Dragula', 4, 'www.youtube.com/dragula');
INSERT INTO songs(name, length, url) VALUES ( 'Make it Bang', 4, 'www.youtube.com/makeitbang');
INSERT INTO songs(name, length, url) VALUES ( 'I got a name', 3, 'www.youtube.com/igotaname');
INSERT INTO songs(name, length, url) VALUES ( 'Are you watching closely', 3, 'www.youtube.com/areyouwatching');
INSERT INTO songs(name, length, url) VALUES ( 'The light field', 2, 'www.youtube.com/thelightfield');
INSERT INTO songs(name, length, url) VALUES ( 'Border Meets Sarah', 4, 'www.youtube.com/bordermeetssarah');
INSERT INTO songs(name, length, url) VALUES ( 'No, not today', 5, 'www.youtube.com/nonottoday');
INSERT INTO songs(name, length, url) VALUES ( 'Interstellar compilation', 72, 'https://www.youtube.com/watch?v=iBfk37Fa3H0');
INSERT INTO songs(name, length, url) VALUES ( 'Bang Bang', 4, 'www.youtube.com/bangbang');
INSERT INTO songs(name, length, url) VALUES ( 'Pretty Thing', 3, 'www.youtube.com/prettything');
INSERT INTO songs(name, length, url) VALUES ( 'Smokestack Lightning', 4, 'www.youtube.com/smokestack');


-- -- soundtrack-song inserts
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES (1, 1);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES (1, 2);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES (1, 3);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES (1, 4);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES (1, 5);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES (2, 6);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES (2, 7);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES (2, 8);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES (2, 9);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 3, 10);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 4, 11);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 4, 12);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 5, 13);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 5, 14);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 5, 15);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 6, 16);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 6, 17);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 6, 18);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 6, 19);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 7, 20);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 7, 21);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 8, 22);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 8, 23);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 8, 24);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 8, 25);
INSERT INTO soundtracks_songs(soundtrack_id, song_id) VALUES ( 9, 26);

-- -- artists inserts
INSERT INTO artists(name, nationality) VALUES ('Thomas Newman', 'American');
INSERT INTO artists(name, nationality) VALUES ('Nino Rota', 'Italian');
INSERT INTO artists(name, nationality) VALUES ('Joe Bloggs', 'British');
INSERT INTO artists(name, nationality) VALUES ('Carmine Coppola', 'Italian');
INSERT INTO artists(name, nationality) VALUES ('Hans Zimmer', 'Germamn');
INSERT INTO artists(name, nationality) VALUES ('Hughie Lewis', 'American');
INSERT INTO artists(name, nationality) VALUES ('Edsel Dope', 'American');
INSERT INTO artists(name, nationality) VALUES ('Acey Slade', 'American');
INSERT INTO artists(name, nationality) VALUES ('Racci Shay', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Virus', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'John Hurley', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Neil Diamond', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Robert Bell', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Ronald Bell', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'George Brown', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Lavell Evans', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Amir Bayyan', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Marilyn Manson', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Liam Howlett', 'British');
INSERT INTO artists(name, nationality) VALUES ( 'Keith Flint', 'British');
INSERT INTO artists(name, nationality) VALUES ( 'Maxim', 'British');
INSERT INTO artists(name, nationality) VALUES ( 'Till Lindemann', 'German');
INSERT INTO artists(name, nationality) VALUES ( 'Richard Z. Kruspe', 'German');
INSERT INTO artists(name, nationality) VALUES ( 'Paul Landers', 'German');
INSERT INTO artists(name, nationality) VALUES ( 'Christoph Schneider', NULL);
INSERT INTO artists(name, nationality) VALUES ( 'Rob Zombie', NULL);
INSERT INTO artists(name, nationality) VALUES ( 'Baauer', NULL);
INSERT INTO artists(name, nationality) VALUES ( 'Jim Croce', NULL);
INSERT INTO artists(name, nationality) VALUES ( 'David Julyan', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Joe Cuba', NULL);
INSERT INTO artists(name, nationality) VALUES ( 'Bo Diddley', 'American');
INSERT INTO artists(name, nationality) VALUES ( 'Howlin Wolf', 'American');

-- -- song-artists inserts
INSERT INTO songs_artists(song_id, artist_id) VALUES (1, 1);
INSERT INTO songs_artists(song_id, artist_id) VALUES (2, 1);
INSERT INTO songs_artists(song_id, artist_id) VALUES (3, 1);
INSERT INTO songs_artists(song_id, artist_id) VALUES (4, 1);
INSERT INTO songs_artists(song_id, artist_id) VALUES (5, 1);
INSERT INTO songs_artists(song_id, artist_id) VALUES (6, 2);
INSERT INTO songs_artists(song_id, artist_id) VALUES (7, 3);
INSERT INTO songs_artists(song_id, artist_id) VALUES (8, 2);
INSERT INTO songs_artists(song_id, artist_id) VALUES (9, 4);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 10, 5);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 11, 6);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 14, 11);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 15, 12);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 16, 18);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 19, 26);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 20, 27);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 21, 28);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 22, 29);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 23, 29);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 24, 29);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 25, 29);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 26, 5);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 27, 30);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 28, 31);
INSERT INTO songs_artists(song_id, artist_id) VALUES ( 29, 32);

-- -- band inserts
INSERT INTO bands(name) VALUES ('Dope');
INSERT INTO bands(name) VALUES ('Kool and the Gang');
INSERT INTO bands(name) VALUES ('The Prodigy');
INSERT INTO bands(name) VALUES ('Rammstein');

-- -- song-band inserts
INSERT INTO songs_bands(song_id, band_id) VALUES (12, 1);
INSERT INTO songs_bands(song_id, band_id) VALUES (13, 2);
INSERT INTO songs_bands(song_id, band_id) VALUES (17, 3);
INSERT INTO songs_bands(song_id, band_id) VALUES (18, 4);

-- -- artists-band inserts
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ('lead vocals', 7, 1);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ('bass', 8, 1);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ('drums', 9, 1);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ('lead guitar', 10, 1);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ('bass', 13, 2);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ('saxophone', 14, 2);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ('drums', 15, 2);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ('lead vocals', 16, 2);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ('guitar', 17, 2);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ( 'Keyboards', 19, 3);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ( 'dancer', 20, 3);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ( 'MC', 21, 3);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ( 'lead vocals', 22, 4);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ( 'lead guitar', 23, 4);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ( 'bass', 24, 4);
INSERT INTO artists_bands(role, artist_id, band_id) VALUES ( 'drums', 25, 4);
