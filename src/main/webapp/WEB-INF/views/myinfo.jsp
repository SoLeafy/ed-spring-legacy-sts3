<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>마이페이지</title>
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
        <script type="text/javascript">
	        const Toast = Swal.mixin({
	            toast: true,
	            position: 'center-center',
	            showConfirmButton: false,
	            timer: 3000,
	            timerProgressBar: true,
	            didOpen: (toast) => {
	              toast.onmouseenter = Swal.stopTimer;
	              toast.onmouseleave = Swal.resumeTimer;
	            }
	          });
	        function emailAuth() {
	        	$.ajax({
	        		url: './emailAuth', //ajax용 rest controller에 만들자.
	        		type: 'post',
	        		dataType: 'text',
	        		//data: , //데이터 안 보내고 동작만 시킬 것
	        		success: function(result){
	        			if(result == 1) {
		        			//Swal.fire("이메일을 발송했습니다.", "결과 : " + result, "success");
		        			Toast.fire('통신문제', '통ㅇ신문제가 발생햇습니다.', 'info');
	        			} else {
	        				Swal.fire("이메일 발송 실패!", "문제가 발생했습니다.", "info");
	        			}
	        		},
	        		error: function(request, status, error){
	        			//접속불가거나 스테이터스나 에러
	        			Swal.fire("통신 실패", "문제가 발생했습니다 : " + error, "error");
	        		}
	        	});
	        }
        </script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <%-- <c:import url="menu.jsp"/> --%>
        <%@ include file="menu.jsp" %>
        <!-- login -->
        <section class="page-section" id="my-info">
            <div class="d-flex justify-content-center"> <!-- justify-content-center --> 
            	<div class="text-center border border-warning rounded p-3 shadow">
            	
            		<button onclick="emailAuth()" class="btn btn-light border border-warning">인증번호 요청하기</button>
            	
	           			<div class="row justify-content-center">
	           				등록한 e-mail로 인증 번호가 발송되었습니다.<br> <!-- p태그 </p>이것만 써서 br처럼 쓸 수있지만,, ㄴㄴ -->
	           				email을 확인 후 인증번호를 입력하세요.
	           				<form action="">
	           					<input type="number" name="number">
	           					<button>인증하기</button>
	           				</form>
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
