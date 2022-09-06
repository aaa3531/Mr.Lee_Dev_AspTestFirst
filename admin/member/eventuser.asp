<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
  
  ' member 읽기
  strSQL = "p_sm_eventuser_list "

  'bRtn = dbcon.GetResult(strSQL, rsUser)

  ' 페이지 작동되는 방식
  Set rsUser = Server.CreateObject("ADODB.RecordSet")
  rsUser.cursorlocation = 3
  rsUser.Open strSQL, DbCon, 1, 3

  if rsUser.EOF or rsUser.BOF then
	NoDataUser = True
  Else
	NoDataUser = False
  end if 
  
  '페이징처리관련
  page =Cint(request("page"))
  If NoDataUser = False then
		Cus_pageSize = 10
		rsUser.PageSize = Cus_pageSize

		pagecount=rsUser.pagecount
		totalRecord = rsUser.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsUser.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsUser.PageSize) + 1)

		if page > lastpg then
			page = lastpg
		end If

	end if
	'페이징처리관련 끝 
%>

  <div style="height:20px;"></div>
<table width=1024 align=center>
<tr>

<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_customer.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "EVENTUSER"
   menu_desc = "이벤트사용자"
%>
<!-- #include virtual="/_include/guide_admin_customer.inc" -->

  <div style="height:10px;"></div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#e8e8e8">
    <td width="30%" align="center" style="border-right:dotted 1px #ffffff;">이름</td>    
    <td width="40%"  align="center" style="border-right:dotted 1px #ffffff;">이메일</td>    
    <td width="30%"  align="center" style="border-right:dotted 1px #ffffff;">전화번호</td>    
    </tr>


    <table width="100%" cellpadding=0 cellspacing=0 border=0>
    	<% if NoDataUser = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsUser.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsUser.EOF and RowCount > 0          %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <td width="30%" align="center">
          <%=rsUser("user_name") %>
          </td>
          <td width="40%">
          <%=rsUser("user_email") %>
          </td>
          <td width="30%" align="center">
          <%=rsUser("user_phone") %>
          </td>
          </tr>
        <%                                
        	RowCount = RowCount - 1
        	rsUser.MoveNext
	        Loop 
        %>
		<% else %>
		<tr height="20" ><td colspan="3">
        	이벤트 사용자가 없습니다.
        </td></tr>
        <% end if         
       	set rsUser = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataUser = false Then
	Cus_Tar = "peio_no=" & peio_no 
%>
<!--#include virtual="/_include/asp_page_function.asp"-->
<table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="100%">
	<tr>
		<td align="center">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" ID="Table11" height="20">
				<tr>
					<td height="20" align="center" valign="middle">
<%
	Response.Write ShowPageBar("eventuser.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>	
	<%end if%>		
	<!-- 페이징 처리 끝-->


  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
