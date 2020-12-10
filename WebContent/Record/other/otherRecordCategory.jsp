<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.FristCategoryData, model.SubcategoryData, model.RecordData" %>
<jsp:include page="../../webHeader.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 기록 보기</title>
<link href="/NewsCabinet/style.css" rel="stylesheet">
<style type="text/css">
	/*CH : categoryHeader*/
	.newsCategoryHeader{
		width: 60%;
		margin: 5px auto;
		border-bottom: 1px solid #2E404E;
	}
	
	
	.newsCategoryHeader a{
		width: 60%;
		margin: 20px auto;
		padding:8px;
		text-decoration: none;
		color: black;
	}
	
	.newsCategoryHeader ul{
	list-style:none;
	}
	
	.CH_FirtstLineli {
		float: left;
		margin: 1px;
		display: block;
		padding: 5px;
		text-decoration: none;
	}
	
	.CH_FirtstLineli a{
		width: 60%;
		padding: 10px;
		text-decoration: none;
		color: black;
	}
	
	.CH_FirtstLineli a:hover{
		border-bottom: 2px solid #2E404E;
	}
	
	.CH_FirtstLineliOn {
		float: left;
		margin: 1px;
		display: block;
		padding: 5px;
		text-decoration: none;
		font-weight:bolder;
		
	}
	
	
	.CH_SecondLineli {
		float: left;
		margin: 1px;
		display: block;
		padding: 5px;
		text-decoration: none;
	}
	
	.CH_SecondLineli a:hover{
		background: #2E404E;
		color: white;
		font-weight: bold;
		border-radius: 10px;
	}
	
	.CH_SecondLineliOn {
		float: left;
		margin: 1px;
		display: block;
		padding: 5px;
		text-decoration: none;
		background: #2E404E;
		color: white;
		font-weight: bold;
		border-radius: 10px;
	}

	.simpleRecordContent{
		text-align: left;
		width: 50%;
		margin: 10px auto;
		padding : 10px;
	}
	
	.simpleRecordItem {
		width: 98%;
		text-align: left;
		border-bottom: 1px solid gray;
		margin: 10px auto;
		padding : 10px;
	}
	
	.simpleRecordItem a{
		text-decoration: none;
		padding: 20px;
		color:black;
	}
	
	.simpleRecordItem a:hover{
		box-shadow: 1px 1px 10px #ddd;
	}
	
</style>
</head>

<body>
	<%	
		ArrayList<FristCategoryData> firstCategoryList = (ArrayList)application.getAttribute("firstCategoryList");
		ArrayList<SubcategoryData> subCategoryList = (ArrayList)application.getAttribute("subCategoryList");
		ArrayList<RecordData> simpleRecordList = (ArrayList)request.getAttribute("simpleRecordList");
		int SelectedfirstCategoryId = (Integer)request.getAttribute("SelectedCategoryId");
		int SelectedSubCategoryId = (Integer)request.getAttribute("SelectedSubCategoryId");
	%>
	
	<div class="basic_contentzone">
			<section>
			<br>
			<h3>전체 기록 보기</h3>
			<br>
			</section>
				
			<div class="newsType">
				<div class="newsCategoryHeader">
					<ul>
					<li class='CH_FirtstLineli'><a href="/NewsCabinet/OthersRecord/main">홈</a><li>
						<%
						String presentFisrtCategoryName = "";
						for(int i = 0; i < firstCategoryList.size(); i++){
							int itemId = firstCategoryList.get(i).getCategoryId();
							String itemName = firstCategoryList.get(i).getCategoryName();
							String recordUrl = "/NewsCabinet/otherRecord?first=" + itemId;
							
							if(itemId == SelectedfirstCategoryId){
								out.println("<li class='CH_FirtstLineliOn'><a href='" + recordUrl + "'>" + itemName + "</a></li>");
								presentFisrtCategoryName = itemName;
							}else{
								out.println("<li class='CH_FirtstLineli'><a href='" + recordUrl + "'>" + itemName + "</a></li>");
							}
						}
						%>
					</ul>
					<br><br>
				</div>
				<div class="newsCategoryHeader">
					<ul>
						<%
						for(int i = 0; i < subCategoryList.size(); i++){
							int firstCategoryId = subCategoryList.get(i).getFirstCategoryId();
							int subItemId = subCategoryList.get(i).getSubcategoryId();
							String subItemName = subCategoryList.get(i).getSubcategoryName();
							String recordUrl = "/NewsCabinet/otherRecord?first=" + firstCategoryId + "&sub=" + subItemId ;
							
							if(firstCategoryId == SelectedfirstCategoryId){
								if(presentFisrtCategoryName.equals(subItemName)){
									continue;
								}else if(subCategoryList.get(i).getSubcategoryId() == SelectedSubCategoryId){
									out.println("<li class='CH_SecondLineliOn'><a href='" + recordUrl + "'>" + subItemName + "</a></li>");
								}else{
									out.println("<li class='CH_SecondLineli'><a href='" + recordUrl + "'>" + subItemName + "</a></li>");
								}
							}
						}%>
					</ul>
					<br><br>
			</div>
				
				<div class="simpleRecordContent">
						<% 
						for(int i = 0; i < simpleRecordList.size(); i++){
							int recordId = simpleRecordList.get(i).getRecordId();
							String subcategoryName = simpleRecordList.get(i).getSubcategoryName();
							String recordTitle = simpleRecordList.get(i).getRecordTitle();
							String userName = simpleRecordList.get(i).getUserName();
							String recordDate = simpleRecordList.get(i).getRecordDate();
							int recordCount = simpleRecordList.get(i).getRecordCount();
							String specificRecordUrl = "/NewsCabinet/UserRecord/record?id=" + recordId;
							%>
							<div class="simpleRecordItem" onclick="location.href='<%=specificRecordUrl%>'">
								<p> <b>[<%=subcategoryName%>]</b> &nbsp; <%=recordTitle %>
								</p><br>
								<p>
								<%=userName %> &nbsp; | &nbsp; <%=recordDate %> &nbsp; | &nbsp; 조회수 &nbsp;<%=recordCount %>
								</p><br>
							</div>
						<%} %>
							
				</div>
				
			</div>
			
	</div>
			



</body>
</html>