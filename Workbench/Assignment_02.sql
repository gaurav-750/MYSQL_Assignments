-- display all employee details with department comp and it and first name starting with p or h
-- select 
-- 	emp_id,
--     concat(fname, ' ', lname) as name,
--     d.dname as Department,
--     designation,
--     JoinDate,
--     d.dlocation
-- from employee e
-- join dept d using(dept_id)
-- where d.dname in ('Computer', 'IT')
-- 	and
--     e.fname regexp ('^A|^R');

-- Lists the number of different Employee Positions.  
-- select distinct designation
-- from employee;

-- Give 10% increase in Salary of the Employee whose joindate  before 2015.  
-- select 
-- 	*,
--     salary * 1.1 as increased_salary
-- from employee
-- where year(JoinDate) < '2005';


--  Delete all the department details having location as ‘mumbai’
-- delete from Dept
-- where dlocation = 'Mumbai';

-- insert into Dept values(3, 'ENTC', 'Mumbai');

-- Find the names of Projects with location ‘pune’  .  
-- select 
-- 	*
-- FROM project
-- where Plocation = 'Pune';


-- Find the project having cost in between 100000 to 500000. 
-- select
-- 	* 
-- from project
-- where Pcost between 10000 and 18000;


--  Find the project having maximum price and find average Project cost.
-- select 
-- 	Proj_id,
--     Pname,
--     Pcost as cost,
--     round(avg(Pcost)) as average_cost
-- from project
-- where Pcost = (
-- 			select 
-- 				max(Pcost)
-- 			from project
-- 		);


--  Display all employees with Emp _id  and Emp name in descending  order
-- select 
-- 	*
-- from employee
-- order by Emp_id DESC;

-- select 
-- 	*
-- from employee
-- order by fname DESC;

-- Display Proj_name,Plocation ,Pcost of all project started in 2004,2005,2007   
-- select 
-- 	Pname,
--     Plocation,
--     Pcost,
--     Pyear
-- from project
-- where Pyear in ('2007', '2008', '2010');

-- Find Department Name ,employee name, designation for which project year is 2010
-- select 
-- 	e.Emp_id,
--     d.Dept_id,
-- 	d.dname,
--     e.fname,
--     e.designation,
--     p.Proj_id as project_id,
--     p.Pyear
-- from employee e
-- join dept d using(Dept_id)
-- right join project p using(Dept_id)
-- where p.Pyear = 2010;

--  Display designation,Dept id which Project cost is greater than 8000
-- select 
--     p.Proj_id,
--     p.Pcost,
-- 	e.Emp_id,
--     e.fname,
--     e.designation,
--     e.Dept_id
-- from project p
-- left join employee e using(Dept_id)
-- where p.Pcost > 8000;

-- Create a view showing the employee and Department details.
-- create view EmpDept as 
-- select 
-- 	e.Emp_id,
--     concat(fname, ' ', lname) as name,
--     e.Dept_id,
--     e.designation,
--     e.salary,
--     d.dname
-- from employee e
-- join Dept d using (Dept_id);

-- select * from EmpDept;

-- Perform Manipulation on simple view - Insert, update, delete, drop view

-- update EmpDept
-- set designation = 'CXO'
-- where Emp_id = 1;

-- drop view EmpDept;













