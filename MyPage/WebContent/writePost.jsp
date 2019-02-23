<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="write post">
    <meta name="author" content="YOOK DONGHYUN">
    
    <title>게시글 작성</title>
    
    <!-- Bootstrap core CSS -->
    <link href="bootstrap/general/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->
    <link href="bootstrap/general/css/scrolling-nav.css" rel="stylesheet">
    
    <!-- CSS Style Sheet -->
	<style>
		/* Font */
		@import url('https://fonts.googleapis.com/css?family=Black+Han+Sans|Jua');
		.jua { font-family: 'Jua', sans-serif; }
		#post
	    {
	    	margin-left:auto;
	        margin-right:auto;
	        padding:10px;
	                
	        border: 1px solid black;
	        border-radius: 25px;
	        box-shadow: 5px 5px gray;
	
	        text-align: center;
	        width: 30%;
	        height: 400px;
	        font-weight: bold;
	        background-color: lightsteelblue;
	
	        float: center;
	     }
	     textarea
	     {
	        width: 250px;
	        height: 150px;
	     }
	     #post_title { width: 250px; }
	</style>
	
	<!-- jQuery import -->
	<script src="jQuery/jquery-1.10.1.js"></script>
  </head>

  <body id="page-top">
  		<!-- FIREBASE IMPORT -->
		<script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
		<script>
			//Initialize Firebase
			var config = 
			{
			  apiKey: "AIzaSyA6F49hsvuStEL_ukhsLiKUEpIxsf2iz40",
			  authDomain: "mypage-c40c6.firebaseapp.com",
			  databaseURL: "https://mypage-c40c6.firebaseio.com",
			  projectId: "mypage-c40c6",
			  storageBucket: "mypage-c40c6.appspot.com",
			  messagingSenderId: "631656443065"
			};
			firebase.initializeApp(config);
		</script>
		
		<!-- Navigation -->
	    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav" style="background-color:rgba(0,46,102,.8);">
	      <div class="container">
	        <a class="navbar-brand" href="#" onclick="goProfile()" style="font-family:'Jua', sans-serif;font-weight:bold;">Study Logger</a>
	      </div>
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
	        function goProfile() 
	        { 
	        	var id = getParameterByName('user_id');
	        	location.href = "profile.jsp?user_id=" + id;
	        }
	      </script>
	    </nav>
	    <!--/ Navigation -->
		
		<!-- POST -->
		<br><br><br>
		<h1 class="jua" style="text-align:center;">포스트 작성하기</h1>
		<div id="post">
			<% String id = (String)session.getAttribute("id"); %>
			<label class="jua" style="font-size:25px;">제목</label><br>
			<input type="text" id="post_title" class="jua"><br><br>
			<label class="jua" style="font-size:25px;">한 줄 응원</label><br>
			<textarea id="post_content" class="jua"></textarea><br><br>
			<input type="button" value="작성하기" onclick="writePost()" class="jua btn btn-secondary">
			<input type="button" value="뒤로가기" onclick="goBack()" class="jua btn btn-secondary">
			<script>
				/* 현재시간 */
				function getTimeStamp() 
				{
					var d = new Date();
					var s = leadingZeros(d.getFullYear(), 4) + '-'
							+ leadingZeros(d.getMonth() + 1, 2) + '-'
							+ leadingZeros(d.getDate(), 2) + ' '
							+ leadingZeros(d.getHours(), 2) + ':'
							+ leadingZeros(d.getMinutes(), 2) + ':'
							+ leadingZeros(d.getSeconds(), 2);
					return s;
				}
		
				/* 포멧지정 */
				function leadingZeros(n, digits) 
				{
					var zero = '';
					n = n.toString();
					if (n.length < digits)
						for (i = 0; i < digits - n.length; i++)
							zero += '0';
					return zero + n;
				}
		
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
				
				/* 포스트 작성 */
				function writePost()
				{
					var id = getParameterByName('user_id');
					var post_title = document.getElementById("post_title").value;
					var post_content = document.getElementById("post_content").value;
					var post_date = getTimeStamp();
					var user_post = firebase.database().ref('user_post/' + '<%= id %>');
					
					// create user_post
					user_post.set
					({
						user_id : id,
						post_title : post_title,
						post_content : post_content,
						post_date : post_date
					});
					
					alert("포스트가 작성되었습니다.");
				}
				
				function goBack()
				{
					location.href = "board.jsp?user_id=" + '<%= id %>'; 
				}
			</script>
		</div>
		<!-- POST -->
		
    <!-- Bootstrap core JavaScript -->
    <script src="bootstrap/general/vendor/jquery/jquery.min.js"></script>
    <script src="bootstrap/general/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="bootstrap/general/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom JavaScript for this theme -->
    <script src="bootstrap/general/js/scrolling-nav.js"></script>
  </body>
</html>