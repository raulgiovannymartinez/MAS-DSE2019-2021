-- Create tables for 201Cats
CREATE TABLE users (
    user_id         SERIAL PRIMARY KEY NOT NULL,
    first_name      character varying(50) NOT NULL,
    last_name       character varying(50) NOT NULL,
    username        character varying(50) NOT NULL,
    fb_login        character varying(50) NOT NULL
);
CREATE TABLE sessions (
    session_id      SERIAL PRIMARY KEY NOT NULL,
    created_on      TIMESTAMP NOT NULL,
    user_id         INTEGER REFERENCES users (user_id) NOT NULL
);
CREATE TABLE videos (
    video_id        SERIAL PRIMARY KEY NOT NULL,
    name            character varying(50) NOT NULL,
    description     TEXT
);
CREATE TABLE friends (
    user_id         INTEGER REFERENCES users (user_id) NOT NULL,
    friend_id       INTEGER REFERENCES users (user_id) NOT NULL
);
CREATE TABLE suggestions (
    suggestion_id   SERIAL PRIMARY KEY NOT NULL,
    session_id      INTEGER REFERENCES sessions (session_id) NOT NULL,
    video_id        INTEGER REFERENCES videos (video_id) NOT NULL
);
CREATE TABLE likes (
    like_id         SERIAL PRIMARY KEY NOT NULL,
    created_on      TIMESTAMP NOT NULL,
    video_id        INTEGER REFERENCES videos (video_id) NOT NULL,
    user_id         INTEGER REFERENCES users (user_id) NOT NULL,
    CONSTRAINT like_once UNIQUE(user_id,video_id)
);
CREATE TABLE watched (
    watch_id         SERIAL PRIMARY KEY NOT NULL,
    created_on       TIMESTAMP NOT NULL,
    end_time         TIMESTAMP NOT NULL,
    video_id         INTEGER REFERENCES videos (video_id) NOT NULL,
    session_id       INTEGER REFERENCES sessions (session_id) NOT NULL
);