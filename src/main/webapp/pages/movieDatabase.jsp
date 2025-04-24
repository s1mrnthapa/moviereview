<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Movies Database – CineCritique</title>
  <style>
    :root {
      --black: #0f0f0f;
      --dark-red: #8b0000;
      --gray-bg: #1a1a1a;
      --white: #fff;
    }

    body {
      font-family: Arial, sans-serif;
      background-color: var(--black);
      color: var(--white);
      margin: 0;
      padding: 0;
    }

    header {
      background-color: var(--dark-red);
      text-align: center;
      padding: 20px;
    }

    header h1 {
      font-size: 26px;
      color: var(--white);
    }

    nav {
      background-color: var(--black);
      padding: 14px 40px;
    }

    nav a {
      text-decoration: none;
      color: var(--white);
      font-weight: bold;
      margin: 0 15px;
      transition: color 0.3s;
    }

    nav a:hover {
      color: var(--dark-red);
    }

    .container {
      max-width: 1000px;
      margin: 40px auto;
      padding: 30px;
      background-color: var(--gray-bg);
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(255, 0, 0, 0.1);
    }

    .action-buttons {
      margin-bottom: 20px;
      text-align: right;
    }

    .action-buttons button {
      padding: 8px 14px;
      margin-left: 8px;
      background-color: var(--dark-red);
      color: var(--white);
      border: none;
      cursor: pointer;
      font-weight: bold;
      border-radius: 6px;
      transition: background-color 0.3s;
    }

    .action-buttons button:hover {
      background-color: #a30000;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    th, td {
      padding: 10px;
      border: 1px solid #444;
      text-align: center;
    }

    th {
      background-color: #222;
    }

    .poster {
      width: 40px;
      height: 60px;
      background: #555;
      margin: auto;
      border-radius: 4px;
    }

    .pagination {
      text-align: right;
    }

    .pagination button {
      padding: 6px 12px;
      margin: 0 4px;
      background: var(--gray-bg);
      border: 1px solid #555;
      color: var(--white);
      cursor: pointer;
      border-radius: 4px;
      transition: background-color 0.3s;
    }

    .pagination button:hover {
      background-color: var(--dark-red);
    }

    footer {
      background-color: var(--dark-red);
      color: var(--white);
      text-align: center;
      padding: 15px;
      margin-top: 60px;
    }
  </style>
</head>
<body>

  <header>
    <h1>CINECRITIQUE – MOVIES DATABASE</h1>
  </header>

  <nav>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="${pageContext.request.contextPath}/pages/addmovies.jsp">Add Movies</a>
    <a href="${pageContext.request.contextPath}/pages/adminprofile.jsp">Admin Profile</a>
    <a href="${pageContext.request.contextPath}/pages/moviedatabase.jsp">Movies Database</a>
    <a href="#">Logout</a>
  </nav>

  <div class="container">
    <div class="action-buttons">
      <button>DELETE</button>
      <button>EDIT</button>
      <button>DONE</button>
    </div>

    <table>
      <thead>
        <tr>
          <th></th>
          <th>Movie ID</th>
          <th>Poster</th>
          <th>Title</th>
          <th>Director</th>
          <th>Cast</th>
          <th>Genre</th>
          <th>Language</th>
          <th>Country</th>
          <th>Duration</th>
          <th>Description</th>
          <th>Avg Reviews</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><input type="checkbox" /></td>
          <td>001</td>
          <td><div class="poster"></div></td>
          <td>Movie Name</td>
          <td>Director A</td>
          <td>Actor X, Y</td>
          <td>Drama</td>
          <td>English</td>
          <td>USA</td>
          <td>2h 10m</td>
          <td>Short Description</td>
          <td>★★★★☆</td>
        </tr>
        <!-- More movie rows can be added dynamically -->
      </tbody>
    </table>

    <div class="pagination">
      <button>&laquo;</button>
      <button>1</button>
      <button>2</button>
      <button>&raquo;</button>
    </div>
  </div>

  <footer>
    &copy; 2025 CineCritique. All Rights Reserved.
  </footer>

</body>
</html>