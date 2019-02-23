<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>관리자 페이지</title>
		<style>
			@import url('https://fonts.googleapis.com/css?family=Black+Han+Sans|Jua');
			#infotable, tr, td
			{
				border: 3px solid black;
				border-collapse: collapse;
				padding: 10px;
				text-align: center;
				font-family:'Jua', sans-serif;
				margin-left: auto;
				margin-right: auto;
				text-align: center;
			}
		</style>
	</head>
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
	
		<!-- HEADER -->
		<header>
			<h1 style="text-align:center;font-family:'Jua', sans-serif;">스터디원 관리</h1>
		</header>
		<!--/ HEADER -->
		
		<!-- SECTION -->
		<section>
			<table id="infotable">
				<tr>
					<td>ID</td>
					<td>이름</td>
					<td>학년</td>
					<td>전공</td>
					<td>성별</td>
					<td>관심사</td>
					<td>접속시간</td>
					<td>관리</td>
				</tr>
			</table>
		</section>
		
		<script>
			allUserdata();
			function del_click(id) 
			{
				var user_data = firebase.database().ref('user_data/' + id);
				user_data.remove();
				
				var user_profile = firebase.database().ref('user_profile/' + id);
				user_profile.remove();
				
				var user_log = firebase.database().ref('user_log/' + id);
				user_log.remove();
				
				var user_post = firebase.database().ref('user_post/' + id);
				user_post.remove();
				
				var user_time = firebase.database().ref('user_time/' + id);
				user_time.remove();
				
				alert("대상 사용자를 삭제하였습니다.");
	
			}
			
			function allUserdata() 
			{
				var user_data = firebase.database().ref('user_data');
				user_data.once('value', function(snapshot) {
					snapshot.forEach(function(childSnapshot) {
						var tmp = childSnapshot.val();
						allUserProfile(tmp.user_id, tmp.last_login);
					});
				});
			}
			
			function allUserProfile(id, time) 
			{
				table = document.getElementById("infotable");
				var user_data = firebase.database().ref('user_profile/' + id);
				user_data.once('value', function(snapshot) {
					var tmp = snapshot.val();
	
					new_tr = document.createElement("tr");
	
					td_id = document.createElement("td");
					td_id.innerHTML = id;
					new_tr.appendChild(td_id);
	
					td_name = document.createElement("td");
					td_name.innerHTML = tmp.name;
					new_tr.appendChild(td_name);
	
					td_grade = document.createElement("td");
					td_grade.innerHTML = tmp.grade;
					new_tr.appendChild(td_grade);
	
					td_major = document.createElement("td");
					td_major.innerHTML = tmp.major;
					new_tr.appendChild(td_major);
	
					td_sex = document.createElement("td");
					td_sex.innerHTML = tmp.gender;
					new_tr.appendChild(td_sex);
	
					td_h = document.createElement("td");
					td_h.innerHTML = tmp.interest;
					new_tr.appendChild(td_h);
	
					td_time = document.createElement("td");
					td_time.innerHTML = time;
					new_tr.appendChild(td_time);
	
					del_btn = document.createElement("input");
					del_btn.setAttribute("type", "button");
					del_btn.setAttribute("onclick", "del_click(" + id + ")");
					del_btn.setAttribute("value", "삭제");
					new_tr.appendChild(del_btn);
	
					table.appendChild(new_tr);
				});
			}
		</script>
	</body>
</html>