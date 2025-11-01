create database week1;
use week1;

create table person(
driver_id varchar(10) PRIMARY KEY,
name varchar(20),
address varchar(30)
);

desc person;

create table car(reg_num varchar(10),model varchar(10),year int, primary
key(reg_num));

desc car;

create table accident(report_num int, accident_date date, location
varchar(20),primary key(report_num));

desc accident;

create table owns(driver_id varchar(10),reg_num varchar(10),

primary key(driver_id, reg_num),

foreign key(driver_id) references person(driver_id),

foreign key(reg_num) references car(reg_num));

desc owns;

create table participated(driver_id varchar(10), reg_num varchar(10),

report_num int, damage_amount int,

primary key(driver_id, reg_num, report_num),

foreign key(driver_id) references person(driver_id),

foreign key(reg_num) references car(reg_num),

foreign key(report_num) references accident(report_num));

desc participated;

-- Query 2

insert into accident values (11,'2003-01-01','Mysore Road');
insert into accident values (12,'2004-02-02','South end Circle');
insert into accident values (13,'2003-01-21','Bull temple Road');
insert into accident values (14,'2008-02-17','Mysore Road');
insert into accident values (15,'2004-03-05','Kanakpura Road');

select * from accident;

insert into person values('A01','Richard','Srinivas Nagar');
insert into person values('A02','Pradeep','Rajajinagar');
insert into person values('A03','Smith','Ashok Nagar');
insert into person values('A04','Venu','NR Colony');
insert into person values('A05','John','Hanumanth Nagar');

select * from person;

insert into car values('KA052250','Indica',1990);
insert into car values('KA031181','Lancer',1957);
insert into car values('KA095477','Toyota',1998);
insert into car values('KA053408','Honda',2008);
insert into car values('KA041702','Audi',2005);

select * from car;

insert into owns values('A01','KA052250');
insert into owns values('A02','KA031181');
insert into owns values('A03','KA095477');
insert into owns values('A04','KA053408');
insert into owns values('A05','KA041702');

select * from owns;

insert into participated values('A01','KA052250',11,10000);
insert into participated values('A01','KA031181',12,50000);
insert into participated values('A01','KA095477',13,25000);
insert into participated values('A01','KA053408',14,3000);
insert into participated values('A01','KA041702',15,5000);

select * from participated;

-- QUERY 3

update participated set damage_amount=25000 where reg_num='KA053408' and report_num=14;
commit;
select * from participated;

insert into accident values(16,'2008-03-15','Domlur');
select * from accident;

select accident_date,location
from ACCIDENT;

select driver_id
from PARTICIPATED
where damage_amount >=25000;


-- WEEK2 

select * from car order by year asc;

select count(report_num) CNT from car c,participated p where c.reg_num=p.reg_num and
model='Lancer';

SELECT COUNT(DISTINCT driver_id) CNT
FROM participated a
JOIN accident b ON a.report_num = b.report_num
WHERE YEAR(b.accident_date) = 2008;

