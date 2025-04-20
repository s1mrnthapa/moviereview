<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // Example: getting user info from session (adjust this if you're using request or a model object)
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String regDate = (String) session.getAttribute("regDate");
    if (username == null) username = "Guest";
    if (email == null) email = "Not Available";
    if (regDate == null) regDate = "Unknown";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Profile - CineCritique</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      background-color: #0b0b0b;
      color: #fff;
    }

    header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background-color: #1a1a1a;
      padding: 15px 20px;
      border-bottom: 2px solid #ff3c3c;
    }

    .logo, .nav-links {
      display: flex;
      align-items: center;
    }

    .logo img {
      width: 40px;
      height: 40px;
      margin-right: 10px;
    }

    .logo h1 {
      margin: 0;
      color: white;
      font-size: 20px;
    }

    .search-bar input {
      padding: 5px;
      width: 300px;
      background-color: #1f1f1f;
      color: #fff;
      border: 1px solid #ff3c3c;
    }

    .search-bar input::placeholder {
      color: #aaa;
    }

    nav {
      display: flex;
      align-items: center;
    }

    nav a {
      color: #fff;
      text-decoration: none;
      margin: 0 10px;
      display: flex;
      align-items: center;
    }

    nav a:hover {
      color: #ff3c3c;
    }

    .profile {
      display: flex;
      align-items: center;
    }

    .profile span {
      margin-right: 5px;
    }

    .profile img {
      width: 30px;
      height: 30px;
      border-radius: 50%;
    }

    .profile-info {
      background-color: #1f1f1f;
      display: flex;
      padding: 20px;
      align-items: center;
      border-bottom: 1px solid #333;
    }

    .profile-info img {
      border-radius: 50%;
      width: 80px;
      height: 80px;
      margin-right: 20px;
      border: 2px solid #ff3c3c;
    }

    .profile-info h3 {
      margin: 5px 0;
    }

    .section {
      padding: 30px 20px;
      display: flex;
      justify-content: space-around;
      background-color: #0b0b0b;
    }

    .category {
      text-align: center;
    }

    .category h3 {
      margin-bottom: 10px;
      color: #ff3c3c;
    }

    .movie-box {
      width: 150px;
      height: 200px;
      background-color: #1f1f1f;
      border: 2px solid #ff3c3c;
      border-radius: 6px;
      transition: transform 0.3s;
    }

    .movie-box:hover {
      transform: scale(1.05);
    }

    a {
      text-decoration: none;
    }
  </style>
</head>
<body>
  <header>
    <div class="logo">
      <img src="image/logo.png" alt="CineCritique Logo" />
      <h1>CINECRITIQUE</h1>
    </div>
    <div class="search-bar">
      <input type="text" placeholder="Search" />
      <button>Search</button>
    </div>
    <nav>
      <a href="filims.jsp">Filim</a>
      <a href="#">Upcoming</a>
      <a href="watchlist.jsp">Watchlist</a>
      <a href="like.jsp">Likes</a>
      <a href="UserProfile.jsp" class="profile">
        <span><%= username %></span>
        <img src="image/images.png" alt="User Icon">
      </a>
    </nav>
  </header>

  <div class="profile-info">
    <img src="image/images.png" alt="User Avatar" />
    <div>
      <a>Username: <%= username %></a><br>
      <a>Email: <%= email %></a><br>
      <a>Register Date: <%= regDate %></a>
    </div>
  </div>

  <div class="section">
    <a href="like.jsp">
      <div class="category">
        <h3>Likes</h3>
        <div class="movie-box"></div>
      </div>
    </a>
    <a href="filims.jsp">
      <div class="category">
        <h3>Filim</h3>
        <div class="movie-box"></div>
      </div>
    </a>
    <a href="watchlist.jsp">
      <div class="category">
        <h3>Watchlist</h3>
        <div class="movie-box"></div>
      </div>
    </a>
  </div>
</body>
</html>
>