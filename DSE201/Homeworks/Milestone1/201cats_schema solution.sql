CREATE TABLE cats."user"
(
  user_id serial primary key NOT NULL,
  user_name character varying(50) NOT NULL,
  facebook_id character varying(50) NOT NULL
)

CREATE TABLE cats.video
(
  video_id serial primary key NOT NULL,
  video_name character varying(50) NOT NULL
)

CREATE TABLE cats.login
(
  login_id serial primary key NOT NULL,
  user_id integer references cats."user" (user_id) NOT NULL,
  "time" timestamp without time zone NOT NULL
)

CREATE TABLE cats.watch
(
  watch_id serial primary key NOT NULL,
  video_id integer references cats.video (video_id) NOT NULL,
  user_id integer integer references cats."user" (user_id) NOT NULL,
  "time" timestamp without time zone NOT NULL
)

CREATE TABLE cats.friend
(
  user_id integer references cats."user" (user_id) NOT NULL,
  friend_id integer references cats."user" (user_id) NOT NULL
)

CREATE TABLE cats."likes"
(
  like_id serial primary key NOT NULL,
  user_id integer references cats."user" (user_id) NOT NULL,
  video_id integer references cats.video (video_id) NOT NULL,
  "time" timestamp without time zone NOT NULL,
  CONSTRAINT like_once UNIQUE(user_id,video_id)
)

CREATE TABLE cats.suggestion
(
  suggestion_id serial primary key NOT NULL,
  login_id integer references cats.login(login_id) NOT NULL,
  video_id integer references cats.video (video_id) NOT NULL
)