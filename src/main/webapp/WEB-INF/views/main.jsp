<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보드</title>
</head>
<body>
	<h1>보드가 될 페이지</h1>
	<table>
		<thead>
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>글쓴이</td>
				<td>날짜</td>
				<td>읽음</td>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${list }" var="row">
			<tr>
				<td>${row.board_no }</td>
				<td>${row.board_title } [${row.comment }]</td>
				<td>${row.board_write }</td>
				<td>${row.board_date }</td>
				<td>${row.board_count }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>