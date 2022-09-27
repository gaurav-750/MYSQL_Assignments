-- Calculate area of circle , radius varying from 5 to 9
-- Store the radius and area in a table named 'Areas'
-- consisting of two columns radius and area
-- drop procedure if exists cal_area;

-- delimiter $$
-- create procedure cal_area()
-- begin
--     declare r int;
--     declare a decimal(5,2);
--     set r = 5;
--     
--     drop table if exists areas;
-- 	-- create the table:
--     create table areas(
-- 		radius int,
--         areas decimal(5,2)
--     );
--     
--     my_loop : loop
-- 		IF r > 9 THEN
-- 			leave my_loop;
-- 		END IF;
-- 	
-- 		set a = pi() * r * r; -- calculate the area
--         -- select concat('Values: ', r, ' ', a) AS 'Values';
--         insert into areas values(r, a);
-- 		
--         set r = r + 1;
--     end loop;
-- 	
--     select * from areas;
-- end$$
-- delimiter ;

-- call cal_area();



-- Borrower (Roll_no, Name, Date of Issue, Name of Book, Status)
-- Fine (Roll_no, Date, Amount)
-- Check the number of daya from issue and fine accordingly, insert fine in amount col of Fine.
-- After submitting, change the status from I to R

-- drop table if exists Borrower;
-- create table Borrower(
-- 	Roll_no int primary key,
--     Name varchar(20) not null,
--     date_of_issue date not null,
--     book_name varchar(50) primary key,
--     status char(1) default 'I'
-- );

-- insert into Borrower values(
-- 	1,
--     "Gaurav",
--     '2022-09-01',
--     "Into the Sideways World",
--     default
-- );

-- insert into Borrower values(
-- 	2,
--     "Kanak",
--     '2022-09-20',
--     "What not to do when you turn invisible",
--     default
-- );

-- insert into Borrower values(
-- 	3,
--     "Sarthak",
--     '2022-08-01',
--     "Time travelling with a hampster",
--     default
-- );

-- insert into Borrower values(
-- 	1,
--     "Gaurav",
--     '2022-09-25',
--     "The Godfather",
--     default
-- );

-- create table Fine(
-- 	Roll_no int, 
--     date_of_return date not null,
-- 	date_of_issue date not null,
--     amount int,
--     foreign key (Roll_no) references Borrower(Roll_no)
-- );

-- drop procedure if exists cal_fine;

-- delimiter $$
-- create procedure cal_fine(
-- 	Roll_no int,
--     book_name varchar(50)
-- )
-- begin
-- 	declare fine int;
--     declare issue_date date;
--     declare days int;
--     
--     -- Exception Handling for Roll_no (It mustn't be -ve)
--     IF Roll_no <= 0 THEN
-- 		SIGNAL SQLSTATE '22003'
--         SET message_text = 'Roll no must be positive!' ;
--     END IF;
--     
--     select 
-- 		date_of_issue
-- 	from Borrower b
--     where b.Roll_no = Roll_no AND b.book_name = book_name
--     INTO issue_date;
--     
--     select datediff(curdate(), issue_date)
--     into days;
--     
--     IF days between 15 and 30 THEN
-- 		set fine = days * 5;
-- 	elseif days > 30 THEN
-- 		set fine = 150 + (days-30) * 50;
--     END IF;
-- 	
--     -- finally, insert into fine table:
--     insert into Fine values(Roll_no, curdate(), issue_date, ifnull(fine, 0));
--     -- update status from I to R:
--     update Borrower b
--     set status = 'R'
--     where b.Roll_no = Roll_no AND b.book_name = book_name; 
-- end$$
-- delimiter ;


-- call cal_fine(1, 'Into the Sideways World');
-- call cal_fine(1, 'The Godfather');


-- Assignment no 05:
-- Stud_Marks(Roll, name, total_marks)
-- Result(Roll, name, class)

create table Stud_Marks(
	Roll_no int primary key,
    name varchar(20),
    total_marks int
);

insert into Stud_Marks values (1, "Gaurav", 1400);
insert into Stud_Marks values (2, "Rahul", 850);
insert into Stud_Marks values (3, "Rohit", 980);

create table Result(
	Roll_no int,
    name varchar(20),
    class varchar(20),
    foreign key (Roll_no) references Stud_Marks(Roll_no)
);

-- desc Result;

drop procedure if exists proc_Grade;

-- delimiter $$
-- create procedure proc_Grade(
-- 	Roll_no int
-- )
-- begin
-- 	declare marks int;
--     declare stud_name varchar(20);
--     declare class varchar(20);
--     
--     -- setting the marks:
--     select total_marks, name
--     from Stud_Marks s
--     where s.Roll_no = Roll_no
--     INTO marks, stud_name;
--     
--     IF marks < 825 THEN
-- 		SIGNAL SQLSTATE '22003'
-- 			SET message_text = 'Marks must be greater than 824!';
--     END IF;
--     
--     
--     IF marks between 990 and 1500 THEN
-- 		set class = 'Distinction';
-- 	ELSEIF marks between 900 and 989 THEN
-- 		set class = 'First class';
-- 	ELSEIF marks between 825 and 899 THEN
-- 		set class = 'Higher second class';
-- 	END IF;
--     
--     -- insert the values into Result table:
--     insert into Result values(
-- 		Roll_no,
--         stud_name,
--         class
--     );
--    
-- end$$
-- delimiter ;

-- call proc_Grade(1);
-- call proc_Grade(2);
-- call proc_Grade(3);

-- insert into Stud_Marks values(
-- 	4, "Rishabh", 820
-- );
-- call proc_Grade(4);


-- FUNCTION:
drop function if exists calClass;

delimiter $$
create function calClass(
	Roll_no int
)
returns varchar(20)
deterministic -- attribute
begin
	declare marks int;
	declare class varchar(20);
    
    select total_marks
    from Stud_Marks s
    where s.Roll_no = Roll_no
    INTO marks;
    
    IF marks < 825 THEN
		SIGNAL SQLSTATE '22003'
			SET message_text = 'Marks must be greater than 824!';
    END IF;

    
    IF marks between 990 and 1500 THEN
		set class = 'Distinction';
	ELSEIF marks between 900 and 989 THEN
		set class = 'First class';
	ELSEIF marks between 825 and 899 THEN
		set class = 'Higher second class';
	END IF;
    
	return class;
end$$
delimiter ;

drop table if exists Result;

create table Result as
	select 
		Roll_no,
		name,
		calClass(Roll_no) as Class
	from Stud_Marks
	where Roll_no != 4;





































