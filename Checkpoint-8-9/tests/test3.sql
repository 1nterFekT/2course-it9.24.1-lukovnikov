create or replace procedure delete_ticket_safe (p_ticket_id int)
language plpgsql
as $$
begin
	if exists (
		select 1 from reviews
		where ticket_id = p_ticket_id
	) then
		raise exception 'Данный билет удалить нельзя, так как на основании него создан отзыв.';
	end if;

	delete from tickets
	where id_ticket = p_ticket_id;
end;
$$;

call delete_ticket_safe (1);