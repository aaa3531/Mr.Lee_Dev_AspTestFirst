<!-- #include virtual="/_include/header_intro.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

   ' terms Detail 뿌리기
  strSQL = "p_sm_gamemethod_view_detail  "

  'response.write strSQL
  'response.end

  Set rsDetailList = Server.CreateObject("ADODB.RecordSet")
    rsDetailList.Open strSQL, DbCon, 1, 1

  if rsDetailList.EOF or rsDetailList.BOF then
	NoDataDetailList = True
  Else
	NoDataDetailList = False
  end if 
  
%>



	<!-- container -->
	<div id="container">
		<!-- content -->
		<div id="content" class="subcon">
			<div class="snb_title">
				<ul>
				<li class="snb_01">게임방법 <span>게임방법입니다. 자세히 읽어보시기 바랍니다.</span></li>
				</ul>

			</div>
			<div class="snb_01_con">
				<ul>
					<li>

    	<% if NoDataDetailList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsDetailList.EOF   %>
           <li><%=rsDetailList("section_desc") %></li>
           <li><%=rsDetailList("detail_desc") %></li>
        <%                           
        	rsDetailList.MoveNext
	        Loop 
        %>
		<% else %>
        <li>게임방법이 없습니다</li>
        <% end if

       	set DetailList = nothing
        %>	
			
				</ul>

			</div>
		
		</div>
		<!-- //content -->
	</div>
	<!-- //container -->
	
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
