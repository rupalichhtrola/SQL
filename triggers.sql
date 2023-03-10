/*A trigger is a stored procedure in database which automatically invokes whenever a special event in the database occurs.*/


create database if not exists bit;
use bit;

create table course2(
course_id int,
course_desc varchar(30),
course_mentor varchar(60),
course_price int,
course_discount int,
create_date date,
user_info varchar(30));

create table course_update(
course_mentor_update varchar(50),
course_price_update int,
course_discount_update int);

#BEFORE triggers run the trigger action before the triggering statement is run.
delimiter //
create trigger course_before_insert1123
before insert 
on course2 for each row
begin 
	declare user_val varchar(50);
	set new.create_date = sysdate();
SELECT USER() INTO user_val;
    set new.user_info = user_val;
    insert into ref_course values(sysdate() , user_val);
    
end; //

create table ref_course(
recode_insert_date date,
recode_user_insert varchar(50)
);

select * from ref_course;
select * from course2;

insert into course2(course_id,course_desc ,course_mentor,course_price,course_discount)
values(101,"fsds","jalpa",1000,10);

create table test1(
c1 varchar(30),
c2 date,
c3 int);


create table test2(
c1 varchar(30),
c2 date,
c3 int);


create table test3(
c1 varchar(30),
c2 date,
c3 int);


delimiter //
create trigger to_update_other
before insert 
on test1 for each row
begin
	
    insert into test2 values('xyz',sysdate() ,23543);
    insert into test3 values('xyz',sysdate() ,23543);
    
end; //

insert into test1 values(
'xyz',sysdate() ,3456
);

select * from test1;
select * from test2;
select * from test3;

#AFTER triggers run the trigger action after the triggering statement is run. 

delimiter //
create trigger to_update_other_table
after insert 
on test1 for each row
begin
	
    update test2 set c1 ='abc' where c1='xyz';
    delete from test3 where c1 ='xyz';
    
end; //

insert into test1 values(
'harsh',sysdate() ,3456);

delimiter //
create trigger to_delete_other_table
after delete
 on test1 for each row
begin	
    insert into test3 values('after delete',sysdate(),43256);
end; //

 /*Deleting a row in a view could either mean deleting it from the base table or updating some values
 so that it is no longer selected by the view*/
 
select * from test1;
select * from test3;

delete from test1 where c1='harsh';



delimiter //
create trigger to_delete_other_before_table
before delete 
on test1 for each row
begin
    insert into test2(c1,c2,c3) values(old.c1,old.c2,old.c3);    
end; //


delete from test1 where c1='abc';


create table test11(
c1 varchar(30),
c2 date,
c3 int);


create table test12(
c1 varchar(30),
c2 date,
c3 int);


create table test13(
c1 varchar(30),
c2 date,
c3 int);

insert into test11 values('krupa1',sysdate(),2345),
('krupa13',sysdate(),2345),
('krupa12',sysdate(),2345),
('krupa14',sysdate(),2345),
('krupa15',sysdate(),2345);

insert into test12 values('krupa1',sysdate(),2345),
('krupa13',sysdate(),2345),
('krupa12',sysdate(),2345),
('krupa14',sysdate(),2345),
('krupa15',sysdate(),2345);

insert into test13 values('krupa1',sysdate(),2345),
('krupa13',sysdate(),2345),
('krupa12',sysdate(),2345),
('krupa14',sysdate(),2345),
('krupa15',sysdate(),2345);

select * from test11;
select * from test12;
select * from test13;


delimiter //
create trigger to_update_other_before
before update 
on test11 for each row
begin
    insert into test12(c1,c2,c3) values(new.c1,new.c2,new.c3);    
end; //

/*Updating a column in a view that involves joins might change the semantics of other columns that are not projected by the view.

*/
drop trigger to_update_other_before;

update test11 set c1='insert new' where c1='krupa1';

