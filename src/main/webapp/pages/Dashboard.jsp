<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html>
<head>

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="resources/admin/style/dashboard.css">
<meta charset="UTF-8">
<title>CINECRITIQUE</title>
<link rel="stylesheet" href="https://use.typekit.net/your-kit-id.css">
<style>
	
	body{
		color:white;
	}
	.section1{
		display: flex;
		padding-top: 120px;
		justify-content: center;
		align-item: center;
	}
	.left-section-top, .sub-section{
		display: flex;
		background: blue;
		justify-content: center;
		align-item: center;
		text-align: center;
	} 
		
	.sub-section{
		width: 300px;
		height: 100px;
		
	}
	
	.highest-rated{
		height: 350px;
		background: pink;
	}
	.column{
	display: grid;
	grid-template-columns: 120px 1fr 120px;
	
}
	
	.right-section{
		background: lightblue;
	}
	
</style>

</head>

<body>
	<%@ include file = "AdminHeader.jsp" %>
	<section class="section1">
		<div class="left-section">
			<div class="left-section-top">
				<div class="sub-section sub-section1">
					Total Movies</br> ${totalMovies}
				</div>
				<div class="sub-section sub-section2">
					Total Users </br> ${totalUsers}
				</div>
				<div class="sub-section sub-section3">
					Total Reviews </br> ${totalReviews}
				</div>
			</div>
			<div class="highest-rated">
				<p>Highest Rated Movies<p>
				<div class="column">
					<p>Rank</p>
					<p>Movie Title</p>
					<p>Rating</p>
				</div>
				<c:forEach var="movie" items="${topRatedMovies}" varStatus="loop">
				    <div class="column">
				        <p>${loop.index + 1}</p>
				        <p>${movie.title}</p>
				        <p>${movie.averageRating}</p>
				    </div>
				</c:forEach>
			</div>
		</div>
		<div class="right-section">
			<img src = "" class="user-profile">
			<p>Top Contributor this month ${topReviewerName}</p>
			<p>Total of ${topReviewCount} Films reviewed</p>
		</div>
	</section>
</body>
</html>
