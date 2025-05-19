<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">
	<title>Edit Movies</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/AdminMoviesServlet" method="POST">
	<c:if test="${empty movie}">
	  <p style="color:tomato;">No movie data found. Please go back and try again.</p>
	</c:if>

	<input type="hidden" name="movieID" value="${movie.movieID}" />

        <label>Title:</label>
        <input type="text" name="title" value="${movie.title}" required /><br/>

        <label>Duration:</label>
        <input type="text" name="duration" value="${movie.duration}" required /><br/>
		<label>Release Date:</label>
		<input type="date" name="releaseDate" value="${movie.releaseDate}" required>
		
        <label>Country:</label>
        <input type="text" name="country" value="${movie.country}" required /><br/>

        <label>Director:</label>
        <input type="text" name="director" value="${movie.director}" required /><br/>

        <label>Description:</label>
        <textarea name="description" required>${movie.description}</textarea><br/>

        <label>Cast:</label>
        <input type="text" name="cast" value="${movie.cast}" required>

        <label>Image Path:</label>
        <input type="text" name="imagePath" value="${movie.imagePath}" /><br/>

        <button type="submit">Update Movie</button>
    	
</form>
</body>
</html>