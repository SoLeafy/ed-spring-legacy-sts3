<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>notice</title>
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
        <link href="css/board.css" rel="stylesheet" />
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
       	<!-- summernote lite -->
       	<script src="/js/summernote/summernote-lite.js"></script>
       	<script src="/js/summernote/summernote-bs4.min.js"></script>
		<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
		<link rel="stylesheet" href="/css/summernote/summernote-lite.css">
		<link href="/css/summernote/summernote-bs4.min.css" rel="stylesheet">
        <style type="text/css">
        .board-no:hover {
        	cursor: pointer;
        }
        .submit-btn-wrapper {
        	display: flex;
        	justify-content: flex-end;
        }
        .pagingArea {
        	background-color: #ffb703;
        }
        .pagingArea > a {
        	color: black;
        }
        </style>
        <script type="text/javascript">
        	function writeCheck() {
        		//alert("글쓰기 버튼을 눌렀습니다.");
        		let title = document.querySelector("#title");
        		let content = document.querySelector("#summernote");
        		//alert(title + " : " + content);
        		if(title.value.length < 2) {
        			alert("제목은 두 글자 이상이어야 합니다.");
        			title.focus();
        			return false;
        		}
        		if(content.value.length < 5) {
        			alert("본문은 다섯 글자 이상이어야 합니다.");
        			content.focus();
        			return false;
        		}
        	}
        	
        	function detail(no) {
        		//swal("Good job!", "상세보기 입니다.", "success"); // title, text, icon, button
        		/* swal({
        			title: "Good job!",
        			text: "번호는 " + no,
        			icon: "success",
        			button: "좋아요"
        		}); */
        		
        		//모달 보이기 - 모달 객체 만들고, show
        		let detailModal = new bootstrap.Modal('#detail', {}); //{옵션}
        		//$("#modalTitle").text(no);
        		//$("#modalContent").text("변경된 내용입니다.");
        		//detailModal.show();
        		
        		$.ajax({
        			url     : "/restDetail",
        			type    : "post",
        			dataType: "json", // text일땐 String이라서 parsing이 안된다
        			data    : {'no': no},
        			success : function(data){ //text -> json
        				//alert(data.board_title);
        				$("#modalTitle").text(data.board_title);
                		$("#modalContent").html(data.board_content);
                		detailModal.show();
        			},
        			error   : function(error){
        				alert(error); //swal 써도 된다
        			}
        		});
        	}
        	
        	
        	function detail111(no) {
        		let detailModal = new bootstrap.Modal('#detail', {});
        		detailModal.show();
        	}
        	
        	function linkPage(pageNo){
        		location.href = "./notice?pageNo="+pageNo;
        	}
        </script>
    </head>
        <body id="page-top">
        <!-- Navigation-->
        <%-- <c:import url="menu.jsp"/> --%>
        <%@ include file="menu.jsp" %>
        
        <!-- 게시판 -->
        <section class="page-section" id="services">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Notice</h2>
                </div>
                <div class="row text-center">
                    <table class="table table-hover">
						<thead>
							<tr>
								<th>no</th>
								<th>title</th>
								<th>author</th>
								<th>date</th>
								<th>views</th>
							</tr>
						</thead>
						<tbody>
							<%-- <c:forEach items="${list }" var="row">
								<tr>
									<td class="board-no" onclick="detail(${row.board_no})">${row.board_no }</td> <!-- 요즘 글번호 빼는 추세 -->
									<td class="title"> <!-- 글번호 형제요소 text 가져오게 해도됨 -->
									<a href="./detail?no=${row.board_no }">
									${row.board_title } 
									<c:if test="${row.comment ne 0 }">
										<span class="badge">${row.comment }</span>
									</c:if>
									</a>
									</td>
									<td>${row.mname }</td>
									<td>${row.board_date }</td>
									<td>${row.board_count }</td>
								</tr>
							</c:forEach> --%>
						</tbody>
					</table>
					<!-- 페이징 -->
					<%-- <div class="m-2 pagingArea">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
					</div> --%>
					<!-- 글쓰기 버튼 -->
					<c:if test="${sessionScope.mid ne null }">
					<button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#write">write</button>
					</c:if>
                </div>
            </div>
        </section>
        
        <!-- 글쓰기 모달 만들기 -->
        <div class="modal" id="write">
        	<div class="modal-dialog modal-xl">
        		<div class="modal-content">
        			<div class="modal-header">
        				<!-- <h3 class="modal-title">글쓰기 창 입니다.</h3> -->
        				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        			</div>
        			<div class="modal-body">
        				<div class="mt-2">
	        				<form action="./write" method="post" onsubmit="return writeCheck()" name="frm">
	        					<div class="write-form-wrapper">
	        					<input type="text" name="title" id="title" class="form-control mb-2" required="required" placeholder="title...">
	        					<textarea name="content" id="summernote" class="form-control mb-2 vh-500" required="required"></textarea>
	        					<div class="submit-btn-wrapper">
	        					<button type="submit" class="btn btn-light">submit</button>
	        					</div>
	        					</div>
	        				</form>
        				</div>
        			</div>
        			<div class="modal-footer">
        				2024-02-19 웹표준 기술 / REST API / RESTFULL
        			</div>
        		</div>
        	</div>
        </div>
        
        <!-- 톺아보기 모달 -->
        <div class="modal" id="detail">
        	<div class="modal-dialog modal-xl">
        		<div class="modal-content">
        			<div class="modal-header">
        			<h5 class="modal-title" id="modalTitle">톺아보기</h5>
        				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        			</div>
        			<div class="modal-body">
        				<div class="mt-2" id="modalContent">
	        				제목<br>
	        				본문내용
        				</div>
        			</div>
        			<div class="modal-footer">
        				톺아보기 모달 닫기
        			</div>
        		</div>
        	</div>
        </div>
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
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
    </body>
</html>
