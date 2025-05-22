<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
  <title>Profile - CineCritique</title>
  <style>
	  body {
	    font-family:Cinzel Decorative, Viaoda Libre, Bodoni Moda,  Amarante, arial;
	    margin: 0;
	    background-color: #0b0b0b;
	    color: #fff;
	  }
	
	  /* Profile Section */
	  .profile-section {
	    display: flex;
	    padding: 20px;
	    align-items: center;
	    border-bottom: 2px solid #24d4ec;
	    margin-bottom: 20px;
	    padding-top: 80px;
	  }
	
	  .avatar {
	    width: 120px;
	    height: 120px;
	    border-radius: 50%;
	    background-color: #1f1f1f;
	    margin-right: 30px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    overflow: hidden;
	  }
	
	  .profile-pic {
	     width: 100%;
	     height: 100%;
	     object-fit: cover;
	     background-color: #1a1a1a; 
	     background-image: url('../../../images/default-profile.png');
	     background-size: cover;
	     background-position: center;
	     background-repeat: no-repeat;
	  }
	
	  .user-info h1 {
	    margin: 0 0 10px 0;
	    font-size: 28px;
	  }
	
	  .bio, .location {
	    color: #ccc;
	    font-size: 16px;
	  }
	
	  .edit-btn {
	    background-color: #1f1f1f;
	    color: #24d4ec;
	    padding: 8px 15px;
	    margin-top: 15px;
	    border-radius: 4px;
	    cursor: pointer;
	    display: inline-block;
	    text-decoration: none;
	    font-size: 16px;
	    transition: all 0.3s;
	  }
	
	  .edit-btn:hover {
	    background-color: #24d4ec;
	    color: #fff;
	  }
	
	  .error-message {
	    background-color: #ffdddd;
	    padding: 10px;
	    border-radius: 4px;
	    border-left: 4px solid #24d4ec;
	    margin: 20px;
	    color: #000;
	  }
	
	  /* Filter Bar */
	  .tabs {
	    display: flex;
	    margin-bottom: 20px;
	    border-bottom: 2px solid #24d4ec;
	    padding-bottom: 10px;
	  }
	
	  .tab {
	    color: white;
	    text-decoration: none;
	    margin-right: 40px;
	    padding-bottom: 10px;
	    text-transform: uppercase;
	    font-size: 16px;
	    font-weight: bold;
	    transition: color 0.3s, border-bottom 0.3s;
	  }
	
	  .tab:hover {
	    color: #24d4ec;
	  }
	
	  .tab.active {
	    color: #24d4ec;
	    border-bottom: 3px solid #24d4ec;
	  }
	
	  /* Main Content Layout */
	  .main-content {
	    display: flex;
	    justify-content: center;
	    padding: 0 20px;
	    max-width: 1200px;
	    margin: 0 auto;
	  }
	
	  .content {
	    width: 100%;
	    max-width: 800px;
	  }
	
	  /* Recent Activity Section */
	  .activity-section {
	    margin-bottom: 30px;
	  }
	
	  .activity-title {
	    color: #24d4ec;
	    font-size: 24px;
	    margin-bottom: 25px;
	    padding-bottom: 10px;
	    border-bottom: 2px solid #24d4ec;
	  }
	
	  .activity-list {
	    display: flex;
	    flex-direction: column;
	    gap: 25px;
	  }
	
	  .activity-item {
	    display: flex;
	    gap: 25px;
	    padding: 20px;
	    border-radius: 8px;
	    background-color: #1a1a1a;
	    transition: transform 0.3s, box-shadow 0.3s;
	  }
	
	  .activity-poster {
	    width: 150px;
	    height: 225px;
	    flex-shrink: 0;
	    overflow: hidden;
	    border-radius: 6px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
	  }
	
	  .activity-poster img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    transition: transform 0.3s;
	  }
	
	  .activity-details {
	    flex: 1;
	    display: flex;
	    flex-direction: column;
	  }
	
	  .movie-title {
	    color: #24d4ec;
	    font-size: 22px;
	    font-weight: bold;
	    margin-bottom: 10px;
	  }
	
	  .activity-date {
	    color: #999;
	    font-size: 16px;
	    margin-bottom: 15px;
	    display: flex;
	    align-items: center;
	  }
	
	  .rating-badge {
	    margin-left: 15px;
	    padding: 3px 10px;
	    color: white;
	    border-radius: 12px;
	    font-size: 14px;
	  }
	
	  .activity-content {
	    color: #ddd;
	    line-height: 1.6;
	    font-size: 16px;
	  }
	
	  .view-more {
	    text-align: right;
	    margin-top: 30px;
	  }
	
	  .view-more-link {
	    color: #24d4ec;
	    text-decoration: none;
	    font-weight: bold;
	    font-size: 16px;
	    padding: 8px 15px;
	    border-radius: 4px;
	    transition: all 0.3s;
	  }
	
	  .view-more-link:hover {
	    background-color: #24d4ec;
	    color: white;
	    text-decoration: none;
	  }
	
	  @media (max-width: 768px) {
	    .profile-section {
	      flex-direction: column;
	      text-align: center;
	    }
	
	    .avatar {
	      margin-right: 0;
	      margin-bottom: 20px;
	    }
	
	    .activity-item {
	      flex-direction: column;
	    }
	
	    .activity-poster {
	      width: 100%;
	      height: auto;
	      aspect-ratio: 2/3;
	    }
	  }
	</style>

</head>
<body>

  <!-- Header -->
  <header>
      	<%@ include file = "header.jsp" %>
  </header>

  <!-- Dynamic Profile Section -->
	<div class="profile-section">
	  <div class="avatar">
    	<img src="${pageContext.request.contextPath}/${not empty userProfile.profilePicturePath ? userProfile.profilePicturePath : 'images/default-profile.png'}" class="profile-pic"
         	onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default-profile.png'"/>
	  </div>
	  <div class="user-info">
	    <h1><c:out value="${userProfile.username}" /></h1>
	    <div class="bio"><c:out value="${userProfile.firstName} ${userProfile.lastName}" /></div>
	    <div class="location"><c:out value="${userProfile.email}" /></div>
	    <div class="member-since">
	      Member since: <fmt:formatDate value="${userProfile.registerDate}" pattern="dd MMM yyyy" />
	    </div>
	    <br>
	    <a href="${pageContext.request.contextPath}/UpdateProfileServlet" class="edit-btn">EDIT PROFILE</a>
	  </div>
	</div>

  <!-- Error Display -->
  <c:if test="${not empty error}">
    <div class="error-message">
      <c:out value="${error}" />
    </div>
  </c:if>

  <!-- Navigation -->
  <div class="tabs filters">
    <a class="tab active">Profile</a>
    <a href="${pageContext.request.contextPath}/ReviewReportServlet" class="tab">Review</a>
  </div>

  <!-- Main Content -->
  <div class="main-content">
	<div class="content">
	  <!-- Recent Activity Section -->
	  <div class="activity-section">
	    <h2 class="activity-title">Recent Activity</h2>
	    
	    <div class="activity-list">
	      <c:choose>
	        <c:when test="${not empty recentReviews}">
	          <!-- Show last 4 reviews (remove 'end' attribute to show all fetched reviews) -->
	          <c:forEach items="${recentReviews}" var="review">
	            <div class="activity-item">
				    <div class="activity-poster">
				        <img src="${pageContext.request.contextPath}/${review.movieImage}" 
				             onerror="this.src='${pageContext.request.contextPath}/images/default-movie.png'">
				    </div>
				    <div class="activity-details">
				        <div class="movie-title">${review.movieTitle}</div>
				        <div class="activity-date">
				            <fmt:formatDate value="${review.reviewDate}" pattern="dd MMM yyyy"/>
				            <span class="rating-badge">Rating: ${review.rating}/5</span>
				        </div>
				        <div class="activity-content">
				            ${review.reviewDescription}
				        </div>
				    </div>
				</div>
	          </c:forEach>
	          
	          <!-- Only show "More" link if there are more than 4 reviews -->
			<c:if test="${not empty recentReviews}">
			    <div class="view-more">
			        <a href="${pageContext.request.contextPath}/ReviewReportServlet" class="view-more-link">
			            View All Reviews →
			        </a>
			    </div>
			</c:if>
	        </c:when>
	        <c:otherwise>
	          <p style="color: #999; text-align: center; padding: 30px 0;">
	            <c:if test="${not empty reviewsError}">
	              <i class="fa fa-exclamation-circle"></i> ${reviewsError}
	            </c:if>
	            <c:if test="${empty reviewsError}">
	              No recent activity yet
	            </c:if>
	          </p>
	        </c:otherwise>
	      </c:choose>
	    </div>
	  </div>
	</div>
  </div>

  <footer>
  	<%@ include file = "footer.jsp" %>
  </footer>
  
</body>
</html>