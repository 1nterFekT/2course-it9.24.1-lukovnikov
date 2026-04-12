create or replace procedure Create_Additional_Tables ()
language plpgsql
as $$
	begin
		create table if not exists reviews (
			id_review serial not null
				constraint pk_reviews primary key,
			ticket_id int not null unique
				references tickets (id_ticket)
				on update cascade on delete cascade,
			-- Не смог прочекать даты, кроме как с помощью триггера. Поэтому проверка будет при вызове процедуры вставки
			review_date date not null,
			rating int not null check (rating between 0 and 10),
			review_text varchar(255) default 'Без комментариев'
		);

		create table if not exists review_comments (
			id_comment serial not null
				constraint pk_review_comments primary key,
			review_id int not null
				references reviews (id_review)
				on update cascade on delete cascade,
			client_id int not null
				references clients (id_client)
				on update cascade on delete cascade,
			-- Не смог прочекать даты, кроме как с помощью триггера. Поэтому проверка будет при вызове процедуры вставки
			comment_datetime timestamp not null,
			content varchar(255) not null
		);

		create index if not exists index_id_review
			on reviews (id_review);

		create index if not exists index_id_comment
			on review_comments (id_comment);
	end;
$$;

call Create_Additional_Tables ()