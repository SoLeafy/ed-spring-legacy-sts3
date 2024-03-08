<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<style type="text/css">
.profilePic {
	width: 30px;
	height: 30px;
}
</style>
</head>
<body>
	${detail.board_title }<br>
	${detail.mname }
	${detail.mpfpic }
	${detail.board_date }
	${detail.board_ip }<br>
	${detail.board_content }
</body>
</html>