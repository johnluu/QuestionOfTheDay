insert into Users (email,password,first_name,last_name)
values('test','test','john','luu');

insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends',sysdate,100);
insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends2',sysdate,200);
insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends3',sysdate,300);
insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends4',sysdate,400);
insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends5',sysdate,500);
insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends6',sysdate,600);
insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends7',sysdate,700);
insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends8',sysdate,800);
insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends9',sysdate,900);
insert into new_questions (user_id,question_text,question_date,watches)
values(1,'How are you my friends10',sysdate,1000);



insert into new_options(question_id,option_text)
values(1,'Good');
insert into new_options(question_id,option_text)
values(1,'Bad');
insert into new_options(question_id,option_text)
values(1,'Average');


insert into new_options(question_id,option_text)
values(2,'Good');
insert into new_options(question_id,option_text)
values(2,'Bad');
insert into new_options(question_id,option_text)
values(2,'Average');

insert into new_options(question_id,option_text)
values(3,'Good');
insert into new_options(question_id,option_text)
values(3,'Bad');
insert into new_options(question_id,option_text)
values(3,'Average');


insert into new_options(question_id,option_text)
values(4,'Good');
insert into new_options(question_id,option_text)
values(4,'Bad');
insert into new_options(question_id,option_text)
values(4,'Average');


insert into new_options(question_id,option_text)
values(5,'Good');
insert into new_options(question_id,option_text)
values(5,'Bad');
insert into new_options(question_id,option_text)
values(5,'Average');


insert into new_options(question_id,option_text)
values(6,'Good');
insert into new_options(question_id,option_text)
values(6,'Bad');
insert into new_options(question_id,option_text)
values(6,'Average');



insert into new_options(question_id,option_text)
values(7,'Good');
insert into new_options(question_id,option_text)
values(7,'Bad');
insert into new_options(question_id,option_text)
values(7,'Average');



insert into new_options(question_id,option_text)
values(8,'Good');
insert into new_options(question_id,option_text)
values(8,'Bad');
insert into new_options(question_id,option_text)
values(8,'Average');




insert into new_options(question_id,option_text)
values(9,'Good');
insert into new_options(question_id,option_text)
values(9,'Bad');
insert into new_options(question_id,option_text)
values(9,'Average');


insert into new_options(question_id,option_text)
values(10,'Good');
insert into new_options(question_id,option_text)
values(10,'Bad');
insert into new_options(question_id,option_text)
values(10,'Average');


INSERT INTO QUESTIONS(QUESTION_ID,USER_ID,QUESTION_TEXT,WATCHES,QUESTION_DATE)
select QUESTION_ID,USER_ID,QUESTION_TEXT,WATCHES,QUESTION_DATE from new_questions
order by watches desc, question_date asc
fetch first 5 rows only;



INSERT INTO OPTIONS(OPTION_ID,QUESTION_ID,OPTION_TEXT)
select OPTION_ID,QUESTION_ID,OPTION_TEXT from new_options
where QUESTION_ID in (select QUESTION_ID from new_questions
order by watches desc, question_date asc
fetch first 5 rows only);

INSERT INTO USER_CHOICES(USER_ID,QUESTION_ID,OPTION_ID) 
			VALUES(1,6,16);
      
UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE + 1   
			WHERE OPTION_ID = 16;
      
INSERT INTO USER_CHOICES(USER_ID,QUESTION_ID,OPTION_ID) 
			VALUES(1,7,19);

--UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE + 1   
--			WHERE OPTION_ID = 19;
--      
--INSERT INTO USER_CHOICES(USER_ID,QUESTION_ID,OPTION_ID) 
--			VALUES(1,8,22);

UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE + 1   
			WHERE OPTION_ID = 22;
      
INSERT INTO USER_CHOICES(USER_ID,QUESTION_ID,OPTION_ID) 
			VALUES(1,9,25);

UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE + 1   
			WHERE OPTION_ID = 25;
      
INSERT INTO USER_CHOICES(USER_ID,QUESTION_ID,OPTION_ID) 
			VALUES(1,10,28);
      
UPDATE OPTIONS SET OPTION_SCORE = OPTION_SCORE + 1   
			WHERE OPTION_ID = 28;

INSERT INTO USER_WATCHING (USER_ID,QUESTION_ID)
VALUES(1,1);

UPDATE NEW_QUESTIONS SET WATCHES = WATCHES + 1
where QUESTION_ID = 1;

select * from user_choices;


--
--INSERT INTO USER_WATCHING (USER_ID,QUESTION_ID)
--VALUES(1,2);
--
--UPDATE NEW_QUESTIONS SET WATCHES = WATCHES + 1
--where QUESTION_ID = 1;
commit;

select * from options;

SELECT OPTIONS.* FROM OPTIONS
JOIN QUESTIONS ON QUESTIONS.QUESTION_ID = OPTIONS.QUESTION_ID
			 where QUESTIONS.QUESTION_DATE >= trunc(sysdate);
