<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
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
    }

    .circle-wrapper {
      width: 130px;
      height: 130px;
      border-radius: 50%;
      border: 3px solid var(--dark-red);
      background-color: var(--black);
      display: flex;
      justify-content: center;
      align-items: center;
      overflow: hidden;
    }

    .circle-wrapper img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .profile-info p {
      margin: 10px 0;
      font-size: 15px;
    }

    .profile-info span.label {
      font-weight: bold;
      color: var(--dark-red);
      min-width: 100px;
      display: inline-block;
    }

    .profile-info .value {
      display: inline-block;
      margin-left: 10px;
      padding: 5px 10px;
      background-color: #2a2a2a;
      border-radius: 4px;
      min-width: 200px;
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

      .profile-info .value {
        min-width: 150px;
      }

      nav {
        padding: 12px 20px;
      }
    }
  </style>
</head>
<body>

  <main>
    <div class="profile-header">
      <div class="profile-img-placeholder">
        <div class="circle-wrapper">
          <% if (session.getAttribute("profileImage") != null) { %>
            <img src="<%= session.getAttribute("profileImage") %>" alt="Admin Profile" />
          <% } else { %>
            <img src="${pageContext.request.contextPath}/images/default-admin.png" alt="Default Profile" />
          <% } %>
        </div>
      </div>

      <div class="profile-info">
        <p><span class="label">User ID:</span> <span class="value">${adminProfile.userId}</span></p>
        <p><span class="label">Username:</span> <span class="value">${adminProfile.username}</span></p>
        <p><span class="label">First Name:</span> <span class="value">${adminProfile.firstName}</span></p>
        <p><span class="label">Last Name:</span> <span class="value">${adminProfile.lastName}</span></p>
        <p><span class="label">Email:</span> <span class="value">${adminProfile.email}</span></p>
        <p><span class="label">Register Date:</span> <span class="value">${adminProfile.registerDate}</span></p>
      </div>
    </div>
  </main>

  <footer>
    &copy; 2025 CineCritique. All Rights Reserved.
  </footer>

</body>
</html>