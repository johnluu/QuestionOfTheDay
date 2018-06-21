select 'drop table ', table_name, 'cascade constraints;' from user_tables;
drop table 	COMMENTS	cascade constraints;
drop table 	USERS	cascade constraints;
drop table 	QUESTIONS	cascade constraints;
drop table 	USER_WATCHING	cascade constraints;
drop table 	OPTIONS	cascade constraints;
drop table 	USER_CHOICES	cascade constraints;



CREATE TABLE USERS (

  USER_ID numeric generated always as identity(start with 1 increment by 1) not null,
  EMAIL VARCHAR(30) UNIQUE,
  PASSWORD VARCHAR(20) NOT NULL,
  first_name varchar(20) not null,
  last_name varchar(20) not null,
  watches NUMERIC default 0,
  choices numeric default 0,
  comments numeric default 0,
  QUESTIONS_CREATED numeric default 0,
  JOIN_DATE DATE NOT NULL,

  

  constraint user_pk primary key (USER_ID)
);


CREATE TABLE QUESTIONS(

  QUESTION_ID numeric generated always as identity(start with 1 increment by 1) not null,
  USER_ID NUMERIC not null,
  QUESTION_TEXT VARCHAR(255) NOT NULL,
  QUESTION_SCORE NUMERIC DEFAULT 0,
  WATCHES NUMERIC DEFAULT 0,
  QUESTION_DATE DATE not null,
  
  constraint QUESTION_PK primary key (QUESTION_ID),
  FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
  
);

CREATE TABLE OPTIONS(

  OPTION_ID numeric generated always as identity(start with 1 increment by 1) not null,
  QUESTION_ID NUMERIC not null,
  OPTION_TEXT VARCHAR(20),
  OPTION_SCORE numeric DEFAULT 0,
  
  constraint OPTION_PK primary key (OPTION_ID),
  FOREIGN KEY (QUESTION_ID) REFERENCES QUESTIONS(QUESTION_ID)

);

CREATE TABLE USER_WATCHING(

  QUESTION_ID NUMERIC,
  USER_ID NUMERIC,
 
  CONSTRAINT USER_WATCHING_PK PRIMARY KEY (QUESTION_ID,USER_ID),
  FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
  FOREIGN KEY (QUESTION_ID) REFERENCES QUESTIONS(QUESTION_ID)
);



CREATE TABLE USER_CHOICES(

  QUESTION_ID NUMERIC not null,
  USER_ID NUMERIC not null,
  OPTION_ID NUMERIC NOT NULL,
 
  CONSTRAINT USER_CHOICES_PK PRIMARY KEY (QUESTION_ID,USER_ID),
  FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
  FOREIGN KEY (QUESTION_ID) REFERENCES QUESTIONS(QUESTION_ID),
  FOREIGN KEY (OPTION_ID) REFERENCES OPTIONS(OPTION_ID)
);

CREATE TABLE COMMENTS(

  COMMENT_ID numeric generated always as identity(start with 1 increment by 1) not null,
  USER_ID NUMERIC not null,
  QUESTION_ID NUMERIC not null,
  OPTION_ID NUMERIC not null,
  COMMENT_TEXT VARCHAR(255) not null,
  COMMENT_SCORE NUMERIC DEFAULT 0,
  COMMENT_DATE DATE NOT NULL,
  
  constraint COMMENT_PK primary key (COMMENT_ID),
  FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
  FOREIGN KEY (QUESTION_ID) REFERENCES QUESTIONS(QUESTION_ID),
  FOREIGN KEY (OPTION_ID) REFERENCES OPTIONS(OPTION_ID)
);




declare
y number := 0;
loop_start Integer := 0;
begin
insert into Users (email,password,first_name,last_name,join_date)
values('test@gmail.com','test','john','luu',sysdate);

    for i in reverse 1..14 loop
        for j in 1..5 loop
insert into questions (user_id,question_text,question_date,watches,QUESTION_SCORE)
values(1,'Question'|| (j+(5*y)),sysdate-i,i*j,j);
            insert into options(question_id,option_text,OPTION_SCORE)
            values(j+(5*y),'Good',j);
            insert into options(question_id,option_text)
            values(j+(5*y),'bad');
            insert into options(question_id,option_text)
            values(j+(5*y),'sad');
    end loop;
     y:= y+1;
end loop;
 for i in 71..110 loop
insert into questions (user_id,question_text,question_date,watches)
values(1,'Pending Question' || (i),(SYSDATE - 5 / 24 /60 /* Minutes */),1);
            insert into options(question_id,option_text)
            values((i),'Good');
            insert into options(question_id,option_text)
            values((i),'bad');
            insert into options(question_id,option_text)
            values((i),'sad');  
insert into user_watching(question_id,user_id)
values(i,1);
end loop;
    for i in 1..70 loop
insert into USER_CHOICES (question_id,user_id,option_id)
values(i,1,((i*3)-2));
end loop;

UPDATE USERS SET CHOICES = 70 WHERE USER_ID = 1;
UPDATE USERS SET QUESTIONS_CREATED = 110 WHERE USER_ID = 1;
UPDATE USERS SET watches = 40 WHERE USER_ID = 1;
commit;
end;

begin
  dbms_scheduler.create_job
  (
   job_name             => 'DELETE_PENDING',
   job_type             => 'PLSQL_BLOCK',
   job_action           => 'begin
   
   
                            DELETE FROM USER_WATCHING;
                            
                            DELETE FROM USER_CHOICES WHERE QUESTION_ID IN(
                            select question_id from questions
                            where QUESTIONS.QUESTION_DATE >= trunc(sysdate)- 1
                            );
   
                            DELETE FROM OPTIONS WHERE OPTION_ID IN(
                            select OPTIONS.OPTION_ID from OPTIONS join questions on questions.question_id = options.question_id 
                            where questions.question_date >= trunc(sysdate)- 1
                            and options.QUESTION_ID NOT in 
                            (select question_id from questions
                            where QUESTIONS.QUESTION_DATE >= trunc(sysdate) - 1
                            order by watches desc, question_date asc
                            fetch first 5 rows only));

                            delete from questions where question_date >= trunc(sysdate)-1 and question_id not in(
                            select question_id from questions
                            where QUESTIONS.QUESTION_DATE >= trunc(sysdate)- 1
                            order by watches desc, question_date asc
                            fetch first 5 rows only);
                            commit; end;',
                            
   start_date           =>  TRUNC(SYSDATE + 1) + 180/(24*60*60) ,
   repeat_interval      => 'FREQ=DAILY;',
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
                            where question_date < trunc(sysdate-13));


                            DELETE FROM USER_CHOICES WHERE QUESTION_ID IN(
                            SELECT QUESTIONS.QUESTION_ID FROM USER_CHOICES JOIN QUESTIONS ON USER_CHOICES.QUESTION_ID = QUESTIONS.QUESTION_ID
                            WHERE QUESTION_DATE < TRUNC(SYSDATE-13));

                            DELETE FROM OPTIONS WHERE OPTIONS.OPTION_ID IN(
                            SELECT OPTIONS.OPTION_ID FROM OPTIONS JOIN QUESTIONS ON OPTIONS.QUESTION_ID = QUESTIONS.QUESTION_ID
                            WHERE QUESTION_DATE < TRUNC(SYSDATE-13));


                            DELETE from questions where question_date < trunc(sysdate-13);
                            commit; end;',
                            
   start_date           =>  trunc(sysdate + 1) - 180/(24*60*60) ,
   repeat_interval      => 'FREQ=DAILY;',
   enabled              => TRUE,
   auto_drop            => FALSE
  );
end;

EXEC  DBMS_SCHEDULER.ENABLE('update_table');
EXEC  DBMS_SCHEDULER.ENABLE('DELETE_PENDING');
EXEC  DBMS_SCHEDULER.ENABLE('DELETE_ARCHIVE');

EXEC DBMS_SCHEDULER.drop_job(job_name => 'UPDATE_TABLE');
EXEC DBMS_SCHEDULER.drop_job(job_name => 'DELETE_PENDING');
EXEC DBMS_SCHEDULER.drop_job(job_name => 'DELETE_ARCHIVE');


SELECT JOB_NAME,START_DATE,NEXT_RUN_DATE,RUN_COUNT,FAILURE_COUNT,REPEAT_INTERVAL,JOB_ACTION FROM user_scheduler_jobs;





