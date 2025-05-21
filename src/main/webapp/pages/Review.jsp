<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">

  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Reviews - CineCritique</title>
  <style>
    body {
      font-family:Cinzel Decorative, Viaoda Libre, Bodoni Moda,  Amarante, arial;
      margin: 0;
      background-color: #0b0b0b;
      color: #fff;
    }

/* Nav Profile Section  */
	.nav-profile-section {
	  display: flex;
	  padding-top:90px ;
	  align-items: center;
	  background-color: #1a1a1a;
	  border-bottom: 1px solid #333;
	}
	
	.nav-avatar {
	  width: 40px; 
	  height: 40px;
	  border-radius: 50%;
	  background-color: #1f1f1f;
	  margin-right: 20px;
	  border: 2px solid #ff3c3c;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  overflow: hidden;
	}
	
	.nav-profile-pic {
	  width: 100%;
	  height: 100%;
	  object-fit: cover;
	  background-color: #1a1a1a;
	}
	
	.nav-links {
	  display: flex;
	  gap: 20px;
	}
	
	.nav-tab {
	  color: #ccc;
	  text-decoration: none;
	  font-size: 14px;
	  padding-bottom: 5px;
	  transition: color 0.3s;
	}
	
	.nav-tab:hover {
	  color: #ff3c3c;
	}
	
	.nav-tab.active {
	  color: #ff3c3c;
	  border-bottom: 2px solid #ff3c3c;
	}

    /* Filter Bar */
    .tabs {
      display: flex;
      margin-bottom: 20px;
      border-bottom: 2px solid #ff3c3c;
      padding-bottom: 10px;
    }

    .tab {
      color: white;
      text-decoration: none;
      margin-right: 25px;
      padding-bottom: 10px;
      text-transform: uppercase;
      font-size: 14px;
      font-weight: bold;
      transition: color 0.3s, border-bottom 0.3s;
    }

    .tab:hover {
      color: #ff3c3c;
    }

    .tab.active {
      color: #ff3c3c;
      border-bottom: 3px solid #ff3c3c;
    }

    /* Reviews Container */
    .reviews-container {
      max-width: 800px;
      margin: 20px auto;
      padding: 20px;
      background: #1a1a1a;
      color: white;
    }

    .reviews-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      border-bottom: 2px solid #ff3c3c;
      padding-bottom: 10px;
    }

    .sort-options {
      margin-bottom: 15px;
      padding: 10px;
      background-color: #1f1f1f;
      border-radius: 4px;
    }

    .sort-options a {
      color: #ff3c3c;
      text-decoration: none;
      margin: 0 5px;
      padding: 3px 8px;
      border-radius: 3px;
    }

    .sort-options a:hover {
      background-color: #2a2a2a;
    }

    .sort-options a.active {
      background-color: #ff3c3c;
      color: white;
    }

    /* Review Items */
    .review-item {
	    display: flex;
	    flex-direction: column;
	    margin-bottom: 25px;
	    padding: 20px;
	    border-left: 3px solid #ff3c3c;
	    background: #2c2c2c;
	    border-radius: 4px;
	    gap: 15px;
	}
	
	.review-header {
	    display: flex;
	    gap: 20px;
	}
	
	.review-poster {
	    width: 100px;
	    height: 150px;
	    overflow: hidden;
	    border-radius: 4px;
	    flex-shrink: 0;
	}
	
	.review-poster img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	
	.review-info {
	    flex: 1;
	}

    .review-date {
      color: #999;
      font-size: 0.9em;
      margin-bottom: 10px;
    }

    .review-rating {
      margin-bottom: 10px;
      font-weight: bold;
    }

    .review-content {
      color: #ddd;
      line-height: 1.5;
      margin-bottom: 15px;
    }

    .review-actions {
      margin-top: 15px;
    }

    .edit-btn, .delete-btn {
      padding: 5px 10px;
      margin-right: 10px;
      border-radius: 3px;
      text-decoration: none;
      font-size: 14px;
      transition: all 0.3s;
    }

    .edit-btn {
      background-color: #1f1f1f;
      color: #ff3c3c;
      border: 1px solid #ff3c3c;
    }

    .edit-btn:hover {
      background-color: #ff3c3c;
      color: white;
    }

    .delete-btn {
      background-color: #1f1f1f;
      color: #ff0000;
      border: 1px solid #ff0000;
    }

    .delete-btn:hover {
      background-color: #ff0000;
      color: white;
    }

    .back-link {
      display: inline-block;
      margin-top: 20px;
      color: #ff3c3c;
      text-decoration: none;
      padding: 8px 15px;
      border: 1px solid #ff3c3c;
      border-radius: 4px;
    }

    .back-link:hover {
      background-color: #ff3c3c;
      color: white;
    }

    .no-reviews {
      text-align: center;
      padding: 30px;
      color: #999;
      font-style: italic;
    }

    /* Message Styles */
    .message-container {
      margin-bottom: 20px;
    }

    .success-message {
      background-color: #ddffdd;
      color: #000;
      padding: 10px;
      margin-bottom: 20px;
      border-left: 4px solid #4CAF50;
    }

    .error-message {
      background-color: #ffdddd;
      color: #000;
      padding: 10px;
      margin-bottom: 20px;
      border-left: 4px solid #f44336;
    }
  </style>
</head>
<body>

  <!-- Header -->
 
   <%@ include file = "header.jsp" %>
 

  <!-- Profile Navigation Bar -->
  <div class="nav-profile-section">
	<div class="nav-avatar">
	   <img src="${pageContext.request.contextPath}/${not empty user.profilePicturePath ? user.profilePicturePath : 'images/default-profile.png'}" 
	         class="nav-profile-pic"
	         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-profile.png'"/>
	</div>
	 <div class="nav-links">
	    <a href="${pageContext.request.contextPath}/pages/Films.jsp" class="nav-tab">Films</a>
	    <a href="${pageContext.request.contextPath}/pages/Watchlist.jsp" class="nav-tab">Watchlist</a>
	    <a href="${pageContext.request.contextPath}/ReviewReportServlet" class="nav-tab active">Reviews</a>
	 </div>
	</div>

  <!-- Combined Filter Tabs -->
  <div class="tabs filters">
    <a href="${pageContext.request.contextPath}/pages/Watched.jsp" class="tab">WATCHED</a>
    <a href="${pageContext.request.contextPath}/pages/Diary.jsp" class="tab">DIARY</a>
    <a href="${pageContext.request.contextPath}/ReviewReportServlet" class="tab active">REVIEWS</a>
  </div>
  
  <!-- Reviews Container -->
  <div class="reviews-container">
    <div class="reviews-header">
      <h2>My Reviews</h2>
    </div>
    
    <!-- Message Display -->
    <div class="message-container">
      <c:if test="${not empty successMessage}">
        <div class="success-message">
          ${successMessage}
        </div>
      </c:if>
      <c:if test="${not empty errorMessage}">
        <div class="error-message">
          ${errorMessage}
        </div>
      </c:if>
    </div>
    
    <!-- Sorting Options -->
    <div class="sort-options">
      <span>Sort by: </span>
      <a href="ReviewReportServlet?sort=newest" class="${param.sort == 'newest' || empty param.sort ? 'active' : ''}">Newest First</a>
      <a href="ReviewReportServlet?sort=oldest" class="${param.sort == 'oldest' ? 'active' : ''}">Oldest First</a>
      <a href="ReviewReportServlet?sort=highest" class="${param.sort == 'highest' ? 'active' : ''}">Highest Rated</a>
      <a href="ReviewReportServlet?sort=lowest" class="${param.sort == 'lowest' ? 'active' : ''}">Lowest Rated</a>
    </div>
    
    <!-- Reviews List -->
    <c:choose>
      <c:when test="${not empty allReviews}">
        <c:forEach items="${allReviews}" var="review">
			<div class="review-item">
			    <div style="display: flex; gap: 20px; margin-bottom: 15px;">
			        <div style="width: 100px; height: 150px; overflow: hidden; border-radius: 4px;">
			            <img src="${pageContext.request.contextPath}/${review.movieImage}" 
			                 alt="${review.movieTitle}" 
			                 style="width: 100%; height: 100%; object-fit: cover;"
			                 onerror="this.src='${pageContext.request.contextPath}/images/default-movie.png'">
			        </div>
			        <div style="flex: 1;">
			            <h3>${review.movieTitle}</h3>
			            <div class="review-date">
			                <fmt:formatDate value="${review.reviewDate}" pattern="MMMM dd, yyyy 'at' hh:mm a"/>
			            </div>
			            <div class="review-rating">
			                Rating: 
			                <c:forEach begin="1" end="${review.rating}">
			                    ★
			                </c:forEach>
			                <c:forEach begin="${review.rating + 1}" end="5">
			                    ☆
			                </c:forEach>
			                (${review.rating}/5)
			            </div>
			        </div>
			    </div>
			    <p class="review-content">${review.reviewDescription}</p>
			    
			    <!-- Edit and Delete buttons -->
			    <div class="review-actions">
			        <a href="EditReviewServlet?reviewID=${review.reviewID}" class="edit-btn">Edit</a>
			        <a href="DeleteReviewServlet?reviewID=${review.reviewID}" 
			           class="delete-btn" 
			           onclick="return confirm('Are you sure you want to delete this review?')">Delete</a>
			    </div>
			</div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="no-reviews">
          <p>You haven't written any reviews yet.</p>
          <p>Start reviewing movies to see them appear here!</p>
        </div>
      </c:otherwise>
    </c:choose>
    
    <a href="${pageContext.request.contextPath}/UpdateProfileServlet" class="back-link">Back to Profile</a>
  </div>

</body>
</html>