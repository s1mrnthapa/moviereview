<!DOCTYPE html>
<html lang="en">
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">
    <title> CineCritique </title>
    <link rel="stylesheet" href="https://use.typekit.net/your-kit-id.css">
    <style>
      @font-face {
      font-family: 'MyCustomFont';
      src: url('fonts/Amarante-Regular.ttf') format('truetype');
      }

      @font-face {
      font-family: 'MyCustomFont2';
      src: url('fonts/Aboreto-Regular.ttf') format('truetype');
      }
      @font-face {
      font-family: 'MyCustomFont3';
      src: url('fonts/BodoniModa_9pt-Regular.ttf') format('truetype');
      }
      * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            height: 100%;
            background-color: black;
        }

        h1 {
            font-family: 'MyCustomFont', sans-serif;
        }

        p {
            font-family: 'MyCustomFont2', serif;
        }

     
        #bg-video {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        .contents {
            display: flex;
            flex-direction: column;
            transform: translateY(-340px);
            text-align: right;
            margin-right: 130px;
            color: yellow;
        }

        .card {
            transform: translateY(30rem);
            margin-left: 150px;
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
        }

        .main-quote {
            font-size: 30px;
            margin-bottom: 200px;
        }

        .get-started {
            margin-bottom: 30px;
        }

        .sign-up-button {
            padding: 12px 28px;
            font-size: 20px;
            color: white;
            background-color: darkred;
            border-radius: 25px;
            text-decoration: none;
        }

        .sign-up-button:hover {
            background-color: #e6322e;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            overflow: auto;
        }

        .modal-content {
            background-color: rgba(41, 41, 41, 0.5);
            margin: 30px auto;
            padding: 30px 40px;
            width: 450px;
            transform: translateY(80px);
        }

        .close {
            position: absolute;
            top: 15px;
            right: 20px;
            color: #ff3b3b;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: #ff0000;
        }

        .modal-content h1 {
            text-align: left;
            margin-bottom: 20px;
            font-family: 'MyCustomFont2';
            color: yellow;
            font-size: 28px;
        }

        .form-container {
            display: flex;
            flex-direction: column;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-name-group, .finalPasswords {
            display: grid;
            grid-template-columns: 1fr 1fr;
            column-gap: 20px;
            margin-bottom: 20px;
        }

        .label_name {
            margin-bottom: 5px;
            display: block;
            color: dar;
            font-family: 'MyCustomFont3';
            text-align: left;
            color: aliceblue;
        }

        .placeholder {
            width: 100%;
            padding: 10px;
            border: 1px solid white;
            background-color: transparent;
            font-size: 14px;
            outline: none;
            transition: border 0.3s ease;
            color: white;
        }

        .placeholder:focus {
            border: 1px solid #ff0000;
        }

        input[type="submit"] {
            background-color: #000;
            color: black;
            padding: 10px;
            height: 40px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }

	      input[type="submit"]:hover {
	      transition: 0.2s ease;
	      background-color: yellow;
		}      
		.hide {
		  display: none !important;
		}
		    </style>
</head>
<body>
     <%@ include file ="header.jsp" %>
      <div class = "container"> 
            <div class="video-play">
                  <video autoplay muted loop id="bg-video">
                      <source src="resources/login/mfl.mp4" type="video/mp4">  
                  </video>
            </div>
            <div class="contents">
                  <div class="card" style="width: 349px;">
                        <img src="images/registerPic.jpg" alt="Image" style="width: 420px; height: 480px; border-radius: 20px; border: 2px solid black;" class="card-image">
                  </div>
                  <div class="main-quote">
                        <h1> Timeless cinema <br>
                              stories that echo across<br>
                              endless generations </h1>
                        <% if (request.getAttribute("error") != null) { %>
					    <div style="
					        background-color: #ffdddd;
					        color: #a94442;
					        border: 1px solid #f5c6cb;
					        border-radius: 6px;
					        padding: 12px 15px;
					        margin-bottom: 20px;
					        font-weight: bold;
					        font-family: 'Segoe UI', sans-serif;
					        text-align: left;">
					        <%= request.getAttribute("error") %>
					    </div>
					<% } %>
                              
                  </div>
                  <div class="down-contents">
                        <div class="get-started">
                              <a href="javascript:void(0);" class="sign-up-button" style="font-family: 'MyCustomFont2'; font-size: 20px;" onclick="openForm()">Get started - it's free</a>
                        </div>
                        <div class="second-quote">
                              <p> Track, rate, and share your cinematic journey.<br>
                                    CineCritique unveils cinema, where every film tells a story. </p>
                        </div>
                  </div>
            </div>
      </div>
            <div id="registerModal" class="modal">
                  <div class="modal-content">
                    <span class="close" onclick="closeForm()">&times;</span>
                    <h1>Join CineCritique</h1>
                    <form class="form-container" action="${pageContext.request.contextPath}/RegisterController" method="post">
                    <% if (request.getAttribute("error") != null) { %>
					    <div style="background-color: #ffdddd; color: #a94442; border: 1px solid #f5c6cb; border-radius: 6px; padding: 12px 15px; margin-bottom: 20px; font-weight: bold; font-family: 'Segoe UI', sans-serif; text-align: left;">
					        <%= request.getAttribute("error") %>
					    </div>
					<% } %>
                        <div class="form-group">
                              <label class="label_name"> User Name: </label>
                              <input class="placeholder" type="text" name="username" required>
                        </div>
                        <div class="form-name-group">
                              <div class="firstName">
                                    <label class="label_name">First Name: </label>
                                    <input class="placeholder" type="text" name="firstName" required>
                              </div>
                              <div class="lastName">
                                    <label class="label_name">Last Name: </label>
                                    <input class="placeholder" type="text" name="lastName" required>
                              </div>
                        </div>
                        <div class="form-group">
                              <label class="label_name">Email: </label>
                              <input class="placeholder" type="email" name="email" required>
                        </div>
                        <div class="finalPasswords">
                              <div class="firstPassword">
                                    <label class="label_name">Password: </label>
                                    <input class="placeholder" type="password" name="password" required>
                              </div>
                              <div class="ConfirmPassword">
                                    <label class="label_name">Confirm Password: </label>
                                    <input class="placeholder" type="password" name="confirm_password" required>
                              </div>
                        </div>
                              <input type = "submit" value = "Register" style="background-color: darkred; font-family: 'MyCustomFont2';">  
                              <p style="text-align: center; margin-top: 10px; color: white;">
                              Already have an account?
                              <a href="${pageContext.request.contextPath}/pages/Login.jsp" style="color: yellow;">Login here</a>
                        </p>
                  </form>
                  </div>
            </div>
            
                <script>
                function openForm() {
                    console.log("Opening modal because error exists");
                    document.getElementById("registerModal").style.display = "block";
                    document.querySelector(".contents").classList.add("hide");
                }

                  function closeForm() {
                        document.getElementById("registerModal").style.display = "none";
                        document.querySelector(".contents").classList.remove("hide"); // Show main contents again
                  }
                
                  window.onclick = function(event) {
                    const modal = document.getElementById("registerModal");
                    if (event.target === modal) {
                      modal.style.display = "none";
                    }
                  }
                  window.onload = function () {
                      <% if (request.getAttribute("error") != null) { %>
                          openForm();
                      <% } %>
                  };
                </script>
</body>
</html> 

