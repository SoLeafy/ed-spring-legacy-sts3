<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>디테일</title>
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
        <!-- sweet alert -->
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script> -->
        <!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		<script type="text/javascript">
			function deletePost(no){
			   Swal.fire({
			        title: "post 삭제",
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
			       	  vform.attr('action', './postDel');
			       	  vform.append($('<input/>', {type:'hidden', name: 'no', value:${detail.board_no}})); //값 붙여주기~
			       	  vform.appendTo('body'); //이 가상 form을 붙일 곳
			       	  vform.submit();
			          Swal.fire("삭제했습니다.", "", "success");
			        }
			      });
			   
			}
			
			function commentInsert() {
				let comment = $("#comment").val();
				if(comment.length < 3) {
					Swal.fire("댓글의 길이가 짧습니다.", "댓글은 3글자 이상이어야 합니다.", "warning");
					return false;
				}
			}
			
			function like(cno) {
				//Swal.fire("좋아요를 누릅니다", "", "warning");
				//location.href="./likeUp?no=${detail.board_no}&cno="+cno; //이거 말고 가상 form으로 던지면 post도 된다.
			    Swal.fire({
			        title: "좋아요를 누르시겠습니까?",
			        icon: "question",
			        showCancelButton: true,
			        confirmButtonColor: "#255f85",
			        cancelButtonColor: "#e9724c",
			        confirmButtonText: "확인",
			        cancelButtonText: "취소",
			    }).then((result) => {
			        if (result.isConfirmed) {
			            // 확인 버튼을 클릭한 경우에만 페이지 이동
			            //location.href = "./likeUp?no=${detail.board_no}&cno=" + cno;
						$.ajax({
							url: "./clikeUp", 
							type: "post", 
							dataType: "text", 
							data: {no: ${detail.board_no}, cno: cno},
							success: function(data) {
								console.log(data);
								$(".clike").html(data);
							},
							error: function(error) {
								alert("통신 실패: " + error);
							}
						});
			        }
			    });
			}
			
			//jquery start
			$(function(){
				$(".likeBtn").click(function() {
					let cno = $(this).next().val();
					let target = $(this).next().next();
					Swal.fire({
				        title: "좋아요를 누르시겠습니까?",
				        icon: "question",
				        showCancelButton: true,
				        confirmButtonColor: "#255f85",
				        cancelButtonColor: "#e9724c",
				        confirmButtonText: "확인",
				        cancelButtonText: "취소",
				    }).then((result) => {
				        if (result.isConfirmed) {
				            // 확인 버튼을 클릭한 경우에만 페이지 이동
				            //location.href = "./likeUp?no=${detail.board_no}&cno=" + cno;
							$.ajax({
								url: "./clikeUp", 
								type: "post", 
								dataType: "text", 
								data: {no: ${detail.board_no}, cno: cno},
								success: function(data) {
									//console.log(data);
									target.html(data);
								},
								error: function(error) {
									alert("통신 실패: " + error);
								}
							});
				        }
				    });
				})
				
				let profile = $('${detail.mpfpic }');
				$("#profilePic").html(profile);
				
				//댓글쓰기 몇 글자 썼는지 확인하는 코드
				$("#comment").keyup(function(){
					let comment = $(this).val();
					if(comment.length > 500) {
						Swal.fire("500자 넘었어요.", "warning");
						$(this).val(comment.substr(0, 500));
					}
					$("#comment-input").text("댓글쓰기 " + comment.length + "/500");
				});
			})

			//댓글 삭제 버튼
			function deleteComment(no) {
				//Swal.fire("댓글을 삭제합니다.", no+"번 댓글을 삭제합니다", "warning");
				if(confirm("댓글을 삭제하시겠습니까?")) {
					location.href="./deleteComment?no=${detail.board_no}&cno="+no;
				}
			}
		</script>
    </head>
        <body id="page-top">
        <!-- Navigation-->
        <%-- <c:import url="menu.jsp"/> --%>
        <%@ include file="menu.jsp" %>
        
        <!-- detail -->
        <section class="page-section" id="detail">
            <div class="container">
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Details</h2>
                </div>
                <div class="card mb-4" style="min-height:500px;">
                	<div class="card-body">
                		<div class="h2">${detail.board_title }</div>
                		<div class="row p-2" style="background-color:#ffc300;">
	                		<div class="col align-middle text-start detailLine">
	                		${detail.mname } 
	                		<div id="profilePic" class="mx-1"></div>
	                		<c:if test="${detail.mid eq sessionScope.mid}">
	                		<img class="imgBtn mx-1" alt="edit" src="./img/edit.png">
	                		<img class="imgBtn mx-1" alt="delete" src="./img/delete_heart.png" title="글삭제" onclick="deletePost(${detail.board_no})">
	                		</c:if>
	                		</div>
	                		<div class="col align-middle text-end detailLineEnd">${detail.board_date } / ${detail.board_ip }</div>
                		</div>
                		<div class="mt-4 min-vh-75">${detail.board_content }</div>
                	</div>
                </div>
        		<button class="btn btn-light" onclick="history.back()">to board</button>
        		<!-- <button class="btn btn-light" onclick="history.go(-1)">to board</button> -->
        		
        		<hr>
        		<!-- 댓글 입력창 = 스크립트로 빈칸 검사하기 -->
        		<%-- <h4>${detail.comment }개의 댓글</h4> --%>
        		<div class="comment">
	       			<form action="./commentWrite" method="post" onsubmit="return commentInsert()">
	        			<div class="row comment-wrapper mb-3">
	        				<!-- <div class="col-8 col-xs-8 col-sm-10 col-md-11 col-xl-11"> -->
	        				<div class="textarea-wrapper">
		        				<textarea class="form-control" id="comment" name="comment" placeholder="write your comment" style="resize:none; height:70px;"></textarea>
	        				</div>
	        				<!-- <div class="col-4 col-xs-4 col-sm-2 col-md-1 col-xl-1"> -->
	        				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		        				<button class="btn btn-light mt-2" type="submit" id="comment-input">댓글쓰기</button>
	        				</div>
	        			</div>
	        			<input type="hidden" name="no" value="${detail.board_no }">
	       			</form>
       			</div>
       			<%-- 선생님꺼 댓글입력창 
       			<div class="">
				<form action="./commentWrite" method="post">
				<div class="row">
				   <div class="input-group mb-3">
				      <textarea class="form-control" name="comment" aria-describedby="comment-input"></textarea>
				        <button class="btn btn-secondary" type="submit" id="comment-input">댓글쓰기</button>
				   </div>
				   
				</div>
				<input type="hidden" name="no" value="${detail.board_no }">            
				   </form>
				</div> --%>
       			<!-- 댓글 출력창 -->
       			<div class="mt-2">
	        		<c:forEach items="${commentList }" var="c">
	        		<div class="card my-2 shadow">
	        			<div class="card-header" style="background-color:#ffc300;">
		        			<div class="row">
			        			<div class="col-7 px-1 detailLine">${c.mname } ${c.profile }</div>
			        			<!-- <div id="comment-profilePic" class="mx-1"></div> -->
			        			<c:if test="${c.mid eq sessionScope.mid }">
				        			<span class="btnSet">
				        			<img class="imgBtn mx-1" alt="edit" src="./img/edit.png">
				        			<img class="imgBtn mx-1" alt="delete" src="./img/delete_heart.png" title="댓글삭제" onclick="deleteComment(${c.no})">
				        			</span>
			        			</c:if>
			        			<div class="col-2"><img alt="ip" src="./img/ip.png"><span class="mx-1">${c.cip }</span></div>
			        			<div class="col-2"><img alt="time" src="./img/time.png"><span class="mx-1">${c.cdate }</span></div>
			        			<div class="col-1">
			        			<img alt="like" src="./img/like.png" class="imgBtn likeBtn">
<%-- 			        			<img alt="like" src="./img/like.png" class="imgBtn" onclick="like(${c.no })"> --%>
								<input type="hidden" value=${c.no }>
			        			<span class="clike">${c.clike }</span>
			        			</div>
		        			</div>
	        			</div>
	        			<div class="card-body">
	        				<div class="card-text">${c.comment }</div>
	        			</div>
	        		</div>
	        		</c:forEach>
        		</div>
        		<%-- 선생님 댓글... 안적었다
        		<div class="mt-2">
	        		<c:forEach items="${commentList }" var="c">
	        		<div class="card my-2">
	        			<div class="card-header bg-warning bg-gradient">
		        			<div class="row">
			        			<div class="col-7">${c.mname }</div>
			        			<div class="col-2">${c.cip }</div>
			        			<div class="col-2">${c.cdate }</div>
			        			<div class="col-1">${c.clike }</div>
		        			</div>
	        			</div>
	        			<div class="card-body">
	        				<div class="card-text">${c.comment }</div>
	        			</div>
	        		</div>
	        		</c:forEach>
        		</div>
        		  --%>
        		<!-- 댓글 끝 -->
            </div>
        </section>
        <!-- <input type="button" value="to board"> -->
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
