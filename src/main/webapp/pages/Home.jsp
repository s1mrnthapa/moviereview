<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Cinzel:wght@400..900&family=Julius+Sans+One&display=swap" rel="stylesheet">
	<title>CINECRITIQUE</title>

	<style>
		body {
			background-color: #000;
			color: white;
			font-family: 'Cinzel', serif;
			margin: 0;
			padding: 0;
		}

		/* ===== Slider Section ===== */
		.slider-container {
			width: 100%;
			height: 400px;
			overflow: hidden;
			position: relative;
			margin-bottom: 60px;
		}

		.slider {
			display: flex;
			width: 100%;
			height: 100%;
			transition: transform 1s ease;
		}

		.slide {
			min-width: 100%;
			height: 100%;
			position: relative;
		}

		.slide img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			filter: brightness(65%);
		}

		.slide-caption {
			position: absolute;
			bottom: 30px;
			left: 50%;
			transform: translateX(-50%);
			color: rgb(34, 255, 244);
			font-size: 2rem;
			font-family: 'Julius Sans One', sans-serif;
			background: rgba(0, 0, 0, 0.5);
			padding: 10px 20px;
			border-radius: 10px;
		}

		/* ===== Section Titles ===== */
		.section-title {
			color: rgb(34, 255, 244);
			margin-bottom: 30px;
			text-align: center;
			font-size: 2rem;
			font-family: 'Julius Sans One', sans-serif;
		}

		/* ===== Movie Grids ===== */
		.trending-section {
			padding: 60px 40px;
			background-color: #111;
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
			color: rgb(34, 255, 244);
		}
	</style>
</head>

<body>
	<%@ include file="header.jsp" %>

	<!-- 🎞️ Trending Slider -->
	<div class="slider-container">
		<div class="slider" id="slider">
			<c:forEach var="movie" items="${trendingMovies}">
				<div class="slide">
					<img src="${movie.imagePath}" alt="${movie.title}">
					<div class="slide-caption">${movie.title}</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- ⭐ Trending Section -->
	<section class="trending-section">
		<h2 class="section-title">Trending This Week</h2>
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

	<!-- 🎬 Upcoming Movies -->
	<section class="trending-section">
		<h2 class="section-title">Upcoming Movies</h2>
		<div class="trending-grid">
			<c:forEach var="movie" items="${upcomingMovies}">
				<div class="movie-card">
					<a href="${pageContext.request.contextPath}/MovieDetail?movieID=${movie.movieID}">
						<img src="${movie.imagePath}" alt="${movie.title}" />
					</a>
					<h4>${movie.title}</h4>
					<p>📅 <fmt:formatDate value="${movie.releaseDate}" pattern="dd MMM yyyy" /></p>
				</div>
			</c:forEach>
		</div>
	</section>

	<!-- 🔄 Slider Script -->
	<script>
		let currentIndex = 0;
		const slides = document.querySelectorAll('.slide');
		const totalSlides = slides.length;

		function showSlide(index) {
			const slider = document.getElementById('slider');
			slider.style.transform = `translateX(-${index * 100}%)`;
		}

		function autoSlide() {
			currentIndex = (currentIndex + 1) % totalSlides;
			showSlide(currentIndex);
		}

		setInterval(autoSlide, 4000); // Every 4 seconds
	</script>
</body>
</html>
