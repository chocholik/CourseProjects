/*create DB*/
create database Patient_diagnosis;
use Patient_diagnosis;

/*create table*/
create table patient_datasets (date date, pid int, p_name varchar(50), age int, weight int, gender varchar(10), location varchar (50), phone_no int, disease varchar(50), doctor_name varchar(50), doctor_id int);
/*modify tape of one column*/
alter table Patient_diagnosis.patient_datasets modify pid varchar(50);
describe Patient_diagnosis.patient_datasets;

/*insert data*/
insert into Patient_diagnosis.patient_datasets (date, pid, p_name, age, weight, gender, location, phone_no, disease, doctor_name, doctor_id) 
value ("2023-08-23", "AA0101", "Honza", 35, 85, "M", "Prague", "123456789", "Cardiac", "Mohan", 21);

/*check after IMPORT from wizard*/
select * from Patient_diagnosis.patient_datasets;

/*total num of pacients*/
select count(pid) as Total_patients from Patient_diagnosis.patient_datasets;

/*age is max*/
select max(age) from Patient_diagnosis.patient_datasets;

/*current date*/
select pid, p_name, curdate() from Patient_diagnosis.patient_datasets;

/*old vs new uppercase name*/
select p_name, upper(p_name) from Patient_diagnosis.patient_datasets;

/*lenght of name*/
select p_name, length(p_name) from Patient_diagnosis.patient_datasets;

/*gender M or F*/
select p_name, mid(gender, 1,1) from Patient_diagnosis.patient_datasets;

/*combine names*/
select concat(p_name, ' ', doctor_name) from Patient_diagnosis.patient_datasets;

/*log value*/
select p_name, age, log10(age) from Patient_diagnosis.patient_datasets;

/*extract year*/
select p_name, extract(YEAR from date) from Patient_diagnosis.patient_datasets;

/*null if similar names*/
select p_name, doctor_name, if(p_name = doctor_name, "OK", NULL) from Patient_diagnosis.patient_datasets;

/*age > 40*/
select age, if(age>40, "YES", "NO") from Patient_diagnosis.patient_datasets;

/*doctor duplicates name*/
select doctor_name, count(*) as count from Patient_diagnosis.patient_datasets group by doctor_name having count(*)=1;