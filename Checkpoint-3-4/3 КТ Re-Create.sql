create or replace procedure Structure_Re_Create ()
language plpgsql
as $$
	begin
		revoke select, insert, update, delete on account_credentials from rl_admin;
		revoke select, insert, update, delete on clients from rl_admin;
		revoke select, insert, update, delete on employees from rl_admin;
		revoke usage, select on sequence account_credentials_id_account_credential_seq from rl_admin;
		revoke usage, select on sequence clients_id_client_seq from rl_admin;
		revoke usage, select on sequence employees_id_employee_seq from rl_admin;

		revoke select, insert, update, delete on actors from rl_content_maker;
		revoke select, insert, update, delete on composers from rl_content_maker;
		revoke select, insert, update, delete on country_produced from rl_content_maker;
		revoke select, insert, update, delete on directors from rl_content_maker;
		revoke select, insert, update, delete on genre from rl_content_maker;
		revoke select, insert, update, delete on movies from rl_content_maker;
		revoke select, insert, update, delete on movies_actors from rl_content_maker;
		revoke select, insert, update, delete on movies_composers from rl_content_maker;
		revoke select, insert, update, delete on movies_countries from rl_content_maker;
		revoke select, insert, update, delete on movies_directors from rl_content_maker;
		revoke select, insert, update, delete on movies_genres from rl_content_maker;
		revoke usage, select on sequence actors_id_actor_seq from rl_content_maker;
		revoke usage, select on sequence composers_id_composer_seq from rl_content_maker;
		revoke usage, select on sequence country_produced_id_country_produced_seq from rl_content_maker;
		revoke usage, select on sequence directors_id_director_seq from rl_content_maker;
		revoke usage, select on sequence genre_id_genre_seq from rl_content_maker;
		revoke usage, select on sequence movies_id_movie_seq from rl_content_maker;
		revoke usage, select on sequence movies_actors_id_movies_actors_seq from rl_content_maker;
		revoke usage, select on sequence movies_composers_id_movies_composers_seq from rl_content_maker;
		revoke usage, select on sequence movies_countries_id_movies_countries_seq from rl_content_maker;
		revoke usage, select on sequence movies_directors_id_movies_directors_seq from rl_content_maker;
		revoke usage, select on sequence movies_genres_id_movies_genres_seq from rl_content_maker;

		revoke select, insert, update, delete on sessions from rl_sessions_maker;
		revoke select on halls from rl_sessions_maker;
		revoke select on movies from rl_sessions_maker;
		revoke usage, select on sequence sessions_id_session_seq from rl_sessions_maker;
		revoke usage, select on sequence halls_id_hall_seq from rl_sessions_maker;
		revoke usage, select on sequence movies_id_movie_seq from rl_sessions_maker;

		revoke select, insert, update, delete on booking from rl_senior_cashier;
		revoke select, insert, update, delete on halls from rl_senior_cashier;
		revoke select, insert, update, delete on seats from rl_senior_cashier;
		revoke select, insert, update, delete on tickets from rl_senior_cashier;
		revoke select on sessions from rl_senior_cashier;
		revoke usage, select on sequence booking_id_booking_seq from rl_senior_cashier;
		revoke usage, select on sequence halls_id_hall_seq from rl_senior_cashier;
		revoke usage, select on sequence seats_id_seat_seq from rl_senior_cashier;
		revoke usage, select on sequence tickets_id_ticket_seq from rl_senior_cashier;
		revoke usage, select on sequence sessions_id_session_seq from rl_senior_cashier;

		revoke select, insert, update, delete on booking from rl_cashier;
		revoke select, insert, update, delete on tickets from rl_cashier;
		revoke select on halls from rl_cashier;
		revoke select on seats from rl_cashier;
		revoke select on sessions from rl_cashier;
		revoke usage, select on sequence booking_id_booking_seq from rl_cashier;
		revoke usage, select on sequence tickets_id_ticket_seq from rl_cashier;
		revoke usage, select on sequence halls_id_hall_seq from rl_cashier;
		revoke usage, select on sequence seats_id_seat_seq from rl_cashier;
		revoke usage, select on sequence sessions_id_session_seq from rl_cashier;

		revoke select, update on clients from rl_visitor;
		revoke select on booking from rl_visitor;
		revoke select on sessions from rl_visitor;
		revoke select on tickets from rl_visitor;
		revoke usage, select on sequence clients_id_client_seq from rl_visitor;
		revoke usage, select on sequence booking_id_booking_seq from rl_visitor;
		revoke usage, select on sequence sessions_id_session_seq from rl_visitor;
		revoke usage, select on sequence tickets_id_ticket_seq from rl_visitor;

		drop table account_credentials;
		drop table actors;
		drop table booking;
		drop table clients;
		drop table composers;
		drop table country_produced;
		drop table directors;
		drop table employees;
		drop table genre;
		drop table halls;
		drop table movies;
		drop table movies_actors;
		drop table movies_composers;
		drop table movies_countries;
		drop table movies_directors;
		drop table movies_genres;
		drop table seats;
		drop table sessions;
		drop table tickets;

		call Structure_Create();
	end;
$$;