create role rl_sessionhead with password 'Pa$$w0rd';
alter role rl_sessionhead LOGIN;
grant connect on database "cinema_db" to rl_sessionhead;

create role rl_cashierhead with password 'Pa$$w0rd';
alter role rl_cashierhead LOGIN;
grant connect on database "cinema_db" to rl_cashierhead;

create role rl_cashier with password 'Pa$$w0rd';
alter role rl_cashier LOGIN;
grant connect on database "cinema_db" to rl_cashier;

create role rl_visitor with password 'Pa$$w0rd';
alter role rl_visitor LOGIN;
grant connect on database "cinema_db" to rl_visitor;

create role rl_administrator with password 'Pa$$w0rd';
alter role rl_administrator LOGIN;
grant connect on database "cinema_db" to rl_administrator;