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

declare
   l_job_exists number;
begin
   select count(*) into l_job_exists
     from user_scheduler_jobs
    where job_name = 'UPDATE_TABLE'
          ;

   if l_job_exists = 1 then
      dbms_scheduler.drop_job(job_name => 'UPDATE_TABLE');
   end if;
end;

EXEC  DBMS_SCHEDULER.ENABLE('UPDATE_TABLE');

EXEC DBMS_SCHEDULER.drop_job(job_name => 'UPDATE_TABLE');
--https://dba.stackexchange.com/questions/135571/auto-update-a-column-every-24-hours-in-oracle-database

--SELECT owner, job_name, comments FROM dba_scheduler_jobs;

GRANT SELECT ON SYS.DBA_JOBS_RUNNING TO john;

SELECT * FROM dba_scheduler_jobs; --ONLY DBA CAN USE THIS ONE
SELECT * FROM user_scheduler_jobs;



