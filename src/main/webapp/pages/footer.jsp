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
body{
	width: 100vw;		
}
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  a {
  	text-decoration: none;
  	color: white;
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
          background-color: rgb(17, 17, 17);
      }

	.footer-info{
			display: flex;
			justify-content: space-between;
	}
	.left-footer,
	.right-footer {
	flex: 1;
	}

	.center-footer {
	text-align: center;
	}
	.right-footer{
		text-align: end;
	}
	.footer-icon{
		transition: all 300ms;
	}
	.footer-icon:hover{
		scale: 1.1;
	}

	.email-box{
		width: 400px;
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


	/* 50 50 for footer */
	.upper-footer,
	.lower-footer {
  flex: 1; /* 50% height each */
}

.footer-right p{
	text-align: end;
}
.pages{
	transition: all 300ms;
}
.pages:hover{
	scale: 1.1;
	color: rgb(36, 212, 236);
	cursor: pointer;
}
.footer-icon, .footer-icon img{
		height: 33px;
	}
.footer-text{
	color: black;
	}

</style>
</head>
<body>
	<!--starting of main container-->

	<footer style="
		display: flex;
		flex-direction: column;
		position: relative;
		height: 100vh;
	">
	<div style="
	background-color: rgb(17, 17, 17);
	position: absolute;
	top: 50%;
 	left: 50%;
	transform: translate(-50%, -15%);
	height: 200px;
	border-radius: 100%;
	padding: 15px;
">
	<a href="<%= request.getContextPath() %>/HomeServlet"><img src="${pageContext.request.contextPath}/pages/resources/index/icon/logo.png" style="height: 100%; "></a>
</div>
		<div class="upper-footer" style="
		padding-top: 150px;
				color:aliceblue;
				display: flex;
				justify-content: space-between;
				position: relative;
				
			">
			<div class="footer-left" style="
			display: flex;
			flex-direction: column;
			row-gap: 15px;
			padding-left:72px;
			">
				<p style="font-size: 3em;">JOIN <br>THE <br>MOVIE FREAK</p>
				<div class="footer-contact-us">
					<form style="
					display: flex; 
					flex-direction: column;
					row-gap: 15px;
					">
						<input type="text" placeholder="ENTER EMAIL" class="email-box">
						<label style="display:flex;">
							<input type="checkbox"><p style="padding-left: 10px;">I consent to receive communications from Cinecritique in 
							relation to our funds, <br>portolio companies, events and/or community programs. </p>
						</label>
						<button type="submit" style="
							width: 150px;
							font-weight: 800;
							border-radius: 26px;
							padding: 10px;
						">RATE WITH US</button>
						
					</form>
				</div>
			</div>

			
			<div class="footer-right" style="
			display: flex;
			flex-direction: column;
			row-gap: 38px;
			padding-right:72px">
				<p style="font-size: 26px; font-weight: 800;">Pages<p>
				<a href="<%= request.getContextPath() %>/HomeServlet"><p class="pages">HOME</p></a>
				<a href="<%= request.getContextPath() %>/MovieListServlet"><p class="pages">MOVIE</p></a>
				<a href="<%= request.getContextPath() %>/UpcomingServlet"><p class="pages">UPCOMING</p></a>
				<a href="<%= request.getContextPath() %>/ProfileServlet"><p class="pages">USER PROFILE</p></a>

			</div>
		</div>
		<div class="lower-footer" style="
			background-color: white;
			height: 100%;
			display: flex;
			flex-direction: column;
			justify-content: space-evenly;
		">
			<div class="footer-icons" style="
				display: flex;
				justify-content: space-between;
				padding-left: 72px;
				padding-right: 72px;
			">
				<div class="footer-icon"> <a href = "https://instagram.com"><img src="${pageContext.request.contextPath}/pages/resources/index/icon/instagram.png"></a></div>
				<div class="footer-icon"><a href = "https://facebook.com"><img src="${pageContext.request.contextPath}/pages/resources/index/icon/facebook.png"></a></div>
				<div class="footer-icon"><a href = "https://linkedin.com"><img src="${pageContext.request.contextPath}/pages/resources/index/icon/linkedin (1).png"></a></div>
				<div class="footer-icon"><a href = "https://x.com"><img src="${pageContext.request.contextPath}/pages/resources/index/icon/twitter.png"></a></div>
			</div>
			<p style="text-align: center; font-size: 200px; " class="footer-text">CINECRITIQUE</p>
			<div class="footer-info" style="
				padding-left: 72px;
				padding-right: 72px;
			">
				<p class="left-footer footer-text">PRIVACY</p>
				<p class="center-footer footer-text">2025 @CINECRITIQUE</p>
				<p class="right-footer footer-text">CODE BY FLIM ENTHUSIASTIC</p>
			</div>

		</div>
	</footer>
	
</body>
</html>
