<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>공지 상세</title>
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
        <link href="css/board.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <style type="text/css">
        .imgBtn:hover {
        	cursor: pointer;
        }
        .detailLine {
        	display: flex;
        	align-items: center;
        }
        .detailLineEnd {
        	display: flex;
        	align-items: center;
        	justify-content: flex-end;
        }
        .profilePic {
        	width: 30px;
			height: 30px;
        }
        .btnSet {
        	display: inline;
        }
        </style>
        <script type="text/javascript">
	        $(function() {
	    		let profile = $('${detail.mpfpic }');
				$("#profilePic").html(profile);
	    	});
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
	        function fileCheck() {
	        	let filaVal = $("#file1").val(); // 파일이름 가져오기
	        	if(fileVal == "") {
	        		alert("파일을 선택하세요.");
	        		return false;
	        	} else {
	        		let ext = fileVal.split('.').pop().toLowerCase(); //확장자분리
	        		//아래 확장자가 있는지 체크
	        		if($.inArray(ext, ['jpg', 'jpeg', 'gif', 'png']) == -1) {
	        			alert('jpg,gif,jpeg,png 파일만 업로드 할 수 있습니다.');
	        			return false;
	        		}
	        	}
	        }
	        function deleteNotice(no) {
	        	Swal.fire({
			        title: "공지 삭제",
			        //text: "글을 삭제합니다.",
			        icon: "warning",
			        showCancelButton: true,
			        confirmButtonColor: "#255f85",
			        cancelButtonColor: "#e9724c",
			        cancelButtonText: "No", 
			        confirmButtonText: "삭제!"
			      }).then(result => {
			        if (result.isConfirmed) {
			       	  // Java에게 삭제하라고 명령 내리기 (ajax 써도 된다)
			       	  // 가상 form = post (이렇게 하나씩 추가 안하고 한줄로 다 써도 됨.)
			       	  //let vform = $('<form name="vform" method="post" action="./postDel"></form>');
			       	  let vform = $("<form></form>");
			       	  vform.attr("name", "vform"); //속성 준다!
			       	  vform.attr('method', 'post');
			       	  vform.attr('action', './noticeDel');
			       	  vform.append($('<input/>', {type:'hidden', name: 'no', value:${detail.nno}})); //값 붙여주기~
			       	  vform.appendTo('body'); //이 가상 form을 붙일 곳
			       	  vform.submit();
			          Swal.fire("삭제했습니다.", "", "success");
			        }
			      });
	        }
	        
	        function deleteNoticeGet(no) {
	        	location.href="./noticeDel" + no;
	        }
        </script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <%-- <c:import url="menu.jsp"/> --%>
        <%@ include file="menu.jsp" %>
        <!-- 파일 업로드 -->
        <section class="page-section" id="gallery">
            <div class="container"> <!-- justify-content-center --> 
            	<div class="text-center">
            		<h2 class="section-heading text-uppercase">Notice Details</h2>
                </div>
                <div class="card mb-4" style="min-height:500px;">
                	<div class="card-body">
                		<div class="h2">${detail.ntitle }</div>
                		<div class="row p-2" style="background-color:#ffc300;">
	                		<div class="col align-middle text-start detailLine">
	                		${detail.mname }(관리자)
	                		<div id="profilePic" class="mx-1"></div>
	                		<c:if test="${detail.mid eq sessionScope.mid}">
	                		<img class="imgBtn mx-1" alt="edit" src="./img/edit.png" onclick="location.href='./noticeUpdate?no=${detail.nno}'">
	                		<img class="imgBtn mx-1" alt="delete" src="./img/delete_heart.png" title="글삭제" onclick="deleteNoticeGet(${detail.nno})">
	                		</c:if>
	                		</div>
	                		<div class="col align-middle text-end detailLineEnd">${detail.ndate } / ${detail.nip }
	                		<span>
	                		<img alt="공지좋아요" src="/img/likes.png">
	                		${detail.nlike }
	                		</span>
	                		</div>
                		</div>
                		<div class="mt-4 min-vh-75">${detail.ncontent }</div>
                	</div>
                </div>
        		<button class="btn btn-light" onclick="history.back()">to notice list</button>
            
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
