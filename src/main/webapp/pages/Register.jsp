<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title> CineCritique </title>
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
                  <h2>Registration Form</h2>
            </div>
            <form class="form-container" action="${pageContext.request.contextPath}/RegisterController" method="post">
            <div class="form-group">
                  <label class="label_name"> UserName: </label>
                  <input class="placeholder" type="text" name="username" required>
            </div>
            <div class="form-group">
                  <label class="label_name">First Name: </label>
                  <input class="placeholder" type="text" name="firstName" required>
            </div>
            <div class="form-group">
                  <label class="label_name">Last Name: </label>
                  <input class="placeholder" type="text" name="lastName" required>
            </div>
            <div class="form-group">
                  <label class="label_name">Email: </label>
                  <input class="placeholder" type="email" name="email" required>
            </div>
            <div class="form-group">
                  <label class="label_name">Password: </label>
                  <input class="placeholder" type="text" name="password" required>
            </div>
            <div class="form-group">
                  <label class="label_name">Register Date: </label>
                  <input class="placeholder" type="date" name="registerDate" required>
            </div>
            <div class="form-group">
                  <label class="label_name">Role: </label>
                  <select class="placeholder" name="role" id="role" required>
                        <option value="">Select Role</option>
                        <option value="User">User</option>
                        <option value="Admin">Admin</option>
                  </select>
            </div>
                  <input type = "submit" value = "register">
            </form>
      </div>
</body>
</html>