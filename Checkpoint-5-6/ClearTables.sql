create or replace procedure Clear_all_tables()
language sql
as $$
	delete from tickets;
	delete from booking;
	delete from clients;
	delete from employees;
	delete from account_credentials;
	delete from seats;
	delete from sessions;
	delete from halls;
	delete from movies_genres;
	delete from movies_countries;
	delete from movies_actors;
	delete from movies_directors;
	delete from movies_composers;
	delete from movies;
	delete from genre;
	delete from country_produced;
	delete from actors;
	delete from directors;
	delete from composers;

	alter sequence tickets_id_ticket_seq restart with 1;
	alter sequence booking_id_booking_seq restart with 1;
	alter sequence clients_id_client_seq restart with 1;
	alter sequence employees_id_employee_seq restart with 1;
	alter sequence account_credentials_id_account_credential_seq restart with 1;
	alter sequence seats_id_seat_seq restart with 1;
	alter sequence sessions_id_session_seq restart with 1;
	alter sequence halls_id_hall_seq restart with 1;
	alter sequence movies_genres_id_movies_genres_seq restart with 1;
	alter sequence movies_countries_id_movies_countries_seq restart with 1;
	alter sequence movies_actors_id_movies_actors_seq restart with 1;
	alter sequence movies_directors_id_movies_directors_seq restart with 1;
	alter sequence movies_composers_id_movies_composers_seq restart with 1;
	alter sequence movies_id_movie_seq restart with 1;
	alter sequence genre_id_genre_seq restart with 1;
	alter sequence country_produced_id_country_produced_seq restart with 1;
	alter sequence actors_id_actor_seq restart with 1;
	alter sequence directors_id_director_seq restart with 1;
	alter sequence composers_id_composer_seq restart with 1;
$$;

call Clear_all_tables();