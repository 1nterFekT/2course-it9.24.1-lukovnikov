create or replace procedure Structure_Create ()
language plpgsql
as $$
	begin
		create table if not exists composers (
			id_composer serial not null constraint pk_composers primary key,
			surname varchar(50) not null,
			name varchar(50) not null,
			patronymic varchar(50)
		);

		create table if not exists directors (
			id_director serial not null constraint pk_directors primary key,
			surname varchar(50) not null,
			name varchar(50) not null,
			patronymic varchar(50)
		);

		create table if not exists actors (
			id_actor serial not null constraint pk_actors primary key,
			surname varchar(50) not null,
			name varchar(50) not null,
			patronymic varchar(50)
		);

		create table if not exists country_produced (
			id_country_produced serial not null
				constraint pk_country_produced primary key,
			name varchar(50) not null
		);

		create table if not exists genre (
			id_genre serial not null constraint pk_genre primary key,
			name varchar(50) not null
		);

		create table if not exists movies (
			id_movie serial not null constraint pk_movies primary key,
			name varchar(50) not null,
			age_restriction varchar(3) not null,
			description varchar(255) not null,
			release_date date not null
		);

		create table if not exists movies_composers (
			id_movies_composers serial not null
				constraint pk_movies_composers primary key,
			id_movie int not null
				references movies (id_movie)
				on update cascade on delete cascade,
			id_composer int not null
				references composers (id_composer)
				on update cascade on delete cascade
		);

		create table if not exists movies_directors (
			id_movies_directors serial not null
				constraint pk_movies_directors primary key,
			id_movie int not null
				references movies (id_movie)
				on update cascade on delete cascade,
			id_director int not null
				references directors (id_director)
				on update cascade on delete cascade
		);

		create table if not exists movies_actors (
			id_movies_actors serial not null
				constraint pk_movies_actors primary key,
			id_movie int not null
				references movies (id_movie)
				on update cascade on delete cascade,
			id_actor int not null
				references actors (id_actor)
				on update cascade on delete cascade
		);

		create table if not exists movies_countries (
			id_movies_countries serial not null
				constraint pk_movies_countries primary key,
			id_movie int not null
				references movies (id_movie)
				on update cascade on delete cascade,
			id_country_produces int not null
				references country_produced (id_country_produced)
				on update cascade on delete cascade
		);

		create table if not exists movies_genres (
			id_movies_genres serial not null
				constraint pk_movies_genres primary key,
			id_movie int not null
				references movies (id_movie)
				on update cascade on delete cascade,
			id_genre int not null
				references genre (id_genre)
				on update cascade on delete cascade
		);

		create table if not exists halls (
			id_hall serial not null constraint pk_halls primary key,
			hall_number int not null unique,
			hall_type varchar(2) not null
		);

		create table if not exists sessions (
			id_session serial not null 
				constraint pk_sessions primary key,
			id_hall int not null
				references halls (id_hall)
				on update cascade on delete cascade,
			session_datetime timestamp not null,
			id_movie int not null
				references movies (id_movie)
				on update cascade on delete cascade
		);

		create table if not exists seats (
			id_seat serial not null 
				constraint pk_seats primary key,
			id_hall int not null
				references halls (id_hall)
				on update cascade on delete cascade,
			row int not null,
			seat int not null
		);

		create table if not exists account_credentials (
			id_account_credential serial not null
				constraint pk_account_credentials primary key,
			login varchar(50) not null unique,
			name varchar(50) not null,
			surname varchar(50) not null,
			patronymic varchar(50),
			password varchar(50) not null
		);

		create table if not exists employees (
			id_employee serial not null
				constraint pk_employees primary key,
			id_account_credentials int not null
				references account_credentials (id_account_credential)
				on update cascade on delete cascade,
			position varchar(50) not null
		);

		create table if not exists clients (
			id_client serial not null
				constraint pk_clients primary key,
			id_account_credentials int not null
				references account_credentials (id_account_credential)
				on update cascade on delete cascade,
			card_number varchar(16) not null,
			card_expiration varchar(5) not null
		);

		create table if not exists booking (
			id_booking serial not null
				constraint pk_booking primary key,
			booking_number varchar(12) not null unique,
			id_client int not null
				references clients (id_client)
				on update cascade on delete cascade,
			booking_datetime timestamp not null,
			id_seat int not null
				references seats (id_seat)
				on update cascade on delete cascade,
			id_session int not null
				references sessions (id_session)
				on update cascade on delete cascade,
			price int not null
		);

		create table if not exists tickets (
			id_ticket serial not null
				constraint pk_tickets primary key,
			ticket_number varchar(11) not null unique,
			id_client int not null
				references clients (id_client)
				on update cascade on delete cascade,
			id_seat int not null
				references seats (id_seat)
				on update cascade on delete cascade,
			id_session int not null
				references sessions (id_session)
				on update cascade on delete cascade,
			price int not null
		);

		create index if not exists index_id_composer
			on composers (id_composer);

		create index if not exists index_surname_name_patronymic_composer
			on composers (surname, name, patronymic);

		create index if not exists index_id_director
			on directors (id_director);

		create index if not exists index_surname_name_patronymic_director
			on directors (surname, name, patronymic);

		create index if not exists index_id_actor
			on actors (id_actor);

		create index if not exists index_surname_name_patronymic_actor
			on actors (surname, name, patronymic);

		create index if not exists index_id_country_produced
			on country_produced (id_country_produced);

		create index if not exists index_id_genre
			on genre (id_genre);

		create index if not exists index_id_movies_composers
			on movies_composers (id_movies_composers);

		create index if not exists index_id_movies_directors
			on movies_directors (id_movies_directors);

		create index if not exists index_id_movies_actors
			on movies_actors (id_movies_actors);

		create index if not exists index_id_movies_countries
			on movies_countries (id_movies_countries);

		create index if not exists index_id_movies_genres
			on movies_genres (id_movies_genres);

		create index if not exists index_id_movie
			on movies (id_movie);

		create index if not exists index_id_hall
			on halls (id_hall);

		create index if not exists index_id_session
			on sessions (id_session);

		create index if not exists index_id_seat
			on seats (id_seat);

		create index if not exists index_id_account_credential
			on account_credentials (id_account_credential);

		create index if not exists index_name_surname_patronymic_account_credentials
			on account_credentials (name, surname, patronymic);

		create index if not exists index_id_employee
			on employees (id_employee);

		create index if not exists index_id_client
			on clients (id_client);

		create index if not exists index_card_number
			on clients (card_number);

		create index if not exists index_id_booking
			on booking (id_booking);

		create index if not exists index_id_ticket
			on tickets (id_ticket);

		grant select, insert, update, delete on account_credentials to rl_admin;
		grant select, insert, update, delete on clients to rl_admin;
		grant select, insert, update, delete on employees to rl_admin;
		grant usage, select on sequence account_credentials_id_account_credential_seq to rl_admin;
		grant usage, select on sequence clients_id_client_seq to rl_admin;
		grant usage, select on sequence employees_id_employee_seq to rl_admin;

		grant select, insert, update, delete on actors to rl_content_maker;
		grant select, insert, update, delete on composers to rl_content_maker;
		grant select, insert, update, delete on country_produced to rl_content_maker;
		grant select, insert, update, delete on directors to rl_content_maker;
		grant select, insert, update, delete on genre to rl_content_maker;
		grant select, insert, update, delete on movies to rl_content_maker;
		grant select, insert, update, delete on movies_actors to rl_content_maker;
		grant select, insert, update, delete on movies_composers to rl_content_maker;
		grant select, insert, update, delete on movies_countries to rl_content_maker;
		grant select, insert, update, delete on movies_directors to rl_content_maker;
		grant select, insert, update, delete on movies_genres to rl_content_maker;
		grant usage, select on sequence actors_id_actor_seq to rl_content_maker;
		grant usage, select on sequence composers_id_composer_seq to rl_content_maker;
		grant usage, select on sequence country_produced_id_country_produced_seq to rl_content_maker;
		grant usage, select on sequence directors_id_director_seq to rl_content_maker;
		grant usage, select on sequence genre_id_genre_seq to rl_content_maker;
		grant usage, select on sequence movies_id_movie_seq to rl_content_maker;
		grant usage, select on sequence movies_actors_id_movies_actors_seq to rl_content_maker;
		grant usage, select on sequence movies_composers_id_movies_composers_seq to rl_content_maker;
		grant usage, select on sequence movies_countries_id_movies_countries_seq to rl_content_maker;
		grant usage, select on sequence movies_directors_id_movies_directors_seq to rl_content_maker;
		grant usage, select on sequence movies_genres_id_movies_genres_seq to rl_content_maker;

		grant select, insert, update, delete on sessions to rl_sessions_maker;
		grant select on halls to rl_sessions_maker;
		grant select on movies to rl_sessions_maker;
		grant usage, select on sequence sessions_id_session_seq to rl_sessions_maker;
		grant usage, select on sequence halls_id_hall_seq to rl_sessions_maker;
		grant usage, select on sequence movies_id_movie_seq to rl_sessions_maker;

		grant select, insert, update, delete on booking to rl_senior_cashier;
		grant select, insert, update, delete on halls to rl_senior_cashier;
		grant select, insert, update, delete on seats to rl_senior_cashier;
		grant select, insert, update, delete on tickets to rl_senior_cashier;
		grant select on sessions to rl_senior_cashier;
		grant usage, select on sequence booking_id_booking_seq to rl_senior_cashier;
		grant usage, select on sequence halls_id_hall_seq to rl_senior_cashier;
		grant usage, select on sequence seats_id_seat_seq to rl_senior_cashier;
		grant usage, select on sequence tickets_id_ticket_seq to rl_senior_cashier;
		grant usage, select on sequence sessions_id_session_seq to rl_senior_cashier;

		grant select, insert, update, delete on booking to rl_cashier;
		grant select, insert, update, delete on tickets to rl_cashier;
		grant select on halls to rl_cashier;
		grant select on seats to rl_cashier;
		grant select on sessions to rl_cashier;
		grant usage, select on sequence booking_id_booking_seq to rl_cashier;
		grant usage, select on sequence tickets_id_ticket_seq to rl_cashier;
		grant usage, select on sequence halls_id_hall_seq to rl_cashier;
		grant usage, select on sequence seats_id_seat_seq to rl_cashier;
		grant usage, select on sequence sessions_id_session_seq to rl_cashier;

		grant select, update on clients to rl_visitor;
		grant select on booking to rl_visitor;
		grant select on sessions to rl_visitor;
		grant select on tickets to rl_visitor;
		grant usage, select on sequence clients_id_client_seq to rl_visitor;
		grant usage, select on sequence booking_id_booking_seq to rl_visitor;
		grant usage, select on sequence sessions_id_session_seq to rl_visitor;
		grant usage, select on sequence tickets_id_ticket_seq to rl_visitor;
	end;
$$;

call Structure_Create();