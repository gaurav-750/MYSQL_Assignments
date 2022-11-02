create a Library table
create a library audit table with the same cols

create table Library(
	isbn int primary key auto_increment,
    book_name varchar(50),
    author varchar(30),
    publish_year varchar(4)
);

insert into Library values(
	default,
    "Time travelling with hampster",
    "Ross Welford",
    "2016"
);

insert into Library values(
	default,
    "The Godfather",
    "Mario Puzo",
    "1969"
);

insert into Library values(
	default,
    "Person Controller",
    "David Baddiel",
    "2015"
);

insert into Library values(
	default,
    "Hold my hand",
    "Durjoy Datta",
    "2013"
);

create table Library_Audit(
	isbn int,
    book_name varchar(50),
    author varchar(30),
    publish_year varchar(4),
    status char(1)
);

delimiter $$
create trigger library_after_update
	AFTER UPDATE ON Library
    for each row
BEGIN
	insert into library_audit values(
		old.isbn,
        old.book_name,
        old.author,
        old.publish_year,
        'U'
    );

END$$
delimiter ;

update library
set publish_year = 2012
where isbn = 6;

-- select * from library;
-- select * from library_audit;


delimiter $$
create trigger library_after_delete
	AFTER DELETE ON Library
    for each row
BEGIN
	insert into library_audit values(
		old.isbn,
        old.book_name,
        old.author,
        old.publish_year,
        'D'
    );

END$$
delimiter ;

delete from library
where isbn = 6;









































