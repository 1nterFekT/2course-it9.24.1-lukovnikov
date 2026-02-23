create or replace procedure create_roles ()
language plpgsql
as $$
	begin
		create role rl_admin;
		create role rl_content_maker;
		create role rl_sessions_maker;
		create role rl_senior_cashier;
		create role rl_cashier;
		create role rl_visitor;
	end;
$$;

call create_roles();