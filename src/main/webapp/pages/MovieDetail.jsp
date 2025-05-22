<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.regex.*" %>
<html>
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">
    <title>${movie.title} | Movie Detail</title>
    <style>
        body {
        color: white;
        }
        .movie-detail-container {
        	padding-top: 140px;
        	display: flex;
            gap: 70px;
            justify-content: center;
			margin-left: 60px;
			margin-right: 100px;
        }
        .movie-poster img {
            width: 280px;
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
       	.review-btn {
			  font-family: 'Cinzel Decorative', serif;
			  background-color: transparent;
			  color: rgb(34, 255, 244);
			  border: 1px solid rgb(34, 255, 244);
			  padding: 8px 80px;
			  border-radius: 5px;
			  font-size: 1em;
			  cursor: pointer;
			  transition: background-color 0.3s ease, color 0.3s ease;
			}
			
			.review-btn:hover {
			  background-color: rgba(34, 255, 244, 0.1);
			}

        .right{
        	width: 400px;
        }

        .movie-info {
		    display: flex;
		    align-items: center;
		    gap: 10px; /* Adjust spacing between items */
		    flex-wrap: wrap; /* Allows wrapping on smaller screens */
		    margin-bottom: 10px;
		}
        .movie-info h1 {
            font-size: 2em;
            font-family: 'Cinzel Decorative', serif;
            color: rgba(34, 255, 244, 0.7);
        }
        .info-item {
            font-size: 1em;
        }
        .tab-buttons {
		    display: flex;
		    gap: 25px;
		    margin: 20px 0;
		    justify-content: center;
		}
		
		.tab-text {
		    color: rgba(34, 255, 244, 0.7); /* soft cyan */
		    font-family: 'Cinzel Decorative', serif;
		    font-weight: 600;
		    font-size: 1.2em;
		    cursor: pointer;
		    position: relative;
		    padding-bottom: 5px;
		    transition: color 0.3s ease;
		    user-select: none;
		}
		
		.tab-text:hover {
		    color: rgb(34, 255, 244);
		}
		
		.tab-text.active {
		    color: rgb(34, 255, 244);
		}
		
		/* subtle underline for active tab */
		.tab-text.active::after {
		    content: "";
		    position: absolute;
		    bottom: 0;
		    left: 10%;
		    width: 80%;
		    height: 2px;
		    background-color: rgb(34, 255, 244);
		    border-radius: 1px;
		}
        
        .tab-pane {
            display: none;
            margin-buttom: 20px;
        }
        .tab-pane.active {
            display: block;
            margin-buttom: 20px;
        }
        .genre-tag, .cast-pill {
            display: inline-block;
            background-color: #444;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            margin: 5px 5px 0 0;
            font-size: 0.9em;
        }
        .watchlist-section, .review-section {
            margin-top: 20px;
        }
        .reviews{
        	display: grid;
			place-items: left;
			margin-left: 370px;
        }
        .user-review {
        	width: 800px;
            background-color: #2c2c2c;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            
        }
        .userr-name{
        	font-family: 'Cinzel Decorative', serif;
        	
        	margin-bottom: 20px;
        	font-size: 12px;
        	color: rgba(34, 255, 244, 0.7);
        }
        .review-author strong {
            color: #00a86b;
        }
        .modal {
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    background: rgba(0, 0, 0, 0.7);
		    display: none;
		    justify-content: center;
		    align-items: center;
		    z-index: 1000;
		}
		
		.modal-content {
		    background: linear-gradient(145deg, #1e1e1e, #262626);
		    border: 1px solid rgba(34, 255, 244, 0.2);
		    box-shadow: 0 0 15px rgba(34, 255, 244, 0.2);
		    border-radius: 15px;
		    padding: 30px;
		    width: 600px;
		    position: relative;
		    font-family: 'Cormorant Unicase', serif;
		    color: white;
		    animation: fadeIn 0.3s ease-in-out;
		}
		
		.modal-content textarea {
		    width: 100%;
		    height: 120px;
		    padding: 12px;
		    font-size: 1em;
		    font-family: 'El Messiri', sans-serif;
		    border: 1px solid #555;
		    border-radius: 10px;
		    background-color: #121212;
		    color: white;
		    resize: vertical;
		    margin-bottom: 15px;
		}
		.star-rating {
		    direction: rtl;
		    display: inline-flex;
		    gap: 5px;
		    font-size: 1.8em;
		    unicode-bidi: bidi-override;
		  }
		
		  .star-rating input[type="radio"] {
		    display: none;
		  }
		
		  .star-rating label {
		    color: #444;
		    cursor: pointer;
		    transition: color 0.2s;
		  }
		
		  .star-rating label:hover,
		  .star-rating label:hover ~ label,
		  .star-rating input[type="radio"]:checked ~ label {
		    color: rgb(34, 255, 244); /* cyan color */
		  }
		
		.modal-content button[type="submit"] {
		    background-color: transparent;
		    border: 1px solid rgb(34, 255, 244);
		    color: rgb(34, 255, 244);
		    padding: 8px 20px;
		    border-radius: 8px;
		    font-family: 'Cinzel Decorative', serif;
		    font-size: 1em;
		    cursor: pointer;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		}
		
		.modal-content button[type="submit"]:hover {
		    background-color: rgba(34, 255, 244, 0.1);
		    transform: scale(1.03);
		}
		
		.modal-content label {
		    font-size: 1em;
		    margin-right: 10px;
		    color: #ccc;
		}
		
		.close {
		    position: absolute;
		    top: 10px;
		    right: 15px;
		    font-size: 28px;
		    color: rgb(34, 255, 244);
		    cursor: pointer;
		}
		
		@keyframes fadeIn {
		    from {
		        transform: scale(0.95);
		        opacity: 0;
		    }
		    to {
		        transform: scale(1);
		        opacity: 1;
		    }
		}
        
    </style>
</head>
<body>
<%@ include file ="header.jsp" %>
<div class="movie-detail-container">
	<div class="left">
	    <div class="movie-poster">
	        <img src="${movie.imagePath}" alt="${movie.title}" />
	    </div>
	    <div class="review-section">
	        <button class="review-btn" onclick="openReviewModal('${movie.movieID}', '${movie.title}', '${movie.imagePath}')">Review or Log</button>
	    </div>
    </div>
    <div class="right">
	    <div class="movie-info">
	        <div class="info-item"><h1>${movie.title}</h1></div>
	        <div class="info-item"><fmt:formatDate value="${movie.releaseDate}" pattern="yyyy" /></div>
	        <div class="info-item"><b>Directed by</b> ${movie.director}</div>
	    </div>
	    <div class="info-item" style="line-height: 1.6;">
		    <div style="font-style: italic; margin-bottom: 10px; margin-top: 25px">
		        <c:out value="${firstSentence}" />
		    </div>
		    <div>
		        <c:out value="${restDescription}" />
		    </div>
		</div>
	    
    <div class="tab-buttons">
    	<span class="tab-text active" onclick="switchTab(event, 'cast')">Cast</span>
	    <span class="tab-text" onclick="switchTab(event, 'genre')">Genre</span>
	    <span class="tab-text" onclick="switchTab(event, 'details')">Details</span>
    </div>

    <div id="cast" class="tab-pane active">
	    <c:forEach var="castMember" items="${fn:split(fn:replace(fn:replace(movie.cast, '[', ''), ']', ''), ',')}">
	        <span class="cast-pill">${fn:trim(castMember)}</span>
	    </c:forEach>
	</div>

    <div id="details" class="tab-pane">
        <div class="info-item"><b>Release Date:</b> <fmt:formatDate value="${movie.releaseDate}" pattern="yyyy-MM-dd" /></div>
        <div class="info-item"><b>Country:</b> ${movie.country}</div>
        <div class="info-item"><b>Director:</b> ${movie.director}</div>
    </div>
    
    <div id="genre" class="tab-pane">
        <c:forEach var="g" items="${movie.genre}">
            <span class="genre-tag">${g}</span>
        </c:forEach>
    </div>
  </div>

	    <div id="reviewModal" class="modal">
	        <div class="modal-content">
	            <span class="close" onclick="closeReviewModal()">&times;</span>
	            	<form action="${pageContext.request.contextPath}/ReviewServlet" method="post">
				    <input type="hidden" name="movieID" value="${movie.movieID}" />
				    <input type="hidden" name="userID" value="${sessionScope.user.userId}" />
				    
				    <div>
				        <textarea name="reviewDescription" placeholder="Write your review here..." required></textarea>
				    </div>
				    
				    <div style="margin-bottom: 8px;">Rating:</div>
					  <div class="star-rating">
					    <input type="radio" id="star5" name="rating" value="5" required>
					    <label for="star5">&#9733;</label>
					    <input type="radio" id="star4" name="rating" value="4">
					    <label for="star4">&#9733;</label>
					    <input type="radio" id="star3" name="rating" value="3">
					    <label for="star3">&#9733;</label>
					    <input type="radio" id="star2" name="rating" value="2">
					    <label for="star2">&#9733;</label>
					    <input type="radio" id="star1" name="rating" value="1">
					    <label for="star1">&#9733;</label>
					  </div>
				    
				    <button type="submit">Save</button>
				</form>
	        </div>
	    </div>
	</div>
	<div class= "reviews">
	    <h2 style="margin-top: 50px;">Rating and Reviews</h2>
	    <c:forEach var="review" items="${movie.reviews}">
	        <div class="user-review">
	            <div class="review-author">
	                <div class= "userr-name"><h1>${review.username}</h1></div>
	                <div>Reviewed on <fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd" /></div>
	            </div>
	            <div><strong>Rated:</strong> ${review.rating} / 5</div>
	            <div>${review.reviewDescription}</div>
	        </div>
	    </c:forEach>
    </div>
	

<script>
	function switchTab(evt, tabName) {
	    // Remove active class from all tabs
	    document.querySelectorAll(".tab-text").forEach(tab => tab.classList.remove("active"));
	    // Hide all tab panes
	    document.querySelectorAll(".tab-pane").forEach(pane => pane.classList.remove("active"));
	    // Add active class to clicked tab
	    evt.currentTarget.classList.add("active");
	    // Show the selected tab pane
	    document.getElementById(tabName).classList.add("active");
	}
    function openReviewModal(id, title, imagePath) {
        document.getElementById("reviewModal").style.display = "flex";
    }
    function closeReviewModal() {
        document.getElementById("reviewModal").style.display = "none";
    }
</script>
</body>
</html>