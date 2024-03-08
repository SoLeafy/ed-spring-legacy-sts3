<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>로그인을 해보자</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link rel="apple-touch-icon" sizes="57x57" href="assets/apple-icon-57x57.png">
		<link rel="apple-touch-icon" sizes="60x60" href="assets/apple-icon-60x60.png">
		<link rel="apple-touch-icon" sizes="72x72" href="assets/apple-icon-72x72.png">
		<link rel="apple-touch-icon" sizes="76x76" href="assets/apple-icon-76x76.png">
		<link rel="apple-touch-icon" sizes="114x114" href="assets/apple-icon-114x114.png">
		<link rel="apple-touch-icon" sizes="120x120" href="assets/apple-icon-120x120.png">
		<link rel="apple-touch-icon" sizes="144x144" href="assets/apple-icon-144x144.png">
		<link rel="apple-touch-icon" sizes="152x152" href="assets/apple-icon-152x152.png">
		<link rel="apple-touch-icon" sizes="180x180" href="assets/apple-icon-180x180.png">
		<link rel="icon" type="image/png" sizes="192x192"  href="assets/android-icon-192x192.png">
		<link rel="icon" type="image/png" sizes="32x32" href="assets/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="96x96" href="assets/favicon-96x96.png">
		<link rel="icon" type="image/png" sizes="16x16" href="assets/favicon-16x16.png">
		<link rel="manifest" href="/manifest.json">
		<meta name="msapplication-TileColor" content="#ffffff">
		<meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
		<meta name="theme-color" content="#ffffff">
		<!-- sweetalert -->
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
        <script type="text/javascript">
        $(function(){
        	//cookie 가져오기 = getCookie
        	let userInputId = getCookie("userInputId");
        	let setCookieYN = getCookie("setCookieYN");
        	if(setCookieYN == 'Y') {
	        	$('#id').val(userInputId); //쿠키에서 뽑은 값을 여기 저장.
	        	$('#saveID').prop("checked", "true");
        	}/*  else { // else 필요없을듯하여 빼심
	        	$('#saveID').prop("checked", "false");
        	} */
        	
        	//alert("구동하려면 제이쿼리가 필요함.");
        	//아이디칸, pw칸 검사
        	$('.check').click(function(){ // 로그인 버튼을 누를 때
        		let id = $("#id").val();
        		let pw = $("#pw").val();
        		if(id == '' || id.length < 3) {
        			Swal.fire("잘못된 아이디", '올바른 아이디를 입력하세요.', "error");
        			$("#id").focus();
        			return false;
        		}
        		if(pw == '' || pw.length < 3) {
        			Swal.fire("잘못된 비밀번호", '올바른 비밀번호를 입력하세요.', "error");
        			$("#pw").focus();
        			return false;
        		}
        		//쿠키에 id저장하기 <- 여기 들어가야 한다.
        		//if문으로 사용자가 아이디저장 체크했는지 확인
        		if($("#saveID").is(':checked')) { //checked라는? 속성이,, 눌렸냐
        			//Swal.fire("확인", "아이디 저장을 눌렀어요", "info");
        			//Swal.fire("출력", id+"라고 입력했습니다", "info");
        			setCookie("userInputId", id, 60); //쿠키 저장하는 함수
        			setCookie("setCookieYN", 'Y', 60); // 아이디 저장을 클릭했는지 저장
        		} else {
        			//사용자가 id 저장을 누르지 않음. = 저장 안 함.
        			delCookie('userInputId');
        			delCookie('setCookieYN');
        		}
        		
        		$("#loginForm").submit();
        	});
        });
        
        //쿠키 저장하는 함수 (쿠키이름, 값, 기한)
        function setCookie(cookieName, value, exdays) {
        	//오늘 날짜 뽑기
        	let date = new Date(); //js꺼
        	//Swal.fire(date); Swal은 안된다,,
        	//alert("오늘날짜:"+date.getDate() + "/60더한 날짜 : " +date.getDate()+exdays);
        	//alert(date.setDate(date.getDate()));
        	//alert(date.setDate(date.getDate()) + exdays);
        	date.setDate(date.getDate() + exdays); // 이거를 빼먹으면 안된다.
        	let value2 = escape(value) + "; expires=" + date.toGMTString();
        	//escape() 아스키문자에 해당하지 않는 문자들은 모두 유니코드 형식으로 변환
        	document.cookie = cookieName + "=" + value2; //GMT <- 그리니치평균시
        };
        
        //쿠키값 가져오기(가져올 쿠키 이름)
        function getCookie(cookieName) {
        	let x;
        	let y;
        	//let val = document.cookie;// 컴퓨터에 저장된 모든 쿠키 가져오기.
        	let val = document.cookie.split(';');// .split(';')은 배열로. 쿠키가 여러개면 ;로 구분
        	//let valSplit = document.cookie.split('=');// 배열이 안 나왔나.. 왜 됐지 
        	for(let i = 0; i < val.length; i++) {
        		x = val[i].substr(0, val[i].indexOf('='));//저장한 쿠키이름
        		y = val[i].substr(val[i].indexOf('=') + 1);//쿠키 값
        		x = x.replace(/^\s+|\s+$/g, ''); //앞뒤 공백 제거 - Y와 userInputId 사이의 공백이 있다.
        		if(x == cookieName){ //x 데이터 검증도 해야만
        			return y;
        		}
        	}
        	
        	//return valSplit[valSplit.length-1];
        }
        
        //삭제하기 (삭제할 쿠키 이름)
        function delCookie(cookieName) {
        	//let date = new Date();
        	//date.setDate(date.getDate() - 1); // 하루 지나게 한다는 뜻. 하루 지나면 삭제되니까(,,)
        	//document.cookie = cookieName + "=; expires=" + date.toGMTString(); // value가 없어서 그냥 ;로 끝내기
        	document.cookie = cookieName + "=; max-age=0"; // date를 쓰지 않고 이것도 된다.
        }
        
        //-----------선생님이 보내주신 스크립트-----------------------
        //아이디 패스워드 적고 아이디 저장 체크한 사람만 저장한다.
        //체크 안한 사람은 로그인만 시킨다.
		/* $(function(){
			var userInputId = getCookie("userInputId"); // 여기랑 다른 이유: 굳이 불러와서 할거없어서 안햇다
			var setCookieYN = getCookie("setCookieYN");
			
			if(setCookieYN == 'Y') {
			    $(".saveID").prop("checked", true);
			} else {
			    $(".saveID").prop("checked", false);
			}
			$("#id").val(userInputId);
			
			$(".check").click(function(){
			   var id = $("#id").val();
			   var pw = $("#pw").val()
			   if(id == '' || id.length < 4){
			      alert("아이디를 입력하세요.");
			      $("#id").focus();
			      return false;
			   }
			   if(pw == '' || pw.length < 4){
			      alert("비밀번호를 입력하세요.");
			      $("#pw").focus();
			      return false;
			   }
			   if($(".saveID").is(":checked")){ 
			        var userInputId = $("#id").val();
			        setCookie("userInputId", userInputId, 60); 
			        setCookie("setCookieYN", "Y", 60);
			    } else {
			        deleteCookie("userInputId");
			        deleteCookie("setCookieYN");
			    }
			    document.loginForm.submit();
			});
		    
		});
		//쿠키값 Set
		function setCookie(cookieName, value, exdays){
		    var exdate = new Date();
		    exdate.setDate(exdate.getDate() + exdays);
		    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		    document.cookie = cookieName + "=" + cookieValue;
		}
		
		//쿠키값 Delete
		function deleteCookie(cookieName){
		    var expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() - 1);
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}
		
		//쿠키값 가져오기
		function getCookie(cookie_name) {
		    var x, y;
		    var val = document.cookie.split(';');
		    //alert(val);
		    for (var i = 0; i < val.length; i++) {
		        x = val[i].substr(0, val[i].indexOf('='));
		        y = val[i].substr(val[i].indexOf('=') + 1);
		        x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
		        
		        if (x == cookie_name) {
		          return unescape(y); // unescape로 디코딩 후 값 리턴
		        }
		    }
		} */
		</script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <%-- <c:import url="menu.jsp"/> --%>
        <%@ include file="menu.jsp" %>
        <!-- Services-->
        <section class="page-section" id="login">
            <div class="d-flex justify-content-center"> <!-- justify-content-center --> 
            	<div class="text-center border border-warning rounded p-3 shadow">
	            	<form action="./login" method="post" id="loginForm">
	            		<img alt="login" src="./img/login.jpg" width="400px;">
	           				<div class="form-wrapper my-3 row">
	            			<label for="staticEmail" class="col-sm-3 col-form-label">ID</label>
	            			<div class="col-sm-8">
		            			<input type="text" class="form-control" name="id" id="id" placeholder="your id">
	            			</div>
	            			</div>
	            			<div class="form-wrapper mb-3 row">
	            			<label for="inputPassword" class="col-sm-3 col-form-label">Password</label>
	            			<div class="col-sm-8">
		            			<input type="password" class="form-control" name="pw" id="pw" placeholder="your password">
	            			</div>
	            			</div>
	            			<div class="mb-3 row">
	            				<div class="col-sm-12 text-start form-check">
	            					<input type="checkbox" class="saveID form-check-input" id="saveID">
	            					<label for="saveID" class="form-check-label">아이디 저장</label>
	            				</div>
	            			</div>
	           			<div class="btn-wrapper mb-3 row justify-content-around">
	            			<button type="reset" class="btn btn-light border border-warning col-4" id="resetBtn">Reset</button>
	            			<button type="button" class="btn btn-light border border-warning col-4 check" id="loginBtn" value="login">Login</button>
	           			</div>
            		</form>
	           			<div class="row justify-content-center">
	           				<a href="./join" class="btn btn-light border border-warning col-4">Join</a>
	           			</div>
            	</div>
            </div>
        </section>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
        
        <!-- 파라미터로 오는 error가 있다면 에러 화면에 출력하기 -->
        <c:if test="${param.error ne null }">
        	<script type="text/javascript">
        		Swal.fire("Oops!", "잘못된 접근. 로그인 하세요.", "error");
        	</script>
        </c:if>
        <c:if test="${param.login ne null }">
        	<script type="text/javascript">
        		Swal.fire("로그인 불가", "올바른 아이디와 비밀번호를 입력하세요.", "error");
        	</script>
        </c:if>
        <c:if test="${param.count ne null }">
        	<script type="text/javascript">
        		let count = ${param.count};
        		if(count < 5) {
        			Swal.fire("로그인 정보를 확인하세요", count + "번 시도했습니다.", "warning");
        		} else {
	        		Swal.fire(
	        				"로그인 불가", 
	        				"로그인을 여러 번 시도했습니다. 관리자에게 문의하세요.", 
	        				"warning");
        		}
        	</script>
        </c:if>
    </body>
</html>
