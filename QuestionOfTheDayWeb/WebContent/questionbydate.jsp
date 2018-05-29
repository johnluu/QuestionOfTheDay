<%
	


		List<Question> QuestionList = null;
		HashMap<Integer,List<Option>> topOption= null;
		HashMap<Integer,Integer> userChoices = null; 
	
		
		if(request.getParameter("questionbydatepage") == null)
		{
			QuestionList = qDAO.getQuestionByDate(1);
			topOption = oDAO.getOptionByDate(1);
			userChoices = ucDAO.getUserChoice(user.getUser_id());
		}
		else
		{
			
			int dateoffset = Integer.parseInt(request.getParameter("questionbydatepage"));
			QuestionList = qDAO.getQuestionByDate(dateoffset);
			topOption = oDAO.getOptionByDate(dateoffset);
			userChoices = ucDAO.getUserChoice(user.getUser_id());
			
			
		}

			
		


	for(Question q: QuestionList)
	{	
		int chosen = 0;
		
		if(userChoices.containsKey(q.getQuestion_id()))
		{		
		chosen = userChoices.get(q.getQuestion_id());
		}
		
		
		out.print("<div class = 'Questionformcontainer'>");
		out.print("<a name='question" + q.getQuestion_id() + "'" +  "href ='Questions.jsp?&question=" + q.getQuestion_id()+ "'>" + q.getQuestion_text() + "</a>" + q.getQuestion_score()  +  "<br/>");
		out.print("<p> "+ q.getDate()  + "</p> <br/>");
		out.print("<form method = 'post'>");
		
		for(Option option:topOption.get(q.getQuestion_id()))
		{
			
			if(chosen == option.getOptions_id())
			{
				
			out.print("<input type='radio' name = 'optionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "' disabled='disabled' checked> "+ option.getOption_text());
			out.print("!");}
			else{
			out.print("<input type='radio' name = 'optionquestion" + q.getQuestion_id()+"' value = '" + option.getOptions_id() + "'> "+ option.getOption_text());
			}
				
			out.print(" " + option.getOption_score() + "</br>");
		}
		out.print("<input type= 'submit' name='questionbutton" + q.getQuestion_id() + "' value ='Submit'>");
		out.print("</form>");
		out.print("</div>");
		
		if(request.getParameter("questionbutton" + q.getQuestion_id()) != null)
		{
			
			String optionid = request.getParameter("optionquestion" +  q.getQuestion_id());
			if (optionid != null)
			{
				if(chosen == 0)
				{
					ucDAO.createUserChoice(user.getUser_id(), q.getQuestion_id(), Integer.parseInt(optionid));
				}
				else
				{
					ucDAO.changeUserChoice(user.getUser_id(), q.getQuestion_id(), chosen, Integer.parseInt(optionid));
					
				}
				
				response.sendRedirect("#question"+q.getQuestion_id());
			}
		}
		
	}

%>