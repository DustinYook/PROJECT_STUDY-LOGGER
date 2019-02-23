<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %> 
<%@ page import="java.text.SimpleDateFormat" %> 
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="log search">
    <meta name="author" content="YOOK DONGHYUN">
    
    <title>로그조회</title>
    
    <!-- Bootstrap core CSS -->
    <link href="bootstrap/general/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->
    <link href="bootstrap/general/css/scrolling-nav.css" rel="stylesheet">
    
    <!-- CSS Style Sheet -->
	<style>
		@import url('https://fonts.googleapis.com/css?family=Black+Han+Sans|Jua');
		.jua { font-family: 'Jua', sans-serif; }
		#report
        {
        	margin-left:auto;
            margin-right:auto;
            padding:10px;
                
            border: 2px solid black;
            border-radius: 25px;
            box-shadow: 5px 5px gray;

            text-align: center;
            width: 40%;
            height: 100%;
            background-color: lightsteelblue;

            float: center;
        }
        #record { text-align:left; }
	</style>
	
	<!-- jQuery import -->
	<script src="jquery-1.10.1.js"></script>
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
		
		<!-- SECTION -->
		<br><br><br>
		<h1 class="jua" style="text-align:center;">로그조회</h1>
		<div id="report">
			<label class="jua" style="font-size:20px;">날짜 선택 : </label>
			<%
				Date date = new Date();
				String modifiedDate= new SimpleDateFormat("yyyy-MM-dd").format(date);
			%>
			<input type="date" id="date" value="<%= modifiedDate %>" class="jua">
			<input type="button" value="선택완료" id="select" onclick="generateReport()" class="btn btn-secondary jua" style="width:90px;height:33px;">
			<article id="record"></article>
			<script>
			/* 쿼리스트링 파싱 */
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
	    
			/* 보고서 작성 */
			function generateReport()
			{
				document.getElementById("record").innerHTML = "";
				
				var input = document.getElementById("date").value; // input에서 값 받아옴
		    	var parse = input.split("-"); // input값을 파싱함
				var dateStr = "" + parse[0] + parse[1] + parse[2]; // 파싱한 문자열을 하나로 묶음
				
				alert("로그를 출력합니다"); // 로그 출력 메세지를 띄움
				var reqDate = document.createElement("h4"); // 날짜 삽입을 위해 텍스트 노드 생성
				reqDate.setAttribute("style", "font-family:'Jua',sans-serif;font-size:20px;color:rgba(0,46,102,.8);");
				reqDate.innerHTML = "<" + dateStr + ">";
				document.getElementById("record").appendChild(reqDate);
				
				var id = getParameterByName('user_id'); // user_id 받아옴
				var user_log = firebase.database().ref('user_log/' + id + '/' + dateStr); // DB에 접근
				user_log.on('value', function(snapshot) {
					 snapshot.forEach(function(childSnapshot) {
					 	var tmp = childSnapshot.val();
					 	
					   	// 동적으로 element 생성
						var div = document.createElement("div"); 
					   	div.setAttribute("style", "font-family:'Jua', sans-serif;font-size:20px;");
						var task_name = document.createElement("span");
					 	var colon = document.createTextNode(" : ");
						var start_time = document.createElement("span"); 
						var tilde = document.createTextNode(" ~ ");
						var end_time = document.createElement("span"); 
						
						// DB로 부터 내용 가져옴
						task_name.innerHTML = tmp.task_name;
						start_time.innerHTML = tmp.begin_time;
						end_time.innerHTML = tmp.end_time;
						
						// HTML에 요소 삽입				
						div.appendChild(task_name);
						div.appendChild(colon);
						div.appendChild(start_time);
						div.appendChild(tilde);
						div.appendChild(end_time);
						document.getElementById("record").appendChild(div);
					 });
					// 조회날짜에 학습시간 얻어오기 위한 처리
						var study_time = "";
						var ref = firebase.database().ref('user_time/' +  id  + '/' + dateStr);
						ref.once("value").then(function(snapshot) { 
							study_time = snapshot.child("user_time").val(); 
							var study = document.createElement("div");
							study.innerHTML = "학습시간 : " + study_time;
							study.setAttribute("style", "font-family:'Jua', sans-serif;font-size:20px;color:navy;");
							document.getElementById("record").appendChild(study);
						});
			    });
			}
		</script>
		</div>
		<!--/ SECTION -->

    <!-- Bootstrap core JavaScript -->
    <script src="bootstrap/general/vendor/jquery/jquery.min.js"></script>
    <script src="bootstrap/general/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="bootstrap/general/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom JavaScript for this theme -->
    <script src="bootstrap/general/js/scrolling-nav.js"></script>
  </body>
</html>