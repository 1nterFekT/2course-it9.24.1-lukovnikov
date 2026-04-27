create or replace procedure AddBooking (
	p_booking_number varchar,
	p_employee_id int,
	p_client_id int,
	p_booking_datetime timestamp,
	p_seat_id int,
	p_session_id int,
	p_price int
)
language plpgsql
as $$
begin
	if exists (
		select 1 from booking
		where seat_id = p_seat_id
		and session_id = p_session_id
	) then
		raise exception 'Место уже занято на данный сеанс';
	end if;

	insert into booking (booking_number, employee_id, client_id, booking_datetime, seat_id, session_id, price)
	values (p_booking_number, p_employee_id, p_client_id, p_booking_datetime, p_seat_id, p_session_id, p_price);
end;
$$;

create or replace procedure AddReview (
	p_ticket_id int,
	p_review_date date,
	p_rating int,
	p_text varchar
)
language plpgsql
as $$
declare v_session_date timestamp;
begin
	select s.session_datetime
	into v_session_date
	from tickets t
	join booking b on t.booking_id = b.id_booking
	join sessions s on b.session_id = s.id_session
	where t.id_ticket = p_ticket_id;

	if p_review_date < v_session_date then
		raise exception 'Нельзя оставить отзыв до просмотра фильма';
	end if;

	insert into reviews (ticket_id, review_date, rating, review_text)
	values (p_ticket_id, p_review_date, p_rating, p_text);
end;
$$;

create or replace procedure AddReviewComment (
	p_review_id int,
	p_client_id int,
	p_datetime timestamp,
	p_content varchar
)
language plpgsql
as $$
declare v_review_date date;
begin
	select review_date into v_review_date
	from reviews
	where id_review = p_review_id;

	if p_datetime < v_review_date then
		raise exception 'Комментарий раньше самого отзыва';
	end if;

	insert into review_comments (review_id, client_id, comment_datetime, content)
	values (p_review_id, p_client_id, p_datetime, p_content);
end;
$$;

create or replace procedure AddSession (
	p_hall_id int,
	p_datetime timestamp,
	p_movie_id int
)
language plpgsql
as $$
begin
	if exists (
		select 1 from sessions
		where hall_id = p_hall_id
		and session_datetime - p_datetime
	) then
		raise exception 'В этом зале уже есть сеанс на это время';
	end if;

	insert into sessions (hall_id, session_datetime, movie_id)
	values (p_hall_id, p_datetime, p_movie_id);
end;
$$;

create or replace procedure AddClient (
	p_account_id int,
	p_card_number varchar,
	p_expiration date
)
language plpgsql
as $$
begin
	if p_expiration < current_date then
		raise exception 'Срок действия карты истёк';
	end if;

	insert into clients (account_credentials_id, card_number, card_expiration)
	values (p_account_id, p_card_number, p_expiration);
end;
$$;