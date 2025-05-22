<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
	<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
    <title>Admin Profile – CineCritique</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@700&family=Amarante&display=swap" rel="stylesheet">

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
            background-color: var(--black);
            font-family: 'Amarante', serif;
            color: var(--white);
        }

        nav {
            background-color: var(--black);
            padding: 12px 20px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        nav a {
            text-decoration: none;
            color: var(--white);
            font-weight: bold;
            padding: 6px 12px;
            transition: 0.3s ease;
        }

        nav a:hover {
            color: #00ff88;
        }

        main {
            max-width: 850px;
            background: var(--gray-bg);
            padding: 40px 50px;
            border-radius: 12px;
        }

        .profile-header {
            display: flex;
            gap: 40px;
            align-items: flex-start;
            flex-wrap: wrap;
            justify-content: center;
            margin-bottom: 30px;
        }

        .profile-img-placeholder {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .circle-wrapper {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 3px solid var(--dark-red);
            background-color: var(--black);
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            cursor: pointer;
        }

        .circle-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .profile-info {
            flex-grow: 1;
            width: 100%;
            max-width: 500px;
            display: grid;
            grid-template-columns: 160px 1fr;
            row-gap: 20px;
            column-gap: 20px;
            background-color: #222;
            padding: 25px;
            border-radius: 10px;
        }

        .label {
            font-weight: bold;
            color: var(--white);
            align-self: center;
        }

        .value {
            background-color: #2a2a2a;
            padding: 10px 14px;
            border-radius: 6px;
            color: #f0f0f0;
        }

        form {
            margin-top: 25px;
            text-align: center;
        }

        button, input[type="file"] {
            padding: 10px 20px;
            background-color: var(--dark-red);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="file"]:disabled, button:disabled {
            background-color: #444;
            cursor: default;
        }

        @media (max-width: 768px) {
            .profile-header {
                flex-direction: column;
                text-align: center;
            }

            .profile-info {
                grid-template-columns: 1fr;
                text-align: center;
            }
        }

        #imgModal {
            display: none;
            position: fixed;
            z-index: 999;
            left: 0; top: 0;
            width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
        }

        #imgModal img {
            display: block;
            margin: 50px auto;
            max-width: 90%;
            max-height: 90%;
            border: 5px solid var(--dark-red);
            border-radius: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<%@ include file = "AdminHeader.jsp" %>

<main>
    <div class="profile-header">
        <div class="profile-img-placeholder">
            <div class="circle-wrapper" onclick="openModal()">
                <c:choose>
                    <c:when test="${not empty sessionScope.profileImage}">
                        <img src="${sessionScope.profileImage}" alt="Admin Profile" id="profileImg" />
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/default-admin.png" alt="Default Profile" id="profileImg" />
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="profile-info">
            <span class="label">User ID:</span> <span class="value">${adminProfile.userId}</span>
            <span class="label">Username:</span> <span class="value">${adminProfile.username}</span>
            <span class="label">First Name:</span> <span class="value">${adminProfile.firstName}</span>
            <span class="label">Last Name:</span> <span class="value">${adminProfile.lastName}</span>
            <span class="label">Email:</span> <span class="value">${adminProfile.email}</span>
            <span class="label">Register Date:</span> <span class="value">${adminProfile.registerDate}</span>
        </div>
    </div>

    <c:if test="${empty sessionScope.profileImage}">
        <form action="${pageContext.request.contextPath}/UploadProfileImageServlet" method="post" enctype="multipart/form-data">
            <br>
            <label for="profileImage"><strong>Upload New Profile Image:</strong></label><br><br>
            <input type="file" name="profileImage" id="profileImage" accept="image/*" required /><br><br>
            <button type="submit">Save Changes</button>
        </form>
    </c:if>
</main>

<div id="imgModal" onclick="closeModal()">
    <img id="modalImage" src="" alt="Full Image" />
</div>

<script>
    function openModal() {
        const img = document.getElementById("profileImg");
        const modal = document.getElementById("imgModal");
        const modalImage = document.getElementById("modalImage");
        modal.style.display = "block";
        modalImage.src = img.src;
    }

    function closeModal() {
        document.getElementById("imgModal").style.display = "none";
    }
</script>

</body>
</html>