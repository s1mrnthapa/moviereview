<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Aboreto&family=Amarante&family=Bodoni+Moda:ital,opsz,wght@0,6..96,400..900;1,6..96,400..900&family=Bona+Nova+SC:ital,wght@0,400;0,700;1,400&family=Cinzel+Decorative:wght@400;700;900&family=Cinzel:wght@400..900&family=Cormorant+Unicase:wght@300;400;500;600;700&family=Eagle+Lake&family=El+Messiri:wght@400..700&family=Julius+Sans+One&family=Kalnia:wght@100..700&family=Metamorphous&family=Slackey&family=Texturina:ital,opsz,wght@0,12..72,100..900;1,12..72,100..900&family=Viaoda+Libre&display=swap" rel="stylesheet">

<meta charset="UTF-8">

<link rel="stylesheet" href="https://use.typekit.net/your-kit-id.css">

<title>CINECRITIQUE</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  ::-webkit-scrollbar {
      width: 5px;
  }
  ::-webkit-scrollbar-track{
      background: rgb(0, 0, 0);
      /* border-radius: 100vw; */
  }
  
  ::-webkit-scrollbar-thumb{
      background: linear-gradient(red,purple, blue);
      border: .25em soild hsl(0, 0%, 100%);
      border-radius: 100vw;
  }
  ::-webkit-scrollbar-thumb:hover{
      background: hsl(0, 0%, 100%);
  }
  
  
      body{
          background-color: black;
          
      }

  
      header{
          display: grid;
          grid-template-columns: 1fr 1fr 1fr;
          background-color: transparent;
          font-size: medium;
          /* justify-content: center;
          justify-items: center; */
          font-family: Cinzel Decorative, Viaoda Libre, Bodoni Moda,  Amarante, arial;
          letter-spacing: 0.25cap;
          font-size: small;
          font-weight:100;
          width: 100%;
          padding-bottom: 60px;
          z-index: 1000;
          position: fixed;
          background: linear-gradient(black, transparent);
      }
      
      .sub_header{
          display: flex;
          justify-content: left;
          align-items: center;
          column-gap: 30px;
      }
      .left_header{
          padding-left: 72px;
      }
      .right_header{
          column-gap: 20px;
          padding-right: 72px;
      }
      
      .right_header{
          justify-content: right;
          /* padding-right: 100px; */
      } 
      .logo_header{
          justify-content: center;
          /* padding-left: 100px; */
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
          left: 50%;
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
          color:rgb(36, 212, 236);
      }&:hover{
          border-bottom-color:rgb(36, 212, 236);
      }}
  
  
      .search_box:active, .search_box:focus{
          background-color: transparent;
          color: rgb(36, 212, 236);
          outline: rgb(36, 212, 236);
      }
      .search_box::placeholder{
          font-family:  Cinzel Decorative, Bodoni Moda, Amarante,  Viaoda Libre, arial;
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
          stroke: rgb(36, 212, 236);
          transition: all 1000ms;
      }
      .search_svg path{
          transition: all 1000ms;
      }
  
      .search_svg:hover path{
          fill: rgb(36, 212, 236);
          stroke: rgb(36, 212, 236);
          transition: all 1000ms;
      }
  
      .page{
          text-decoration: none;
          color: white;
          text-align: center;
          align-items: center;
          transition: linear 100ms;
      }
      .page:hover{
          color: rgb(34, 255, 244);
          /* text-decoration: underline; */		
          scale: 1.1;
          font-weight: bold;
      }
      .page:active{
          color: rgb(36, 212, 236);
          opacity: 0.5;
      }

	  .drop-box a{
	      tesxt-decoration: none;
	      color:inherit;
	   }      
      .drop-box p{
        color: white;
      }

      .user_icon_wrapper{
        position: relative;
      }
      .drop-box{
        position: absolute;
        opacity: 0;
      }
      .user_icon_wrapper:hover .drop-box{
        opacity: 1;
        transition: linear 0.3s;
        cursor: pointer;
      }
      
      .drop-box-nav1:hover, .drop-box-nav2:hover{
        background: white;
        color: color: rgb(34, 255, 244);;
      }
      
      
</style>
</head>
<body>
	<header>

		<div class="left_header sub_header">
            <a href="<%= request.getContextPath() %>/HomeServlet"  class = "page">HOME</a>
            <a href="<%= request.getContextPath() %>/MovieListServlet"  class = "page">MOVIE</a>
            <a href="<%= request.getContextPath() %>/UpcomingServlet" class = "page">UPCOMING</a>
        </div>

		<div class = "sub_header logo_header logo_wrapper" style="
		position:relative;
		">
			<img src="${pageContext.request.contextPath}/pages/resources/index/icon/logo.png" class="logo">
			<p class="logo_text">CINECRITIQUE</p>
		</div>
		

        <div class="sub_header right_header">
			<div class = "sub_header search_bar">
				<input type ="search" class="search search_box" placeholder="Search.....">


				<div class="search_icon_wrapper">
					<svg class = "search_svg" width="20px" height="20px" viewBox="0 0 24 24" fill="FFFFFF" xmlns="http://www.w3.org/2000/svg">
						<path d="M10.77 18.3C9.2807 18.3 7.82485 17.8584 6.58655 17.031C5.34825 16.2036 4.38311 15.0275 3.81318 13.6516C3.24325 12.2757 3.09413 10.7616 3.38468 9.30096C3.67523 7.84029 4.39239 6.49857 5.44548 5.44548C6.49857 4.39239 7.84029 3.67523 9.30096 3.38468C10.7616 3.09413 12.2757 3.24325 13.6516 3.81318C15.0275 4.38311 16.2036 5.34825 17.031 6.58655C17.8584 7.82485 18.3 9.2807 18.3 10.77C18.3 11.7588 18.1052 12.738 17.7268 13.6516C17.3484 14.5652 16.7937 15.3953 16.0945 16.0945C15.3953 16.7937 14.5652 17.3484 13.6516 17.7268C12.738 18.1052 11.7588 18.3 10.77 18.3ZM10.77 4.74999C9.58331 4.74999 8.42327 5.10189 7.43657 5.76118C6.44988 6.42046 5.68084 7.35754 5.22672 8.45389C4.77259 9.55025 4.65377 10.7566 4.88528 11.9205C5.11679 13.0844 5.68824 14.1535 6.52735 14.9926C7.36647 15.8317 8.43556 16.4032 9.59945 16.6347C10.7633 16.8662 11.9697 16.7474 13.0661 16.2933C14.1624 15.8391 15.0995 15.0701 15.7588 14.0834C16.4181 13.0967 16.77 11.9367 16.77 10.75C16.77 9.15869 16.1379 7.63257 15.0126 6.50735C13.8874 5.38213 12.3613 4.74999 10.77 4.74999Z" fill="#FFFFFF" stroke="white"/>
						<path d="M20 20.75C19.9015 20.7504 19.8038 20.7312 19.7128 20.6934C19.6218 20.6557 19.5392 20.6001 19.47 20.53L15.34 16.4C15.2075 16.2578 15.1354 16.0697 15.1388 15.8754C15.1422 15.6811 15.221 15.4958 15.3584 15.3583C15.4958 15.2209 15.6812 15.1422 15.8755 15.1388C16.0698 15.1354 16.2578 15.2075 16.4 15.34L20.53 19.47C20.6704 19.6106 20.7493 19.8012 20.7493 20C20.7493 20.1987 20.6704 20.3893 20.53 20.53C20.4608 20.6001 20.3782 20.6557 20.2872 20.6934C20.1962 20.7312 20.0985 20.7504 20 20.75Z" fill="white"stroke="white"/>
					  </svg>
				  </div>

			</div>

			<%
			    String uri = request.getRequestURI();
			    boolean isLoginOrRegister = uri.contains("Login.jsp") || uri.contains("Register.jsp");
			%>
            <div class="user_icon_wrapper">
				<svg class="icon user_icon" width="25" height="25" viewBox="0 0 24 24" fill="none"
				  xmlns="http://www.w3.org/2000/svg">
				  <path d="M12 12C14.76 12 17 9.76 17 7C17 4.24 14.76 2 12 2C9.24 2 7 4.24 7 7C7 9.76 9.24 12 12 12Z"
					stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
				  <path d="M20.59 22C20.59 18.13 16.74 15 12 15C7.26 15 3.41 18.13 3.41 22"
					stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
				</svg>
				<% if (!isLoginOrRegister) { %>
                <div class="drop-box">
                    <a href="<%= request.getContextPath() %>/ProfileServlet" class="drop-box-nav1"><p>Profile</p></a>
                    <a href="<%= request.getContextPath() %>/LogOutController" class="drop-box-nav2"><p>Logout</p></a> 
                </div>
                <% } %>
			  </div>
        </div>
    	</header>

	<!--starting of main container-->
</body>
<style>
	
</style>
</html>