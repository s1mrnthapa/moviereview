<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Movies Database – CineCritique</title>
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
      vertical-align: middle;
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

<header>
  <h1>CINECRITIQUE – MOVIES DATABASE</h1>
</header>

<nav>
  <a href="dashboard.jsp">Dashboard</a>
  <a href="${pageContext.request.contextPath}/pages/addmovies.jsp">Add Movies</a>
  <a href="${pageContext.request.contextPath}/pages/adminprofile.jsp">Admin Profile</a>
  <a href="${pageContext.request.contextPath}/pages/moviedatabase.jsp">Movies Database</a>
  <a href="#">Logout</a>
</nav>

<div class="container">
  <div class="action-buttons">
    <!-- EDIT button triggers JS to toggle Select buttons -->
    <button type="button" id="editBtn" onclick="toggleSelectMode()">EDIT</button>
    <!-- DELETE & DONE submit form with appropriate action param -->
    <button type="submit" form="movieForm" name="action" value="delete">DELETE</button>
    <button type="submit" form="movieForm" name="action" value="done">DONE</button>
  </div>

  <form id="movieForm" method="post" action="MovieActionServlet">
    <table>
      <thead>
        <tr>
          <th id="selectHeader">Select</th>
          <th>Movie ID</th>
          <th>Poster</th>
          <th>Title</th>
          <th>Director</th>
          <th>Cast</th>
          <th>Genre</th>
          <th>Language</th>
          <th>Country</th>
          <th>Duration</th>
          <th>Description</th>
          <th>Avg Reviews</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="movie" items="${movies}">
          <tr>
            <td class="selectCell" data-movieid="${movie.id}">
              <input type="checkbox" name="selectedMovieIds" value="${movie.id}" />
            </td>
            <td>${movie.id}</td>
            <td class="poster">
              <c:choose>
                <c:when test="${not empty movie.posterUrl}">
                  <img src="${movie.posterUrl}" alt="Poster of ${movie.title}" />
                </c:when>
                <c:otherwise>
                  <div style="width:40px; height:60px; background:#555; border-radius:4px; margin:auto;"></div>
                </c:otherwise>
              </c:choose>
            </td>
            <td>${movie.title}</td>
            <td>${movie.director}</td>
            <td>${movie.cast}</td>
            <td>${movie.genre}</td>
            <td>${movie.language}</td>
            <td>${movie.country}</td>
            <td>${movie.duration}</td>
            <td>${movie.description}</td>
            <td>
              <c:choose>
                <c:when test="${movie.avgReview >= 4}">★★★★☆</c:when>
                <c:when test="${movie.avgReview >= 3}">★★★☆☆</c:when>
                <c:when test="${movie.avgReview >= 2}">★★☆☆☆</c:when>
                <c:when test="${movie.avgReview >= 1}">★☆☆☆☆</c:when>
                <c:otherwise>☆☆☆☆☆</c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty movies}">
          <tr>
            <td colspan="12">No movies found.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </form>

  <div class="pagination">
    <button>&laquo;</button>
    <button>1</button>
    <button>2</button>
    <button>&raquo;</button>
  </div>
</div>

<footer>
  &copy; 2025 CineCritique. All Rights Reserved.
</footer>

<script>
  let isSelectMode = false;

  function toggleSelectMode() {
    const selectCells = document.querySelectorAll('.selectCell');
    const header = document.getElementById('selectHeader');
    const editBtn = document.getElementById('editBtn');

    if (!isSelectMode) {
      // Switch to Select button mode (single select for edit)
      selectCells.forEach(cell => {
        const movieId = cell.getAttribute('data-movieid');
        // Remove checkbox if exists
        cell.innerHTML = '';
        // Create Select button
        const btn = document.createElement('button');
        btn.type = 'submit';
        btn.name = 'selectedMovieId';  // single movie id param for editing
        btn.value = movieId;
        btn.textContent = 'Select';
        btn.style.padding = '5px 10px';
        btn.style.cursor = 'pointer';
        btn.style.borderRadius = '6px';
        btn.style.backgroundColor = '#8b0000';
        btn.style.color = '#fff';
        btn.style.border = 'none';
        btn.onmouseover = () => btn.style.backgroundColor = '#a30000';
        btn.onmouseout = () => btn.style.backgroundColor = '#8b0000';

        cell.appendChild(btn);
      });
      header.innerText = 'Select';
      editBtn.textContent = 'CANCEL';
      isSelectMode = true;
    } else {
      // Switch back to checkbox mode (multi-select delete)
      selectCells.forEach(cell => {
        const movieId = cell.getAttribute('data-movieid');
        cell.innerHTML = '';
        const checkbox = document.createElement('input');
        checkbox.type = 'checkbox';
        checkbox.name = 'selectedMovieIds';
        checkbox.value = movieId;
        cell.appendChild(checkbox);
      });
      header.innerText = '';
      editBtn.textContent = 'EDIT';
      isSelectMode = false;
    }
  }
</script>

</body>
</html>
