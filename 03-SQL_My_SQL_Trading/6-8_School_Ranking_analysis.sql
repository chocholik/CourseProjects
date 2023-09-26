/*create DB*/
create database Scool_ranking;
use Scool_ranking;
/*create tables*/
create table if not exists student_datasets (
    s_id int not null primary key,
    s_fname varchar(50),
    s_lname varchar(50),
    class int,
    age int
);
create table if not exists marksheet_dataset (score int, year int, class int, s_id int);
/*this is for control*/
describe Scool_ranking.student_datasets;
describe Scool_ranking.marksheet_dataset;
/*---IMPORTING DEMO DATA with wizard---*/
/*age >=16 a last name Kumar*/
select *
from Scool_ranking.student_datasets
where age >= 16
    and s_lname like 'Kumar';
/*800 > score > 1000*/
select *
from Scool_ranking.marksheet_datasets
where score >= 800
    and score <= 1000;
select *
from Scool_ranking.marksheet_datasets
where score between 800 and 1000;
/*new score*/
select (score + 5) as new_score,
    year,
    class,
    s_id
from Scool_ranking.marksheet_datasets;
/*sedc order of the score*/
select *
from Scool_ranking.marksheet_datasets
order by score desc;
/*first name with a*/
select *
from Scool_ranking.student_datasets
where s_fname like "a%";