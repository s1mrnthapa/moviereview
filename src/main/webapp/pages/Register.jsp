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
      src: url('images/Amarante-Regular.ttf') format('truetype');
      }

      @font-face {
      font-family: 'MyCustomFont2';
      src: url('images/Aboreto-Regular.ttf') format('truetype');
      }
      @font-face {
      font-family: 'MyCustomFont3';
      src: url('images/BodoniModa_9pt-Regular.ttf') format('truetype');
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
		font-size: small;
		font-weight:100;
        width: 100%;
		z-index: 1000;
		position: fixed;
	}
	
    .sub_header{
        display: flex;
        justify-content: center;
        align-items: center;
        column-gap: 55px
    }
    .right_header{
		column-gap: 20px;
    }
	
	.right_header{
		justify-content: right;
		padding-right: 100px;
	} 
	.left_header{
		justify-content: left;
		padding-left: 100px;
	}

	.logo{
		height: 55px;
		transition: all 1000ms;

	}
	.logo:hover{
		filter: invert(1);
		transition: 300ms;
	}
	.logo_text{
		position: absolute;
		top: 50%;
		left: 25%;
		transform: translate(-50%, -50%);
		margin: 0;
		color: white; /* or whatever color you want */
		font-size: 1.2rem;
		font-weight: bold;
		pointer-events: none;
		transition: all 1000ms;
		opacity: 0;
	}
	.logo_wrapper:hover .logo{
		opacity: 0;
	}
	.logo_wrapper:hover .logo_text{
		opacity: 1;
	}
	.page{
		text-decoration: none;
		color: white;
        text-align: center;
        align-items: center;
		transition: 10	00ms;
	}
	.page:hover{
		color: red;
		text-decoration: underline;
		transition: all 1000ms;

	
	}
	.search_bar{
		gap: 12px;
	}

	.search_box{
		/* width: 90px; */
	}

	.search_icon{
		height: 16px;
		fill: white;
	}

	.search_box{
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


	.search_box:active, .search_box:focus{
		background-color: transparent;
		color: red;
		outline: red;
	}
	.search_box::placeholder{
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
	.icon path{
		transition: all 1000ms;
	}
	.icon:hover path {
        stroke: red; /* On hover, change stroke to red */
		transition: all 1000ms;
	}
	.search_svg:hover path{
		fill: red;
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
		<div class = "sub_header left_header logo_wrapper" style="
		position:relative;
		">
			<img src = "/images/cinecritique-logo-only.png" class="logo">
			<p class="logo_text">CINECRITIQUE</p>
		</div>
		

		<div class="left_headers sub_header">
            <a href="homepage.html" class = "page">HOME</a>
            <a href="homepage.html" class = "page">MOVIE</a>
            <a href="homepage.html" class = "page">UPCOMING</a>
        </div>

        <div class="sub_header right_header">
			<div class = "sub_header search_bar">
				<input type ="search" class="search search_box" placeholder="Search.....">


				<div class="search_icon_wrapper">
					<svg class = "search_svg" width="16px" height="16px" viewBox="0 0 24 24" fill="white" xmlns="http://www.w3.org/2000/svg">
						<path d="M10.77 18.3C9.2807 18.3 7.82485 17.8584 6.58655 17.031C5.34825 16.2036 4.38311 15.0275 3.81318 13.6516C3.24325 12.2757 3.09413 10.7616 3.38468 9.30096C3.67523 7.84029 4.39239 6.49857 5.44548 5.44548C6.49857 4.39239 7.84029 3.67523 9.30096 3.38468C10.7616 3.09413 12.2757 3.24325 13.6516 3.81318C15.0275 4.38311 16.2036 5.34825 17.031 6.58655C17.8584 7.82485 18.3 9.2807 18.3 10.77C18.3 11.7588 18.1052 12.738 17.7268 13.6516C17.3484 14.5652 16.7937 15.3953 16.0945 16.0945C15.3953 16.7937 14.5652 17.3484 13.6516 17.7268C12.738 18.1052 11.7588 18.3 10.77 18.3ZM10.77 4.74999C9.58331 4.74999 8.42327 5.10189 7.43657 5.76118C6.44988 6.42046 5.68084 7.35754 5.22672 8.45389C4.77259 9.55025 4.65377 10.7566 4.88528 11.9205C5.11679 13.0844 5.68824 14.1535 6.52735 14.9926C7.36647 15.8317 8.43556 16.4032 9.59945 16.6347C10.7633 16.8662 11.9697 16.7474 13.0661 16.2933C14.1624 15.8391 15.0995 15.0701 15.7588 14.0834C16.4181 13.0967 16.77 11.9367 16.77 10.75C16.77 9.15869 16.1379 7.63257 15.0126 6.50735C13.8874 5.38213 12.3613 4.74999 10.77 4.74999Z" fill="#000000"/>
						<path d="M20 20.75C19.9015 20.7504 19.8038 20.7312 19.7128 20.6934C19.6218 20.6557 19.5392 20.6001 19.47 20.53L15.34 16.4C15.2075 16.2578 15.1354 16.0697 15.1388 15.8754C15.1422 15.6811 15.221 15.4958 15.3584 15.3583C15.4958 15.2209 15.6812 15.1422 15.8755 15.1388C16.0698 15.1354 16.2578 15.2075 16.4 15.34L20.53 19.47C20.6704 19.6106 20.7493 19.8012 20.7493 20C20.7493 20.1987 20.6704 20.3893 20.53 20.53C20.4608 20.6001 20.3782 20.6557 20.2872 20.6934C20.1962 20.7312 20.0985 20.7504 20 20.75Z" fill="#FFFFFF"/>
					  </svg>
				  </div>

			</div>


            <div class="user_icon_wrapper">
				<svg class="icon user_icon" width="25" height="25" viewBox="0 0 24 24" fill="none"
				  xmlns="http://www.w3.org/2000/svg">
				  <path d="M12 12C14.76 12 17 9.76 17 7C17 4.24 14.76 2 12 2C9.24 2 7 4.24 7 7C7 9.76 9.24 12 12 12Z"
					stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
				  <path d="M20.59 22C20.59 18.13 16.74 15 12 15C7.26 15 3.41 18.13 3.41 22"
					stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
				</svg>
			  </div>
        </div>
    	</header>
      <div class = "container"> 
            <div class="video-play">
                  <video autoplay muted loop id="bg-video">
                      <source src="images/mfl.mp4" type="video/mp4">  
                  </video>
            </div>
            <div class="contents">
                  <div class="card" style="width: 349px;">
                        <img src="images/download.jpg" alt="Image" style="width: 420px; height: 480px; border-radius: 20px; border: 2px solid black;" class="card-image">
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

