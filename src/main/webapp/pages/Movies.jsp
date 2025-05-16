<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">
    <title>Movies List</title>
    <style>
      body {
         background-color: black;
     }
     .title h1{
     	padding-top: 100px;
     	color: white;
     	text-align: center;
     	font-family: Cinzel Decorative;
     	font-size: 30px;
     }
	     .search-section {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin: 40px;
		    gap: 20px;
		}

		/* Filters */
		.filters {
		    display: flex;
		    align-items: center;
		    flex-wrap: wrap;
		    font-family: 'Amarante', serif;
		    color: #ccc;
		}
		.filters-sec {
			margin-left: 20px;
		}
		
		.filter-select {
		    background-color: #1c1f23;
		    color: white;
		    border: 1px solid #333;
		    padding: 5px 1px;
		    border-radius: 6px;
		    font-size: 14px;
		    font-family: 'Bodoni Moda', serif;
		}
		/* Search Box */
		.search-box {
		    display: flex;
		    align-items: center;
		    gap: 10px;
		}
		
		.search-input {
		    padding: 8px 14px;
		    font-size: 14px;
		    border-radius: 6px;
		    border: 1px solid #333;
		    background-color: #1c1f23;
		    color: white;
		    width: 220px;
		    font-family:  Cinzel Decorative, Bodoni Moda, Amarante,  Viaoda Libre, arial;
	          font-style: italic;
		}
		
		.search-button {
		    padding: 8px 10px;
		    border: none;
		    background-color: rgb(34, 255, 244);
		    color: black;
		    font-weight: bold;
		    font-size: 14px;
		    border-radius: 6px;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		    font-family: 'Cinzel Decorative', serif;
		}
		
		.search-button:hover {
		    background-color: #00b848;
		}
		     
	     .movie-container {
	         display: grid;
	         grid-template-columns: repeat(6, 1fr); /* 5 equal-width columns */
			 gap: 30px; 
			 justify-self: center; /* horizontal center */
	  		 align-self: center; 
	  		 margin-top: 40px;
	     }
	     .movie-container .movie-card {
	         border: 1px solid #1E1E1E;
	         border-radius: 5px;
	         padding: 10px;
	         width: 220px; 
	         background-color: #1E1E1E;
	         text-align: center;
	         justify-content: center;
	         flex-wrap: wrap;
	     }
	     .movie-card img {
	         width: 100%;
	         height: 270px; 
	         object-fit: cover;
	         border-radius: 5px;
	     }
	     .movie-card .movie-details {
	         padding-top: 10px;
	         font-size: 14px;
	         color: #333;
	     }
	     .movie-card .movie-details .title {
	     	 font-family: Cinzel Decorative, Viaoda Libre, Bodoni Moda,  Amarante, arial;
	     	 color: white;
	         font-weight: bold;
	         font-size: 16px;
	     }
	     .movie-card .movie-details .release-year {
	     	 font-family: Bodoni Moda;
	         font-size: 14px;
	         color: #888;
	     }
 </style>
    
</head>
<body>
<%@ include file ="header.jsp" %>


<c:if test="${empty movies}">
    <p>No movies available.</p>
    <c:redirect url='${request.contextPath}/MovieListServlet'/>
</c:if>
<div class="title">
	<h1>"Cinema is timeless, So are these films"</h1>
</div>
<div class="search-section">
 <!-- Left filters -->
    <div class="filters">
		<h4 style= "color: white;"> Browse By </h4>
		<div class="filters-sec">
		<form action="${pageContext.request.contextPath}/MovieListServlet" method="get">
			<select class="filter-select" id="year" name="year">
	          <option value="" ${empty param.year ? 'selected' : ''}>All Years</option>
	          <option value="Upcoming" ${param.year == 'Upcoming' ? 'selected' : ''}>Upcoming</option>
	          <option value="2020" ${param.year == '2020' ? 'selected' : ''}>2020s</option>
	          <option value="2010" ${param.year == '2010' ? 'selected' : ''}>2010s</option>
	          <option value="2000" ${param.year == '2000' ? 'selected' : ''}>2000s</option>
	          <option value="1990" ${param.year == '1990' ? 'selected' : ''}>1990s</option>
	          <option value="1980" ${param.year == '1980' ? 'selected' : ''}>1980s</option>
	          <option value="1970" ${param.year == '1970' ? 'selected' : ''}>1970s</option>
	          <option value="1960" ${param.year == '1960' ? 'selected' : ''}>1960s</option>
	          <option value="1950" ${param.year == '1950' ? 'selected' : ''}>1950s</option>
	          <option value="1940" ${param.year == '1940' ? 'selected' : ''}>1940s</option>
	          <option value="1930" ${param.year == '1930' ? 'selected' : ''}>1930s</option>
	          <option value="1920" ${param.year == '1920' ? 'selected' : ''}>1920s</option>
	          <option value="1910" ${param.year == '1910' ? 'selected' : ''}>1910s</option>
	          <option value="1900" ${param.year == '1900' ? 'selected' : ''}>1900s</option>
	          <option value="1890" ${param.year == '1890' ? 'selected' : ''}>1890s</option>
	          <option value="1880" ${param.year == '1880' ? 'selected' : ''}>1880s</option>
	          <option value="1870" ${param.year == '1870' ? 'selected' : ''}>1870s</option>
	          <option value="1860" ${param.year == '1860' ? 'selected' : ''}>1860s</option>
        </select>

        <select class="filter-select" id="genre" name="genre">
          <option value="" ${empty param.genre ? 'selected' : ''}>All Genres</option>
          <option value="Action" ${param.genre == 'PG13' ? 'selected' : ''}>Action</option>
          <option value="Drama" ${param.genre == 'Family Drama' ? 'selected' : ''}>Drama</option>
          <option value="Comedy" ${param.genre == 'Comedy' ? 'selected' : ''}>Comedy</option>
          <option value="Thriller" ${param.genre == 'Thriller' ? 'selected' : ''}>Thriller</option>
          <option value="Adventure" ${param.genre == 'Adventure' ? 'selected' : ''}>Adventure</option>
          <option value="Romance" ${param.genre == 'Romance' ? 'selected' : ''}>Romance</option>
          <option value="Science Fiction" ${param.genre == 'Science Fiction' ? 'selected' : ''}>Science Fiction</option>
          <option value="Music" ${param.genre == 'Music' ? 'selected' : ''}>Music</option>
          <option value="Crime" ${param.genre == 'Crime' ? 'selected' : ''}>Crime</option>
          <option value="Horror" ${param.genre == 'Horror' ? 'selected' : ''}>Horror</option>
          <option value="Animation" ${param.genre == 'Animation' ? 'selected' : ''}>Animation</option>
        </select>
        
         <select class="filter-select" id="genre" name="genre">
          <option value="" ${empty param.genre ? 'selected' : ''}>All Genres</option>
          <option value="Action" ${param.genre == 'Action' ? 'selected' : ''}>Action</option>
          <option value="Drama" ${param.genre == 'Drama' ? 'selected' : ''}>Drama</option>
          <option value="Comedy" ${param.genre == 'Comedy' ? 'selected' : ''}>Comedy</option>
          <option value="Thriller" ${param.genre == 'Thriller' ? 'selected' : ''}>Thriller</option>
          <option value="Adventure" ${param.genre == 'Adventure' ? 'selected' : ''}>Adventure</option>
          <option value="Romance" ${param.genre == 'Romance' ? 'selected' : ''}>Romance</option>
          <option value="Science Fiction" ${param.genre == 'Science Fiction' ? 'selected' : ''}>Science Fiction</option>
          <option value="Music" ${param.genre == 'Music' ? 'selected' : ''}>Music</option>
          <option value="Crime" ${param.genre == 'Crime' ? 'selected' : ''}>Crime</option>
          <option value="Horror" ${param.genre == 'Horror' ? 'selected' : ''}>Horror</option>
          <option value="Animation" ${param.genre == 'Animation' ? 'selected' : ''}>Animation</option>
        </select>
	</div>
	</div>
	<!-- Right: Search box -->
    <div class="search-box">
        <input type="search" class="search-input" placeholder="Search for a film...">
        <button class="search-button">Search</button>
    </div>
</div>

<!-- Loop through movies if not empty -->
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

</body>
</html>
