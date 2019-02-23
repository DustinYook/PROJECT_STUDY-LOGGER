<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<!-- HEAD -->
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="study log maker">
		<meta name="author" content="YOOK DONGHYUN">
		
		<title>스터디로거</title>
		
		<!-- Bootstrap core CSS -->
		<link href="bootstrap/main/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Custom fonts for this template -->
		<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:200,200i,300,300i,400,400i,600,600i,700,700i,900,900i" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Merriweather:300,300i,400,400i,700,700i,900,900i" rel="stylesheet">
		<link href="bootstrap/main/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
		
		<!-- Custom styles for this template -->
		<link href="bootstrap/main/css/coming-soon.min.css" rel="stylesheet">
		
		<!-- CSS Style Sheet -->
		<style>
			@import url('https://fonts.googleapis.com/css?family=Black+Han+Sans|Jua');
			#jua1, #jua2 { font-family: 'Jua', sans-serif; }
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
	
		<!-- Background Video -->
		<div class="overlay"></div>
		<video autoplay="autoplay" muted="muted"
			loop="loop">
			<source src="bootstrap/main/mp4/bg.mp4" type="video/mp4">
		</video>
	
		<div class="masthead">
			<div class="masthead-bg"></div>
			<div class="container h-100">
				<div class="row h-100">
					<div class="col-12 my-auto">
						<div class="masthead-content text-white py-5 py-md-0">
							<h1 id="jua1">스터디로거</h1>
							<p id="jua2" class="mb-6">
								스터디로거에서 학습시간을 기록하고<br>
								학습인증게시판을 통해 스터디모임을 관리하세요!<br>
								회원가입 후 무료로 서비스를 이용하세요!
							</p>
							<div class="input-group input-group-newsletter">
								<!-- FORM -->
								<form id="login" method="POST">
									<table>
										<tr>
											<td><input type="text" id="id" class="form-control" placeholder="아이디 입력" style="font-family:'Jua',sans-serif;text-align:center;width:300px;font-size:20px;"></td>
										</tr>
										<tr>
											<td><input type="password" id="pw" class="form-control" placeholder="비밀번호 입력" style="font-family:'Jua',sans-serif;text-align:center;width:300px;font-size:20px;"></td>
										</tr>
										<tr>
											<td>
												<input class="btn btn-secondary" type="button" name="id" onclick="login()" value="로그인" style="font-family: 'Jua', sans-serif; width:145px;font-size:20px;">
												<input class="btn btn-secondary" type="reset" name="pw" onclick="goSignUp()" value="회원가입" style="font-family: 'Jua', sans-serif;width:150px;font-size:20px;">
											</td>
										</tr>
									</table>
								</form>
								<!--/ FORM -->
								<!-- JAVA SCRIPT -->
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
									
									/* 포멧지정  */
									function leadingZeros(n, digits) 
									{
										var zero = '';
										n = n.toString();
										if (n.length < digits)
											for (i = 0; i < digits - n.length; i++)
												zero += '0';
										return zero + n;
									}
									
									/* 로그인시간 업데이트 */
									function updatelogInTime(id, pw) 
									{
										var user_ref = firebase.database().ref("user_data/" + id);
										user_ref.set
										({
											user_id : id,
											user_pw : pw,
											last_login : getTimeStamp()
										});
									}
									
									/* 로그인 */
									function login() 
									{
										// 입력필드에서 값을 받아옴
										var id = $("#id").val(); 
										var pw = $("#pw").val();
										var user_data = firebase.database().ref('user_data');
										user_data.once('value', function(snapshot) {
											snapshot.forEach(function(childSnapshot) {
												var tmp = childSnapshot.val();
												if (tmp.user_id == id) 
												{
													if (tmp.user_pw == pw) 
													{
														if(tmp.user_id == "12345")
															alert("관리자 계정으로 로그인되었습니다");
														else
															alert("로그인 되었습니다");
														
														updatelogInTime(id, pw);
														
														var form = $("#login");
														form.attr("action", "./Login?id=" + id + "&&pw=" + pw);
														form.submit(); // form 제출  -> Login.java로 이동 -> Servlet에 의해 처리
													} 
													else
														alert("비밀번호가 일치하지 않습니다");
												}
											});
										});
									}
									
									/* 회원가입으로 이동 */
									function goSignUp() { location.href = "signup.jsp"; }
								</script>
								<!--/ JAVA SCRIPT -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- DEVELOPER CONTACT INFORMATION -->
		<div class="social-icons">
	      <ul class="list-unstyled text-center mb-0">
	        <li class="list-unstyled-item">
	          <a href="https://github.com/DustinYook">
	            <i class="fab fa-github"></i>
	          </a>
	        </li>
	        <li class="list-unstyled-item">
	          <a href="https://www.facebook.com/DustinYook">
	            <i class="fab fa-facebook-f"></i>
	          </a>
	        </li>
	        <li class="list-unstyled-item">
	          <a href="https://www.instagram.com/dustin_yook/">
	            <i class="fab fa-instagram"></i>
	          </a>
	        </li>
	      </ul>
	    </div>
	    <!--/ DEVELOPER CONTACT INFORMATION -->
	
		<!-- Bootstrap core JavaScript -->
		<script src="bootstrap/main/vendor/jquery/jquery.min.js"></script>
		<script src="bootstrap/main/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
		<!-- Custom scripts for this template -->
		<script src="bootstrap/main/js/coming-soon.min.js"></script>
	</body>
	<!--/ BODY -->
</html>