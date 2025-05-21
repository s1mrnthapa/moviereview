<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">

	<meta charset="UTF-8">
	<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
	<title>CINECRITIQUE</title>
	<link rel="stylesheet" href="https://use.typekit.net/your-kit-id.css">

	<style>
		body {
			background-color: black;
			color: white;
			font-family: 'Cinzel', serif;
			margin: 0;
			padding: 0;
		}
		.trending-section {
			padding: 60px 40px;
			background-color: #111;
		}
		.trending-section h2 {
			color: #rgb(34,255,244);
			margin-bottom: 30px;
			text-align: center;
			font-size: 2rem;
		}
		.trending-grid {
			display: grid;
			grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
			gap: 20px;
		}
		.movie-card {
			background: #222;
			border-radius: 10px;
			padding: 10px;
			text-align: center;
			transition: transform 0.3s ease;
		}
		.movie-card:hover {
			transform: scale(1.05);
		}
		.movie-card img {
			width: 100%;
			height: 270px;
			object-fit: cover;
			border-radius: 6px;
		}
		.movie-card h4 {
			margin-top: 10px;
			font-size: 1rem;
		}
		.movie-card p {
			font-size: 0.9rem;
			color: #rgb(34,255,244);
		}
		
	</style>
</head>

<body>
	<%@ include file="header.jsp" %>

	<!-- ⭐ Trending Section -->
	<section class="movie-container">
		<h2>Trending This Week</h2>
		<div class="trending-grid">
			<c:forEach var="movie" items="${trendingMovies}">
				<div class="movie-card">
					<img src="${movie.imagePath}" alt="${movie.title}" />
					<h4>${movie.title}</h4>
					<p>⭐ ${movie.averageRating}</p>
				</div>
			</c:forEach>
		</div>
	</section>

	<div class="movie-container">
	<c:forEach var="movie" items="${movies}">
	    <div class="movie-card">
	    	<a href="${pageContext.request.contextPath}/MovieDetail?movieID=${movie.movieID}">
	        	<img src="${movie.imagePath}" alt="${movie.title}" />
	        	</a>
	        	<div class="movie-details">
		            <div class="title">${movie.title}</div>
		            <div class="release-year"><fmt:formatDate value="${movie.releaseDate}" pattern="yyyy" /></div>
	        </div>
	    </div>
	</c:forEach>
	</div>

	<!-- 🎬 Upcoming Movies -->
	<section class="trending-section">
		<h2>Upcoming Movies</h2>
		<div class="trending-grid">
			<c:forEach var="movie" items="${upcomingMovies}">
				<div class="movie-card">
				<a href="${pageContext.request.contextPath}/MovieDetail?movieID=${movie.movieID}">
					<img src="${movie.imagePath}" alt="${movie.title}" />
				</a>
					<h4>${movie.title}</h4>
					<p>📅 <fmt:formatDate value="${movie.releaseDate}" pattern="dd MMM yyyy"/></p>
				</div>
			</c:forEach>
		</div>
	</section>

	<%@ include file="footer.jsp" %>
</body>
</html>