

declare
y number := 0;
loop_start Integer := 0;
begin
insert into Users (email,password,first_name,last_name,join_date)
values('test','test','john','luu',sysdate);

    for i in reverse 1..15 loop
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
commit;
end;

declare

begin

    for i in 76..120 loop
      
insert into questions (user_id,question_text,question_date)
values(1,'Pending Question' || (i),(SYSDATE - 5 / 24 /60 /* Minutes */));

            insert into options(question_id,option_text)
            values((i),'Good');
            insert into options(question_id,option_text)
            values((i),'bad');
            insert into options(question_id,option_text)
            values((i),'sad');
end loop;
commit;
end;





                            DELETE FROM USER_WATCHING;
   
                      
                          
   
                            DELETE FROM OPTIONS WHERE OPTION_ID IN(
                            select OPTIONS.OPTION_ID from OPTIONS join questions on questions.question_id = options.question_id 
                            where questions.question_date >= trunc(sysdate)- 1
                            and options.QUESTION_ID NOT in 
                            (select question_id from questions
                            where QUESTIONS.QUESTION_DATE >= trunc(sysdate) - 1
                            order by watches desc, question_date asc
                            fetch first 5 rows only));

                            delete from questions where question_date >= trunc(sysdate)- 1 and question_id not in(
                            select question_id from questions
                            where QUESTIONS.QUESTION_DATE >= trunc(sysdate)- 1
                            order by watches desc, question_date asc
                            fetch first 5 rows only);
                            commit;




SELECT OPTION_ID FROM USER_CHOICES 
			where USER_ID = 1 and QUESTION_ID = 71;

select * from questions;
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends2',sysdate-10,200);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends3',sysdate-10,300);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends4',sysdate-10,400);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends5',sysdate-10,500);
--
--insert into options(question_id,option_text)
--values(1,'Good');
--insert into options(question_id,option_text)
--values(1,'Bad');
--insert into options(question_id,option_text)
--values(1,'Average');
--
--
--insert into options(question_id,option_text)
--values(2,'Good');
--insert into options(question_id,option_text)
--values(2,'Bad');
--insert into options(question_id,option_text)
--values(2,'Average');
--
--insert into options(question_id,option_text)
--values(3,'Good');
--insert into options(question_id,option_text)
--values(3,'Bad');
--insert into options(question_id,option_text)
--values(3,'Average');
--
--
--insert into options(question_id,option_text)
--values(4,'Good');
--insert into options(question_id,option_text)
--values(4,'Bad');
--insert into options(question_id,option_text)
--values(4,'Average');
--
--
--insert into options(question_id,option_text)
--values(5,'Good');
--insert into options(question_id,option_text)
--values(5,'Bad');
--insert into options(question_id,option_text)
--values(5,'Average');



--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends6',sysdate-9,600);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends7',sysdate-9,700);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends8',sysdate-9,800);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends9',sysdate-9,900);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends10',sysdate-9,1000);
--
--insert into options(question_id,option_text)
--values(6,'Good');
--insert into options(question_id,option_text)
--values(6,'Bad');
--insert into options(question_id,option_text)
--values(6,'Average');
--
--
--insert into options(question_id,option_text)
--values(7,'Good');
--insert into options(question_id,option_text)
--values(7,'Bad');
--insert into options(question_id,option_text)
--values(7,'Average');
--
--
--
--insert into options(question_id,option_text)
--values(8,'Good');
--insert into options(question_id,option_text)
--values(8,'Bad');
--insert into options(question_id,option_text)
--values(8,'Average');
--
--
--
--
--insert into options(question_id,option_text)
--values(9,'Good');
--insert into options(question_id,option_text)
--values(9,'Bad');
--insert into options(question_id,option_text)
--values(9,'Average');
--
--
--insert into options(question_id,option_text)
--values(10,'Good');
--insert into options(question_id,option_text)
--values(10,'Bad');
--insert into options(question_id,option_text)
--values(10,'Average');
--
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends6',sysdate-8,600);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends7',sysdate-8,700);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends8',sysdate-8,800);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends9',sysdate-8,900);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends10',sysdate-8,1000);
--
--insert into options(question_id,option_text)
--values(11,'Good');
--insert into options(question_id,option_text)
--values(11,'Bad');
--insert into options(question_id,option_text)
--values(11,'Average');
--
--
--insert into options(question_id,option_text)
--values(12,'Good');
--insert into options(question_id,option_text)
--values(12,'Bad');
--insert into options(question_id,option_text)
--values(12,'Average');
--
--
--
--insert into options(question_id,option_text)
--values(13,'Good');
--insert into options(question_id,option_text)
--values(13,'Bad');
--insert into options(question_id,option_text)
--values(13,'Average');
--
--insert into options(question_id,option_text)
--values(14,'Good');
--insert into options(question_id,option_text)
--values(14,'Bad');
--insert into options(question_id,option_text)
--values(14,'Average');
--
--insert into options(question_id,option_text)
--values(15,'Good');
--insert into options(question_id,option_text)
--values(15,'Bad');
--insert into options(question_id,option_text)
--values(15,'Average');
--
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends6',sysdate-7,600);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends7',sysdate-7,700);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends8',sysdate-7,800);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends9',sysdate-7,900);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends10',sysdate-7,1000);
--
--insert into options(question_id,option_text)
--values(16,'Good');
--insert into options(question_id,option_text)
--values(16,'Bad');
--insert into options(question_id,option_text)
--values(16,'Average');
--
--
--insert into options(question_id,option_text)
--values(17,'Good');
--insert into options(question_id,option_text)
--values(17,'Bad');
--insert into options(question_id,option_text)
--values(17,'Average');
--
--
--
--insert into options(question_id,option_text)
--values(18,'Good');
--insert into options(question_id,option_text)
--values(18,'Bad');
--insert into options(question_id,option_text)
--values(18,'Average');
--
--insert into options(question_id,option_text)
--values(18,'Good');
--insert into options(question_id,option_text)
--values(18,'Bad');
--insert into options(question_id,option_text)
--values(18,'Average');
--
--insert into options(question_id,option_text)
--values(18,'Good');
--insert into options(question_id,option_text)
--values(18,'Bad');
--insert into options(question_id,option_text)
--values(18,'Average');
--
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends6',sysdate-7,600);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends7',sysdate-7,700);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends8',sysdate-7,800);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends9',sysdate-7,900);
--insert into questions (user_id,question_text,question_date,watches)
--values(1,'How are you my friends10',sysdate-7,1000);
--
--insert into options(question_id,option_text)
--values(16,'Good');
--insert into options(question_id,option_text)
--values(16,'Bad');
--insert into options(question_id,option_text)
--values(16,'Average');
--
--
--insert into options(question_id,option_text)
--values(17,'Good');
--insert into options(question_id,option_text)
--values(17,'Bad');
--insert into options(question_id,option_text)
--values(17,'Average');
--
--
--
--insert into options(question_id,option_text)
--values(18,'Good');
--insert into options(question_id,option_text)
--values(18,'Bad');
--insert into options(question_id,option_text)
--values(18,'Average');
--
--insert into options(question_id,option_text)
--values(18,'Good');
--insert into options(question_id,option_text)
--values(18,'Bad');
--insert into options(question_id,option_text)
--values(18,'Average');
--
--insert into options(question_id,option_text)
--values(18,'Good');
--insert into options(question_id,option_text)
--values(18,'Bad');
--insert into options(question_id,option_text)
--values(18,'Average');






select * from comments;


select * from user_choices;

select option_id from user_choices where question_id = 7 and USER_ID = 1;

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
       
select * from questions;
commit;
select * from questions where question_date >= (trunc(sysdate) - 0) and question_date < trunc(sysdate)- (0-1) ;
select * from questions where question_date >= (trunc(sysdate) - 1) and question_date < trunc(sysdate)- (1-1) ;

select * from questions where question_date >= (trunc(sysdate) - 0) and question_date < trunc(sysdate)- (0-1) ;

select * from questions
where QUESTION_DATE < trunc(sysdate) and QUESTION_DATE >= trunc(sysdate)-7
order by watches desc, question_date asc
offset 5 rows
 fetch next 5 rows only;


SELECT OPTIONS.*, questions.question_id,QUESTIONS.QUESTION_DATE FROM OPTIONS 
				 JOIN QUESTIONS ON QUESTIONS.QUESTION_ID = OPTIONS.QUESTION_ID 
							 where question_date >= (trunc(sysdate) - 1) and question_date < trunc(sysdate)- (1-1);
                             
                             select * from questions 
			where question_date >= (trunc(sysdate) - ?) and question_date < trunc(sysdate)- (?-1);

select options.* from options
join questions on options.QUESTION_ID = QUESTIONS.QUESTION_ID
where options.QUESTION_ID in(
select QUESTION_ID from questions
where QUESTION_DATE < trunc(sysdate) and QUESTION_DATE >= trunc(sysdate)-7
order by watches desc, question_date asc
offset (0*5) rows
fetch next 5 rows only);


select QUESTION_ID from questions
where QUESTION_DATE < trunc(sysdate) and QUESTION_DATE >= trunc(sysdate)-7
order by watches desc, question_date asc
offset (0*5) rows
fetch next 5 rows only;
