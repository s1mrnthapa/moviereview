<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">

  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Edit Review - CineCritique</title>
  <style>
	 body {
	  font-family: Cinzel Decorative, Viaoda Libre, Bodoni Moda, Amarante, arial;
	  margin: 0;
	  background-color: #0b0b0b;
	  color: #fff;
	}
	
	.edit-container {
	  max-width: 100wh;
	  padding-top: 120px;
	  background-color: #1a1a1a;
	  border-radius: 5px;
	  border-left: 4px solid #24d4ec;
	}
	
	.edit-title {
	  color: #24d4ec;
	  margin-bottom: 20px;
	  border-bottom: 1px solid #333;
	  padding-bottom: 10px;
	}
	
	.form-group {
	  margin-bottom: 20px;
	}
	
	label {
	  display: block;
	  margin-bottom: 8px;
	  font-weight: bold;
	}
	
	.form-control {
	  width: 100%;
	  padding: 10px;
	  background-color: #2c2c2c;
	  border: 1px solid #444;
	  border-radius: 4px;
	  color: #fff;
	}
	
	textarea.form-control {
	  min-height: 150px;
	  resize: vertical;
	}
	
	.rating-options {
	  display: flex;
	  gap: 10px;
	}
	
	.rating-options input[type="radio"] {
	  display: none;
	}
	
	.rating-options label {
	  cursor: pointer;
	  padding: 5px 10px;
	  background-color: #2c2c2c;
	  border: 1px solid #444;
	  border-radius: 4px;
	}
	
	.rating-options input[type="radio"]:checked + label {
	  background-color: #24d4ec;
	  color: white;
	}
	
	.btn {
	  padding: 10px 20px;
	  border: none;
	  border-radius: 4px;
	  cursor: pointer;
	  font-weight: bold;
	  text-decoration: none;
	  display: inline-block;
	}
	
	.btn-primary {
	  background-color: #24d4ec;
	  color: white;
	}
	
	.btn-secondary {
	  background-color: #2c2c2c;
	  color: #fff;
	  border: 1px solid #444;
	}
	
	.btn:hover {
	  opacity: 0.9;
	}
	
	.error-message {
	  color: #ff6b6b;
	  margin-bottom: 20px;
	  padding: 10px;
	  background-color: #2c2c2c;
	  border-left: 3px solid #24d4ec;
	}
  </style>
</head>
<body>

  <!-- Header -->
  <header>
    <%@ include file = "header.jsp" %>
  </header>

	  <div class="edit-container">
	    <h1 class="edit-title">Edit Review for ${review.movieTitle}</h1>
	    
	    <c:if test="${not empty errorMessage}">
	      <div class="error-message">
	        ${errorMessage}
	      </div>
	    </c:if>
	    
	    <form action="EditReviewServlet" method="POST">
	      <input type="hidden" name="reviewID" value="${review.reviewID}">
	      
	      <div class="form-group">
	        <label for="rating">Rating</label>
	        <div class="rating-options">
	          <c:forEach begin="1" end="5" var="i">
	            <input type="radio" id="rating${i}" name="rating" value="${i}" ${review.rating == i ? 'checked' : ''}>
	            <label for="rating${i}">${i} ★</label>
	          </c:forEach>
	        </div>
	      </div>
	      
	      <div class="form-group">
	        <label for="reviewDescription">Review</label>
	        <textarea class="form-control" id="reviewDescription" name="reviewDescription" 
	                  required>${review.reviewDescription}</textarea>
	      </div>
	      
	      <div class="form-group">
	        <button type="submit" class="btn btn-primary">Update Review</button>
	        <a href="ReviewReportServlet" class="btn btn-secondary">Cancel</a>
	      </div>
	    </form>
	  </div>

</body>
</html>