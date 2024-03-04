<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>회원가입</title>
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
    	let idCheckBool = false;
    	let emailCheckBool = false;
    	
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
    	
    	function verifyEmail() {
    		return false;
    	}
    	function checkEmail() {
    		let email = document.querySelector("#inputEmail").value;
    		const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    		if(!regExp.test(email)) {
    			Swal.fire("이메일", "잘못된 이메일입니다.", "error");
    			return false;
    		} else {
    			//Swal.fire("이메일", "올바른 이메일입니다.", "success");
    			$.ajax({
    				url: "./emailCheck",
    				type: "post",
    				dataType: "text",
    				data: {"email": email}, 
    				success: function(result){
    					Swal.fire("통신 결과", "성공: " + result, "success");
    					if(result != 0) { // 지금 db에 중복이메일이 많아서... == 1로 할 수 없었다
    						Swal.fire("Error", "이미 가입된 이메일입니다.", "error");
    						emailCheckBool = false;
    						$('#joinBtn').attr("disabled", "disabled");
    						$('#inputEmail').focus();
    						return false;
    					} else {
    						Swal.fire("가입 가능", "가입되지 않은 이메일", "success");
    						emailCheckBool = true;
    						$('#joinBtn').removeAttr("disabled");
    						return true;
    					}
    				},
    				error: function(error){
    					Swal.fire("통신 결과", "실패: " + error, "error");
    				}
    			});
    			return false;
    		}
    	}
    	
    	function checkId() {
    		let id = $('#inputId').val();
    		
    		const regExp = /^[a-z0-9]{4,15}$/;
    		if(id.length < 4 || !regExp.test(id)) { // id.length < 4 이거는 이미 정규표현식에 들어있어서 안해도 되는듯
    			Swal.fire("잘못된 아이디", "아이디는 영문자 4글자 이상, 특수문자가 없어야 합니다.", "error");
    			//$('.id-alert').html('<p class="alert">아이디는 영문자 5글자 이상이고 특수문자가 없어야 합니다.</p>');
    			$('#inputId').focus();
    		} else {
    			$.ajax({
    				url: './checkId',
    				type: 'post',
    				dataType: 'text',
    				data: {id: id},
    				success: function(result) {
    					console.log("통신 결과: " + result);
    					if(result == 1) {
    						Swal.fire("가입 불가", "이미 가입된 아이디입니다.", "warning");
    						idCheckBool = false;
    						$('#joinBtn').attr("disabled", "disabled"); //비활성화 시키기
    						$('#inputId').focus();
    					} else {
    						Swal.fire("가입 가능", "가입되지 않은 아이디", "success");
    						//$('.id-alert').append('<p class="alert">가입할 수 있습니다.</p>');
							//$('.id-alert .alert').css("color", "black");
							idCheckBool = true; //?이건가
							//$('#joinBtn').removeAttr("disabled"); //비활성화 제거하기 = 활성화 시키기 -> 이메일까지 해야 활성화
    					}
    					
    				},
    				error: function() {
    					alert("통신 실패");
    				}
    			});
    		}
    		return false;
    	}
    	function pwCheck() {
			let pw1 = document.querySelector("#inputPw1");
			let pw2 = document.querySelector("#inputPw2");
			if(pw1.value != pw2.value) {
				Swal.fire("비밀번호가 일치하지 않아요.", "", "info");
				return false;
			}
			
			let memId = document.querySelector("#inputId");
			let memName = document.querySelector("#inputName");
			let memEmail = document.querySelector("#inputEmail");
			
			if(memId.value.length < 1) {
				Swal.fire("아이디를 입력하세요.", "", "info");
				return false;
			}
			if(pw1.value.length < 1) {
				Swal.fire("비밀번호를 입력하세요.", "", "info");
				return false;
			}
			if(memEmail.value.length < 1) {
				Swal.fire("이메일을 입력하세요.", "", "info");
				return false;
			}
			if(memName.value.length < 1) {
				Swal.fire("이름을 입력하세요.", "", "info");
				return false;
			}
    	}
    	
    	$(function() {
    		$('.id-alert, .pw-alert, .name-alert').hide();
    		//Swal.fire('title', 'content', 'success');
    		//2024-02-29 애플리케이션 테스트 수행 psd
    		$('#idCheckBtn').click(function(){
	    		let id = $("#inputId").val();
    			Swal.fire("ID검사", "검사할 아이디 : " + id, "success");
    			//3글자 이상, 10글자 이하
    			//기회가 된다면 공백을 사용하지 못하게.
    			const regExp = /^[a-zA-Z0-9]{3,10}$/;
    			if(!regExp.test(id)){
    				//3글자 이하, 10글자 이상 = 비정상 -> 멈춤
    				Swal.fire("안되는 ID", "id는 3글자 이상, 10글자 이하 영문자와 숫자 조합으로 정해주세요.", "error");
    			} else {
    				//Swal.fire("적절한 ID", "가입이 가능합니다.", "success");
    				//3글자 이상, 10글자 이하 = 정상 -> ajax
    				$.ajax({
    					url: './idCheck',
    					type: 'post',
    					dataType: 'json',
    					data: {'id': id},
    					success: function(data){
    						alert("통신 성공, 가입된 아이디 수: " + data.count);
    						if(data.count == 1) {
        						Swal.fire("가입 불가", "이미 가입된 아이디입니다.", "warning");
        						idCheckBool = false;
        						$('#joinBtn').attr("disabled", "disabled"); //비활성화 시키기
        						$('#inputId').focus();
        					} else {
        						Swal.fire("가입 가능", "가입할 수 있습니다.", "success");
        						//$('.id-alert').append('<p class="alert">가입할 수 있습니다.</p>');
    							//$('.id-alert .alert').css("color", "black");
    							idCheckBool = true; //?이건가
    							// $('#joinBtn').removeAttr("disabled"); //비활성화 제거하기 = 활성화 시키기
        					}
    					},
    					error: function(error){
    						alert("통신 실패: " + error);
    					}
    				});
    			}
    		});
    		
    		//join을 클릭하면 이벤트 발생
    		$('#joinBtn').click(function(){
    			//Swal.fire('회원가입', '회원가입 버튼을 클릭하셨습니다.', 'success');
    			//id값 외 가져오기. 가상 form으로 보낼 것.
    			let id = $('#inputId').val();
    			let pw1 = $('#inputPw1').val();
    			let pw2 = $('#inputPw2').val();
    			let name = $('#inputName').val();
    			let email = $('#inputEmail').val();
    			//Swal.fire("회원가입", "아이디: " + id + "<br>비밀번호: " + pw1 + " / " + pw2 + "<br>이메일: " + email + "<br>이름: " + name, "success");
    			//입력값 검사 모두 완료한 뒤에 전송해야함(하나라도 안되면 ㄴㄴ)
    			
    			if(!pwCheck()) {
    				return false;
    			} else {
	    			//전송하기
	    			//가상 form 생성
	    			let joinForm = $('<form></form>');
	    			joinForm.attr('name', 'join');
	    			joinForm.attr('method', 'post');
	    			joinForm.attr('action', './join');
	    			
	    			//값들 싹다 넣기
	    			joinForm.append($('<input>', {'type':'hidden', 'name':'id', 'value':id })); //JSON 방식
	    			joinForm.append($('<input>', {'type':'hidden', 'name':'pw', 'value':pw1 }));
	    			joinForm.append($('<input>', {'type':'hidden', 'name':'name', 'value':name }));
	    			joinForm.append($('<input>', {'type':'hidden', 'name':'email', 'value':email }));
	    			
	    			joinForm.appendTo('body');
	    			joinForm.submit();
    			}
    		});
    		
    		/* $("#inputId").on("change keyup paste", function(){
    			$('.id-alert').show();
    			$('.id-alert').html("<p class='alert'>입력한 아이디는 " + $(this).val() + "</p>");
    			if($('#inputId').val().length > 4) {
    				idCheck();
    			}
    		}); */
    	});
    </script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <%-- <c:import url="menu.jsp"/> --%>
        <%@ include file="menu.jsp" %>
        <!-- Services-->
        <section class="page-section" id="login">
            <div class="d-flex justify-content-center"> <!-- justify-content-center --> 
            	<div class="text-center border border-warning rounded p-4 shadow">
	            		<!-- 아이디 -->
           				<div class="row g-3 align-items-center">
						  <div class="col-2 d-flex justify-content-start">
						    <label for="inputId" class="col-form-label">아이디</label>
						  </div>
						  <div class="col-6">
						    <input type="text" id="inputId" class="form-control" aria-describedby="passwordHelpInline">
						  </div>
						  <div class="col-4">
						    <button class="btn btn-outline-warning" type="button" id="idCheckBtn">아이디 중복 검사</button>
<!-- 						    <button class="btn btn-outline-warning" type="button" id="idCheckBtn" onclick="return checkId()">아이디 중복 검사</button> -->
						  </div>
						</div>
						<div class="input-group mb-2 id-alert">
							<p class="alert">올바른 아이디를 입력하세요</p>
						</div>
						<!-- 비밀번호 -->
						<div class="row g-3 align-items-center mt-1">
						  <div class="col-2">
						    <label for="inputPw1" class="col-form-label d-flex justify-content-start">비밀번호</label>
						  </div>
						  <div class="col-5">
						    <input type="password" id="inputPw1" class="form-control" aria-describedby="passwordHelpInline">
						  </div>
						  <div class="col-5">
						    <input type="password" id="inputPw2" class="form-control" aria-describedby="passwordHelpInline" placeholder="비밀번호 확인">
						  </div>
						</div>
						<div class="input-group mb-2 pw-alert">
							<p class="alert">올바른 비밀번호를 입력하세요</p>
						</div>
						<!-- 이메일 -->
						<div class="row g-3 align-items-center mt-1">
						  <div class="col-2 d-flex justify-content-start">
						    <label for="inputEmail" class="col-form-label">이메일</label>
						  </div>
						  <div class="col-6">
						    <input type="text" id="inputEmail" class="form-control" aria-describedby="passwordHelpInline">
						  </div>
						  <div class="col-4">
						    <button class="btn btn-outline-warning" type="button" id="emailCheckBtn" onclick="return checkEmail()">이메일 중복 검사</button>
						  </div>
						</div>
						<!-- 닉네임 -->
						<div class="row g-3 align-items-center mt-1">
						  <div class="col-2 d-flex justify-content-start">
						    <label for="inputName" class="col-form-label">닉네임</label>
						  </div>
						  <div class="col-10">
						    <input type="text" id="inputName" class="form-control" aria-describedby="passwordHelpInline">
						  </div>
						</div>
						<div class="input-group mb-2 name-alert">
							<p class="alert">올바른 닉네임을 입력하세요</p>
						</div>
						<div class="d-flex justify-content-end m-3">
							<button class="btn btn-warning" id="joinBtn" disabled="disabled">가입하기</button>
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
    </body>
</html>
