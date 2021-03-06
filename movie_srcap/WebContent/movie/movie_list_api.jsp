<%@page import="net.movie.db.MovieBean"%>
<%@page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../layout/header.jsp"></c:import>
<%
	List movieList = (List) request.getAttribute("movielist");
	int nowpage = ((Integer)request.getAttribute("page")).intValue();
	int startpage = ((Integer)request.getAttribute("startpage")).intValue();
	int endpage = ((Integer)request.getAttribute("endpage")).intValue();
%>
<!-- content -->
<section class="content">
	<div class="content_area">
		<div class="section movie_area">
			<h2 class="title01">영화 정보</h2>
			
			<!-- 검색 -->
			<form action="MovieScrapList.mv" method="get">
			<label class="tit" for="stx">검색할 영화제목을 입력해주세요.</label>
			<input type="text" name="stx" id="stx" value="${param.stx }" size="40" />
			<input type="submit" class="btn01" value="영화검색" />
			</form>

			<div class="clearfix mv_top_area">
				<div class="mylist_area">
					<a href="MovieMyList.mv" class="btn01">MY LIST</a>
				</div>
				<!-- 오름차순, 내림차순 -->  
				<div class="sort_list" id="orderby">
					<a href="MovieScrapList.mv?sort=prodYear&stx=${param.stx }" class="btn02 <c:if test="${ param.sort == 'prodYear' || empty param.sort}">on</c:if>">개봉순</a>
					<a href="MovieScrapList.mv?sort=title&stx=${param.stx }" class="btn02 <c:if test="${ param.sort == 'title'}">on</c:if>">영화순</a>
				</div>
			</div>
			<!-- 뿌려줄 곳 -->
			<div class="movie_list">
				<ul class="clear">
				<c:forEach items="${movieList }" var="movie" begin="0" end="9">
				<li>
					<div class="img">
						<a href="MovieScrapView.mv?seq=${movie.movieSeq }&id=${movie.movieId }">
						<c:forTokens items="${movie.poster }" delims="|" var="item" begin="0" end="0">
						<c:choose>
							<c:when test="${item == 'http://file.koreafilm.or.kr/thm/02/00/02/55/tn_DPF005962.JPG' }">
							<img src='${PATH }/public/images/common/no_img.png' alt='NO IMAGE' />
							</c:when>
							<c:otherwise>
							<img src="${item}" alt="" />
							</c:otherwise>
						</c:choose>
						</c:forTokens>
						<c:if test="${empty movie.poster }">
						<img src='${PATH }/public/images/common/no_img.png' alt='NO IMAGE' />
						</c:if>
						</a>
					</div>
					<div class="info">
						<dl>
							<dt>${movie.title }
								<c:if test="${movie.titleOrg != '' }">
									(${movie.titleOrg })
								</c:if>
							</dt>
							<dd>감독 : ${movie.director }</dd>
							<dd>배우 : 
							<c:forEach items="${movie.actor }" var="actor" varStatus="status">
							<c:if test="${status.index != 0}">,</c:if>
							${actor }
							</c:forEach>
							</dd>
							<dd class="movie_btn">
								<a href="MovieScrapView.mv?seq=${movie.movieSeq }&id=${movie.movieId }">자세히보기</a>
								<a href="MovieScrapAdd.mv?seq=${movie.movieSeq }&id=${movie.movieId }">스크랩하기</a>
								<a href="BoardListAction.bo">토론하기</a>
							</dd>
						</dl>
					</div>
				</li>
				</c:forEach>
				</ul>
			</div>

			<!-- 페이징 처리 -->
			<div class="page_area">
			<% if(nowpage > 1 ){ %>
				<a href="./MovieScrapList.mv?stx=${param.stx }&page=<%= nowpage-1 %>" class="page_prev">이전</a>
			<% } %>
				<% for ( int a = 1; a <= endpage; a++ ){
					if(a==nowpage){ %>
						<em><%= a %></em>
					<% } else { %>
						<a href="./MovieScrapList.mv?stx=${param.stx }&page=<%=a%>"><%=a%></a>
					<% } %>
				<% } %>
				<% if(nowpage>=10){ %>
				<% } else { %>
					<a href="./MovieScrapList.mv?stx=${param.stx }&page=<%= nowpage+1 %>" class="page_prev">다음</a>
				<% } %>
			</div>
		</div>
	</div>
</section>
<!-- //content -->

<c:import url="../layout/footer.jsp"></c:import>