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
      border-bottom: 2px solid #ff3c3c;
      margin-bottom: 20px;
      padding-top: 80px;
    }

    .avatar {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      background-color: #1f1f1f;
      margin-right: 20px;
      border: 2px solid #ff3c3c;
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
      font-size: 24px;
    }

    .bio, .location {
      color: #ccc;
    }

    .edit-btn {
      background-color: #1f1f1f;
      color: #ff3c3c;
      border: 1px solid #ff3c3c;
      padding: 5px 10px;
      margin-top: 10px;
      border-radius: 4px;
      cursor: pointer;
      display: inline-block;
      text-decoration: none;
    }

    .error-message {
      background-color: #ffdddd;
      padding: 10px;
      border-radius: 4px;
      border-left: 4px solid #ff3c3c;
      margin: 20px;
      color: #000;
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
      margin-right: 40px;
      padding-bottom: 10px;
      text-transform: uppercase;
      font-size: 15px;
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

    /* Sidebar */
    .sidebar {
      display: flex;
      flex-direction: column;
      width: 300px;
      margin-left: auto;
      padding: 20px;
      background-color: #1f1f1f;
      border-left: 2px solid #ff3c3c;
    }

    .sidebar-section {
      margin-bottom: 30px;
    }

    .sidebar-title {
      color: #ff3c3c;
      font-size: 16px;
      margin-bottom: 10px;
    }

    .watchlist-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
      gap: 10px;
    }

    .watchlist-item {
      width: 120px;
      height: 180px;
      background-color: #2c3440;
      border-radius: 4px;
      border: 1px solid #ff3c3c;
    }

    /* Recent Activity Section */
    .activity-section {
      margin: 0 20px 30px;
    }

    .activity-title {
      color: #ff3c3c;
      font-size: 22px;
      margin-bottom: 20px;
      padding-bottom: 8px;
      border-bottom: 2px solid #ff3c3c;
    }

    .activity-list {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .activity-item {
	    display: flex;
	    gap: 15px;
	    padding-bottom: 15px;
	    border-bottom: 1px solid #333;
	}
	
	.activity-poster {
	    width: 60px;
	    height: 90px;
	    flex-shrink: 0;
	    overflow: hidden;
	    border-radius: 4px;
	}
	
	.activity-poster img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	}
	
	.activity-details {
	    flex: 1;
	}

    .movie-title {
      color: #ff3c3c;
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 5px;
    }

    .activity-date {
      color: #999;
      font-size: 14px;
      margin-bottom: 8px;
    }

    .activity-content {
      color: #ccc;
      line-height: 1.5;
    }

    .view-more {
      text-align: right;
      margin-top: 20px;
    }

    .view-more-link {
      color: #ff3c3c;
      text-decoration: none;
      font-weight: bold;
    }

    .view-more-link:hover {
      text-decoration: underline;
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
    <a href="${pageContext.request.contextPath}/ReviewReportServlet" class="tab">Films</a>
  </div>

  <!-- Main Content -->
  <div class="main-content" style="display: flex; justify-content: space-between;">
	<div class="content" style="flex: 3;">
	  <!-- Recent Activity Section -->
	  <div class="activity-section">
	    <h2 class="activity-title">Recent Activity</h2>
	    
	    <div class="activity-list">
	      <c:choose>
	        <c:when test="${not empty recentReviews}">
	          <!-- Show last 4 reviews (remove 'end' attribute to show all fetched reviews) -->
	          <c:forEach items="${recentReviews}" var="review">
	            <!-- Inside the activity-item div in UserProfile.jsp -->
				<div class="activity-item" style="display: flex; gap: 15px;">
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

    <!-- Sidebar (Watchlist) -->
    <div class="sidebar">
      <div class="sidebar-section">
        <div class="sidebar-title">WATCHLIST</div>
        <div class="watchlist-grid">
          <div class="watchlist-item"></div>
          <div class="watchlist-item"></div>
          <div class="watchlist-item"></div>
          <div class="watchlist-item"></div>
        </div>
      </div>
    </div>
  </div>


  <footer>
  	<%@ include file = "footer.jsp" %>
  </footer>
  
</body>
</html>