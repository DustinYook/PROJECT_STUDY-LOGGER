<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<!-- HEAD -->
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="board">
		<meta name="author" content="YOOK DONGHYUN">
		
		<title>학습인증게시판</title>
		
		<!-- Bootstrap core CSS -->
		<link href="bootstrap/board/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Custom fonts for this template -->
		<link href="bootstrap/board/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
		<link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
		
		<!-- Custom styles for this template -->
		<link href="bootstrap/board/css/clean-blog.min.css" rel="stylesheet">
		
		<!-- CSS Style Sheet -->
		<style>
			@import url('https://fonts.googleapis.com/css?family=Black+Han+Sans|Jua');
			.juaFont, #jua { font-family: 'Jua', sans-serif; }
		</style>
		
		<!-- jQuery import -->
		<script src="jQuery/jquery-1.10.1.js"></script>
	</head>
	<!--/ HEAD -->

	<!-- BODY -->
	<body>
		<!-- FIREBASE IMPORT -->
		<script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
		<script>
			//Initialize Firebase
			var config = 
			{
				apiKey : "AIzaSyA6F49hsvuStEL_ukhsLiKUEpIxsf2iz40",
				authDomain : "mypage-c40c6.firebaseapp.com",
				databaseURL : "https://mypage-c40c6.firebaseio.com",
				projectId : "mypage-c40c6",
				storageBucket : "mypage-c40c6.appspot.com",
				messagingSenderId : "631656443065"
			};
			firebase.initializeApp(config);
		</script>
		<!--/ FIREBASE IMPORT -->
		
		<!-- Navigation -->
	    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
	      <div class="container">
	      	<a class="navbar-brand juaFont" href="#" onclick="goProfile()">Study Logger</a>
	        <div class="collapse navbar-collapse" id="navbarResponsive">
	          <ul class="navbar-nav ml-auto">
	            <li class="nav-item">
	            	<a class="nav-link juaFont" href="#" onclick="writePost()" style="border-radius:25px;font-size:20px;">
	            		게시글 작성하기
	            	</a>
	            </li>
	          </ul>
	        </div>
	      </div>
	      <script>
	      	/* URL 파싱 */
		    function getParameterByName(name) 
	        {
	        	name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
	        	var regexS = "[\\?&]" + name + "=([^&#]*)";
	        	var regex = new RegExp(regexS);
	        	var results = regex.exec(window.location.href);
	        	if (results == null)
	        		return "";
	        	else
	        		return decodeURIComponent(results[1].replace(/\+/g, " "));
	        }
	      	
	        function goProfile() 
	        { 
	        	var id = getParameterByName('user_id');
	        	location.href = "profile.jsp?user_id=" + id;
	        }
	    </script>
	    </nav>
		<!--/ NAVIGATION -->
	    
		<!-- PAGE HEADER -->
		<header class="masthead" style="background-image: url('bootstrap/board/img/home-bg.jpg')">
			<div class="overlay"></div>
			<div class="container">
				<div class="row">
					<div class="col-lg-8 col-md-10 mx-auto">
						<div class="site-heading">
							<h1 class="juaFont">학습인증게시판</h1>
							<span class="subheading" id="jua">스터디모입 구성원에게 나의 학습시간을 인증하세요!</span>
						</div>
					</div>
				</div>
			</div>
		</header>
		<!--/ PAGE HEADER -->
	
		<!-- MAIN CONTENT -->
		<section class="container">
			<div class="row">
				<div class="col-lg-8 col-md-10 mx-auto">
					<div class="post-preview">
						
						<!-- BOARD CONTAINER -->
						<div id="container"></div>
						
						<!-- JAVA SCRIPT -->
						<script>
							function getParameterByName(name) 
							{
								name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
								var regexS = "[\\?&]" + name + "=([^&#]*)";
								var regex = new RegExp(regexS);
								var results = regex.exec(window.location.href);
								if (results == null)
									return "";
								else
									return decodeURIComponent(results[1].replace(/\+/g, " "));
							}
							
							function writePost() 
							{ 
								var id = getParameterByName('user_id');
								location.href = "writePost.jsp?user_id=" + id; 
							}
						
							/* 게시판 업데이트 하는 처리 */
							var user_post = firebase.database().ref('user_post');
								user_post.on('value', function(snapshot) {
								snapshot.forEach(function(childSnapshot) {
								var tmp = childSnapshot.val();
						
								// 동적으로 element 생성
								var div = document.createElement("div");
								var h3 = document.createElement("h3");
								var p = document.createElement("p");
								var hr = document.createElement("hr");
								
								// 동적으로 생성된 요소의 CSS 설정
								h3.setAttribute("style", "font-family:'Jua',sans-serif;");
								p.setAttribute("style", "font-size:20px;font-family:'Jua',sans-serif;");
								
								// 포스트날짜를 파싱하는 처리
								var str = tmp.post_date;
								var parse1 = String(str).split("-");
								var parse2 = String(parse1[2]).split(" ");
								var result = parse1[0] + parse1[1] + parse2[0];
								
								// DB로 부터 내용 가져옴
								h3.innerHTML = tmp.post_title;
								p.innerHTML = "한 줄 응원 : " + tmp.post_content;
								p.innerHTML += "<br>" + "작성자 : " + tmp.user_id + "<br>" + "작성시간 : " + tmp.post_date; 
								
								// 해당 게시글 작성시점에 학습시간 얻어오기 위한 처리
								var study_time = "";
								var ref = firebase.database().ref('user_time/' +  tmp.user_id  + '/' + result);
								ref.once("value").then(function(snapshot) { 
									study_time = snapshot.child("user_time").val(); 
									console.log(study_time);
									p.innerHTML += "<br>" + "학습시간 : " + study_time;
								});
								// 정리하자면 {"키 값" : "값"}에서 value를 접근하려면  snapshot.child("키 값").val()을 사용해야 한다 
								
								div.appendChild(h3);
								div.appendChild(p);
								div.appendChild(hr);
								document.getElementById("container").appendChild(div);
								});
							});
						</script>
						<!--/ JAVA SCRIPT -->
					</div>
				</div>
			</div>
		</section>
		<!--/ MAIN CONTENT -->
		
		<!-- Bootstrap core JavaScript -->
		<script src="bootstrap/board/vendor/jquery/jquery.min.js"></script>
		<script src="bootstrap/board/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
		<!-- Custom scripts for this template -->
		<script src="bootstrap/board/js/clean-blog.min.js"></script>
	</body>
	<!--/ BODY -->
</html>