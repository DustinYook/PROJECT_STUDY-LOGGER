<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<!-- HEAD -->
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="record log">
		<meta name="author" content="YOOK DONGHYUN">
		
		<title>로그작성</title>
		
		<!-- Bootstrap Core CSS -->
		<link href="bootstrap/record/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Custom Fonts -->
		<link href="bootstrap/record/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
		<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
		<link href="bootstrap/record/vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet">
		
		<!-- Custom CSS -->
		<link href="bootstrap/record/css/stylish-portfolio.min.css" rel="stylesheet">
		
		<!-- CSS Style Sheet -->
		<style>
		@import url('https://fonts.googleapis.com/css?family=Black+Han+Sans|Jua');
		.juaFont { font-family:'Jua', sans-serif; }
		</style>
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
		<!--/ FIREBASE IMPORT -->
	
		<!-- Navigation -->
		<a class="menu-toggle rounded" href="#"> <i class="fas fa-bars"></i></a>
		<nav id="sidebar-wrapper">
			<!-- SECTION #1 -->
			<section>
				<!-- ARTICLE #1 -->
				<article id="clock">	
					<br><br><br><br><br>
					<h1 class="juaFont" style="text-align:center;color:white;">현재시간</h1>
					<!-- ANALOG CLOCK -->
					<canvas id="myCanvas" width="300px" height="200px"></canvas>
					<br>
					<script>
						var canvas = document.getElementById("myCanvas"); // canvas 요소 받아오기
						var context = canvas.getContext("2d"); // context 객체 받아오기
						
						var intervalId = 0;	            
						var now; // 현재시간
						
						var x = 125;
						var y = 100;
						var r = 70;
						
						// 1) 시침 설정	            
						var hour; // 시간	        
						var hourAngle; // 시침의 각도	            
						var hourX, hourY; // 시침의 좌표
		
						// 시침을 그리는 함수
						function drawHourClockHands()
						{
							now = new Date(); // 현재시간 담을 변수
							hour = now.getHours(); // 시간을 가져옴
							hourAngle = (hour / 12 * 2.0 * Math.PI) - (Math.PI / 2);
							hourX = x + Math.cos(hourAngle) * r * 0.8;
							hourY = y + Math.sin(hourAngle) * r * 0.8;
							
							// 시침 그리기
							context.beginPath();
							context.moveTo(x, y); // 원의 중심으로 이동
							context.lineTo(hourX, hourY);
							context.strokeStyle = "black";
							context.stroke(); // 화면출력
						}
	
						// 2) 분침 설정
						var min; // 분
						var minAngle; // 분침의 각도
						var minX, minY; // 분침의 좌표
		
						// 분침을 그리는 함수
						function drawMinClockHands()
						{
							now = new Date(); // 현재시간 담을 변수
							min = now.getMinutes(); // 초를 가져옴
							minAngle = (min / 60) * 2.0 * Math.PI - Math.PI / 2;
							minX = x + Math.cos(minAngle) * r;
							minY = y + Math.sin(minAngle) * r;
							
							// 분침 그리기
							context.beginPath();
							context.moveTo(x, y); // 원의 중심으로 이동
							context.lineTo(minX, minY);
							context.strokeStyle = "black";
							context.stroke(); // 화면출력
						}
						
						// 3) 초침 설정
						var sec; // 초
						var secX, secY; // 초침의 각도
						var secAngle; // 초침의 좌표
		
						// 초침을 그리는 함수
						function drawSecClockHands()
						{
							now = new Date(); // 현재시간 담을 변수
							sec = now.getSeconds(); // 초를 가져옴
							secAngle = (sec / 60) * 2.0 * Math.PI - Math.PI / 2;
							secX = x + Math.cos(secAngle) * r;
							secY = y + Math.sin(secAngle) * r;
							
							// 초침 그리기
							context.beginPath();
							context.moveTo(x, y); // 원의 중심으로 이동
							context.lineTo(secX, secY);
							context.strokeStyle = "red"
							context.lineWidth = "2";
							context.stroke(); // 화면출력
						}
						
						// 4) 시계바늘을 그리는 함수
						function drawClockHands()
						{
							drawHourClockHands();
							drawMinClockHands();
							drawSecClockHands();
						}
						
						// 5) 시계판을 그리는 함수
						function drawCircle()
						{
							context.beginPath(); // context 초기화
							context.arc(x, y, r, 0, 2.0 * Math.PI, true); // 원을 그림
							context.fillStyle = "white"; // 색깔 채움
							context.strokeStyle = "black"; // 선 색 지정
							context.lineWidth = "2"; // 선 두께 지정
							context.closePath(); // 닫힌 도형 생성 
							context.fill(); // 색칠하기 (먼저 closePath해야 함)
							context.stroke(); // 선 그리기
						}
							       
						// 6) 시계를 구동하는 함수
						function init()
						{
							context.clearRect(0, 0, 300, 300); // 초기화
							drawCircle(); // 시계판 그림
							drawClockHands(); // 시계바늘 그림
							intervalId = setInterval(init, 1000);
						}
		
						init();	        
					</script>
				</article>
				<!--/ ARTICLE #1 -->
	
				<!-- ARTICLE #2 -->
				<article style="text-align:center;margin-left:auto;margin-right:auto;">
					<!-- DIGITAL CLOCK -->
					<time id="timer"></time>
					<script>
				        var time;
		
				        function getNow()
				        {
				        	var now = new Date(); // 현재시간을 받아옴
				        	var hr = now.getHours(); // 시간
				        	var min = now.getMinutes(); // 분
				        	var sec = now.getSeconds(); // 초
				        	var obj = document.getElementById("timer");
				        	
				        	obj.innerHTML = hr + "시 " + (min < 10 ? "0" + min : min) + "분 "  + (sec < 10 ? "0" + sec : sec) + "초";
				        	obj.setAttribute("style", "font-family:'Jua',sans-serif;font-size:30px;color:white;padding:20px;");
				        	
				        	setInterval(getNow, 1000);
				        }
				        getNow();
			        </script>
				</article>
				<!--/ ARTICLE #2 -->
			</section>
			<!--/ SECTION #1 -->
		</nav>
		<!--/ NAVIGATION -->
	
		<!-- HEADER -->
		<header class="masthead d-flex">
			<div class="container text-center my-auto">
				<h1 class="mb-1 juaFont">학습로그 작성</h1>
				<h3 class="mb-5 juaFont">
					<em>학습로그를 작성하고 나의 학습기록을 스터디그룹에 자랑하세요!</em>
				</h3>
				<a class="btn btn-primary btn-xl js-scroll-trigger" href="#about" style="font-family:'Jua', sans-serif;font-size:20px;">작성하기</a>
				<a class="btn btn-primary btn-xl js-scroll-trigger" onclick="goProfile()" href="#" style="font-family:'Jua', sans-serif;font-size:20px;">뒤로가기</a>
			</div>
			<div class="overlay"></div>
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
		    
		    function getTimeStamp() 
            {
            	var d = new Date();
            	var s = leadingZeros(d.getFullYear(), 4)
            			+ leadingZeros(d.getMonth() + 1, 2)
            			+ leadingZeros(d.getDate(), 2);
            	return s;
            }

            function leadingZeros(n, digits) 
            {
            	var zero = '';
            	n = n.toString();

            	if (n.length < digits)
            		for (i = 0; i < digits - n.length; i++)
            			zero += '0';
            	return zero + n;
            }
		    
	        function goProfile() 
	        { 
	        	//location.href = "profile.jsp?user_id=" + id;
	        	location.href = "profile.jsp";
	        	//var ret = confirm("페이지를 떠나면 오늘은 더 이상 로그 작성이 불가능합니다.\n그래도 떠나시겠습니까?");
            	//if (ret) 
            	//{
        			//var id = getParameterByName('user_id');
                	//var user_time = firebase.database().ref('user_time/' + id + '/' + getTimeStamp());
                	//user_time.update({ user_flag : "true" });
                	
            	//} 
            	//else
            	//	alert("페이지 이동이 취소되었습니다");
	        }
	    </script>
		</header>
		<!--/ HEADER -->
	
		<section class="content-section bg-light" id="about" style="height:800px;">
			<div class="container text-center">
				<!-- ARTICLE #2 -->
				<article id="log">
					<h1 class="juaFont" style="font-size:70px;">학습로그</h1>
					<div>
						<input class="juaFont" type="text" id="task" placeholder="업무내용" style="text-align: center;font-size:23px;width:300px">&nbsp; 
						<input class="juaFont btn btn-primary" type="button" id="btn" value="기록하기" onclick="ctrl()" style="text-align: center;font-size:21px;"> 
						<br><br>
					</div>
					<div id="taskLog" class="juaFont" style="font-size:25px;"></div>
					<script>
		                var beginCnt = 0; // begin에 id 번호 부여
		                var endCnt = 0; // end에 id 번호 부여
		                var flag = true; // 흐름을 제어하기 위한 플래그
		                var begin_time = ""; // 시작시간
		                var end_time = ""; // 끝 시간
		                var task_name = ""; // 업무이름
						var result = 0;
		                var temp = 0;
		                var acc_time = "";
		                var study_duration = "";
		                var timeArry = new Array();
		                
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
		
		                function getTimeStamp() 
		                {
		                	var d = new Date();
		                	var s = leadingZeros(d.getFullYear(), 4)
		                			+ leadingZeros(d.getMonth() + 1, 2)
		                			+ leadingZeros(d.getDate(), 2);
		                	return s;
		                }
		
		                function leadingZeros(n, digits) 
		                {
		                	var zero = '';
		                	n = n.toString();
		
		                	if (n.length < digits)
		                		for (i = 0; i < digits - n.length; i++)
		                			zero += '0';
		                	return zero + n;
		                }
		
		                /* 기록제어 */
		                function ctrl() 
		                {
		                	// 논리상으로는 문제가 없고 실제로도 동작하나 응답시간이 많이 느려 일단 주석으로 처리했습니다.
		                	//var id = getParameterByName("user_id"); 
		                	//var ref = firebase.database().ref('user_time/' + id + '/' + getTimeStamp());
		                	//ref.on("value", function(snapshot) {
		                	  // var temp = snapshot.val();
		                	   //if(temp.user_flag == "false")		                	   
		                	   //{
		                		    if (flag) 
				                	{
				                		flag = !flag; // flip
				                		document.getElementById("btn").value = "기록완료";
				                		insertBegin();
				                	} 
				                	else 
				                	{
				                		if (document.getElementById("task").value) // 입력이 NULL인지 확인
				                		{
				                			flag = !flag; // flip
				                			document.getElementById("btn").value = "기록시작";
				                			insertEnd();
				                			document.getElementById("task").value = ""; // 입력박스 초기화
				                		} else
				                			alert("내용이 입력되지 않았습니다!");
				                	}
		                	   //}
		                	   //else
		                		 //  alert("오늘은 로그를 작성할 수 없습니다");
		                	//}, function (error) {
		                	 //  console.log("Error: " + error.code);
		                	//});
		                }
		
		                /* 시작시간 입력 */
		                function insertBegin() 
		                {
		                	var now = new Date(); // 현재시간
		                	
		                	var log = document.createElement("div"); // 컨테이너
		                	log.setAttribute("id", "log" + beginCnt);
		                	log.setAttribute("style", "margin: 5px;");
		
		                	var begin = document.createElement("span"); // 시작시간
		                	begin_time = ((now.getHours() < 10) ? "0" : "") + now.getHours() + ":" 
		                					+ ((now.getMinutes() < 10) ? "0" : "") + now.getMinutes() 
		                					+ ":" + ((now.getSeconds() < 10) ? "0" : "") + now.getSeconds();
		                	begin.setAttribute("id", "begin" + beginCnt);
		                	begin.innerHTML = ((now.getHours() < 10) ? "0" : "") + now.getHours() + ":";
		                	begin.innerHTML += ((now.getMinutes() < 10) ? "0" : "") + now.getMinutes();
		                	begin.innerHTML += ":" + ((now.getSeconds() < 10) ? "0" : "") + now.getSeconds();
		                	begin.setAttribute("style", "font-weight:bold;color:black;");
		                	
		                	var tilde = document.createTextNode("~"); // 틸드
		
		                	// 로그 한 줄에 삽입
		                	log.appendChild(begin);
		                	log.appendChild(tilde);
		
		                	// 전체 로그에 삽입
		                	document.getElementById("taskLog").appendChild(log);
		                	
		                	var id = getParameterByName('user_id');
		                	var today = getTimeStamp();
		                	
		                	/* 세팅 */
		                	var user_log = firebase.database().ref('user_log/' + id + '/' + today + '/log' + beginCnt);
		                	user_log.set
		                	({
		                		begin_time : begin_time,
		                		end_time : end_time,
		                		task_name : task_name,
		                		study_duration : study_duration
		                	});
		
		                	beginCnt++;
		                }
		
		                /* 종료시간 입력 */
		                function insertEnd() 
		                {
		                	var now = new Date(); // 현재시간
		                	
		                	var end = document.createElement("span"); // 종료시간
		                	end_time = ((now.getHours() < 10) ? "0" : "") + now.getHours() + ":" 
		                				+ ((now.getMinutes() < 10) ? "0" : "") + now.getMinutes()
		                				+ ":" + ((now.getSeconds() < 10) ? "0" : "") + now.getSeconds();
		                	end.setAttribute("id", "end" + endCnt);
		                	end.innerHTML = ((now.getHours() < 10) ? "0" : "") + now.getHours() + ":";
		                	end.innerHTML += ((now.getMinutes() < 10) ? "0" : "") + now.getMinutes();
		                	end.innerHTML += ":" + ((now.getSeconds() < 10) ? "0" : "") + now.getSeconds();
		                	end.setAttribute("style", "font-weight:bold;color:black;");
		                	
		                	var cmt = document.createTextNode("  //  "); // 주석표시
		                	
		                	var task = document.createElement("span"); // 업무설명
		                	task.setAttribute("id", "task" + endCnt);
		                	task.innerHTML = document.getElementById("task").value + "&nbsp;&nbsp;";
		                	task_name = document.getElementById("task").value;
		                	
		                	var nbsp = document.createTextNode(" "); // 빈칸
		                	
		                    var rmv = document.createElement("input"); // 삭제버튼
		                	rmv.setAttribute("type", "button");
		                	rmv.setAttribute("value", "삭제");
		                	rmv.setAttribute("class", "btn btn-primary");
		                	rmv.setAttribute("id", "rmv" + endCnt);
		                	rmv.addEventListener("click", remove);
		                	
		                	var edit = document.createElement("input"); // 수정버튼
		                	edit.setAttribute("type", "button");
		                	edit.setAttribute("value", "수정");
		                	edit.setAttribute("class", "btn btn-secondary");
		                	edit.setAttribute("id", "edit" + endCnt);
		                	edit.addEventListener("click", editing);
		                	
		                	var br = document.createElement("br"); // 줄바꿈
		                	var hr = document.createElement("hr"); // 수평선
		                	
		                	// 로그 한줄에 삽입
		                	document.getElementById("log" + endCnt).appendChild(end);
		                	document.getElementById("log" + endCnt).appendChild(cmt);
		                	document.getElementById("log" + endCnt).appendChild(task);
		                	document.getElementById("log" + endCnt).appendChild(nbsp);
		                	document.getElementById("log" + endCnt).appendChild(rmv);
		                	document.getElementById("log" + endCnt).appendChild(nbsp);
		                	document.getElementById("log" + endCnt).appendChild(edit);
		                	document.getElementById("log" + endCnt).appendChild(hr);
		                	
		                	var id = getParameterByName('user_id');
		                	var user_log = firebase.database().ref('user_log/' + id + '/' + getTimeStamp() + '/log' + endCnt);
		                	
		                	user_log.update
		                	({
		                		end_time : end_time,
		                		task_name : task_name
		                	});
		                	
		                	// pasing을 함
		                    var beginParse = begin_time.split(":");
		                    var endParse = end_time.split(":");
		                                
		                    // Date 객체 생성하여 시간차이를 구함
		                    var b = new Date("0", "0", "0", beginParse[0], beginParse[1], beginParse[2], "0"); // 시작시간
		                    var e = new Date("0", "0", "0", endParse[0], endParse[1], endParse[2], "0"); // 끝 시간
		                    var diff = (e.getTime() - b.getTime()) / 1000;  //sec 단위로 시간차이 나타냄
		                    
		                    result += diff;
		                    var temp = result;
	
		                    var sec = result % 60;
		                    result -= sec;
		                    result /= 60;
		                    var min = result % 60;
		                    var hr = result / 60;
	
		                    result = temp;
	
		                    var str = (hr.toFixed(0) > 0) ? (hr.toFixed(0) + "시간 ") : "";
		                    str += (min.toFixed(0) > 0) ? (min.toFixed(0) + "분 ") : "";
		                    str += (sec.toFixed(0) > 0) ? (sec.toFixed(0) + "초") : "0초";
		                    acc_time = str;
		                   
		                    user_log.update
		                	({
		                		study_duration : diff
		                	});
		                    timeArry.push(diff);
		                    
		                    calculate();
		                	
		                	endCnt++;
		                }
		                
		                /* 누적학습시간 계산 */
		                function calculate()
		                {
		                	var id = getParameterByName('user_id');
		                	var user_time = firebase.database().ref('user_time/' + id + '/' + getTimeStamp());
		                	user_time.set
		                	({
		                		user_time : acc_time,
		                		user_flag : "false"
		                	});
		                }
		
		                /* 로그삭제 */
		                function remove() 
		                {
		                	var ret = confirm("정말 삭제하시겠습니까?");
		                	if (ret) 
		                	{
		                		var c = this.parentNode;
		                		var p = c.parentNode;
		                		p.removeChild(c);
		                		
		                		var rmvId = this.id; // 삭제할 대상 노드의 id를 받아옴
			                	var parse = rmvId.split("rmv"); // 파싱함
			                	
			                	var id = getParameterByName('user_id');
								var user_log = firebase.database().ref('user_log/' + id + '/' + getTimeStamp() + '/log' + parse[1]);
								user_log.remove();
								
								var time = result - timeArry[Number(parse[1])];
								result = time;
								
								var now_sec = time;
								var hour = now_sec / 3600;
								var min = (now_sec % 3600) / 60;
								var sec = now_sec % 60;
								
								var str = (hour.toFixed(0) > 0) ? (hour.toFixed(0) + "시간 ") : "";
			                    str += (min.toFixed(0) > 0) ? (min.toFixed(0) + "분 ") : "";
			                    str += (sec.toFixed(0) > 0) ? (sec.toFixed(0) + "초") : "0초";
			                    
			                    acc_time = str;
			                    console.log(acc_time);
								
								calculate();
		                	} 
		                	else
		                		alert("삭제되지 않았습니다");
		                }
		
		                /* 로그수정 */
		                function editing() 
		                {
		                	var target = this.parentNode.getElementsByTagName("span")[2];
		                	task_name = prompt("변경할 업무이름을 입력해주세요");
		                	target.innerHTML = task_name + "&nbsp;&nbsp;";
		                	
		                	var editId = this.id;
		                	var parse = editId.split("edit");
		                	
		                	var id = getParameterByName('user_id');
							var user_log = firebase.database().ref('user_log/' + id + '/' + getTimeStamp() + '/log' + parse[1]);
		                	
		                	user_log.update
		                	({
		                		task_name : task_name
		                	});
		                } 
	                </script>
				</article>
				<!--/ ARTICLE #2 -->
			</div>
		</section>
	
		<!-- Bootstrap core JavaScript -->
		<script src="bootstrap/record/vendor/jquery/jquery.min.js"></script>
		<script src="bootstrap/record/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
		<!-- Plug in JavaScript -->
		<script src="bootstrap/record/vendor/jquery-easing/jquery.easing.min.js"></script>
	
		<!-- Custom scripts for this template -->
		<script src="bootstrap/record/js/stylish-portfolio.min.js"></script>
	</body>
	<!--/ BODY -->
</html>