<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<!-- HEAD -->
	<head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	    <meta name="description" content="signup page">
	    <meta name="author" content="YOOK DONGHYUN">
	    
	    <title>회원가입</title>
	    
	    <!-- Bootstrap core CSS -->
	    <link href="bootstrap/profile/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	    
	    <!-- Custom fonts for this template -->
	    <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700" rel="stylesheet">
	    <link href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i" rel="stylesheet">
	    <link href="bootstrap/profile/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
	    
	    <!-- Custom styles for this template -->
	    <link href="bootstrap/profile/css/resume.min.css" rel="stylesheet">
	    
	    <!-- CSS Style Sheet -->
	    <style>
	    @import url('https://fonts.googleapis.com/css?family=Black+Han+Sans|Jua');
		.juaFont { font-family: 'Jua', sans-serif; }
	    td 
	    { 
	    	padding: 5px; 
	    	font-size: 20px; 
	    	color: black;  
	    }
	    </style>
	    
	    <!-- jQuery import -->
		<script src="jQuery/jquery-1.10.1.js"></script>
	</head>
	<!--/ HEAD -->

	<!-- BODY -->
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
		
		<!-- SECTION -->
	  	<section class="resume-section p-3 p-lg-5 d-flex d-column" id="about">
        	<div class="my-auto">
	        	<!-- FORM -->
				<form name="profile" method="GET">
					<table>
						<!-- ID -->
						<tr>
							<td class="juaFont">아이디</td>
							<td><input class="juaFont" type="text" id = "id" name="username"></td>
							<td><input class="juaFont btn" style="background-color:rgba(0,46,102,0.8);color:white;" type="button" onclick="mycheck()" id="check" value="중복확인"></td>
						</tr>
						<!-- PASSWORD -->
						<tr>
							<td class="juaFont">비밀번호</td>
							<td><input class="juaFont" type="password" id="pw" name="pw"></td>
						</tr>
						<!-- NAME -->
						<tr>
							<td class="juaFont">이름</td>
							<td><input class="juaFont" type="text" id="name"></td>
						</tr>
						<!-- GENDER -->
						<tr>
							<td class="juaFont">성별</td>
							<td>
								<label class="juaFont">남자</label>
								<input type="radio" value="남자" name="gender" class="juaFont" id="sex">&nbsp;&nbsp;
								<label class="juaFont">여자</label>
								<input type="radio" value="여자" name="gender" class="juaFont" id="sex">
							</td>
						</tr>
						<!-- MAJOR -->
						<tr>
							<td class="juaFont">전공</td>
							<td><input class="juaFont" type="text" id="major"></td>
						</tr>
						<!-- GRADE -->
						<tr>
							<td class="juaFont">학년</td>
							<td>
								<input type="text" list="grades" id="grade" class="juaFont">
								<datalist id="grades">
									<option value="1학년">
									<option value="2학년">
									<option value="3학년">
									<option value="4학년">
									<option value="졸업생">
									<option value="휴학생">
								</datalist>
							</td>
						</tr>
						<!-- INTEREST -->
						<tr>
							<td class="juaFont">관심사</td>
							<td><input class="juaFont" type="text" id="interest"></td>
						</tr>
					</table>   
				</form>
				<!--/ FORM -->
        	</div>
      	</section>
		
		<!-- NAVIGATION -->
	    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="sideNav" style="background-color:rgba(0,46,102,0.8);">
	      <a class="navbar-brand js-scroll-trigger" href="#page-top">
	        <span class="d-none d-lg-block">
	          <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="bootstrap/profile/img/profile.jpg" alt="">
	        </span>
	      </a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="navbar-toggler-icon"></span>
	      </button>
	      <div class="collapse navbar-collapse" id="navbarSupportedContent">
	        <ul class="navbar-nav">
	          <li class="nav-item">
	            <a class="nav-link juaFont" href="#" onclick="signup()">저장하기</a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link juaFont" href="#" onclick="goMain()">메인으로</a>
	          </li>
	        </ul>
	      </div>
	  	</nav>
      	<!--/ NAVIGATION -->
      
      	<!--  JAVA SCRIPT -->
		<script>
			function goMain()  {  location.href = "main.jsp"; }
			
			/* 현재날짜 */
			function getTimeStamp() 
			{
				var d = new Date();
				var s = leadingZeros(d.getFullYear(), 4) + '-'
						+ leadingZeros(d.getMonth() + 1, 2) + '-'
						+ leadingZeros(d.getDate(), 2) + ' ' +
						leadingZeros(d.getHours(), 2) + ':'
						+ leadingZeros(d.getMinutes(), 2) + ':'
						+ leadingZeros(d.getSeconds(), 2);
				return s;
			}
			
			function timeStamp()
			{
				var d = new Date();
				var s = leadingZeros(d.getFullYear(), 4)
						+ leadingZeros(d.getMonth() + 1, 2)
						+ leadingZeros(d.getDate(), 2);
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
	
			var user_data = firebase.database().ref('user_data'); // user_data 테이블 가져옴
			var data = new Array();
			user_data.on('value', function(snapshot) {
				data.splice(0, data.length); // 배열초기화
				snapshot.forEach(function(childSnapshot) {
					var childData = childSnapshot.val();
					data.push(childData.user_id);
				});
			});
	
			/* 회원가입 */
			function signup() 
			{
				var id = document.getElementById("id").value
				var pw = document.getElementById("pw").value;
				var gender = document.profile.gender.value;
				var name = document.getElementById("name").value;
				var major = document.getElementById("major").value;
				var grade = document.getElementById("grade").value;
				var interest = document.getElementById("interest").value;
	
				if (document.getElementById("id").disabled) 
				{
					// user_data create
					var user_data = firebase.database().ref('user_data/' + id);
					user_data.set
					({
						user_id : id,
						user_pw : pw,
						last_login : getTimeStamp()
					});
	
					// user_profile create
					var user_profile = firebase.database().ref('user_profile/' + id);
					user_profile.set
					({
						name : name,
						gender : gender,
						major : major,
						grade : grade,
						interest : interest
					});
					
					var user_time = firebase.database().ref('user_time/' + id + '/' + timeStamp());
					user_time.set({
						user_time : "0초",
						user_flag : "false"
					});
					
					location.href = "main.jsp";
					alert("회원가입이 완료되었습니다");
				} 
				else
					alert("아이디 중복확인을 눌러주세요");
			}
	
			/* 중복확인 */
			function mycheck() 
			{
				var id = $("#id").val();
				var checked = 0;
	
				data.forEach(function(tmp) {
					if (tmp == id) 
					{
						alert("이미 사용중인 아이디입니다");
						checked = 1;
					}
				});
	
				if (checked == 0) 
				{
					alert("사용 가능한 아이디입니다");
					document.getElementById("id").disabled = true;
				}
			}
		</script>
      
	    <!-- Bootstrap core JavaScript -->
	    <script src="bootstrap/profile/vendor/jquery/jquery.min.js"></script>
	    <script src="bootstrap/profile/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	    <!-- Plugin JavaScript -->
	    <script src="bootstrap/profile/vendor/jquery-easing/jquery.easing.min.js"></script>
	    
	    <!-- Custom scripts for this template -->
	    <script src="bootstrap/profile/js/resume.min.js"></script>
  	</body>
  	<!--/ BODY -->
</html>