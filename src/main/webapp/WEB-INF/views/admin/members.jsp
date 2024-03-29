<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>회원 관리</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

	<!-- 제이쿼리 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
	<style type="text/css">
        .profilePic {
        	width: 30px;
			height: 30px;
        }
        </style>
	
	<script type="text/javascript">
		function linkPage(page) {
			location.href="./board?page="+page+"&perPage=${perPage}&search=${search}";
		}
		$(function(){
			$("#perPage").change(function(){//select 드롭다운을 변경했을 시 (ajax 쓰는게 좋을거같다..)
				location.href="./board?page=${page}&perPage="+$("#perPage").val();
			})
			$("#searchBtn").click(function(){
				location.href="./board?page=${page}&perPage=${perPage}&search="+$("#search").val();
			});
		});
	</script>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <c:import url="sidebar.jsp"/>
        <!-- 메뉴는 c:import냐 include file이냐 -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <c:import url="topbar.jsp"/>
                <!-- Topbar가 여기서 끝남 -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
                
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">회원 관리</h1>
                    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>
                            
                            <div class="m-2 row">
                            <select name="perPage" id="perPage" class="form-control col-2">
                            	<option value="1" <c:if test="${perPage eq 1 }">selected="selected"</c:if>>10개씩 보기</option>
                            	<option value="2" <c:if test="${perPage eq 2 }">selected="selected"</c:if>>20개씩 보기</option>
                            	<option value="3" <c:if test="${perPage eq 3 }">selected="selected"</c:if>>30개씩 보기</option>
                            	<option value="4" <c:if test="${perPage eq 4 }">selected="selected"</c:if>>40개씩 보기</option>
                            	<option value="5" <c:if test="${perPage eq 5 }">selected="selected"</c:if>>50개씩 보기</option>
                            	<option value="10" <c:if test="${perPage eq 10 }">selected="selected"</c:if>>100개씩 보기</option>
                            </select>
                            <div class="col-7 input-group">
                            <select name="searchOption" id="searchOption" class="form-control col-3">
                            	<option value="1" <c:if test="${searchOption eq 1 }">selected="selected"</c:if>>아이디 검색</option>
                            	<option value="2" <c:if test="${searchOption eq 2 }">selected="selected"</c:if>>닉네임 검색</option>
                            </select>
	                            <input type="text" name="search" id="search" class="form-control">
	                            <button type="button" class="btn btn-info" id="searchBtn">search</button>
                            </div>
                            <button class="btn col-3 btn-light">Reset</button>
                            </div>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">전체 회원 목록</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>회원번호</th>
                                            <th>프로필사진</th>
                                            <th>아이디</th>
                                            <th>닉네임</th>
                                            <th>가입일</th>
                                            <th>회원등급</th>
                                            <th>이메일</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>회원번호</th>
                                            <th>프로필사진</th>
                                            <th>아이디</th>
                                            <th>닉네임</th>
                                            <th>가입일</th>
                                            <th>회원등급</th>
                                            <th>이메일</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    <c:forEach items="${list }" var="row">
                                        <tr>
                                            <td>${row.mno }</td>
                                            <td>${row.mpfpic }</td>
                                            <td>${row.mid }</td>
                                            <td>${row.mname }</td>
                                            <td>${row.mdate }</td>
                                            <td>${row.mgrade }</td>
                                            <td>${row.memail }</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
	                    <%-- <div class="m-2 d-flex justify-content-end">
	                    	<ui:pagination paginationInfo="${paginationInfo }" type="text" jsFunction="linkPage"/>
	                    </div> --%>
                    </div>
                    

                </div>
                <!-- /.container-fluid -->

            </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <c:import url="footer.jsp"/>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>