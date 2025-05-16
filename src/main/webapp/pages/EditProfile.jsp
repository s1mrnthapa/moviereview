<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>CineCritique - Edit Profile</title>
  <style>
    body {
      margin: 0;
      font-family: sans-serif;
      background: #0b0b0b;
      color: #fff;
    }

    header {
      background: #1a1a1a;
      padding: 10px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 2px solid #ff3c3c;
    }

    .logo-container, nav, .profile {
      display: flex;
      align-items: center;
    }

    .logo {
      width: 40px;
      height: 40px;
      margin-right: 10px;
    }

    h1 {
      font-size: 18px;
      margin: 0;
    }

    nav a {
      color: white;
      text-decoration: none;
      margin: 0 8px;
    }

    nav a:hover {
      color: #ff3c3c;
    }

    nav a.active {
      color: #ff3c3c;
      border-bottom: 2px solid #ff3c3c;
    }

    .profile img {
      width: 30px;
      height: 30px;
      border-radius: 50%;
      margin-left: 5px;
    }

    .container {
      max-width: 800px;
      margin: 30px auto;
      padding: 20px;
      background: #1a1a1a;
      border-radius: 10px;
      border: 1px solid #ff3c3c;
    }

    .form-group {
      margin-bottom: 15px;
    }

    label {
      display: block;
      margin-bottom: 5px;
      color: #ccc;
    }

    input[type="text"],
    input[type="email"] {
      width: 100%;
      padding: 10px;
      background-color: #2c2c2c;
      border: 1px solid #444;
      border-radius: 4px;
      color: #fff;
    }

    input[disabled] {
      background-color: #3a3a3a;
      color: #aaa;
    }

    .form-name-group {
      display: flex;
      gap: 20px;
    }

    .form-name-group .form-group {
      flex: 1;
    }

    .submit-btn {
      background-color: #ff3c3c;
      border: none;
      padding: 10px 20px;
      color: #fff;
      font-size: 16px;
      border-radius: 6px;
      cursor: pointer;
    }

    .submit-btn:hover {
      background-color: #e23434;
    }

    .error-message {
      background-color: #ffdddd;
      color: #a94442;
      border: 1px solid #f5c6cb;
      border-radius: 6px;
      padding: 12px 15px;
      margin-bottom: 20px;
      font-weight: bold;
    }

    .back-link {
      text-align: center;
      margin-top: 20px;
    }

    .back-link a {
      color: yellow;
      text-decoration: none;
    }

    .back-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <!-- Header -->
  <header>
    <div class="logo-container">
      <img src="${pageContext.request.contextPath}/images/cinecritique-logo-only.png" alt="Logo" class="logo">
      <h1>CINECRITIQUE</h1>
    </div>
    <nav>
      <a href="${pageContext.request.contextPath}/pages/films.jsp">Films</a>
      <a href="#">Upcoming</a>
      <a href="${pageContext.request.contextPath}/WatchlistServlet">Watchlist</a>
      <a href="${pageContext.request.contextPath}/LikesServlet">Likes</a>
      <a href="${pageContext.request.contextPath}/ProfileServlet" class="profile">
        <span><c:out value="${userProfile.username}" /></span>
        <img src="${pageContext.request.contextPath}/image/images.png" alt="User Icon">
      </a>
    </nav>
  </header>

  <!-- Main Container -->
  <div class="container">
    <h2>Edit Profile</h2>

    <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="POST">
      <!-- Error Message -->
      <c:if test="${not empty error}">
        <div class="error-message">
          <c:out value="${error}"/>
        </div>
      </c:if>


      <!-- Username (Editable) -->
      <div class="form-group">
        <label>Username:</label>
        <input type="text" name="username" value="${userProfile.username}" required>
      </div>

      <!-- First and Last Name -->
      <div class="form-name-group">
        <div class="form-group">
          <label>First Name:</label>
          <input type="text" name="firstName" value="${userProfile.firstName}" required>
        </div>
        <div class="form-group">
          <label>Last Name:</label>
          <input type="text" name="lastName" value="${userProfile.lastName}" required>
        </div>
      </div>

      <!-- Email -->
      <div class="form-group">
        <label>Email:</label>
        <input type="email" name="email" value="${userProfile.email}" required>
      </div>

      <!-- Submit -->
      <input type="submit" value="Save Changes" class="submit-btn">
    </form>

    <!-- Back Link -->
    <div class="back-link">
      <a href="${pageContext.request.contextPath}/ProfileServlet">← Back to Profile</a>
    </div>
  </div>

</body>
</html>