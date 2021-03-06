<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="../layout/header.jsp"></c:import>

<!-- content -->
<section class="content">
	<div class="content_area">
		<div class="section">
			<h2 class="title01">토론방</h2>
			<div class="board_list_area">
				<div class="clearfix board_list_top">
					
					<!-- search_area -->
					<div class="search_area" id="searchForm">
						<!-- <form action="BoardListForm.bo" name="fboardSearch" method="get"> -->
						<form>
							<div>
								<input type="hidden" name="orderby" value="board_max_seq" />
								<select name="opt" class="input-select" style="width: 100px">
									<option value="0">제목</option>
									<option value="1">내용</option>
									<option value="3">작성자</option>
								</select>
								<input type="text" size="20" name="condition" value="" placeholder="Search" />
								<input type="submit" class="btn01" value="Search" />
							</div>
						</form>
						<!-- //search_area -->
					</div>

					<!-- 정렬 -->
				<div class="sort_list">
					<c:choose>
						<c:when test="${condition != null }">
							<a href="${PATH }/BoardListAction.bo?&opt=${opt }&condition=${condition }&orderby=board_max_seq" class="btn02 on">최신글</a>
							<a href="${PATH }/BoardListAction.bo?&opt=${opt }&condition=${condition }&orderby=board_max_ref" class="btn02">조회수</a>
						</c:when>
						<c:otherwise> 
							<a href="${PATH }/BoardListAction.bo?&orderby=board_max_seq" class="btn02 <c:if test="${ empty param.orderby || param.orderby == 'board_max_seq'}">on</c:if>">최신글</a>
							<a href="${PATH }/BoardListAction.bo?&orderby=board_max_ref" class="btn02 <c:if test="${ param.orderby == 'board_max_ref'}">on</c:if> ">조회수</a>
						</c:otherwise>
					</c:choose>
				
				
					
				</div>
				<!-- //정렬 -->
				<form method="post" name="frm">
					<div class="board_list">
						<table>
							<colgroup>
								<col class="col_num" />
								<col class="col_title" />
								<col class="col_author" />
								<col class="col_date" />
								<col class="col_hit" />
							</colgroup>					
							<thead>
								<tr>
									<th class="m_area">No.</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="board" items="${requestScope.list}">
								<tr>
									<td>${board.board_num}</td>
									<td class="left">
										<c:if test="${board.board_re_lev > 1}">
											<c:forEach begin="1" end="${board.board_re_lev}">&nbsp;&nbsp; <!-- 답변글일경우 글 제목 앞에 공백을 준다. --></c:forEach>
												<img src="img/reply_icon.gif">
										</c:if>
											<a href="BoardDetailAction.bo?num=${board.board_num}&pageNum=${spage}">${board.board_subject}</a></td>
										<td>${board.board_id}</td>
										<td>${board.board_date}</td>
										<td>${board.board_count}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- board_list_bottom -->
					<div class="clearfix board_list_bottom">
						<div class="button_area_right">
							<a href="${PATH }/BoardWriteForm.bo" class="btn01" >글쓰기</a>
						</div>
					</div>
					<!-- //board_list_bottom -->
				</form>
			</div>
			
			<div id="pageForm"  class="page_area">
			
			<c:choose>
				<c:when test="${condition != null }">
					<c:if test="${startPage != 1}">
					<%-- <c:if test="${startPage != 1}"> --%>
					<a href='BoardListAction.bo?page=${startPage-1}&opt=${opt }&condition=${condition }&orderby=${orderby}'  class="page_prev" >이전</a>
					</c:if>

					<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
					<c:if test="${pageNum == spage}"><em>${pageNum}</em></c:if>
					<c:if test="${pageNum != spage}"><a href='BoardListAction.bo?page=${pageNum}&opt=${opt }&condition=${condition }&orderby=${orderby}'>${pageNum}</a></c:if>
					</c:forEach>

					<c:if test="${endPage != maxPage }">
					<a href='BoardListAction.bo?page=${endPage+1 }&opt=${opt }&condition=${condition }&orderby=${orderby}'  class="page_next">다음</a>
					</c:if>	
				</c:when>
				<c:otherwise>	
					<c:if test="${startPage != 1}">
					<%-- <c:if test="${startPage != 1}"> --%>
					<a href='BoardListAction.bo?page=${startPage-1}&orderby=${orderby}'  class="page_prev" >이전</a>
					</c:if>

					<c:forEach var="pageNum" begin="${startPage}" end="${endPage}">
					<c:if test="${pageNum == spage}"><em>${pageNum}</em></c:if>
					<c:if test="${pageNum != spage}"><a href='BoardListAction.bo?page=${pageNum}&orderby=${orderby}'>${pageNum}</a></c:if>
					</c:forEach>

					<c:if test="${endPage != maxPage }">
					<a href='BoardListAction.bo?page=${endPage+1 }&orderby=${orderby}'  class="page_next">다음</a>
					</c:if>					
				</c:otherwise>
			</c:choose>
			
			
			
				
			</div>

		</div>
	</div>
</section>
<!-- //content -->

<c:import url="../layout/footer.jsp"></c:import>