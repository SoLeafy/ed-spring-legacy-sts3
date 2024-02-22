<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
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
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style type="text/css">
.wrapper {
	display: flex;
	justify-content: center;
}
.inner-wrapper {
	display: flex;
	align-content: center;
	flex-direction: column;
	
	width: 75%;
	height: 500px;
}
.other-wrapper {
	display: flex;
	flex-direction: column;
	align-items: center;
}
.profile-holder {
	width: 400px;
	height: 400px;
}
.btn-wrapper {
	display: flex;
	justify-content: space-around;
}
</style>
<script type="text/javascript">
$(function(){
	let pfHolder = $('.profile-holder');
	$("#getProfile").click(function(){
		//alert("눌렀습니다.");
		$.ajax({
			url: "./getProfile",
			type: "POST",
			dataType: "text",
			data: {mid: "${sessionScope.mid}"},
			success: function(data) {
				console.log(data);
				//let pfpic = $(data);
				pfHolder.html(data);
			},
			error: function(error) {
				alert("통신 실패");
			}
		});
	});
	
	$("#sendProfile").click(function(){
		let holdingPf = $(pfHolder.html());
		holdingPf = holdingPf.removeAttr('style').attr("class", "profilePic");
		console.log(holdingPf[0]);
		let pfString = holdingPf[0].outerHTML;
		$.ajax({
			url: "./revisedProfile",
			type: "POST",
			dataType: "text",
			data: {profile: pfString},
			success: function(result) {
				alert("태그정리 결과: " + result);
			},
			error: function(error) {
				alert("통신 실패 - 태그수정");
			}
		});
	});
});
</script>
</head>
<body>
<%@ include file="menu.jsp" %>
	<div class="wrapper">
		<div class="inner-wrapper">
			<div class="sn-wrapper">
				<form action="./profile" method="post">
				  <textarea id="summernote" name="profile"></textarea>
				  <button type="submit" class="btn btn-light border border-warning">submit</button>
				</form>
			</div>
			
			<div class="other-wrapper">
					<div class="profile-holder border border-warning rounded mt-5"></div>
				<div class="btn-wrapper mt-3">
					<button id="getProfile" class="btn btn-light border border-warning">프사가져오기</button>
					<button id="sendProfile" class="btn btn-light border border-warning">프사태그정리</button>
				</div>
			</div>
		</div>
	</div>
	<script>
	$(document).ready(function() {
		  $('#summernote').summernote();
		});
	</script>
</body>
</html>