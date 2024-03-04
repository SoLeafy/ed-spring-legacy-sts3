<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 쓰기</title>
<!-- summernote lite 으.. 경로 -->
<!-- <script src="/js/summernote/summernote-lite.js"></script> -->
<!-- <script src="/js/summernote/summernote-bs4.min.js"></script> -->
<!-- <script src="/js/summernote/lang/summernote-ko-KR.js"></script> -->
<!-- <link rel="stylesheet" href="/css/summernote/summernote-lite.css"> -->
<!-- <link href="/css/summernote/summernote-bs4.min.css" rel="stylesheet"> -->
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style type="text/css">
.btnWrapper {
	display: flex;
	margin-top: 5px;
}
</style>
</head>
<body>
<section class="container d-flex flex-column align-items-center">
	<h1>공지 쓰기</h1>
	<form action="./noticeWrite" method="post">
	<div class="row">
		<input name="ntitle" class="form-control">
		<textarea name="ncontent" id="summernote"></textarea>
		<div class="d-flex justify-content-end">
			<button type="submit" class="btn btn-light">공지 쓰기</button>
		</div>
	</div>
	</form>
	<div class="btnWrapper">
		<button onclick="location.href='/notice'" class="btn btn-dark">공지사항으로</button>
	</div>
</section>
</body>
<script type="text/javascript">
$(document).ready(function() {
	$('#summernote').summernote({
		  height: 600,                 // 에디터 높이
		  lang: 'ko-KR', // default: 'en-US'
		  placeholder: "write here...", 
		  fontNames : ['D2Coding', 'Arial Black', 'Comic Sans MS', 'Courier New'], // 폰트 나열
			  toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    /* ['font', ['strikethrough', 'superscript', 'subscript']], */
			    ['fontname', ['fontname','fontsize', 'color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    /* ['height', ['height']] */
			    ['table', ['table','link', 'picture', 'video']],
			    ['view', ['fullscreen', 'codeview', 'help']]
			  ]
	});
});
</script>
</html>