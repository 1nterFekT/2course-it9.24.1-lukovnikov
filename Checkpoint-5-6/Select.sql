-- Данные сотрудников
-- select 
-- 	ac.surname || ' ' || ac.name || ' ' || ac.patronymic as fullname,
-- 	e.position,
-- 	ac.login,
-- 	ac.password
-- from account_credentials ac
-- join employees e on e.account_credentials_id = ac.id_account_credential;

-- Клиенты
-- select
-- 	ac.surname || ' ' || ac.name || ' ' || ac.patronymic as fullname,
-- 	c.card_number,
-- 	c.card_expiration,
-- 	ac.login,
-- 	ac.password
-- from account_credentials ac
-- join clients c on c.account_credentials_id = ac.id_account_credential

-- Покупка билетов 
-- select
-- 	emp_acc.login as employee,
-- 	cli_acc.login as client,
-- 	'БР-' || b.booking_number as booking_number,
-- 	b.booking_datetime,
-- 	m.name as movie_name,
-- 	h.hall_number,
-- 	s.session_datetime,
-- 	se.row as row_number,
-- 	se.seat as seat_number,
-- 	b.price,
-- 	t.ticket_number || '/КБ' as ticket_number
-- from booking b
-- join employees e on b.employee_id = e.id_employee
-- join account_credentials emp_acc on e.account_credentials_id = emp_acc.id_account_credential
-- join clients c on b.client_id = c.id_client
-- join account_credentials cli_acc on c.account_credentials_id = cli_acc.id_account_credential
-- join sessions s on b.session_id = s.id_session
-- join movies m on s.movie_id = m.id_movie
-- join halls h on s.hall_id = h.id_hall
-- join seats se on b.seat_id = se.id_seat
-- left join tickets t on b.id_booking = t.booking_id;

-- Афиша (тут использовал string_agg, чтобы не было огромного множества повторяющихся строк)
-- select
-- 	m.name as movie_name,
-- 	string_agg(distinct cp.name, ', ') as country_produced,
-- 	string_agg(distinct a.surname || ' ' || a.name, ', ') as actors,
-- 	m.description,
-- 	string_agg(distinct d.surname || ' ' || d.name, ', ') as directors,
-- 	string_agg(distinct c.surname || ' ' || c.name, ', ') as composers,
-- 	m.age_restriction,
-- 	string_agg(distinct g.name, ', ') as genres,
-- 	m.release_date
-- from movies m
-- left join movies_countries mc on m.id_movie = mc.movie_id
-- left join country_produced cp on mc.country_produced_id = cp.id_country_produced
-- left join movies_actors ma on m.id_movie = ma.movie_id
-- left join actors a on ma.actor_id = a.id_actor
-- left join movies_directors md on m.id_movie = md.movie_id
-- left join directors d on md.director_id = d.id_director
-- left join movies_composers mco on m.id_movie = mco.movie_id
-- left join composers c on mco.composer_id = c.id_composer
-- left join movies_genres mg on m.id_movie = mg.movie_id
-- left join genre g on mg.genre_id = g.id_genre
-- group by
-- 	m.id_movie,
-- 	m.name,
-- 	m.description,
-- 	m.age_restriction,
-- 	m.release_date;

-- Расписание показов без мест (вывел без мест, тк я так не понял, как корректно это все сделать)
-- select
-- 	h.hall_number,
-- 	h.hall_type,
-- 	m.name as movie_name,
-- 	string_agg(to_char(s.session_datetime, 'HH24:MI'), ', ') as sessions_datetime
-- from sessions s
-- join halls h on s.hall_id = h.id_hall
-- join movies m on s.movie_id = m.id_movie
-- group by
-- 	h.id_hall,
-- 	h.hall_number,
-- 	h.hall_type,
-- 	m.id_movie,
-- 	m.name
-- order by
-- 	h.hall_number,
-- 	m.name

-- Расписание показов с местами (сделано с помощью ИИ)
select
	h.hall_number,
	to_char(s2.session_datetime, 'HH24:MI') as session_time,
	se.row,
	se.seat,

	case
		when t.id_ticket is not null then 'занято'
		when b.id_booking is not null then 'забронировано'
		else 'свободно'
	end as status
	
from sessions s2
join halls h on s2.hall_id = h.id_hall
join seats se on se.hall_id = h.id_hall
left join booking b on b.session_id = s2.id_session and b.seat_id = se.id_seat
left join tickets t on t.booking_id = b.id_booking
order by
	h.hall_number,
	s2.session_datetime,
	se.row,
	se.seat;