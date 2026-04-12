create or replace procedure automated_booking_number_creation_test (
	p_employee_id int,
	p_client_id int,
	p_booking_datetime timestamp,
	p_seat_id int,
	p_session_id int,
	p_price int
)
language plpgsql
as $$
declare
	last_number int;
	new_number int;
	year_part text;
	booking_str text;
begin
	select coalesce(max(cast(substring(booking_number from 'БР-(\d+)/') as int)), 0)
	into last_number
	from booking;

	new_number := last_number + 1;
	year_part := to_char(p_booking_datetime, 'YY');
	booking_str := 'БР-' || lpad(new_number::text, 8, '0') || '/' || year_part;

	insert into booking (booking_number, employee_id, client_id, booking_datetime, seat_id, session_id, price)
	values (booking_str, p_employee_id, p_client_id, p_booking_datetime, p_seat_id, p_session_id, p_price);
end;
$$;

call automated_booking_number_creation_test (2, 4, '2025-09-17 10:29:30', 30, 5, 350);

select booking_number
from booking
order by id_booking desc
limit 1;