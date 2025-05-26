<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Playball&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Roboto+Serif:ital,opsz,wght@0,8..144,100..900;1,8..144,100..900&display=swap" rel="stylesheet">
    <title>Movies List</title>
    <style>
      body {
         background-color: black;
     }
	     .title h1{
	     	padding-top: 100px;
	     	color: white;
	     	text-align: center;
	     	font-family: "Cinzel Decorative";
	     	font-weight: 500;
	     	font-style: italic;
	     }
	     .search-section {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    margin: 40px;
		    gap: 20px;
		}

		.filter-search-wrapper {
			  display: flex;
			  gap: 1rem;
			  flex-wrap: wrap;
			  align-items: center;
			  margin-top: 1rem;
			}
		
		.filter-select {
		    background-color: #1c1f23;
		    color: white;
		    border: 1px solid #333;
		    padding: 5px 1px;
		    border-radius: 6px;
		    font-size: 14px;
		    font-family:  Cinzel Decorative, Bodoni Moda, Amarante,  Viaoda Libre, arial;
	        font-style: italic;
		    
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
		.search-box {        
  			  margin-left: 48em;
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
		.browse-title h4{
			font-family: 'Cinzel Decorative';
			font-size: 14px;
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
	     .star-filled{
		     font-family: Bodoni Moda;
		     color: yellow;
		     font-size: 13px;
	     }
	     .rating-value{
		     color: #888;
		     font-family: Bodoni Moda;
	     }
	     .error-message {
		    background-color: #ff4c4c;
		    color: white;
		    padding: 10px 20px;
		    border-radius: 8px;
		    margin: 20px auto;
		    width: fit-content;
		    font-family: 'Poppins', sans-serif;
		    font-weight: bold;
		    box-shadow: 0 0 10px rgba(255, 0, 0, 0.4);
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
  <form action="${pageContext.request.contextPath}/MovieListServlet" method="get">
    
    <div class="filter-search-wrapper">
	    <div class= "browse-title">
	    	<h4 style="color: white;">Browse By</h4>
	    </div>
      <!-- Year Filter -->
      <div>
      <select class="filter-select" id="year" name="year">
        <option value="" selected>Year</option>
        <option value="Upcoming" ${param.year == 'Upcoming' ? 'selected' : ''}>Upcoming</option>
        <option value="2020" ${param.year == '2020' ? 'selected' : ''}>2020s</option>
        <option value="2010" ${param.year == '2010' ? 'selected' : ''}>2010s</option>
        <option value="2000" ${param.year == '2000' ? 'selected' : ''}>2000s</option>
        <option value="1990" ${param.year == '1990' ? 'selected' : ''}>1990s</option>
        <option value="1980" ${param.year == '1980' ? 'selected' : ''}>1980s</option>
        <option value="1970" ${param.year == '1970' ? 'selected' : ''}>1970s</option>
        <option value="1960" ${param.year == '1960' ? 'selected' : ''}>1960s</option>    
      </select>

      <!-- Genre Filter -->
      <select class="filter-select" id="genre" name="genre">
        <option value="" selected>Genre</option>
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

      <!-- Search Box -->
      <div class="search-box">
        <input type="search" class="search-input" name="keyword" placeholder="Search for a film...">
        <button class="search-button">Search</button>
        <c:if test="${empty error}">
		    <div class="error-message">${error}</div>
		</c:if>
      </div>
    </div>
  </form>
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
		            <div class="movie-meta">
					    <span class="star-filled">&#9733;</span>
    					<span class="rating-value">${movie.averageRating}</span>
					    &nbsp;|&nbsp;
					    <span class="release-year">
					        <fmt:formatDate value="${movie.releaseDate}" pattern="yyyy" />
					    </span>
					</div>    
	        </div>
	    </div>
	</c:forEach>
	</div>
	
	<script>
	  // Get references to the selects
	  const yearSelect = document.getElementById('year');
	  const genreSelect = document.getElementById('genre');
	
	  yearSelect.addEventListener('change', () => {
	    yearSelect.form.submit();
	  });
	
	  genreSelect.addEventListener('change', () => {
	    genreSelect.form.submit();
	  });
	</script>
</body>
</html>