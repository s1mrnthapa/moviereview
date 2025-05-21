<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Admin – View Users</title>
  <style>
    body {
      background-color: #0f0f0f;
      color: white;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
    }
	 header {
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 80px; /* Set height */
		  z-index: 1000;
		}
    .container {
      margin: 100px auto;
      max-width: 95%;
      padding: 20px;
      background-color: #1a1a1a;
      border-radius: 8px;
      overflow-x: auto;
    }

    .title h1 {
      font-family: Cinzel Decorative;
      font-size: 28px;
      margin-bottom: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
      min-width: 1000px;
    }

    th, td {
      padding: 10px;
      border: 1px solid #333;
      white-space: nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
    }

    th {
      background-color: #222;
      color: cyan;
      font-family: Cinzel Decorative;
    }

    tr:nth-child(even) {
      background-color: #2a2a2a;
    }

    @media (max-width: 768px) {
      table {
        font-size: 12px;
      }

      th, td {
        padding: 8px;
      }
    }
  </style>
</head>
<body>
  <header>
    <%@ include file="AdminHeader.jsp" %>
  </header>
  <div class="container">
	  <div class="title">
			<h1>CineCritique | View Users</h1>
		</div>
    <c:if test="${empty users}">
      <c:redirect url='${request.contextPath}/AllUsersServlet'/>
    </c:if>

    <table>
      <thead>
        <tr>
          <th>Username</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Email</th>
          <th>Register Date</th>
          <th>Total Reviews</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="user" items="${users}">
          <tr>
            <td>${user.username}</td>
            <td>${user.firstName}</td>
            <td>${user.lastName}</td>
            <td>${user.email}</td>
            <td>${user.registerDate}</td>
            <td>${user.totalReviews}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</body>
</html>
