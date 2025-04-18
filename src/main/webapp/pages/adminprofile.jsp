<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Profile – CineCritique</title>
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
      font-family: Arial, sans-serif;
      background-color: var(--black);
      color: var(--white);
    }

    header {
      background-color: var(--dark-red);
      padding: 20px;
      text-align: center;
    }

    header h1 {
      font-size: 26px;
      letter-spacing: 1px;
      color: var(--white);
    }

    nav {
      background-color: var(--black);
      padding: 12px 40px;
    }

    nav a {
      margin: 6px 12px;
      text-decoration: none;
      color: var(--white);
      font-weight: bold;
      transition: color 0.3s;
    }

    nav a:hover {
      color: var(--dark-red);
    }

    main {
      max-width: 1000px;
      margin: 40px auto;
      background: var(--gray-bg);
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(255, 0, 0, 0.1);
    }

    .profile-header {
      display: flex;
      gap: 30px;
      align-items: center;
      flex-wrap: wrap;
    }

    .profile-img-placeholder {
      display: flex;
      flex-direction: column;
      align-items: center;
      position: relative;
    }

    .circle-wrapper {
      width: 130px;
      height: 130px;
      border-radius: 50%;
      border: 3px dashed var(--dark-red);
      background-color: var(--black);
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      overflow: hidden;
    }

    .circle-wrapper span {
      position: absolute;
      color: var(--white);
      text-align: center;
      font-size: 14px;
      padding: 10px;
      z-index: 1;
    }

    .circle-wrapper img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: none;
      z-index: 2;
    }

    .profile-img-placeholder input[type="file"] {
      margin-top: 12px;
      color: var(--white);
      font-size: 13px;
    }

    .profile-info p {
      margin: 10px 0;
      font-size: 15px;
    }

    .profile-info span {
      font-weight: bold;
    }

    .profile-info input,
    .profile-info select {
      margin-top: 6px;
      padding: 8px;
      width: 100%;
      border: 1px solid #444;
      border-radius: 6px;
      background-color: #1c1c1c;
      color: var(--white);
    }

    .profile-info input:focus,
    .profile-info select:focus {
      border-color: var(--dark-red);
      outline: none;
    }

    .stats {
      display: flex;
      justify-content: space-between;
      margin: 40px 0;
      flex-wrap: wrap;
      gap: 20px;
    }

    .stat-box {
      flex: 1;
      min-width: 200px;
      background: var(--black);
      padding: 25px;
      text-align: center;
      border-radius: 10px;
      border: 1px solid #333;
    }

    .stat-box h3 {
      font-size: 32px;
      color: var(--dark-red);
    }

    .stat-box p {
      font-size: 14px;
      color: #ccc;
    }

    .actions {
      text-align: center;
      margin-top: 20px;
    }

    .actions button,
    .actions a {
      background: var(--dark-red);
      color: var(--white);
      padding: 10px 20px;
      margin: 5px;
      border-radius: 6px;
      text-decoration: none;
      border: none;
      cursor: pointer;
      font-weight: bold;
    }

    .actions button:hover,
    .actions a:hover {
      background-color: var(--red-hover);
    }

    footer {
      background-color: var(--dark-red);
      color: var(--white);
      text-align: center;
      padding: 15px;
      margin-top: 60px;
    }

    @media (max-width: 768px) {
      .profile-header {
        flex-direction: column;
        text-align: center;
      }

      .stats {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>

  <header>
    <h1>CINECRITIQUE – ADMIN PROFILE</h1>
  </header>

  <nav>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="addmovies.jsp">Add Movies</a>
    <a href="adminprofile.jsp">Admin Profile</a>
    <a href="moviedatabase.jsp">Movies Database</a>
    <a href="#">Logout</a>
  </nav>

  <main>
    <form action="#" method="POST" enctype="multipart/form-data">
      <div class="profile-header">
        <div class="profile-img-placeholder">
          <div class="circle-wrapper">
            <span id="upload-label">Upload Photo</span>
            <img id="preview" alt="Preview" />
          </div>
          <input type="file" id="profile-photo" name="profile-photo" accept="image/*" onchange="loadPreview(event)" />
        </div>

        <div class="profile-info">
          <p><span>Name:</span> <input type="text" name="name" value="<%= session.getAttribute('name') %>" /></p>
          <p><span>Email:</span> <input type="email" name="email" value="<%= session.getAttribute('email') %>" /></p>
          <p><span>Username:</span> <input type="text" name="username" value="<%= session.getAttribute('username') %>" /></p>
          <p><span>Role:</span> 
            <select name="role">
              <option value="admin" <%= "admin".equals(session.getAttribute("role")) ? "selected" : "" %>>Admin</option>
              <option value="user" <%= "user".equals(session.getAttribute("role")) ? "selected" : "" %>>User</option>
            </select>
          </p>
          <p><span>Joined:</span> <input type="date" name="joined" value="<%= session.getAttribute('joined') %>" /></p>
          <p><span>Last Login:</span> <input type="date" name="last-login" value="<%= session.getAttribute('lastLogin') %>" /></p>
        </div>
      </div>

      <div class="stats">
        <div class="stat-box">
          <h3><%= session.getAttribute("moviesAdded") %></h3>
          <p>Movies Added</p>
        </div>
        <div class="stat-box">
          <h3><%= session.getAttribute("reviewsModerated") %></h3>
          <p>Reviews Moderated</p>
        </div>
        <div class="stat-box">
          <h3><%= session.getAttribute("usersManaged") %></h3>
          <p>Users Managed</p>
        </div>
      </div>

      <div class="actions">
        <button type="submit">Save Changes</button>
      </div>
    </form>
  </main>

  <footer>
    &copy; 2025 CineCritique. All Rights Reserved.
  </footer>
