<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Movies List</title>
    <style>
    body {
        font-family: Arial, sans-serif;
    }
    .movie-container {
        display: flex;
        flex-wrap: wrap;
        gap: 15px; /* smaller gap between cards */
    }
    .movie-card {
        border: 1px solid #ccc;
        padding: 10px;
        width: 180px; /* make card itself smaller */
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        background-color: #fff;
    }
    .movie-card h2 {
        font-size: 1em; /* smaller title font */
        margin-bottom: 5px;
    }
    .movie-card p {
        font-size: 0.8em; /* smaller text */
        margin: 3px 0;
    }
    .movie-card ul {
        list-style-type: none;
        padding: 0;
    }
    .movie-card ul li {
        font-size: 0.8em;
    }
    .movie-card img {
        width: 100%;
        height: 270px; /* height keeping 2:3 ratio (180 * 1.5 = 270) */
        object-fit: cover; /* fill the box perfectly */
    }
</style>
    
    
</head>
<body>

<h1>Movies List</h1>

<!-- Loop through the movies list passed from the servlet -->
<!-- Check if movies is null or empty -->
<c:if test="${empty movies}">
    <p>No movies available.</p>
</c:if>

<!-- Loop through movies if not empty -->
<c:forEach var="movie" items="${movies}">
    <div class="movie-card">
        <h2>${movie.title}</h2>
        <img src="${movie.imagePath}" alt="${movie.title}" />
        <p><b>Release Date:</b> <fmt:formatDate value="${movie.releaseDate}" pattern="yyyy-MM-dd" /></p>
        <p><b>Duration:</b> ${movie.duration}</p>
        <p><b>Country:</b> ${movie.country}</p>
        <p><b>Director:</b> ${movie.director}</p>
        <p><b>Description:</b> ${movie.description}</p>
        <p><b>Genres:</b>
            <c:forEach var="g" items="${movie.genre}">
                <span>${g}<c:if test="${!gStatus.last}">, </c:if></span>
            </c:forEach>
        </p>
        <p><b>Cast:</b>
            <c:forEach var="actor" items="${movie.cast}">
                <span>${actor}</span><c:if test="${!empty actor}">, </c:if>
            </c:forEach>
        </p>
    </div>
</c:forEach>

</body>
</html>
