create or replace procedure check_movie_dates (
	p_movie_id int,
	p_release_date date,
	p_start_date date,
	p_end_date date
)
language plpgsql
as $$
begin
	if p_start_date < p_release_date then
		raise exception 'Дата начала показа не должна быть раньше даты премьеры';
	end if;

	if p_end_date < p_start_date then
		raise exception 'Дата окончания показа не можеть быть раньше даты начала';
	end if;

	raise notice 'Даты указаны корректно';
end;
$$;

call check_movie_dates (2, '2024-03-03', '2024-03-01', '2024-03-19');