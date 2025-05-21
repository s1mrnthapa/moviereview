<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">
  <title>CineCritique</title>
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    .blurry-bg {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -2;
    }

    .blurry-bg img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      filter: blur(5px);
    }

    .card-wrapper {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      padding-top: 50px;
    }

    .card {
      display: grid;
      grid-template-columns: 1fr 1fr;
      max-width: 980px;
      height: 550px;
      width: 90%;
      overflow: hidden;
      border-radius: 20px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.6);
    }

    .form-side {
      background-color: rgba(0, 0, 0, 0.8);
      padding: 60px 40px;
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: flex-start;
      gap: 40px;
    }

    .form-container {
      display: flex;
      flex-direction: column;
      gap: 20px;
      width: 100%;
    }

    .form-group {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }
    
    .heading1 h1{
    	font-family: Cinzel Decorative;    
    	color: cyan; 
    	font-size: 38px;
	    margin-bottom: 6px;
	    margin-top: 5px;
    }
    .heading2 p{
    	font-family: 'Aboreto', cursive;
    	margin-bottom: 22px;
    }

    label {
      color: #eeeeee;
      font-size: 18px;
      font-family: Bodoni Moda,  Amarante, arial;  
      margin-bottom: 6px;   
    }

    .placeholder {
      width: 100%;
      padding: 8px 10px;
      font-size: 14px;
      background: transparent;
      border-radius: 4px;
      border: 1px solid #999;
      color: white;
      transition: border-color 0.3s, box-shadow 0.3s;
      font-family: Bodoni Moda,  Amarante, arial;    
      font-style: bold;  
    }

    .placeholder:focus {
      outline: none;
      border-color: black;
      box-shadow: 0 0 5px cyan;
    }

    .placeholder:hover {
      border-color: cyan;
    }

    .buttons {
      display: grid;
      grid-template-columns: 1fr 1fr;
      margin-top: 10px;
    }

    input[type="submit"] { 
      background-color: cyan; 
      font-size: 14px;
      border-radius: 8px;
      border: none;
      height: 40px;
      width: 100px;
      font-weight: bold;
      color: white;
      cursor: pointer;
      font-family: 'MyCustomFont2';
      transition: background-color 0.3s;
    }

    input[type="submit"]:hover {
      background-color: black;
    }

    a {
      font-weight: bold;
      text-decoration: none;
      color: cyan;
      font-family: Cinzel Decorative; 
      font-style: underline;
    }

    a:hover {
      color: black;
    }

    .image-side {
      background-color: transparent;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .image-side img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .register {
    	width: 200px;
    	margin-top: 2px;
    }
	.register p{
	  font-size: 13px;
      font-family: 'Aboreto', cursive;
    }
    .error-message {
      color: darkred;
      border: 1px solid #ff4d4d;
      padding: 10px 10px;
      width: 100%;
      font-weight: bold;
      text-align: center;
      background-color: transparent;
    }

    @media (max-width: 768px) {
      .card {
        grid-template-columns: 1fr;
        height: auto;
        border-radius: 0;
      }

      .image-side {
        display: none;
      }
    }
  </style>
</head>
<body>
  

  <!-- Background Image -->
  <div class="blurry-bg">
    <img src="resources/login/photo2.jpg" alt="Blurry Background">
  </div>

  <!-- Centered Card Grid -->
  <div class="card-wrapper">
    <div class="card">
      
      <!-- Left Side: Form -->
      <div class="form-side">
        <div style="transform: translateY(20px);">
          <div class="heading1">
            <h1>Welcome Back</h1>
          </div>
          <div class="heading2" style="margin-top: 15px; color: white;">
            <p>Enter the scene, your story begins here. </p>
          </div>
          
          <% 
            String errorMessage = (String) session.getAttribute("error");
            if (errorMessage != null) {
          %>
            <div class="error-message">
              <%= errorMessage %>
            </div>
          <%
              session.removeAttribute("error");
            }
          %>
          <%
            String logoutMessage = (String) session.getAttribute("logoutMessage");
            if (logoutMessage != null) {
          %>
            <div class="error-message">
              <%= logoutMessage %>
            </div>
          <%
              session.removeAttribute("logoutMessage");
            }
          %>
        </div>

        <form class="form-container" action="${pageContext.request.contextPath}/LogInController" method="post">
          <div class="form-group">
            <label>UserName:</label>
            <input class="placeholder" type="text" name="username" required>
          </div>
          <div class="form-group">
            <label>Password:</label>
            <input class="placeholder" type="password" name="password" required>
          </div>
          <div class="buttons">
            <div>
              <input type="submit" value="Login" style="font-family: Cinzel Decorative;">
            </div>
            <div class="register" style="margin-left: 30px; font-size: 14px;">
              <p style="text-align: center; color: white;">
                Don't have an account? <br>
                <a href="${pageContext.request.contextPath}/pages/Register.jsp">Register here</a>
              </p>
            </div>
          </div>
        </form>
      </div>

      <!-- Right Side: Image -->
      <div class="image-side">
        <img src="resources/login/photo2.jpg" alt="Right Image">
      </div>

    </div>
  </div>
</body>
</html>
