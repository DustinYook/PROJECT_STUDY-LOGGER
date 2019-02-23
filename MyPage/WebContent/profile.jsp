<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<!-- HEAD -->
	<head>
	    <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	    <meta name="description" content="">
	    <meta name="author" content="YOOK DONGHYUN">
	    
	    <title>회원정보</title>
	    
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
	    		padding: 5px 15px; 
	    		font-size: 20px; 
	    		color:black;
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
	        	<% String id = (String)session.getAttribute("id"); %>
	        	<h3 class="juaFont"><%= id %>님 반갑습니다!</h3><hr>
				<table>
					<!-- ID -->
					<tr>
						<td class="juaFont">아이디</td>
						<td><span class="juaFont" id="login_id"></span></td>
					</tr>
					<!-- NAME -->
					<tr>
						<td class="juaFont">이름</td>
						<td><input class="juaFont" type="text" id="name"></td>
					</tr>
					<!-- MAJRO -->
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
					<!-- GENDER -->
					<tr>
						<td class="juaFont">성별</td>
						<td>
							<form name="genderForm">
								<label class="juaFont">남자</label>
								<input type="radio" value="남자" name="gender" class="jua" id="sex">&nbsp;&nbsp;
								<label class="juaFont">여자</label>
								<input type="radio" value="여자" name="gender" class="jua" id="sex">
							</form>
						</td>
					</tr>
					<!-- INTEREST -->
					<tr>
						<td class="juaFont">관심사</td>
						<td><input class="juaFont" type="text" id="interest"></td>
					</tr>
					<!-- STUDY TIME -->
					<tr>
						<td class="juaFont">학습시간</td>
						<td><span class="juaFont" id="time"></span></td>
					</tr>
					<!-- STUDY MEMBER -->
					<tr>
						<td class="juaFont">스터디멤버</td>
						<td><span class="juaFont" id="list"></span></td>
					</tr>
				</table>
        	</div>
      	</section>
		
		<!-- JAVA SCRIPT -->
  		<script>
  			var id = "<%= id %>";
  			document.getElementById("login_id").innerHTML = id;

			var user_data = firebase.database().ref('user_data/' + id);
			user_data.once('value', function(snapshot) {
			    snapshot.forEach(function(childSnapshot) {
			      var tmp = childSnapshot.val();
			      if(tmp.user_id==id)
			        document.getElementById("last").innerHTML = tmp.last_login;
			    });
			  });

			 /* 현재시간 */
			 function getTimeStamp() 
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
			
			var user_ref = firebase.database().ref('user_profile/'+id);
			user_ref.on('value', function(snapshot) {
					    var tmp = snapshot.val();
						    document.getElementById("name").value = tmp.name;
			  			    document.genderForm.gender.value = tmp.gender;
			  			    document.getElementById("major").value = tmp.major;
			  			    document.getElementById("grade").value = tmp.grade;
			  			    document.getElementById("interest").value = tmp.interest;
					  });
			
			var user_time = firebase.database().ref('user_time/' + id + '/' + getTimeStamp());
			var arry = new Array();
			user_time.on('value', function(snapshot) {
			    var tmp = snapshot.val();
			    console.log(tmp);
			    arry.push(tmp.user_time);
				document.getElementById("time").innerHTML = arry;
			  });
		  
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
			
			var id = getParameterByName('user_id');
			var user_data = firebase.database().ref('user_data');
			var arr = new Array();
			user_data.on('value', function(snapshot) {
				snapshot.forEach(function(childSnapshot) {
						var temp = childSnapshot.val();
						arr.push(temp.user_id);
						document.getElementById("list").innerHTML = arr;
				});
			});
			
			/* 게시판 이동 */
			function goBoard()
			{
				location.href = "board.jsp?user_id=" + "<%= id %>";
			}

			/* 학습기록 이동 */
			function goRecord()
			{
				location.href = "record.jsp?user_id=" + "<%= id %>";
			}
  		</script> 
  		<!--/ JAVA SCRIPT -->
  		
		<!-- NAVIGATION -->
	    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="sideNav" style="background-color:rgba(0,46,102,.8);">
	      
	      <!-- PHOTO -->
	      <a class="navbar-brand js-scroll-trigger" href="#page-top">
	        <span class="d-block d-lg-none" id="login_id"></span>
	        <span class="d-none d-lg-block">
	          <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="bootstrap/profile/img/profile.png" alt="my photo">
	        </span>
	      </a>
	      <!--/ PHOTO -->
	      
	      <!-- MENU -->
	      <div class="collapse navbar-collapse" id="navbarSupportedContent">
	        <ul class="navbar-nav">
	          <li class="nav-item">
	            <a class="nav-link juaFont" href="#" onclick="goRecord()" id="disableTarget">로그작성</a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link juaFont" href="#" onclick="goShowRecord()">로그조회</a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link juaFont" href="#" onclick="goBoard()">인증하기</a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link juaFont" href="#" onclick="updateAccount()">정보수정</a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link juaFont" href="#" onclick="removeAccount()">회원탈퇴</a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link juaFont" href="#" onclick="logout()">로그아웃</a>
	          </li>
	        </ul>
	      </div>
	      <script>
		      /* 계정삭제 */
			  function removeAccount()
			  {
				    var ret = confirm("정말 탈퇴하시겠습니까?");
				    if(ret)
				    {
				    	var rmv_data = firebase.database().ref('user_data/' + '<%= id %>');
				    	var rmv_profile = firebase.database().ref('user_profile/' + '<%= id %>');
				    	var rmv_post = firebase.database().ref('user_post/' + '<%= id %>');
				    	var rmv_log = firebase.database().ref('user_log/' + '<%= id %>');
				    	var rmv_time = firebase.database().ref('user_time/' + '<%= id %>');
				    	
				    	rmv_data.remove();
				    	rmv_profile.remove();
				    	rmv_post.remove();
				    	rmv_log.remove();
				    	rmv_time.remove();
				    	
						alert("탈퇴되었습니다");
						location.href = "main.jsp";
				    }
				    else
				    	alert("탈퇴가 취소되었습니다");
			  }
	
			  /* 정보수정 */
			  function updateAccount()
			  {
			  	var _name = document.getElementById("name").value; // 이름
				var _gender = document.genderForm.gender.value; // 성별
				var _major = document.getElementById("major").value; // 전공
				var _grade = document.getElementById("grade").value; // 학년
				var _interest = document.getElementById("interest").value; // 관심사
					
				// 변경 확인 다이얼로그 띄움
					var ret = confirm("정말 수정하시겠습니까?");
				    if(ret)
				    {
				    	var edit = firebase.database().ref('user_profile/' + '<%= id %>');
						edit.update
						({ 
							name: _name,
							gender: _gender,
							major: _major,
							grade: _grade,
							interest: _interest
						});
						alert("수정이 완료되었습니다");
						location.href = "profile.jsp?user_id=" + "<%= id %>";
				    }
				    else
				    	alert("수정이 취소되었습니다.");
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

		  /* 로그조회 */
          function goShowRecord() 
          { 
          	location.href = "showLog.jsp?user_id=" + "<%= id %>";
          }
			
		  /* 로그아웃 */
		  function logout() { location.href = "main.jsp"; }
	      </script>
	  	</nav>
      	<!--/ NAVIGATION -->
      
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