<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>CineCritique</title>
  <style>
    @font-face {
      font-family: 'MyCustomFont';
      src: url('Amarante-Regular.ttf') format('truetype');
    }

    @font-face {
      font-family: 'MyCustomFont2';
      src: url('Aboreto-Regular.ttf') format('truetype');
    }

    @font-face {
      font-family: 'MyCustomFont3';
      src: url('BodoniModa_9pt-Regular.ttf') format('truetype');
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }
    h1 {
            font-family: 'MyCustomFont', sans-serif;
            }

      p {
            font-family: 'MyCustomFont2', serif;
            }

    body, html {
      height: 100%;
      font-family: 'MyCustomFont3', sans-serif;
    }

    /* Fullscreen blurry background */
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

    /* Centered Card Container */
    .card-wrapper {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .card {
      display: grid;
      grid-template-columns: 1fr 1fr;
      max-width: 980px;
      height: 550px;
      width: 90%;
      overflow: hidden;
    }

    /* Left side - white form */
    .form-side {
      background-color: white;
      padding: 60px 30px; 
      display: flex;
      flex-direction: column;
      gap: 50px;
      justify-content: flex-start;
      align-items: flex-start;
    }

    .form-container {
      display: flex;
      flex-direction: column;
      gap: 20px;
      width: 80%;
      transform: translateY(20px);
    }

    .form-group {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .placeholder {
      width: 120%;
      border-top: none;
	border-left: none;
	border-right: none;
      border-bottom-width: 1px;
		transition: all 1000ms;
	&:focus{
		outline: none;
		color:red;
	}&:hover{
		border-bottom-color:red;
	}}
      .buttons{
            display: grid;
            grid-template-columns: 1fr 1fr;
      }

    input[type="submit"] {
      background-color: darkred;
      border-radius: 20px;
      border: none;
      height: 35px;
      width: 150px;
      font-weight: bold;
      cursor: pointer;
    }

    input[type="submit"]:hover {
      background-color:black;
    }
 
    a {
      font-weight: bold;
      margin-top: 10px;
      text-decoration: none;
    }

    a:hover {
      color: #ff4d4d;
    }

    .heading1 h1 {
      font-size: 30px;
      color: #333;
      margin-bottom: 10px;
    }

    /* Right side image */
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
    .logouut{
      font-family: 'MyCustomFont2'; 
      margin-left: 185px;
      margin-top: 8px;
    }
    .logouut:hover{
      text-decoration: underline;
      color: darkred;
    }

    @media (max-width: 768px) {
      .card {
        grid-template-columns: 1fr;
        height: auto;
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
    <img src="Chungking Express.jpg" alt="Blurry Background">
  </div>

  <!-- Centered Card Grid -->
  <div class="card-wrapper">
    <div class="card">
      
      <!-- Left Side: White Form -->
      <div class="form-side">
            <div style="transform: translateY(20px);">
                  <div class="heading1">
                        <h1 style="color: black; font-size: 50px;">Welcome Back</h1>
                  </div>
                  <div class="heading2" style="margin-top: 15px;">
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
          <div class="buttons" style="margin-top: 20px;">
            <div>
                  <input type="submit" value="Login" style="color: white; font-family: 'MyCustomFont2';">
            </div>
            <div class="logouut">
                  <a href="${pageContext.request.contextPath}/LogOutController" style="color: black;">Logout</a>
              </div>
        </div>
        </form>
      </div>

      <!-- Right Side: Static Image -->
      <div class="image-side">
        <img src="Chungkingg Express.jpg" alt="Right Image">
      </div>

    </div>
  </div>
</body>
</html>
