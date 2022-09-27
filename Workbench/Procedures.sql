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














