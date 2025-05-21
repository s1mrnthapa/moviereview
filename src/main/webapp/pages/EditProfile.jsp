<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">

  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>CineCritique - Edit Profile</title>
  <style>
    body {
      margin: 0;
      font-family: Cinzel Decorative, Viaoda Libre, Bodoni Moda,  Amarante, arial;
      background: #0b0b0b;
      color: #fff;
    }

    .container {
      max-width: 800px;
      margin: 30px auto;
      padding: 20px;
      background: #1a1a1a;
      border-radius: 10px;
    }

    .form-group {
      margin-bottom: 15px;
    }

    label {
      display: block;
      margin-bottom: 5px;
      color: #ccc;
    }

    input[type="text"],
    input[type="email"],
    input[type="file"] {
      width: 100%;
      padding: 10px;
      background-color: #2c2c2c;
      border: 1px solid #444;
      border-radius: 4px;
      color: #fff;
    }

    input[type="checkbox"] {
      margin-right: 8px;
    }

    input[disabled] {
      background-color: #3a3a3a;
      color: #aaa;
    }

    .form-name-group {
      display: flex;
      gap: 20px;
    }

    .form-name-group .form-group {
      flex: 1;
    }

    .submit-btn {
      background-color: #1f1f1f;
      border: none;
      padding: 10px 20px;
      color: #fff;
      font-size: 16px;
      border-radius: 6px;
      cursor: pointer;
    }

    .submit-btn:hover {
      background-color: #24d4ec;
    }

    .error-message {
      background-color: #ffdddd;
      color: #a94442;
      border: 1px solid #f5c6cb;
      border-radius: 6px;
      padding: 12px 15px;
      margin-bottom: 20px;
      font-weight: bold;
    }

    .back-link {
      text-align: center;
      margin-top: 20px;
    }

    .back-link a {
      color: yellow;
      text-decoration: none;
    }

    .back-link a:hover {
      text-decoration: underline;
    }

    .profile-picture-container {
      display: flex;
      align-items: center;
      gap: 20px;
      margin: 15px 0;
    }

    .profile-picture-preview {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      overflow: hidden;
    }

    .profile-picture-preview img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .picture-actions {
      display: flex;
      gap: 10px;
    }
  </style>
</head>
<body>

<!-- Main Container -->
<div class="container">
  <h2>Edit Profile</h2>

  <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="post" enctype="multipart/form-data">
    
    <!-- Error Message -->
    <c:if test="${not empty error}">
      <div class="error-message">
        <c:out value="${error}"/>
      </div>
    </c:if>

    <!-- Profile Picture -->
    <div class="form-group">
      <label>Current Profile Picture:</label>
      <div class="profile-picture-container">
        <div class="profile-picture-preview">
          <img src="${pageContext.request.contextPath}/${not empty userProfile.profilePicturePath ? userProfile.profilePicturePath : 'images/default-profile.png'}" alt="Profile Picture" />
        </div>
      </div>
    </div>

    <div class="form-group">
      <label>Upload New Profile Picture:</label>
      <input type="file" name="profilePicture"/>
    </div>

    <c:if test="${not empty userProfile.profilePicturePath}">
      <div class="form-group">
        <label>
          <input type="checkbox" name="removePicture" value="true" />
          Remove current picture
        </label>
      </div>
    </c:if>

    <!-- Username -->
    <div class="form-group">
      <label>Username:</label>
      <input type="text" name="username" value="${userProfile.username}" required>
    </div>

    <!-- First and Last Name -->
    <div class="form-name-group">
      <div class="form-group">
        <label>First Name:</label>
        <input type="text" name="firstName" value="${userProfile.firstName}" required>
      </div>
      <div class="form-group">
        <label>Last Name:</label>
        <input type="text" name="lastName" value="${userProfile.lastName}" required>
      </div>
    </div>

    <!-- Email -->
    <div class="form-group">
      <label>Email:</label>
      <input type="email" name="email" value="${userProfile.email}" required>
    </div>

    <!-- Submit -->
    <input type="submit" value="Save Changes" class="submit-btn">
  </form>

  <!-- Back Link -->
  <div class="back-link">
    <a href="${pageContext.request.contextPath}/ProfileServlet">← Back to Profile</a>
  </div>
</div>

</body>
</html>
