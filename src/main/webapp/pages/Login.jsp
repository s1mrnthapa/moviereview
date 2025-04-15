<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Workshop 2</title>
    <style>
      *{
            font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
      }
    	.container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border: 12px soild black;
    	}
      .form-container{
            display: grid;
  		grid-template-columns: 1fr 1fr;
            row-gap: 30px;
            column-gap: 80px;
      }
    	.form-group{
            display: flex;
            flex-direction: column;
            row-gap: 10px;
    	}
      .placeholder{
            width: 130px;
            border: 2px pink solid;
            border-radius: 5px;
            height: 20px;
      }
      .button{
            width: 100px;
            height: 30px;
            background-color: pink;
            border: 1px pink solid;
            border-radius: 4px;
      }

    </style>
</head>
<body>
      <div class = "container">
            <div class="heading1">
                  <h2>Login Form</h2>
            </div>
            <%
            String error = request.getParameter("error");
            if (error != null) {
                if (error.equals("username")) { out.println("<p class='error'>Username must be at least 6 characters long and cannot contain special characters.</p>"); }
                else if (error.equals("password")) { out.println("<p class='error'>Password must have 1 uppercase letter, 1 number, and 1 special character.</p>"); }
            }
            	%>
            <form class="form-container" action="../LogInController" method="post">
            <div class="form-group">
                  <label class="label_name">UserName: </label>
                  <input class="placeholder" type="text" name="username" required>
            </div>
            <div class="form-group">
                  <label class="label_name">Password: </label>
                  <input class="placeholder" type="text" name="password" required>
            </div>
                  <input type = "submit" value = "login">
            </form>
      </div>
</body>
</html>