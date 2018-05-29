--Register new user
insert into Users (email,password,first_name,last_name)
values('test2@gmail.com','asasasa','john','luu');

----------------------------------------------------------

--Creating new questions------------------------------------------
insert into new_questions (user_id,question_text,question_date)
values(1,'How are you my friends4',sysdate);
--returning user_id into ?; RETURNS USER_ID TO DAO CALL
--https://stackoverflow.com/questions/3552260/plsql-jdbc-how-to-get-last-row-id/3552353#3552353

--Create options for the question
--gets the user_id from the above
insert into new_options(question_id,option_text)
values(1,'Good');
insert into new_options(question_id,option_text)
values(1,'Bad');
insert into new_options(question_id,option_text)
values(1,'Average');

--------------------------------------------------------

SELECT * FROM User_Watching where user_id = 1 and QUESTION_ID = 1;

INSERT INTO USER_WATCHING (USER_ID, QUESTION_ID)
VALUES (1,1); 

DELETE USER_WATCHING WHERE USER_ID = 1 AND QUESTION_ID = 1;


select * from new_questions
order by watches desc, question_date asc
fetch first 5 rows only;

--Insert new questions into questions------------------------
INSERT INTO QUESTIONS(QUESTION_ID,USER_ID,QUESTION_TEXT,WATCHES,QUESTION_DATE)
select QUESTION_ID,USER_ID,QUESTION_TEXT,WATCHES,QUESTION_DATE from new_questions
order by watches desc, question_date asc
fetch first 5 rows only;



--INSERT NEW_OPTIONS INTO OPTIONS
INSERT INTO OPTIONS(OPTION_ID,QUESTION_ID,OPTION_TEXT)
select OPTION_ID,QUESTION_ID,OPTION_TEXT from new_options
where QUESTION_ID in (select QUESTION_ID from new_questions
order by watches desc, question_date asc
fetch first 5 rows only);

--Delete new questions and options
truncate table new_options;
truncate table user_watching;
delete from new_questions;
--------------------------------------------------------------
--USER WATCHING NEW QUESTION;
INSERT INTO USER_WATCHING (USER_ID,QUESTION_ID)
VALUES(1,1);

UPDATE NEW_QUESTIONS SET WATCHES = WATCHES + 1
where QUESTION_ID = 1;


--UNWATCHING A NEW QUESTION
DELETE USER_WATCHING WHERE  USER_ID = 1 AND QUESTION_ID = 1;

UPDATE NEW_QUESTIONS SET WATCHES = WATCHES - 1
where QUESTION_ID = 1;

------------------------------------------------------------
SELECT * FROM OPTIONS WHERE QUESTION_ID = 6;

--USER_CHOOSING NEW
INSERT INTO USER_CHOICES(USER_ID,QUESTION_ID,OPTION_ID)
VALUES(1,6,16);

UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE + 1
WHERE OPTION_ID = 16;

--USER CHANGING CHOICE
UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE-1
WHERE OPTION_ID IN (
SELECT OPTION_ID FROM USER_CHOICES WHERE USER_ID = 1 AND QUESTION_ID = 6);

UPDATE USER_CHOICES SET OPTION_ID = 17 
WHERE USER_ID = 1 AND QUESTION_ID = 6;

UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE + 1
WHERE OPTION_ID = 17;

SELECT OPTION_ID FROM USER_CHOICES WHERE USER_ID = 1 AND QUESTION_ID = 6;
/*
SELECT USER_CHOICES.OPTION_ID FROM USER_CHOICES JOIN
OPTIONS ON USER_CHOICES.OPTION_ID = OPTIONS.OPTION_ID
JOIN QUESTIONS ON QUESTIONS.QUESTION_ID = OPTIONS.QUESTION_ID
WHERE USER_CHOICES.USER_ID = 1 AND QUESTIONS.QUESTION_ID = 6;
*/
-------------------------------------------------------------

--CREATING COMMENTS

INSERT INTO COMMENTS (USER_ID,QUESTION_ID,COMMENT_TEXT)
VALUES (1,6,'This question sucks');

-------------------------------------------------------------

--Getting todays questions
Select * from QUESTIONS where QUESTION_DATE >= trunc(sysdate-1);
select * from Questions;
--Getting choices from questions
select * from OPTIONS where question_id = 10;

--Getting Old Questions
Select * from QUESTIONS where QUESTION_DATE < trunc(sysdate);

--Getting New Questions
Select * from New_Questions;

--Getting New Options from new users
select * from new_OPTIONS where question_id = 11;


--AUTOMATICALLY TRUNCATE TABLES ETC
begin
  dbms_scheduler.create_job
  (
   job_name             => 'UPDATE_TABLE',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'begin
                            INSERT INTO QUESTIONS(QUESTION_ID,USER_ID,QUESTION_TEXT,WATCHES,QUESTION_DATE)
                            select QUESTION_ID,USER_ID,QUESTION_TEXT,WATCHES,QUESTION_DATE from new_questions
                            order by watches desc, question_date asc
                            fetch first 5 rows only;

                            INSERT INTO OPTIONS(OPTION_ID,QUESTION_ID,OPTION_TEXT)
                            select OPTION_ID,QUESTION_ID,OPTION_TEXT from new_options
                            where QUESTION_ID in (select QUESTION_ID from new_questions
                            order by watches desc, question_date asc
                            fetch first 5 rows only);

                            delete from new_options;
                            delete from user_watching;
                            delete from new_questions;
                            commit; end;',
                            
   start_date           =>  trunc(sysdate+1),
   repeat_interval      => 'FREQ=DAILY;BYHOUR=0;BYMINUTE=0',
   enabled              => TRUE,
   auto_drop            => FALSE
  );
end;

begin
  dbms_scheduler.create_job
  (
   job_name             => 'DELETE_PENDING',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'begin
   
                            DELETE FROM USER_WATCHING;
   
                            DELETE FROM OPTIONS WHERE OPTION_ID IN(
                            select OPTIONS.OPTION_ID from OPTIONS join questions on questions.question_id = options.question_id 
                            where questions.question_date >= trunc(sysdate)
                            and options.QUESTION_ID NOT in 
                            (select question_id from questions
                            where QUESTIONS.QUESTION_DATE >= trunc(sysdate)
                            order by watches desc, question_date asc
                            fetch first 5 rows only));

                            delete from questions where question_date >= trunc(sysdate) and question_id not in(
                            select question_id from questions
                            where QUESTIONS.QUESTION_DATE >= trunc(sysdate)
                            order by watches desc, question_date asc
                            fetch first 5 rows only);
                            commit; end;',
                            
   start_date           =>  trunc(sysdate+1),
   repeat_interval      => 'FREQ=DAILY;BYHOUR=0;BYMINUTE=0',
   enabled              => TRUE,
   auto_drop            => FALSE
  );
end;


begin
  dbms_scheduler.create_job
  (
   job_name             => 'DELETE_ARCHIVE',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'begin
   
                           delete from comments where comments.comment_id in(
                            select comments.comment_id from comments join questions on comments.question_id = questions.question_id
                            where question_date < trunc(sysdate-14));


                            DELETE FROM USER_CHOICES WHERE QUESTION_ID IN(
                            SELECT QUESTIONS.QUESTION_ID FROM USER_CHOICES JOIN QUESTIONS ON USER_CHOICES.QUESTION_ID = QUESTIONS.QUESTION_ID
                            WHERE QUESTION_DATE < TRUNC(SYSDATE-14));

                            DELETE FROM OPTIONS WHERE OPTIONS.OPTION_ID IN(
                            SELECT OPTIONS.OPTION_ID FROM OPTIONS JOIN QUESTIONS ON OPTIONS.QUESTION_ID = QUESTIONS.QUESTION_ID
                            WHERE QUESTION_DATE < TRUNC(SYSDATE-14));


                            DELETE from questions where question_date < trunc(sysdate-14);
                            commit; end;',
                            
   start_date           =>  trunc(sysdate+1),
   repeat_interval      => 'FREQ=DAILY;BYHOUR=0;BYMINUTE=0',
   enabled              => TRUE,
   auto_drop            => FALSE
  );
end;


EXEC  DBMS_SCHEDULER.ENABLE('DELETE_PENDING');
EXEC  DBMS_SCHEDULER.ENABLE('DELETE_ARCHIVE');

EXEC DBMS_SCHEDULER.drop_job(job_name => 'DELETE_PENDING');
EXEC DBMS_SCHEDULER.drop_job(job_name => 'DELETE_ARCHIVE');

--https://dba.stackexchange.com/questions/135571/auto-update-a-column-every-24-hours-in-oracle-database


GRANT SELECT ON SYS.DBA_JOBS_RUNNING TO john;

SELECT * FROM dba_scheduler_jobs; --ONLY DBA CAN USE THIS ONE
SELECT JOB_NAME,START_DATE,NEXT_RUN_DATE,RUN_COUNT,FAILURE_COUNT,REPEAT_INTERVAL,JOB_ACTION FROM user_scheduler_jobs;



commit;

select * from questions;
select * from options;

insert into questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends10',sysdate-15,1000);

insert into options(question_id,option_text)
values(63,'Good');

insert into user_choices(question_id,user_id,option_id)
values(63,1,170);



insert into comments(user_id,question_id,option_id,comment_text,comment_date)
values(1,63,170,'fasfas',sysdate);

insert into comments(user_id,question_id,option_id,comment_text,comment_date)
values(1,1,1,'fasfas',sysdate);


SELECT * FROM USER_CHOICES;





select comments.*, questions.question_Date from comments join questions on comments.question_id = questions.question_id
where question_date < trunc(sysdate-14);

SELECT USER_CHOICES.*, QUESTIONS.QUESTION_DATE FROM USER_CHOICES JOIN QUESTIONS ON USER_CHOICES.QUESTION_ID = QUESTIONS.QUESTION_ID
WHERE QUESTION_DATE < TRUNC(SYSDATE-14);

SELECT OPTIONS.*, QUESTIONS.QUESTION_DATE FROM OPTIONS JOIN QUESTIONS ON OPTIONS.QUESTION_ID = QUESTIONS.QUESTION_ID
WHERE QUESTION_DATE < TRUNC(SYSDATE-14);

select questions.* from questions where question_date < trunc(sysdate-14);




select * from questions where question_date >= (trunc(sysdate) - 1) and question_date < trunc(sysdate)- (1-1) ;

select * from questions where question_date >= (trunc(sysdate) - 0) and question_date < trunc(sysdate)- (0-1) ;

select * from questions;


sELECT USER_CHOICES.QUESTION_ID,USER_CHOICES.OPTION_ID FROM USER_CHOICES join questions on questions.question_id = USER_CHOICES.question_id
 where USER_CHOICES.USER_ID = 1  and USER_CHOICES.question_id in
(select QUESTION_ID from questions
where QUESTION_DATE < trunc(sysdate) and QUESTION_DATE >= trunc(sysdate)-7
order by question_score desc, question_date asc
offset (0*5) rows
fetch next 5 rows only);

select *  from Questions where QUESTION_DATE >= trunc(sysdate)-7 and QUESTION_DATE < TRUNC(SYSDATE);
select COUNT(*)  from Questions where QUESTION_DATE >= trunc(sysdate)-7 and QUESTION_DATE < TRUNC(SYSDATE);
 
