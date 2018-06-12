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
  PASSWORD VARCHAR(10) NOT NULL,
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
  WATCHING number(1) default 1,
 
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




