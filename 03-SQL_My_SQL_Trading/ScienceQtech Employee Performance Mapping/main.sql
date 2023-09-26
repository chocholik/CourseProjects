/*Creating DB*/
create database if not exists u878289772_ScienceQtechVF;
/*Using DB as default DB*/
use u878289772_ScienceQtechVF;

/*Creating tables in DB - point 1*/
create table if not exists emp_record_table (emp_id varchar(50), first_name varchar(100), last_name varchar(100), gender varchar(10), role varchar(100),
dept varchar(100), exp int, country varchar(100), continent varchar(100), salary float, emp_rating float, manager_id varchar(50), proj_id varchar(50));

create table if not exists proj_table (project_id varchar(100), proj_name varchar(100),  domain varchar(100), start_date date, closure_date date, 
dev_qtr varchar(50), status varchar(50));

create table if not exists  data_science_team(emp_id varchar(100), first_name varchar(100), last_name varchar(100), gender char, role varchar(100), dept varchar(100),
exp int, county varchar(100), continent varchar(50));

/*importing demo data from dataset, I use import tool in MySQL Workbench*/

/*visual check of imported data*/
select * from emp_record_table;
select * from proj_table;
select * from data_science_team;

/*point 3 - Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.*/
select emp_id, first_name, last_name, gender, dept from data_science_team;

/*point 4 - Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: */
/* less than two */
select emp_id, first_name, last_name, gender, dept, emp_rating from emp_record_table where emp_rating < 2;
/* greater than four */
select emp_id, first_name, last_name, gender, dept, emp_rating from emp_record_table where emp_rating > 4;
/* between two and four */
select emp_id, first_name, last_name, gender, dept, emp_rating from emp_record_table where emp_rating between 2 and 4;

/*point 5 - Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME*/
select concat(first_name, ' ' , last_name) as name from emp_record_table where dept = 'FINANCE';

/*point 6 - Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President). */
/*I create auxiliary table to join original table*/
drop table if exists managers;
create table managers (emp_id varchar(50), reporters int);
insert into managers (emp_id, reporters) select manager_id, count(emp_id) from emp_record_table where manager_id <> '' group by manager_id;
select * from managers ;
/*making view as we want*/
select emp_id, concat(first_name, " ", last_name), role, reporters from emp_record_table inner join managers using (emp_id);



/*point 7 - Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table. */
select d.first_name, d.last_name from data_science_team d where dept in ("HEALTCARE", "FINANCE")
union
select e.first_name, e.last_name from emp_record_table e where dept in  ("HEALTCARE", "FINANCE");

/*point 8 - Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department. */
/*drop procedure if exists*/
drop procedure if exists compare_exp_vs_deptEXP;
/*Creating procedure*/
delimiter &&
create procedure compare_exp_vs_deptEXP()
begin
	/*dropping table if exists*/
    drop table if exists max_dept;
    /*creating helper table*/
	create table max_dept (dept varchar(100), max_dept_rating float);
	insert into max_dept (dept, max_dept_rating) select dept, max(emp_rating) as max_dept_rating from emp_record_table where dept = "ALL";
	insert into max_dept (dept, max_dept_rating) select dept, max(emp_rating) as max_dept_rating from emp_record_table where dept = "AUTOMOTIVE";
	insert into max_dept (dept, max_dept_rating) select dept, max(emp_rating) as max_dept_rating from emp_record_table where dept = "FINANCE";
	insert into max_dept (dept, max_dept_rating) select dept, max(emp_rating) as max_dept_rating from emp_record_table where dept = "HEALTHCARE";
	insert into max_dept (dept, max_dept_rating) select dept, max(emp_rating) as max_dept_rating from emp_record_table where dept = "RETAIL";
	/*making view as we want*/
	select emp_id, concat(first_name, " ", last_name), country, continent, salary, role, dept, emp_rating, max_dept_rating from emp_record_table inner join max_dept using (dept) order by dept;
end&&
/*Calling procedure*/
 call compare_exp_vs_deptEXP;

/*point 9 - Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.*/
select min(salary), max(salary), role from emp_record_table group by role;

/*point 10 - Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.*/
/*drop procedure if exists*/
drop procedure if exists rating;
/*creating procedure*/
delimiter &&
create procedure rating()
begin
	select concat(first_name, " ", last_name) as name, exp, 
	case 
		when exp <= 4 then "E"
		when exp > 4 and exp <=8 then "D"
		when exp > 8 and exp <=12 then "C"
		when exp > 12 and exp <=16 then "B"
		when exp > 16  then"A"
	end as mark

    from emp_record_table;
end&&
/*calling procedure*/
 call rating;



/*point 11 - Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.*/
drop view if exists salary_bigeer_6k;
create view salary_bigeer_6k as select concat(first_name, " ", last_name) as name, salary, country from emp_record_table where salary > 6000;
select * from salary_bigeer_6k;

/*point 12 - Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.*/
/*drop procedure if exists*/
drop procedure if exists more_then10;
/*creating procedure*/
delimiter &&
create procedure more_then10()
begin
	select first_name, last_name, exp FROM emp_record_table WHERE exp > 10;
end &&
/*calling the procedure*/
call more_then10();

/*point 13 - Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.*/
/*drop procedure if exists*/
drop procedure if exists more_then3;
/*creating procedure*/
delimiter &&
create procedure more_then3()
begin
	select * from emp_record_table WHERE exp > 3;
end &&
/*calling the procedure*/
call more_then3();

/*point 14 - Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.*/
/*drop procedure if exists*/
drop procedure if exists check_position;
/*Creating procedure*/
delimiter &&   
create procedure check_position()
begin
	select concat(first_name, " ", last_name) as name, role, exp,
    case
		when role = "JUNIOR DATA SCIENTIST" then exp >0 & exp<=2
		when role = "ASSOCIATE DATA SCIENTIST" then exp >2 & exp<=5
        when role = "SENIOR DATA SCIENTIST" then exp >5 & exp<=10
		when role = "LEAD DATA SCIENTIST" then exp >10 & exp<=12
		when role = "MANAGER" then exp >12 & exp<=16
    end as check_position
	from data_science_team;
end &&
/*Calling the procedure*/
call check_position();
 
 
/*point 15 - Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.*/
/*creting index*/
create index indx on emp_record_table(first_name);
explain select * from emp_record_table where first_name ='Eric';
/*Checking if the index was created*/
show indexes from emp_record_table;


/*point 16 - Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).*/
drop procedure if exists bonus;
delimiter &&
create procedure bonus()
begin
	select emp_id,first_name,last_name, (salary+(salary*0.05*emp_rating)) as salary_with_bonus from emp_record_table;
end&&
/*calling the procedure*/
call bonus;

/*point 17 - Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.*/
drop procedure if exists salary_by_country;
delimiter &&
create procedure salary_by_country (country1 varchar(100))
begin
	select avg(salary), country, continent from emp_record_table where country = country1 group by continent, country;
end&&
/*calling the procedure*/
call salary_by_country ("GERMANY");
