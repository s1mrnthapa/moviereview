<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>CINECRITIQUE - Filims</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #0b0b0b;
      color: #fff;
    }

    header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 15px 20px;
      background-color: #1a1a1a;
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

    .search-bar input {
      padding: 5px;
      width: 250px;
      background-color: #1f1f1f;
      color: #fff;
      border: 1px solid #ff3c3c;
    }

    .search-bar input::placeholder {
      color: #aaa;
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

    .profile span {
      margin-right: 5px;
    }

    .profile img {
      width: 30px;
      height: 30px;
      border-radius: 50%;
    }

    .sidebar {
      display: flex;
      align-items: center;
      padding: 15px 20px;
      background-color: #1a1a1a;
      border-bottom: 2px solid #ff3c3c;
    }

    .sidebar select {
      background-color: #1f1f1f;
      color: #fff;
      border: 1px solid #ff3c3c;
      padding: 5px 10px;
    }

    .movie-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
      gap: 30px;
      padding: 40px;
    }

    .movie-card {
      background-color: #1f1f1f;
      height: 220px;
      border-radius: 8px;
      border: 2px solid #ff3c3c;
      background-size: cover;
      background-position: center;
      transition: transform 0.3s;
    }

    .movie-card:hover {
      transform: scale(1.05);
    }
  </style>
</head>
<body>
  <header>
    <div class="logo-container">
      <img src="image/logo.png" alt="Logo" class="logo">
      <h1>CINECRITIQUE</h1>
    </div>
    <div class="search-bar">
      <input type="text" placeholder="Search movies..">
    </div>
    <nav>
      <a href="filims.jsp">Filim</a>
      <a href="#">Upcoming</a>
      <a href="watchlist.jsp">Watchlist</a>
      <a href="like.jsp">Likes</a>
      <a href="UserProfile.jsp" class="profile">
        <span>${sessionScope.username}</span>
        <img src="image/images.png" alt="User Icon">
      </a>
    </nav>
  </header>

  <div class="sidebar">
    <select>
      <option>Genre</option>
      <option>Action</option>
      <option>Drama</option>
      <option>Thriller</option>
    </select>
  </div>

  <div class="movie-grid">
    <c:forEach var="movie" items="${movies}">
      <div class="movie-card" style="background-image: url('${movie.imageUrl}');"></div>
    </c:forEach>

    <c:if test="${empty movies}">
      <div class="movie-card" style="background-image: url('image/filim.png');"></div>
      <div class="movie-card" style="background-image: url('image/filim.png');"></div>
      <div class="movie-card" style="background-image: url('image/filim.png');"></div>
    </c:if>
  </div>
</body>
</html>
