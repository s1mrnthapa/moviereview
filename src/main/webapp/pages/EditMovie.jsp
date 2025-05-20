<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Movie</title>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;700&family=Julius+Sans+One&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Julius Sans One', sans-serif;
            background: url('https://wallpaperaccess.com/full/1119536.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #eee;
        }

        form {
            background: rgba(28, 28, 28, 0.85);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.6);
            max-width: 700px;
            width: 100%;
            color: #fff;
        }

        h2 {
            font-family: 'Cinzel', serif;
            font-size: 32px;
            margin-bottom: 25px;
            text-align: center;
            color: #f4c95d;
        }

        label {
            display: block;
            margin-top: 18px;
            font-weight: bold;
            color: #f4c95d;
            font-size: 14px;
        }

        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            border: none;
            border-radius: 10px;
            background-color: rgba(255, 255, 255, 0.08);
            color: #f0f0f0;
            font-size: 15px;
            transition: background-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        textarea:focus {
            background-color: rgba(255, 255, 255, 0.12);
            outline: none;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        input[type="hidden"] {
            display: none;
        }

        button {
            width: 100%;
            margin-top: 30px;
            padding: 14px;
            border: none;
            border-radius: 10px;
            background-color: #f4c95d;
            color: #1c1c1c;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s;
        }

        button:hover {
            background-color: #ffd777;
            transform: scale(1.02);
        }

        .error-message {
            text-align: center;
            color: tomato;
            font-weight: bold;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<form action="${pageContext.request.contextPath}/EditMovieServlet" method="POST" enctype="multipart/form-data">
    <h2>Edit Movie</h2>

    <c:if test="${empty movie}">
        <p class="error-message">No movie data found. Please go back and try again.</p>
    </c:if>

    <input type="hidden" name="movieID" value="${movie.movieID}" />
    <p>DEBUG: movieID = ${movie.movieID}</p>

    <label>Title:</label>
    <input type="text" name="title" value="${movie.title}" required />

    <label>Duration:</label>
    <input type="text" name="duration" value="${movie.duration}" required />

    <label>Release Date:</label>
    <input type="date" name="releaseDate" value="${movie.releaseDate}" required />

    <label>Country:</label>
    <input type="text" name="country" value="${movie.country}" required />

    <label>Director:</label>
    <input type="text" name="director" value="${movie.director}" required />

    <label>Description:</label>
    <textarea name="description" required>${movie.description}</textarea>
    
    <!-- Cast -->
	<c:set var="castString" value="" />
	<c:forEach var="c" items="${movie.cast}" varStatus="status">
	    <c:set var="castString" value="${castString}${c}${status.last ? '' : ', '}" />
	</c:forEach>
	
	<label>Cast:</label>
	<input type="text" name="cast" value="${castString}" />
	
	<label>Genres:</label>
		<div>
		    <c:forEach var="genre" items="${allGenres}">
		        <label>
		            <input type="checkbox" name="genres" value="${genre}" 
		                <c:if test="${selectedGenres.contains(genre)}">checked</c:if> />
		            ${genre}
		        </label><br/>
		    </c:forEach>
		</div>
	    <label>Current Image:</label>
	    <div>
	        <img src="${movie.imagePath}" alt="Movie Image" style="max-width: 150px; max-height: 150px; border-radius: 8px; margin-bottom: 10px;" />
	    </div>
	
	    <label>Upload New Image (optional):</label>
    	<input type="file" name="imageFile" accept="image/*" />

    <button type="submit">Update Movie</button>
</form>
</body>
</html>
