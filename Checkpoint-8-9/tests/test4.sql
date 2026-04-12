create or replace procedure add_genre_to_movie (
	p_movie_id int,
	p_genre_id int
)
language plpgsql
as $$
begin
	if exists (
		select 1 from movies_genres
		where movie_id = p_movie_id
		and genre_id = p_genre_id
	) then
		raise exception 'Указанный жанр уже есть у фильма!';
	end if;

	insert into movies_genres(movie_id, genre_id)
	values (p_movie_id, p_genre_id);
end;
$$;

call add_genre_to_movie (1, 1);