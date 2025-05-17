<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Profile - CineCritique</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      background-color: #0b0b0b;
      color: #fff;
    }

    header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background-color: #1a1a1a;
      padding: 15px 20px;
      border-bottom: 2px solid #ff3c3c;
    }

    .logo {
      display: flex;
      align-items: center;
    }

    .logo img {
      width: 40px;
      height: 40px;
      margin-right: 10px;
    }

    .logo h1 {
      margin: 0;
      font-size: 24px;
      white-space: nowrap;
    }

    .search-bar {
      display: flex;
      align-items: center;
    }

    .search-bar input {
      padding: 10px;
      width: 300px;
      background-color: #1f1f1f;
      color: #fff;
      border: 1px solid #ff3c3c;
      border-radius: 4px;
      margin-right: 10px;
    }

    .search-bar button {
      padding: 10px 15px;
      background-color: #ff3c3c;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .search-bar button:hover {
      background-color: #e63939;
    }

    nav {
      display: flex;
      align-items: center;
    }

    nav a {
      color: #fff;
      text-decoration: none;
      margin: 0 15px;
      padding: 5px 10px;
      border-radius: 4px;
      transition: background-color 0.3s;
    }

    nav a:hover {
      background-color: #ff3c3c;
    }

    /* Profile Section */
    .profile-section {
      display: flex;
      padding: 20px;
      align-items: center;
      border-bottom: 2px solid #ff3c3c;
      margin-bottom: 20px;
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

    .section-title {
      color: #ff3c3c;
      font-size: 18px;
      margin: 30px 20px 10px;
    }

    .movie-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 15px;
      padding: 0 20px;
    }

    .movie-poster {
      width: 120px;
      height: 180px;
      background-color: #2c3440;
      border-radius: 4px;
      border: 1px solid #ff3c3c;
    }
  </style>
</head>
<body>

  <!-- Header -->
  <header>
    <div class="logo">
      <a href="${pageContext.request.contextPath}/Home.jsp" style="display: flex; align-items: center; text-decoration: none; color: white;">
        <img src="${pageContext.request.contextPath}/images/cinecritique-logo-only.png" alt="CineCritique Logo" />
        <h1>CINECRITIQUE</h1>
      </a>
    </div>

    <div class="search-bar">
      <input type="text" placeholder="Search" />
      <button>Search</button>
    </div>
    
    <nav>
      <a href="${pageContext.request.contextPath}/Home.jsp">Home</a>
      <a href="${pageContext.request.contextPath}/Movies.jsp">Films</a>
      <a href="${pageContext.request.contextPath}/UpcomingMovies.jsp">Upcoming</a>
      <a href="${pageContext.request.contextPath}/WatchlistServlet">Watchlist</a>
    </nav>
  </header>

  <!-- Dynamic Profile Section -->
  <div class="profile-section">
    <div class="avatar">
    	<img src="${pageContext.request.contextPath}/${not empty userProfile.profilePicturePath and userProfile.profilePicturePath.contains('.') ? userProfile.profilePicturePath : 'images/default-profile.png'}" 
         alt="Profile Picture" 
         class="profile-pic" />
	</div>
    <div class="user-info">
      <h1><c:out value="${userProfile.username}" /></h1>
      <div class="bio"><c:out value="${userProfile.firstName} ${userProfile.lastName}" /></div>
      <div class="location"><c:out value="${userProfile.email}" /></div>
      <div class="member-since">Member since: <c:out value="${userProfile.registerDate}" /></div>
      <br>
      <a href="${pageContext.request.contextPath}/pages/EditProfile.jsp" class="edit-btn">EDIT PROFILE</a>
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
    <a href="${pageContext.request.contextPath}/UserMovie.jsp" class="tab">Films</a>
    <a href="${pageContext.request.contextPath}/WatchlistServlet" class="tab">Watchlist</a>
  </div>

  <!-- Main Content -->
  <div class="main-content" style="display: flex; justify-content: space-between;">
    <div class="content" style="flex: 3;">
      <!-- Favorite Films -->
      <div class="section-title">FAVORITE FILMS</div>
      <div class="movie-grid">
        <div class="movie-poster"></div>
        <div class="movie-poster"></div>
        <div class="movie-poster"></div>
        <div class="movie-poster"></div>
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

</body>
</html>