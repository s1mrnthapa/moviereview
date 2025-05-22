<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CINECRITIQUE Dashboard</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Julius+Sans+One&display=swap" rel="stylesheet">

    <!-- External CSS (optional) -->
    <link rel="stylesheet" href="resources/admin/style/dashboard.css">

    <style>
        body {
            margin: 0;
            font-family: 'Julius Sans One', sans-serif;
            background-color: #0e0e0e;
            color: #f5f5f5;
        }

        .section1 {
            display: flex;
            padding: 100px 40px 40px;
            gap: 30px;
            justify-content: space-between;
        }

        .left-section {
            flex: 3;
        }

        .left-section-top {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 30px;
        }

        .sub-section {
            flex: 1;
            background: #1e1e1e;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
            font-size: 18px;
            transition: transform 0.3s ease;
        }

        .sub-section:hover {
            transform: translateY(-5px);
            background-color: #292929;
        }

        .highest-rated {
            background: #151515;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
        }

        .highest-rated p:first-child {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
            letter-spacing: 1px;
            color: rgb(34, 255, 244);
        }

        .column {
            display: grid;
            grid-template-columns: 80px 1fr 100px;
            gap: 10px;
            padding: 10px 0;
            border-bottom: 1px solid #333;
        }

        .column p {
            margin: 0;
        }

        .right-section {
            flex: 1.2;
            background: #1a1a1a;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
            text-align: center;
        }

        .user-profile {
            width: 120px;
            height: 120px;
            background-color: #444;
            border-radius: 50%;
            margin-bottom: 20px;
            object-fit: cover;
        }

        .right-section p {
            margin: 10px 0;
            font-size: 16px;
            color: #ddd;
        }

        .right-section p:first-of-type {
            font-size: 18px;
            font-weight: bold;
            color: #f39c12;
        }
    </style>
</head>
<body>

    <%@ include file="AdminHeader.jsp" %>

    <section class="section1">
        <div class="left-section">
            <!-- Dashboard Stats -->
            <div class="left-section-top">
                <div class="sub-section sub-section1">
                    Total Movies<br/> <strong>${totalMovies}</strong>
                </div>
                <div class="sub-section sub-section2">
                    Total Users<br/> <strong>${totalUsers}</strong>
                </div>
                <div class="sub-section sub-section3">
                    Total Reviews<br/> <strong>${totalReviews}</strong>
                </div>
            </div>

            <!-- Highest Rated Movies -->
            <div class="highest-rated">
                <p>Highest Rated Movies</p>
                <div class="column" style="font-weight:bold;">
                    <p>#</p>
                    <p>Movie Title</p>
                    <p>Rating</p>
                </div>
                <c:forEach var="movie" items="${topRatedMovies}" varStatus="loop">
                    <div class="column">
                        <p>${loop.index + 1}</p>
                        <p>${movie.title}</p>
                        <p>${movie.averageRating}</p>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Right Section: Top Contributor -->
        <div class="right-section">
            <img src="resources/images/default-user.png" class="user-profile" alt="User Profile">
            <p>Top Contributor This Month</p>
            <p><strong>${topReviewerName}</strong></p>
            <p>Total of <strong>${topReviewCount}</strong> films reviewed</p>
        </div>
    </section>

</body>
</html>
