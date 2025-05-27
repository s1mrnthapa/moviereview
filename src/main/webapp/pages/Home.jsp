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

		.movie-card .image-container {
			width: 100%;
			aspect-ratio: 2 / 3;
			overflow: hidden;
			border-radius: 6px;
		}

		.movie-card .image-container img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			display: block;
		}

		.movie-card h4 {
			margin-top: 10px;
			font-size: 1rem;
		}

		.movie-card p {
			font-size: 0.9rem;
			color: rgb(34, 255, 244);
		}
		
		section{
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		position: relative;
		scroll-snap-align: start;
		scroll-snap-stop:  normal;
	}
		.image_wrapper{
		position: relative;
	}
	.button_wrapper{
		display: flex;
		justify-content: center;
		align-items: center;
		position: absolute;
	}
	.explore_button{
		padding: 2em 5em;
		border: none;
		color:white;
 	   font-weight: bold;
		border-radius: 1000px;
		background-color: rgb(0, 0, 0);
		display: flex;
		justify-content: center;
		align-items: center;
        position: relative;
	}
	.explore_button::after{
		content: '';
		position: absolute;
		height: 108%;
		width: 104%;
		border-radius: 1000px;
		background-image: linear-gradient(to bottom right, rgb(186, 0, 0), rgb(109, 11, 207));
		z-index: -1;
	}
	.explore_button:hover{
		background-color: transparent;
    	z-index: 1;
    /* background-image: linear-gradient(green, pink); */
	}
	</style>
</head>

<body>
	<%@ include file="header.jsp" %>


	<section class="container1">
		<div class="image_wrapper">
			<img src="${pageContext.request.contextPath}/pages/resources/posters/spiderman.jpg" style="
				width:100%;
				height: 100vh;
				object-fit: cover;
				">
		</div>
		<div class="button_wrapper">
			<button class="explore_button">EXPLORE</button>
		</div>
	</section>


	<!-- ⭐ Trending Section -->
	<container class="trending-section">
		<h2 class="section-title">Trending This Week</h2>
		<div class="trending-grid">
			<c:forEach var="movie" items="${trendingMovies}">
				<div class="movie-card">
					<div class="image-container">
						<img src="${movie.imagePath}" alt="${movie.title}" />
					</div>
					<h4>${movie.title}</h4>
					<p>⭐ ${movie.averageRating}</p>
				</div>
			</c:forEach>
		</div>
	</container>

	<!-- 🎬 Upcoming Movies -->
	<container class="trending-section">
		<h2 class="section-title">Upcoming Movies</h2>
		<div class="trending-grid">
			<c:forEach var="movie" items="${upcomingMovies}">
				<div class="movie-card">
					<a href="${pageContext.request.contextPath}/MovieDetail?movieID=${movie.movieID}">
						<div class="image-container">
							<img src="${movie.imagePath}" alt="${movie.title}" />
						</div>
					</a>
					<h4>${movie.title}</h4>
					<p>📅 <fmt:formatDate value="${movie.releaseDate}" pattern="dd MMM yyyy" /></p>
				</div>
			</c:forEach>
		</div>
	</container>
	<%@ include file="footer.jsp" %>
	
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
