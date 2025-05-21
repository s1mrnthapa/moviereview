<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Add Movie – CineCritique</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@700&family=Amarante&display=swap" rel="stylesheet" />

  <style>
    :root {
      --black: #0f0f0f;
      --dark-red: #8b0000;
      --red-hover: #a30000;
      --gray-bg: #1a1a1a;
      --white: #ffffff;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Amarante', serif;
      background-color: var(--black);
      color: var(--white);
    }

    header {
      background-color: var(--dark-red);
      padding: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    header h1 {
      font-family: 'Cinzel Decorative', cursive;
      font-size: 26px;
      letter-spacing: 1px;
      color: var(--white);
    }

    nav {
      background-color: var(--black);
      padding: 12px 40px;
      display: flex;
      gap: 15px;
    }

    nav a {
      text-decoration: none;
      color: var(--white);
      font-weight: bold;
      transition: color 0.3s;
      padding: 6px 10px;
      font-family: 'Amarante', serif;
    }

    nav a:hover {
      color: #00ff88;
    }

    main {
      padding: 30px;
      max-width: 900px;
      margin: 0 auto;
    }

    .movie-form {
      display: flex;
      flex-wrap: wrap;
      gap: 50px;
      background-color: var(--gray-bg);
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0, 255, 136, 0.25);
      font-family: 'Amarante', serif;
    }

    .movie-form label {
      display: block;
      margin-bottom: 15px;
      font-weight: 600;
      color: var(--white);
    }

    .movie-form input,
    .movie-form textarea {
      width: 100%;
      padding: 10px;
      margin-top: 6px;
      border: 1px solid #444;
      border-radius: 6px;
      background-color: #1c1c1c;
      color: var(--white);
      font-family: 'Amarante', serif;
      font-size: 1rem;
    }

    .movie-form input:focus,
    .movie-form textarea:focus {
      border-color: #00ff88;
      outline: none;
    }

    .genres {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-bottom: 20px;
    }

    .genres label {
      font-weight: normal;
      background-color: #00ff88;
      color: var(--black);
      padding: 5px 10px;
      border-radius: 5px;
      font-family: 'Amarante', serif;
      cursor: pointer;
      user-select: none;
    }

    .left-form,
    .right-form {
      flex: 1 1 400px;
    }

    button {
      padding: 12px 24px;
      background-color: #00ff88;
      color: var(--black);
      font-weight: bold;
      border: none;
      cursor: pointer;
      border-radius: 6px;
      transition: background-color 0.3s;
      font-family: 'Amarante', serif;
      font-size: 1.1rem;
    }

    button:hover {
      background-color: #00cc6a;
    }

    input[type="file"]::file-selector-button {
      padding: 8px 15px;
      background-color: #00ff88;
      color: var(--black);
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
      font-family: 'Amarante', serif;
    }

    footer {
      background-color: var(--dark-red);
      color: var(--white);
      padding: 15px;
      text-align: center;
      margin-top: 40px;
      font-family: 'Amarante', serif;
    }

    @media (max-width: 768px) {
      .movie-form {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>

<header>
  <h1>CINECRITIQUE - AddMovies</h1>
</header>

<nav>
  <a href="${pageContext.request.contextPath}/pages/dashboard.jsp">Dashboard</a>
  <a href="${pageContext.request.contextPath}/pages/addMovie.jsp">Add Movies</a>
  <a href="${pageContext.request.contextPath}/pages/adminprofile.jsp">Admin Profile</a>
  <a href="${pageContext.request.contextPath}/pages/Movies.jsp">Movies</a>
  <a href="${pageContext.request.contextPath}/pages/moviedatabase.jsp">Movies Database</a>
</nav>

<main>
  <form class="movie-form" action="${pageContext.request.contextPath}/AddMovieServlet" method="post" enctype="multipart/form-data">
    <div class="left-form">
      <label>Movie Title
        <input type="text" name="title" required />
      </label>

      <label>Release Date
        <input type="date" name="release_date" required />
      </label>

      <label>Genre</label>
      <div class="genres">
        <label><input type="checkbox" name="genre" value="1" /> Action</label>
        <label><input type="checkbox" name="genre" value="2" /> Comedy</label>
        <label><input type="checkbox" name="genre" value="3" /> Drama</label>
        <label><input type="checkbox" name="genre" value="4" /> Thriller</label>
        <label><input type="checkbox" name="genre" value="5" /> Adventure</label>
        <label><input type="checkbox" name="genre" value="6" /> Romantic</label>
        <label><input type="checkbox" name="genre" value="7" /> Science Fiction</label>
        <label><input type="checkbox" name="genre" value="8" /> Music</label>
        <label><input type="checkbox" name="genre" value="9" /> Crime</label>
        <label><input type="checkbox" name="genre" value="10" /> Horror</label>
        <label><input type="checkbox" name="genre" value="11" /> Animation</label>
      </div>

      <label>Duration
        <input type="text" name="duration" placeholder="e.g., 2h 15m" />
      </label>

      <label>Country
        <input type="text" name="country" />
      </label>

      <label>Director
        <input type="text" name="director" />
      </label>

      <label>Cast Members
        <input type="text" name="cast" placeholder="Casts" />
      </label>

      <label>Storyline / Description
        <textarea name="description" rows="4" placeholder="Write a short summary..."></textarea>
      </label>

      <label>Upload Movie Image
        <input type="file" name="image" required />
      </label>
    </div>

    <div class="right-form">
      <button type="submit">Upload Movie</button>
    </div>
  </form>

  <%-- Display success or error messages --%>
  <p style="color: #00ff88; font-family: 'Amarante', serif; font-weight: bold;">
    <%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : "" %>
  </p>
  <p style="color: #ff4444; font-family: 'Amarante', serif; font-weight: bold;">
    <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
  </p>
</main>

<footer>
  &copy; 2025 CineCritique. All rights reserved.
</footer>

</body>
</html>
