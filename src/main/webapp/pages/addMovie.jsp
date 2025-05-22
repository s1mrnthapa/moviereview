<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
  <title>Add Movie – CineCritique</title>
  <style>
	  :root {
	    --background: #0d0d0d;
	    --primary: #00ffff; /* cyan */
	    --light-gray: #1c1c1c;
	    --text: #e0fafa;
	    --border: #2a2a2a;
	  }
	
	  * {
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
	  }
	  header {
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 80px; /* Set height */
		  z-index: 1000;
		}
	  
	
	  body {
	  	position: relative;
  	 	z-index: 1;
	    font-family: 'Segoe UI', sans-serif;
	    background-color: var(--background);
	    color: var(--text);
	  }
	
	  main {
	    position: relative;
  	 	z-index: 1;
	    padding-top: 100px;
	    width: 70%;
	    margin-left: 200px;
	  }
	   main h1{
    	font-family: Cinzel Decorative;
    	margin-bottom: 25px;
    	font-size: 30px;
    	}
	  
	
	  .movie-form {
	  display: flex;
	  flex-direction: column;
	  gap: 30px;
	  padding: 10px;
	  padding-top: 0px;
	}
	
	.form-grid {
	  display: grid;
	  grid-template-columns: 1fr 1fr;
	  gap: 60px;
	}
	
	.form-group label {
	  display: block;
	  margin-bottom: 20px;
	  color: var(--primary);
	  font-weight: 500;
	  font-family: Cinzel Decorative;
	}
	
	input, textarea {
	  width: 100%;
	  padding: 10px;
	  margin-top: 6px;
	  background-color: #121212;
	  color: var(--text);
	  border: 1px solid var(--border);
	  border-radius: 5px;
	}
	
	.genres {
	  display: flex;
	  flex-wrap: wrap;
	  gap: 10px;
	  margin-top: 10px;
	}
	
	.genres label {
	  background-color: #111;
	  padding: 5px 10px;
	  border-radius: 5px;
	  font-size: 13px;
	  color: var(--primary);
	}
	
	.form-actions {
	  display: flex;
	  justify-content: flex-end;
	}
	
	button {
	  background-color: var(--primary);
	  color: #000;
	  font-weight: bold;
	  padding: 12px 24px;
	  border: none;
	  border-radius: 6px;
	  cursor: pointer;
	}
	
	button:hover {
	  background-color: #00d2d2;
	}
	
	  input[type="file"]::file-selector-button {
	    background-color: var(--primary);
	    color: #000;
	    border: none;
	    padding: 8px 16px;
	    border-radius: 4px;
	    cursor: pointer;
	  }

	
	  p {
	    margin-top: 20px;
	    font-size: 16px;
	  }
</style>
  
</head>
<body>
<header>
	<%@ include file ="AdminHeader.jsp" %>
	</header>
  <main>
  	<h1> CineCritique | Add Movies </h1>
    <form class="movie-form" action="${pageContext.request.contextPath}/AddMovieServlet" method="post" enctype="multipart/form-data">
  <div class="form-grid">
    <div class="form-group">
      <label>Movie Title
        <input type="text" name="title" required />
      </label>

      <label>Release Date
        <input type="date" name="release_date" required />
      </label>

      <label>Duration
        <input type="text" name="duration" placeholder="e.g., 2h 15m" />
      </label>

      <label>Country
        <input type="text" name="country" />
      </label>
      
      <label>Genre</label>
      <div class="genres">
        <label><input type="checkbox" name="genre" value="1" /> Action</label>
        <label><input type="checkbox" name="genre" value="2" /> Comedy</label>
        <label><input type="checkbox" name="genre" value="3" /> Drama</label>
        <label><input type="checkbox" name="genre" value="4" /> Thriller</label>
        <label><input type="checkbox" name="genre" value="5" /> Adventure</label>
        <label><input type="checkbox" name="genre" value="6" /> Romantic</label>
        <label><input type="checkbox" name="genre" value="7" /> Sci-Fi</label>
        <label><input type="checkbox" name="genre" value="8" /> Music</label>
        <label><input type="checkbox" name="genre" value="9" /> Crime</label>
        <label><input type="checkbox" name="genre" value="10" /> Horror</label>
        <label><input type="checkbox" name="genre" value="11" /> Animation</label>
      </div>
    </div>

    <div class="form-group">
      <label>Director
        <input type="text" name="director" />
      </label>

      <label>Cast Members
        <input type="text" name="cast" placeholder="Casts" />
      </label>

      <label>Storyline / Description
        <textarea name="description" rows="5" placeholder="Write a short summary..."></textarea>
      </label>
      
      <label>Upload Movie Image
        <input type="file" name="image" required />
      </label>
      <div class="form-actions">
    <button type="submit">Upload Movie</button>
  </div>

    </div>
  </div>
</form>
    
    
    <%-- Display success or error messages --%>
    <p style="color: green;"><%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : "" %></p>
    <p style="color: red;"><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %></p>
  </main>
  </body>
</html>

  