<%
	
	List<Question> rankQuestionList = qDAO.getQuestionArchiveByDate(1);
	HashMap<Integer,List<Option>> ranktopOption= oDAO.getOptionArchiveByDate(1);
	HashMap<Integer,Integer> rankuserChoices = ucDAO.getUserChoice(user.getUser_id());
	
	
	 
	for(Question q: rankQuestionList)
	{
		out.print("<div class = 'Questionformcontainer'>");
		out.print("<a name='rankquestion" + q.getQuestion_id() + "'" +  "href ='Questions.jsp?&question=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a>" + q.getQuestion_score()  +  "<br/>");
		out.print("<p> "+ q.getDate()  + "</p> <br/>");
		
		
		int chosen = 0;
		
		if(rankuserChoices.containsKey(q.getQuestion_id()))
		{		
		chosen = rankuserChoices.get(q.getQuestion_id());
		}
		
		
		for(Option option:ranktopOption.get(q.getQuestion_id()))
		{
			
			if(chosen == option.getOptions_id())
			{
				
			out.print("<input type='radio' name = 'rankoptionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled='disabled' checked> "+ option.getOption_text());
			out.print("!");}
			else{
			out.print("<input type='radio' name = 'rankoptionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled> "+ option.getOption_text());
			}
				
			out.print(" " + option.getOption_score() + "</br>");
		}
		out.print("</div>");
		

		
	}
%>