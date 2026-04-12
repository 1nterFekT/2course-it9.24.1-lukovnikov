create or replace procedure check_similar_card_test (
	p_account_id int,
	p_card_number varchar(16),
	p_card_expiration date
)
language plpgsql
as $$
begin
	if exists (
		select 1 from clients
		where card_number = p_card_number
	) then
		raise exception 'Указанный номер карты уже есть в таблице!';
	end if;

	insert into clients (account_credentials_id, card_number, card_expiration)
	values (p_account_id, p_card_number, p_card_expiration);
end;
$$;

call check_similar_card_test (1, '4112678821211962', '2025-02-01');