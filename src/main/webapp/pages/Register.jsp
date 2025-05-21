<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">
    <title> CineCritique </title>
    <link rel="stylesheet" href="https://use.typekit.net/your-kit-id.css">
    <style>
      * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        h1 {
            font-family: 'Amarante', cursive;
			font-size: 60px;
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
            pointer-events: none;
        }
        .contents {
        	display: grid;
        	gap: 30px;
        	padding-top: 180px;
        	padding-left: 70px;
        	place-items: left;
        }
        .main-quote h1{
            font-size: 55px;
            text-align: left;
            margin-bottom: 230px;
            color: white;
        }
        .down-contents{
        	text-align: left;
        }

        .get-started {
            margin-bottom: 30px;
        }

        .sign-up-button {
            padding: 12px 28px;
            font-size: 20px;
            color: black;
            background-color: rgb(36, 212, 236);
            border-radius: 25px;
            text-decoration: none;
        }

        .sign-up-button:hover {
            background-color: white;
        }

        .modal {
            display: none;
            position: fixed;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            overflow: auto;
            z-index: 1000;
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
		    top: 10px;
		    right: 15px;
		    font-size: 28px;
		    color: rgb(34, 255, 244);
		    cursor: pointer;
        }

        .close:hover {
            color: #ff0000;
        }

        .modal-content h1 {
            text-align: left;
            margin-bottom: 20px;
            font-family: Cinzel Decorative, Viaoda Libre, Bodoni Moda,  Amarante, arial;     
            color: cyan;
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
            font-family: Cinzel Decorative, Viaoda Libre, Bodoni Moda,  Amarante, arial;
            text-align: left;
            color: white;
        }

        .placeholder {
            width: 100%;
            padding: 10px;
            border: 1px solid cyan;
            background-color: transparent;
            font-size: 14px;
            outline: none;
            transition: border 0.3s ease;
            color: white;
        }

        .placeholder:focus {
            border: 1px solid cyan;
        }

        input[type="submit"] {
            background-color: cyan;
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
                      <source src="resources/video/background.mp4" type="video/mp4">  
                  </video>
            </div>
            <div class="contents">
                  <div class="main-quote">
                        <h1> Timeless cinema stories that <br>
                        	 echo across endless <br>
                        	 generations </h1>
                        <% if (request.getAttribute("error") != null) { %>
					    <div style="
					    	color: darkred;
						    border: 1px solid #ff4d4d;
						    padding: 10px 10px;
						    width: 100%;
						    font-weight: bold;
				            text-align: center;
				            background-color: transparent;
					        margin-bottom: 20px;
					        font-family: 'Segoe UI', sans-serif;
					        text-align: center;">
					        <%= request.getAttribute("error") %>
					    </div>
					<% } %>                              
                  </div>
                  <div class="down-contents">
                        <div class="get-started">
                              <a href="javascript:void(0);" class="sign-up-button" style="font-family: 'Aboreto', cursive; font-size: 15px;" onclick="openForm()">Get started - it's free</a>
                        </div>
                        <div class="second-quote">
                              <p style="color: white; font-family: 'Aboreto', cursive;"> Track, rate, and share your cinematic journey.<br>
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
                    <%
					    String error = request.getParameter("error");
					    if (error != null) {
					%>
					    <div style="background-color: #ffdddd; color: #a94442; border: 1px solid #f5c6cb; border-radius: 6px; padding: 12px 15px; margin-bottom: 20px; font-weight: bold; font-family: 'Segoe UI', sans-serif; text-align: left;">
					        <%= error %>
					    </div>
					<%
					    }
					%>
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
                              <input type = "submit" value = "Register" style="background-color: cyan; font-family: 'Aboreto', cursive;">  
                              <p style="text-align: center; margin-top: 10px; color: white; font-family: 'Aboreto', cursive;">
                              Already have an account?
                              <a href="${pageContext.request.contextPath}/pages/Login.jsp" style="color: cyan;">Login here</a>
                        </p>
                  </form>
                  </div>
            </div>
            
                <script>
                <% if (request.getParameter("error") != null) { %>
                window.onload = function () {
                    openForm();
                };
            <% } %>
	                function openForm() {
	                    console.log("Opening modal because error exists");
	                    document.getElementById("registerModal").style.display = "block";
	                    document.querySelector(".contents").classList.add("hide");
	                }
	
	                  function closeForm() {
	                	  document.getElementById("registerModal").style.display = "none";
	                	  document.querySelector(".contents").classList.remove("hide");
	                  }
	                
	                  window.onclick = function(event) {
	                    const modal = document.getElementById("registerModal");
	                    if (event.target === modal) {
	                      modal.style.display = "none";
	                    }
	                  } 
                </script>
</body>
</html> 
