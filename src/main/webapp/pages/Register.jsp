<!DOCTYPE html>
<html lang="en">
<head>
    <title> CineCritique </title>
    <style>
      @font-face {
      font-family: 'MyCustomFont';
      src: url('Amarante-Regular.ttf') format('truetype');
      }

      @font-face {
      font-family: 'MyCustomFont2';
      src: url('Aboreto-Regular.ttf') format('truetype');
      }
      @font-face {
      font-family: 'MyCustomFont3';
      src: url('BodoniModa_9pt-Regular.ttf') format('truetype');
      }
      * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        html, body {
            height: 100%;
            width: 100%;
        }
        h1 {
            font-family: 'MyCustomFont', sans-serif;
            }

            p {
            font-family: 'MyCustomFont2', serif;
            }
            header{
		display: grid;
            grid-template-columns: 1fr 1fr 1fr;
		background-color: rgb(0, 0, 0);
            font-size: medium;
		/* justify-content: center;
		justify-items: center; */
		font-family: Cinzel Decorative, Amarante, Bodoni Moda,Viaoda Libre, arial;
		letter-spacing: 0.25cap;
		font-size: 10px;
		font-weight:100;
            width: 100%;
		z-index: 1000;
		position: fixed;
	}
	
    .sub_header{
        display: flex;
        color:green;
        justify-content: center;
        align-items: center;
        column-gap: 30px
    }

    .menu_bar{
        justify-content: left;
        padding-left: 70px;
    }

    .right_header{
		column-gap: 20px;
    }
	
	.right_header{
		justify-content: right;
		padding-right: 70px;
	} 
	/* .left_header{
		justify-content: left;
		padding-left: 100px;
	} */

	.logo{
		height: 55px;
		transition: 1000ms;

	}
	.logo:hover{
		height: 60px;
		filter: invert(1);
		transition: 300ms;
	}
	.page{
		text-decoration: none;
		color: white;
        text-align: center;
        align-items: center;
		transition: 500ms;
	}
	.page:hover{
		color: red;
		text-decoration: underline;
		transition: 300ms;

	
	}
	.search_bar{
		gap: 12px;
	}

	.search_box{
		width: 90px;
	}

	.search{
		height:16px;
		background-color: transparent;

		border-top: none;
		border-left: none;
		border-right: none;
		border-color: white;
		border-bottom-width: 1px;
		transition: all 1000ms;
	&:focus{
		outline: none;
		color:red;
	}&:hover{
		border-bottom-color:red;
	}}


	.search:active, .search:focus{
		background-color: transparent;
		color: red;
		outline: red;
	}
	.search::placeholder{
		font-family:  Bodoni Moda, Amarante, Cinzel Decorative, Viaoda Libre, arial;
		/* font-size: 1rem; */
		font-style: italic;
		color: #888;
	}
    .user_icon{
        height: 25px;
		transition: 300ms;
		display: block;
    }

	.user_icon:hover{
		background-color: black;
		display: block;
		border: 2px soild red;
		border-radius: 50%;
		transition: 300ms;
	}
	.poster_grid{
		display: flex;
		justify-content: right;
		gap: 10px;
	}
	.left_grid{
		display: flex;
		gap: 10px;
		background-color: rgb(17, 17, 17);
	}
	.posters_line_1{
		display: flex;
		flex-direction: column;
		gap: 10px;
		width: 168px;
	}
	.poster{
		width: 168px;
		border-radius: 6px;
	}
	.main_container{
		display: grid;
		grid-template-columns: 50% 50%;
	}
        .container {
            height: 100vh; /* Full viewport height */
            color: white; /* Make text stand out over the video */
            overflow: hidden;
        }
        #bg-video {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover; /* Ensures the video covers the whole background without distortion */
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
        .card{
            transform: translateY(30rem);
            margin-left: 150px;
            backdrop-filter: blur(8px); /* dreamy blur */
            border: 1px solid rgba(255, 255, 255, 0.1); /* subtle border */
            border-radius: 1rem; /* soft corners */
            padding: 1.5rem;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3); /* soft shadow for depth */
        }
        .main-quote {
            font-size: 30px;
            margin-bottom: 200px;
        }
        .get-started{
            margin-bottom: 30px;
        }
      .sign-up-button {
            padding: 12px 28px;
            font-size: 20px;
            color: white;
            background-color: black; /* You can change this to match your theme */
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

      /* Modal content box */
      .modal-content {
      background-color: rgba(41, 41, 41, 0.5); /* black with 50% opacity */
      margin: 30px auto;
      padding: 30px 40px;
      width: 450px;
      transform: translateY(80px);
      }

      /* Close button (X) */
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

      /* Header title */
      .modal-content h1 {
      text-align: left;
      margin-bottom: 20px;
      font-family: 'MyCustomFont2';
      color: yellow;
      font-size: 28px;
}

      /* Form container */
      .form-container {
      display: flex;
      flex-direction: column;
}

      /* Form group (label + input/select) */
      .form-group {
      margin-bottom: 15px;
}
      .form-name-group, .finalPasswords{
            display: grid;
            grid-template-columns: 1fr 1fr;
            column-gap: 20px;
            margin-bottom: 20px;
      }

      /* Labels */
      .label_name {
      margin-bottom: 5px;
      display: block;
      color: dar;
      font-family: 'MyCustomFont3';
      text-align: left;
      color: aliceblue;
}

      /* Inputs & selects */
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
     /* Inputs & selects */
     .placeholder:focus {
      border: 1px solid #ff0000;
    }
      /* Submit button */
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
      <header>

            <div class="menu_bar sub_header">
                <a href="homepage.html" class = "page">HOME</a>
                <a href="homepage.html" class = "page">MOVIE</a>
                <a href="homepage.html" class = "page">UPCOMING</a>
            </div>
            
                <div class = "sub_header left_header">
                      <img src = "/cinecritique logo only.png" class="logo">
                </div>
    
                
    
            <div class="sub_header right_header">
                      <div class = "sub_header search_bar">
                            <input type ="search" class="search search_box" placeholder="Search.....">
                            <img src="/icon/search.png" class="icon search">
                      </div>
                <img src="/icon/user.png" class="icon user_icon">
            </div>
              </header>
      <div class = "container"> 
            <div class="video-play">
                  <video autoplay muted loop id="bg-video">
                        <source src="mfl.mp4" type="video/mp4">
                  </video>
            </div>
            <div class="contents">
                  <div class="card" style="width: 349px;">
                        <img src="download (1).jpg" alt="Image" style="width: 420px; height: 480px; border-radius: 20px; border: 2px solid black;" class="card-image">
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
                  </form>
                        <p style="text-align: center; margin-top: 10px; color: white;">
                              Already have an account?
                              <a href="${pageContext.request.contextPath}/pages/Login.jsp" style="color: yellow;">Login here</a>
                        </p>
                  </div>
            </div>
                <script>
                  function openForm() {
                        document.getElementById("registerModal").style.display = "block";
                        document.querySelector(".contents").classList.add("hide"); // Hide main contents
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
                      const hasError = '<%= request.getAttribute("error") != null ? "true" : "false" %>';
                      if (hasError === "true") {
                          openForm();
                      }
                  };
                </script>
</body>
</html> 

