<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>${movie.title} | Movie Detail</title>
    <style>
        body {
            font-family: 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
        }
        .movie-detail-container {
            margin: 30px;
        }
        .movie-poster img {
            width: 300px;
            height: 450px;
            object-fit: cover;
            border-radius: 10px;
        }
        .movie-info {
        	display: flex;
            margin-top: 20px;
        }
        .movie-info h1 {
            font-size: 2em;
            color: #ffffff;
        }
        .info-item {
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
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background: #1c1c1c;
            padding: 20px;
            border-radius: 10px;
            width: 700px;
        }
        .close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 28px;
            cursor: pointer;
        }
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