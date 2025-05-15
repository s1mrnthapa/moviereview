<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<<<<<<< HEAD
=======
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
>>>>>>> origin/branch_simsim

<html>
<head>
    <title>${movie.title} | Movie Detail</title>
<<<<<<< HEAD
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
    <style>
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            background-color: #181818;
            color: #E0E0E0;
            margin: 0;
        }
        .movie-detail-container {
            display: flex;
            gap: 30px;
            max-width: 1200px;
            margin: 80px 200px;
            background-color: #1c1c1c;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.5);
=======
    <style>
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
        }
        .movie-detail-container {
            margin: 30px;
>>>>>>> origin/branch_simsim
        }
        .movie-poster img {
            width: 300px;
            height: 450px;
            object-fit: cover;
            border-radius: 10px;
        }
        .movie-info {
<<<<<<< HEAD
            flex: 1;
        }
        .movie-info h1 {
            margin-top: 0;
=======
        	display: flex;
            margin-top: 20px;
        }
        .movie-info h1 {
>>>>>>> origin/branch_simsim
            font-size: 2em;
            color: #ffffff;
        }
        .info-item {
<<<<<<< HEAD
            margin: 8px 0;
            font-size: 1em;
        }
        .genre-tags {
            margin: 10px 0;
        }
        .genre-tag {
            display: inline-block;
            background-color: #333;
            color: #ddd;
            padding: 5px 10px;
            margin: 3px;
            border-radius: 20px;
            font-size: 0.9em;
        }
        .watchlist-section, .review-section {
            margin-top: 10px;
        }
        .watchlist-section button {
        	margin-button: 40px;
        }
       	.rating{
       		margin-left: 60px;
       		text-align: center;
       	} 
        .rating .stars {
	        display: flex;
	        align-items: center;
	        gap: 10px;
	   	}
        .stars i {
	        color: #e6e6e6;
	        font-size: 20px;
	        cursor: pointer;
	        transition: color 0.2s ease;
        }
        .stars i:hover {
        	color: #ff9c1a;
        }
        .stars i.active {
        	color: #ff9c1a;
        }  
        textarea {
            width: 100%;
            height: 100px;
            background-color: #2c2c2c;
            color: #ccc;
            border: 1px solid #555;
            border-radius: 5px;
            padding: 10px;
            resize: none;
            margin-top: 10px;
        }
        .quote-text h2{
	        font-size: 18px;
	        margin-top: 34px;
        }
        button {
            background-color: #00A86B;
            color: white;
            border: none;
            padding: 10px 20px;
            margin-top: 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #007A53;
        }
        /* Modal Styles */
        .modal {
            position: fixed; /* Fixed typo: was 'postion' */
=======
            margin: 10px 0;
            font-size: 1em;
        }
        .tab-buttons {
            display: flex;
            gap: 15px;
            margin: 20px 0;
        }
        .tab-btn {
            background-color: #2c2c2c;
            color: #ccc;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
        }
        .tab-btn.active, .tab-btn:hover {
            background-color: #00a86b;
            color: #fff;
        }
        .tab-pane {
            display: none;
        }
        .tab-pane.active {
            display: block;
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
        .user-review {
            background-color: #2c2c2c;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
        }
        .review-author strong {
            color: #00a86b;
        }
        .modal {
            position: fixed;
>>>>>>> origin/branch_simsim
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            justify-content: center;
            align-items: center;
<<<<<<< HEAD
            z-index: 1000;
=======
>>>>>>> origin/branch_simsim
        }
        .modal-content {
            background: #1c1c1c;
            padding: 20px;
            border-radius: 10px;
<<<<<<< HEAD
            width: 800px;
            height: 500px;
            text-align: center;
            color: #fff;
            position: relative;
=======
            width: 700px;
>>>>>>> origin/branch_simsim
        }
        .close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 28px;
            cursor: pointer;
        }
<<<<<<< HEAD
	        .movie-container{
	        display: flex;
	        gap: 60px;
	        margin: 30px;
	        
	    }
	    .quote-text h2{
	     	margin-left: 30px;
	     }
        
        .movie-container img {
            border-radius: 6px;
            margin-bottom: 15px;
            width: 200px;
            height: 280px;
            object-fit: cover;
        }
        .contents-movie{
        	text-align: left;
        }
        .review-text textarea{
        	width: 450px;
        	height: 200px;
        }
        .sec-rating{
        	display: flex;
        }
        .save-button {
        	text-align: right;
        	margin-top: 50px;
        }
       /* User Reviews Section */
		.user-review {
		    background-color: #2c2c2c;
		    padding: 20px;
		    border-radius: 8px;
		    margin-top: 20px;
		    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
		    color: #e0e0e0;
		}
		
		.user-review-header {
		    display: flex;
		    gap: 15px;
		    align-items: center;
		}
		
		.user-avatar {
		    width: 40px;
		    height: 40px;
		    border-radius: 50%;
		    overflow: hidden;
		}
		
		.user-avatar img {
		    width: 100%;
		    height: 100%;
		    object-fit: cover;
		}
		
		.review-author {
		    color: #fff;
		}
		
		.review-author strong {
		    font-size: 1.1em;
		    color: #00a86b;
		}
		
		.review-date {
		    font-size: 0.9em;
		    color: #ccc;
		}
		
		.stars {
		    margin-top: 10px;
		}
		
		.stars i {
		    font-size: 18px;
		    color: #e6e6e6;
		    transition: color 0.2s ease;
		}
		
		.stars i.active {
		    color: #ff9c1a;
		}
		
		.review-text {
		    margin-top: 10px;
		}
		
		.review-text p {
		    font-size: 1em;
		    line-height: 1.6;
		}
		
		.review-divider {
		    margin-top: 15px;
		    border-top: 1px solid #444;
		    margin-bottom: 10px;
		}
       

    </style>
</head>

<body>

<div class="movie-detail-container">
    <!-- Movie Poster -->
    <div class="movie-poster">
        <img src="${movie.imagePath}" alt="${movie.title}" />
    </div>

    <!-- Movie Info -->
    <div class="movie-info">
        <h1>${movie.title}</h1>
        <div class="info-item"><b>Description:</b> ${movie.description}</div>
        <div class="info-item"><b>Release Date:</b> <fmt:formatDate value="${movie.releaseDate}" pattern="yyyy-MM-dd" /></div>
        <div class="info-item"><b>Duration:</b> ${movie.duration}</div>
        <div class="info-item"><b>Country:</b> ${movie.country}</div>
        <div class="info-item"><b>Director:</b> ${movie.director}</div>

        <!-- Genres -->
        <div class="genre-tags">
            <c:forEach var="g" items="${movie.genre}">
                <span class="genre-tag">${g}</span>
            </c:forEach>
        </div>

        <!-- Cast -->
        <div class="info-item"><b>Cast:</b> <c:out value="${movie.cast}" /></div>

        <!-- Watchlist Section -->
        <div class="watchlist-section">
            <h3>Add to Watchlist:</h3>
            <form action="/" method="post">
                <input type="hidden" name="movieID" value="${movie.movieID}" />
                <button type="submit">+ Add to Watchlist</button>
            </form>
        </div>

        <!-- Review Section -->
        <div class="review-section">
            <h3>Write a Review:</h3>
            <button onclick="openReviewModal('${movie.movieID}', '${movie.title}', '${movie.imagePath}')">Review or Log</button>
        </div>
    </div>
    <!-- Modal Overlay -->
<div id="reviewModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeReviewModal()">&times;</span>
        
        <div class="movie-container">
            <div class="poster-movie">
                <img id="modalMoviePoster" src="" alt="Movie Poster" />
            </div>
            <div class="contents-movie">
                <h2 id="modalMovieTitle"></h2>
                <!-- Form starts here -->
                <form id="reviewForm" action="${pageContext.request.contextPath}/ReviewServlet" method="post">
                    <input type="hidden" name="movieID" id="modalMovieID" />
                    <input type="hidden" name="userID" id="userID" value="${sessionScope.user.userId}" />

                    <!-- Review Description -->
                    <div class="review-text">
                        <textarea name="reviewDescription" placeholder="Write your review here..." required></textarea>
                    </div>
                    <div class="sec-rating">
                        <div class="quote-text">
                            <h2> A frame in your story. </h2>
                        </div>
                        <!-- Star Rating -->
                        <div class="rating">
                            <h3>Rating</h3>
                            <div class="stars">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                            </div>
                            <input type="hidden" name="rating" id="ratingValue" />
                        </div>
                    </div>
                    <!-- Submit Button -->
                    <div class="save-button">
                        <button type="submit">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>

<!-- User Reviews Section Below Movie Details -->
<h2>User Reviews</h2>

<c:forEach var="review" items="${movie.reviews}">
    <div class="user-review">
        <div class="user-review-header">
            <div class="user-avatar">
                <img src="path-to-avatar.jpg" alt="User Avatar" class="avatar-img" />
            </div>
            <div class="review-author">
                <strong>User ${review.userID}</strong>
                <p class="review-date">
                    Reviewed on <fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd" />
                </p>
            </div>
        </div>

        <!-- Numeric Rating -->
		<div class="rating">
		    <p><strong>Rated:</strong> ${review.rating} / 5</p>
		</div>
        

        <!-- Review Description -->
        <div class="review-text">
            <p>${review.reviewDescription}</p>
        </div>

        <hr class="review-divider" />
    </div>
</c:forEach>

<script>
		function openReviewModal(movieID, title, imagePath) {
		    document.getElementById('reviewModal').style.display = 'flex';
		    document.getElementById('modalMovieID').value = movieID;
		    document.getElementById('modalMovieTitle').innerText = title;
		    document.getElementById('modalMoviePoster').src = imagePath;
		}
		
		function closeReviewModal() {
		    document.getElementById('reviewModal').style.display = 'none';
		}
		
		function setRating(value) {
		    document.getElementById('ratingValue').value = value;
		}
		const stars = document.querySelectorAll(".stars i");

		stars.forEach((star, index1) => {
		    star.addEventListener("click", () => {
		        // Update stars' visual
		        stars.forEach((star, index2) => {
		            index1 >= index2 ? star.classList.add("active") : star.classList.remove("active");
		        });
		        
		        document.getElementById('ratingValue').value = index1 + 1;
		    });
		});

</script>

</body>
</html>
=======
    </style>
</head>
<body>
<div class="movie-detail-container">
    <div class="movie-poster">
        <img src="${movie.imagePath}" alt="${movie.title}" />
    </div>
    
    <div class="review-section">
        <button onclick="openReviewModal('${movie.movieID}', '${movie.title}', '${movie.imagePath}')">Review or Log</button>
    </div>
	<div class="title-details">
		<h1>${movie.title}</h1>
		
	</div>
    <div class="movie-info">
        <div class="info-item"><h1>${movie.title}</h1></div>
        <div class="info-item"><fmt:formatDate value="${movie.releaseDate}" pattern="yyyy" /></div>
        <div class="info-item"><b>Directed by</b> ${movie.director}</div>
    </div>
    <div class="info-item"><b>Description:</b> ${movie.description}</div>

    <div class="tab-buttons">
    	<button class="tab-btn active" onclick="switchTab(event, 'cast')">Cast</button>
        <button class="tab-btn" onclick="switchTab(event, 'genre')">Genre</button>
        <button class="tab-btn" onclick="switchTab(event, 'details')">Details</button>
    </div>

    <div id="cast" class="tab-pane active">
        <c:forEach var="castMember" items="${fn:split(movie.cast, ',')}">
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

    <div class="watchlist-section">
        <form action="/" method="post">
            <input type="hidden" name="movieID" value="${movie.movieID}" />
            <button type="submit">+ Add to Watchlist</button>
        </form>
    </div>

    <div id="reviewModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeReviewModal()">&times;</span>
            <form action="${pageContext.request.contextPath}/ReviewServlet" method="post">
                <input type="hidden" name="movieID" value="${movie.movieID}" />
                <input type="hidden" name="userID" value="${sessionScope.user.userId}" />
                <textarea name="reviewDescription" placeholder="Write your review here..." required></textarea>
                <div>
                    <label>Rating: <input type="number" name="rating" min="1" max="5" required></label>
                </div>
                <button type="submit">Save</button>
            </form>
        </div>
    </div>

    <h2>User Reviews</h2>
    <c:forEach var="review" items="${movie.reviews}">
        <div class="user-review">
            <div class="review-author">
                <strong>User ${review.userID}</strong>
                <div>Reviewed on <fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd" /></div>
            </div>
            <div><strong>Rated:</strong> ${review.rating} / 5</div>
            <div>${review.reviewDescription}</div>
        </div>
    </c:forEach>
</div>

<script>
    function switchTab(evt, tabName) {
        document.querySelectorAll(".tab-pane").forEach(pane => pane.classList.remove("active"));
        document.querySelectorAll(".tab-btn").forEach(btn => btn.classList.remove("active"));
        document.getElementById(tabName).classList.add("active");
        evt.currentTarget.classList.add("active");
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
>>>>>>> origin/branch_simsim
