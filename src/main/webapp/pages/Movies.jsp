<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Movies List</title>
    <style>
      body {
         font-family: Arial, sans-serif;
         margin: 20px;
     }
     .movie-container {
         display: flex;
         gap: 15px; 
         overflow: hidden;
     }
     .movie-container .movie-card {
         border: 1px solid #ccc;
         padding: 10px;
         width: 180px; 
         box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
         background-color: #fff;
         text-align: center;
         justify-content: center;
         flex-wrap: wrap;
     }
     .movie-card img {
         width: 100%;
         height: 270px; 
         object-fit: cover;
     }
 </style>
    
</head>
<body>

<h1>Movies List</h1>

<c:if test="${empty movies}">
    <p>No movies available.</p>
    <c:redirect url='${request.contextPath}/MovieListServlet'/>
</c:if>

<!-- Loop through movies if not empty -->
<div class="movie-container">
<c:forEach var="movie" items="${movies}">
    <div class="movie-card">
    	<a href="${pageContext.request.contextPath}/MovieDetail?movieID=${movie.movieID}">
        	<img src="${movie.imagePath}" alt="${movie.title}" />
        	</a>
    </div>
</c:forEach>
</div>

</body>
</html>
