<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Admin Profile – CineCritique</title>
  <style>
    :root {
      --black: #0f0f0f;
      --dark-red: #8b0000;
      --gray-bg: #1a1a1a;
      --white: #fff;
    }

    body {
      font-family: Arial, sans-serif;
      background-color: var(--black);
      color: var(--white);
      margin: 0;
      padding: 0;
    }

    header {
      background-color: var(--dark-red);
      text-align: center;
      padding: 20px;
    }

    header h1 {
      font-size: 26px;
      color: var(--white);
    }

    nav {
      background-color: var(--black);
      padding: 14px 40px;
    }

    nav a {
      text-decoration: none;
      color: var(--white);
      font-weight: bold;
      margin: 0 15px;
      transition: color 0.3s;
    }

    nav a:hover {
      color: var(--dark-red);
    }

    .container {
      max-width: 1000px;
      margin: 40px auto;
      padding: 30px;
      background-color: var(--gray-bg);
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(255, 0, 0, 0.1);
    }

    .action-buttons {
      margin-bottom: 20px;
      text-align: right;
    }

    .action-buttons button {
      padding: 8px 14px;
      margin-left: 8px;
      background-color: var(--dark-red);
      color: var(--white);
      border: none;
      cursor: pointer;
      font-weight: bold;
      border-radius: 6px;
      transition: background-color 0.3s;
    }

    .action-buttons button:hover {
      background-color: #a30000;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    th, td {
      padding: 10px;
      border: 1px solid #444;
      text-align: center;
    }

    th {
      background-color: #222;
    }

    .poster img {
      width: 40px;
      height: 60px;
      border-radius: 4px;
      object-fit: cover;
    }

    .pagination {
      text-align: right;
    }

    .pagination button {
      padding: 6px 12px;
      margin: 0 4px;
      background: var(--gray-bg);
      border: 1px solid #555;
      color: var(--white);
      cursor: pointer;
      border-radius: 4px;
      transition: background-color 0.3s;
    }

    .pagination button:hover {
      background-color: var(--dark-red);
    }

    footer {
      background-color: var(--dark-red);
      color: var(--white);
      text-align: center;
      padding: 15px;
      margin-top: 60px;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="action-buttons">
    <form method="post" action="deleteMovies">
      <button type="submit">DELETE</button>
    </form>
  </div>

  <table>
    <thead>
    <tr>
      <th></th>
      <th>Movie ID</th>
      <th>Poster</th>
      <th>Title</th>
      <th>Director</th>
      <th>Cast</th>
      <th>Genre</th>
      <th>Release Date</th>
      <th>Country</th>
      <th>Duration</th>
      <th>Description</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${empty movies}">
      <tr>
        <td colspan="12" style="text-align:center; color: lightgray;">No movies found in the database.</td>
      </tr>
      <c:redirect url='${request.contextPath}/AdminMoviesServlet'/>
    </c:if>
    <c:forEach var="movie" items="${movies}">
      <tr>
        <td><input type="checkbox" name="movieIds" value="${movie.movieID}" /></td>
        <td>${movie.movieID}</td>
        <td class="poster">
          <img src="${pageContext.request.contextPath}/images/${movie.imagePath}" alt="${movie.title}">
        </td>
        <td>${movie.title}</td>
        <td>${movie.director}</td>
        <td><c:forEach var="c" items="${movie.cast}">${c}, </c:forEach></td>
        <td><c:forEach var="g" items="${movie.genre}">${g}, </c:forEach></td>
        <td>${movie.releaseDate}</td>
        <td>${movie.country}</td>
        <td>${movie.duration}</td>
        <td>${movie.description}</td>
        <td>
          <a href="${pageContext.request.contextPath}/AdminMoviesServlet?action=edit&movieID=${movie.movieID}">Edit</a>     
          <a href="deleteMovie?movieID=${movie.movieID}" onclick="return confirm('Are you sure you want to delete this movie?');" style="color:tomato">Delete</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <div class="pagination">
    <button>&laquo;</button>
    <button>1</button>
    <button>2</button>
    <button>&raquo;</button>
  </div>
</div>
<script>
  console.log("Movies loaded:", ${fn:length(movies)});
</script>
</body>
</html>
