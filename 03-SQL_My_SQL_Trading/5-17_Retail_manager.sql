/*create DB*/
create database SQL_Basics;
use SQL_Basics;
/*create tables*/
create table SQL_Basics.ctable (cid int, cname varchar(100), clocation varchar(100), cphone varchar(20));
describe customer;
create table ptable (pcode varchar(100), pname varchar(100), price float, stock int, category varchar(50));
describe product;
create table sales (sdate date, order_n long, pcode varchar(100), pname varchar(100), quant int, price float);
describe sales;
/*rename bad tables names*/
ALTER TABLE ptable RENAME TO product;
ALTER TABLE ctable RENAME TO customer;

/*Insert values into table*/
insert into SQL_Basics.customer (cid, cname, clocation, cphone) values (001, "Peter", "Prague", "987654321"), (002, "Pavel", "Brno", "123456789");
select * from customer;
insert into SQL_Basics.product (pcode, pname, price, stock, category) value (1, 'XBOX', 1000, 10, "console");
insert into SQL_Basics.product (pcode, pname, price, stock, category) value (2, 'Playstation', 900, 5, "console");
select * from product;
insert into SQL_Basics.sales (sdate, order_n, pcode, pname, quant, price) values ("2023-08-22", 5001, 1, "XBOX", 1, 1000), ('2023-08-21', 5002, 2, "Playstation", 2, 1800);
select * from sales;

/*add columns to sales table*/
alter table sales add (S_no int, categories varchar(100));
describe sales;

/*change stock type*/
alter table product modify stock varchar(25); 

/*change table name*/
ALTER TABLE customer RENAME TO customer_details;

/*drop columns*/
alter table sales drop column S_no;
alter table sales drop column categories;
describe sales;

/*display from sales, I must create new column Client ID*/
alter table sales add cid int;
select order_n, cid, sdate, price, quant from sales;

/*IMPORTING DATA FROM DOWNLOAD, customer and product data imported to my tables,
SALES WAS IMPORTED AS DOWNLOAD DATASHEET, downloaded datasheed has more columns then */
select order_no, c_id, order_date, price, qty from sales_datasets;

/*category is stationary*/
select * from product where category = "Stationary";

/*unique category*/
select distinct category from product order by category;

/*quant > 2 price <500*/
select * from sales_datasets where qty > 2 and price <500;

/*name ends with a*/
select cname from customer where cname like "%a";

/*desc order price*/
select * from product order by price desc;

/*similar categories >=2*/
select pcode, category from product where stock >= 2;

/*combine duplicated rows*/
select count(order_no) as all_orders, c_name from sales_datasets group by c_name with rollup;
