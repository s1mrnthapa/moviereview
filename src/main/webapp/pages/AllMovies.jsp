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
      --soft-gray: #2a2a2a;
      --light-border: #333;
      --cyan: #00ffff;
    }
    header {
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 80px; /* Set height */
		  z-index: 1000;
		}

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: var(--black);
      color: var(--white);
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 95%;
      margin: 30px auto;
      padding: 20px;
      padding-top: 70px;
      background-color: var(--gray-bg);
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(255, 255, 255, 0.05);
      overflow-x: auto;
    }
    .container h1{
    	font-family: Cinzel Decorative;
    	margin-bottom: 15px;
    	font-size: 30px;
    }

    .success-message {
      color: #39e639;
      font-weight: bold;
      margin-bottom: 10px;
    }

    .error-message {
      color: #ff4d4d;
      font-weight: bold;
      margin-bottom: 10px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
      min-width: 1000px;
    }

    th, td {
      padding: 10px 8px;
      text-align: left;
      vertical-align: top;
      border: 1px solid var(--light-border);
      max-width: 160px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    th {
      background-color: #222;
      color: cyan;
      font-family: Cinzel Decorative;
      
    }

    tbody tr:nth-child(even) {
      background-color: var(--soft-gray);
    }

    .poster img {
      width: 50px;
      height: 75px;
      border-radius: 4px;
      object-fit: cover;
    }
    /* Container inside the action cell */
	td .edit-button,
	td form button[type="submit"] {
	  width: 60px;
	  display: inline-block;
	  padding: 6px 12px;
	  font-size: 13px;
	  border-radius: 4px;
	  font-weight: 600;
	  text-align: center;
	  cursor: pointer;
	  text-decoration: none;
	  transition: background-color 0.3s, color 0.3s;
	}
	
	/* Edit Button */
	.edit-button {
	  background-color: cyan;
	  color: black;
	}
	
	.edit-button:hover {
	  background-color: white;
	}
	
	/* Delete Button */
	td form button[type="submit"] {
	  background-color: grey;
	  color: white;
	  border: none;
	  margin-top: 10px;
	}
	
	td form button[type="submit"]:hover {
	  background-color: red;
	}
    @media (max-width: 768px) {
      table {
        font-size: 12px;
      }

      .poster img {
        width: 40px;
        height: 60px;
      }

      th, td {
        padding: 8px 6px;
      }
    }
  </style>
  </style>
</head>
<body>
<header>
	<%@ include file ="AdminHeader.jsp" %>
	</header>
<div class="container">
	<h1> CineCritique | Movie Management </h1>
	<c:if test="${param.success == 'deleted'}">
	    <p class="success-message">Movie deleted successfully.</p>
	</c:if>
	<c:if test="${param.error == 'notdeleted'}">
	    <p class="error-message">Movie could not be deleted.</p>
	</c:if>
  <table>
    <thead>
    <tr>
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
      <th>Average <br>Reviews</th>
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
        
        <td>${movie.movieID}</td>
        <td class="poster">
          	<img src="${movie.imagePath}" alt="${movie.title}" />
        </td>
        <td>${movie.title}</td>
        <td>${movie.director}</td>
        <td><c:forEach var="c" items="${movie.cast}">${c}, </c:forEach></td>
        <td><c:forEach var="g" items="${movie.genre}">${g}, </c:forEach></td>
        <td>${movie.releaseDate}</td>
        <td>${movie.country}</td>
        <td>${movie.duration}</td>
        <td>${movie.description}</td>
        <td>${movie.averageRating}</td>
        <td>
          <a class="edit-button" href="${pageContext.request.contextPath}/EditMovieServlet?movieID=${movie.movieID}">Edit</a>
          <form id= "deleteForm" action="${pageContext.request.contextPath}/DeleteMovieServlet" method="POST" onsubmit="return confirm('Are you sure you want to delete this movie?');">
		    <input type="hidden" name="movieID" value="${movie.movieID}" />
		    <button type="submit">Delete</button>
		</form>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
<script>
  console.log("Movies loaded:", ${fn:length(movies)});
</script>
</body>
</html>