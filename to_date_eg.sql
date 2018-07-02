/*
Script to demonstrate the effect of specifying nls_date_language 
and alter session set nls_territory in oracle
tested on 12.1

The thread below https://twitter.com/sqldaily/status/1013731540726108161 refers
the reader can add the date literal examples quite easily. 

create the user as follows, or specify a different user

drop user u1 cascade;
create user u1 identified by u1 default tablespace users quota 10m on users;
grant create table to u1;
*/
drop table u1.date_eg purge;
create table u1.date_eg( dt date, fmt varchar2(50),territory varchar2(20), display varchar2(50) );

alter session set nls_territory='AMERICA';

insert into u1.date_eg(
    dt
,   fmt
,   territory
,   display) 
values (
    to_date('January 15, 1989, 11:00 AM','Month dd,YYYY, HH:MI AM','NLS_DATE_LANGUAGE=American') 
,   'NLS_DATE_LANGUAGE=American'
,   'AMERICA'
,   to_char(to_date('January 15, 1989, 11:00 AM','Month dd,YYYY, HH:MI AM','NLS_DATE_LANGUAGE=American') )
);

insert into u1.date_eg(
    dt
,   fmt
,   territory
,   display) 
values (
    to_date('01 15, 1989, 11:00','MM dd,YYYY, HH24:MI','NLS_DATE_LANGUAGE=Korean') 
,   'NLS_DATE_LANGUAGE=Korean'
,   'AMERICA'
,   to_char(to_date('01 15, 1989, 11:00','MM dd,YYYY, HH24:MI','NLS_DATE_LANGUAGE=Korean') )
);


alter session set nls_territory='KOREA';

insert into u1.date_eg(
    dt
,   fmt
,   territory
,   display) 
values (
    to_date('January 15, 1989, 11:00 AM','Month dd,YYYY, HH:MI AM','NLS_DATE_LANGUAGE=American') 
,   'NLS_DATE_LANGUAGE=American'
,   'KOREA'
,   to_char(to_date('January 15, 1989, 11:00 AM','Month dd,YYYY, HH:MI AM','NLS_DATE_LANGUAGE=American') )
);

insert into u1.date_eg(
    dt
,   fmt
,   territory
,   display) 
values (
    to_date('01 15, 1989, 11:00','MM dd,YYYY, HH24:MI','NLS_DATE_LANGUAGE=Korean')  
,   'NLS_DATE_LANGUAGE=Korean'
,   'KOREA'
,   to_char(to_date('01 15, 1989, 11:00','MM dd,YYYY, HH24:MI','NLS_DATE_LANGUAGE=Korean')  )
);

commit;

alter session set nls_territory='KOREA';
select * from u1.date_eg;
alter session set nls_territory='AMERICA';
select * from u1.date_eg;


/*
Typical output 

Table U1.DATE_EG dropped.


Table U1.DATE_EG created.


Session altered.


1 row inserted.


1 row inserted.


Session altered.


1 row inserted.


1 row inserted.


Commit complete.


Session altered.


DT       FMT                                                TERRITORY            DISPLAY                                           
-------- -------------------------------------------------- -------------------- --------------------------------------------------
89/01/15 NLS_DATE_LANGUAGE=American                         AMERICA              15-JAN-89                                         
89/01/15 NLS_DATE_LANGUAGE=Korean                           AMERICA              15-JAN-89                                         
89/01/15 NLS_DATE_LANGUAGE=American                         KOREA                89/01/15                                          
89/01/15 NLS_DATE_LANGUAGE=Korean                           KOREA                89/01/15                                          


Session altered.


DT        FMT                                                TERRITORY            DISPLAY                                           
--------- -------------------------------------------------- -------------------- --------------------------------------------------
15-JAN-89 NLS_DATE_LANGUAGE=American                         AMERICA              15-JAN-89                                         
15-JAN-89 NLS_DATE_LANGUAGE=Korean                           AMERICA              15-JAN-89                                         
15-JAN-89 NLS_DATE_LANGUAGE=American                         KOREA                89/01/15                                          
15-JAN-89 NLS_DATE_LANGUAGE=Korean                           KOREA                89/01/15                                          




*/