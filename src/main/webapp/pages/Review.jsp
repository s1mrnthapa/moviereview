<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cinzel+Decorative&family=Viaoda+Libre&family=Bodoni+Moda&family=Amarante&display=swap" rel="stylesheet">

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Reviews - CineCritique</title>
    <style>
        body {
            font-family: Cinzel Decorative, Viaoda Libre, Bodoni Moda, Amarante, arial;
            margin: 0;
            background-color: #0b0b0b;
            color: #fff;
            padding-top: 80px; /* Space for fixed header */
        }

        /* Fixed Header */
        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background-color: #0b0b0b;
        }

        /* Profile Navigation */
        .profile-nav {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 2px solid #24d4ec;
            background-color: #1a1a1a;
            margin-top: 0;
        }

        .profile-nav-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 20px;
            overflow: hidden;
        }

        .profile-nav-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-nav-tabs {
            display: flex;
            gap: 30px;
        }

        .profile-nav-tab {
            color: #ccc;
            text-decoration: none;
            font-size: 16px;
            padding-bottom: 5px;
        }

        .profile-nav-tab.active {
            color: #24d4ec;
            border-bottom: 2px solid #24d4ec;
        }
        .profile-nav-tab:hover{
        	color: #24d4ec;
        }

        /* Main Content */
        .main-container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #24d4ec;
        }

        /* Sort Options */
        .sort-options {
            margin-bottom: 25px;
            padding: 10px 0;
        }

        .sort-options a {
            color: #24d4ec;
            text-decoration: none;
            margin-right: 15px;
        }

        .sort-options a.active {
            font-weight: bold;
            text-decoration: underline;
        }

        /* Review Items */
        .review-item {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #333;
        }

        .review-poster {
            width: 120px;
            height: 180px;
            flex-shrink: 0;
            overflow: hidden;
            border-radius: 4px;
        }

        .review-poster img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .review-content {
            flex: 1;
        }

        .review-title {
            color: #24d4ec;
            font-size: 18px;
            margin-bottom: 5px;
        }

        .review-meta {
            color: #999;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .review-text {
            color: #ddd;
            line-height: 1.5;
            margin-bottom: 15px;
        }

        .review-actions {
            margin-top: 10px;
        }

        .action-btn {
            padding: 5px 10px;
            margin-right: 10px;
            border-radius: 3px;
            text-decoration: none;
            font-size: 14px;
        }

        .edit-btn {
            background-color: #1f1f1f;
            color: #24d4ec;
        }

        .delete-btn {
            background-color: #1f1f1f;
            color: #24d4ec;
        }

        /* Empty State */
        .no-reviews {
            text-align: center;
            padding: 50px 20px;
            color: #999;
        }

        /* Messages */
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .success-message {
            background-color: rgba(76, 175, 80, 0.2);
            border-left: 4px solid #4CAF50;
        }

        .error-message {
            background-color: rgba(244, 67, 54, 0.2);
            border-left: 4px solid #f44336;
        }
    </style>
</head>
<body>

    <!-- Fixed Header -->
    <header>
        <%@ include file = "header.jsp" %>
    </header>

    <!-- Profile Navigation -->
    <div class="profile-nav">
        <div class="profile-nav-avatar">
            <img src="${pageContext.request.contextPath}/${not empty user.profilePicturePath ? user.profilePicturePath : 'images/default-profile.png'}" 
                 onerror="this.src='${pageContext.request.contextPath}/images/default-profile.png'"/>
        </div>
        <div class="profile-nav-tabs">
            <a href="${pageContext.request.contextPath}/ProfileServlet" class="profile-nav-tab">Profile</a>
            <a href="${pageContext.request.contextPath}/ReviewReportServlet" class="profile-nav-tab active">Reviews</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-container">
        <div class="page-header">
            <h2>My Reviews</h2>
        </div>

        <!-- Messages -->
        <c:if test="${not empty successMessage}">
            <div class="message success-message">
                ${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="message error-message">
                ${errorMessage}
            </div>
        </c:if>

        <!-- Sort Options -->
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
                        <div class="review-poster">
                            <img src="${pageContext.request.contextPath}/${review.movieImage}" 
                                 onerror="this.src='${pageContext.request.contextPath}/images/default-movie.png'"/>
                        </div>
                        <div class="review-content">
                            <h3 class="review-title">${review.movieTitle}</h3>
                            <div class="review-meta">
                                <fmt:formatDate value="${review.reviewDate}" pattern="dd MMM yyyy"/>
                                • Rating: ${review.rating}/5
                            </div>
                            <p class="review-text">${review.reviewDescription}</p>
                            <div class="review-actions">
                                <a href="EditReviewServlet?reviewID=${review.reviewID}" class="action-btn edit-btn">Edit</a>
                                <a href="DeleteReviewServlet?reviewID=${review.reviewID}" 
                                   class="action-btn delete-btn"
                                   onclick="return confirm('Are you sure you want to delete this review?')">Delete</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-reviews">
                    <p>You haven't written any reviews yet.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%@ include file = "footer.jsp" %>
</body>
</html>