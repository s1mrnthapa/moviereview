<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Likes - CineCritique</title>
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
      width: 300px;
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

    .likes-section {
      padding: 20px;
    }

    .likes-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }

    .likes-header h2 {
      color: #ff3c3c;
      margin: 0;
    }

    .likes-header select {
      padding: 5px 10px;
      background-color: #1f1f1f;
      color: #fff;
      border: 1px solid #ff3c3c;
    }

    .movie-container {
      display: flex;
      overflow-x: auto;
      padding: 10px;
      border: 2px solid #ff3c3c;
      background-color: #1a1a1a;
      border-radius: 6px;
    }

    .movie {
      width: 150px;
      height: 220px;
      background-color: #1f1f1f;
      margin-right: 10px;
      border: 2px solid #ff3c3c;
      border-radius: 6px;
      background-image: url('https://via.placeholder.com/150x220');
      background-size: cover;
      background-position: center;
      transition: transform 0.3s;
      flex: 0 0 auto;
    }

    .movie:hover {
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
      <input type="text" placeholder="Search">
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

  <div class="likes-section">
    <div class="likes-header">
      <h2>Liked Movies</h2>
      <select>
        <option>Genre</option>
        <option>Action</option>
        <option>Comedy</option>
        <option>Drama</option>
      </select>
    </div>

    <div class="movie-container">
      <!-- Example of looping through liked movies using JSTL -->
      <c:forEach var="movie" items="${likedMovies}">
        <div class="movie" style="background-image: url('${movie.imageUrl}');"></div>
      </c:forEach>

      <!-- Static placeholder fallback if no data is provided -->
      <c:if test="${empty likedMovies}">
        <div class="movie"></div>
        <div class="movie"></div>
        <div class="movie"></div>
      </c:if>
    </div>
  </div>
</body>
</html>
