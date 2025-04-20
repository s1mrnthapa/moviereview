<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>CineCritique Login</title>
    <style>
        * {
            font-family: 'Lucida Sans', sans-serif;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 100px;
        }
        .form-container {
            display: flex;
            flex-direction: column;
            row-gap: 20px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            row-gap: 10px;
        }
        .placeholder {
            width: 200px;
            border: 2px pink solid;
            border-radius: 5px;
            height: 30px;
            padding-left: 10px;
        }
        .button {
            width: 120px;
            height: 35px;
            background-color: pink;
            border: 1px pink solid;
            border-radius: 4px;
            cursor: pointer;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
        .success-message {
            color: green;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login Form</h2>

        <!-- Display error or success messages -->
        <%
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
            <p class="error-message">Invalid username or password!</p>
        <% 
            }
            String success = request.getParameter("success");
            if ("1".equals(success)) {
        %>
            <p class="success-message">Login successful!</p>
        <% } %>

        <form class="form-container" action="../LogInController" method="post">
            <div class="form-group">
                <label>UserName:</label>
                <input class="placeholder" type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Password:</label>
                <input class="placeholder" type="password" name="password" required>
            </div>
            <input class="button" type="submit" value="Login">
        </form>
    </div>
</body>
</html>
