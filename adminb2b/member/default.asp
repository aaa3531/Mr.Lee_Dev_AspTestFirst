<!-- #include virtual="/_include/top_menu_adminb2b.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  ' member 읽기
  strSQL = "p_sm_member_b2b_follower '" & session("member_no") & "' "

  'bRtn = dbcon.GetResult(strSQL, rsMember)

  ' 페이지 작동되는 방식
  Set rsMember = Server.CreateObject("ADODB.RecordSet")
  rsMember.cursorlocation = 3
  rsMember.Open strSQL, DbCon, 1, 3

  if rsMember.EOF or rsMember.BOF then
	NoDataMember = True
  Else
	NoDataMember = False
  end if 
  
  '페이징처리관련
  page =Cint(request("page"))
  If NoDataMember = False then
		Cus_pageSize = 10
		rsMember.PageSize = Cus_pageSize

		pagecount=rsMember.pagecount
		totalRecord = rsMember.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsMember.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsMember.PageSize) + 1)

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

  
  <!-- #include virtual="/_include/menu_adminb2b_member.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "CUSTOMER"
   menu_desc = "B2B회원조회"
%>
<!-- #include virtual="/_include/guide_adminb2b_member.inc" -->

  <div style="height:10px;"></div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#47b7ad">
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">아이디</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">등급</td>   
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">총포인트</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">마진율</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;"></td>    
    </tr>


    <table width="100%" cellpadding=0 cellspacing=0 border=0>
    	<% if NoDataMember = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsMember.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsMember.EOF and RowCount > 0          %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <td width="20%" align="center">
          <%=rsMember("member_id") %>
          </td>
          <td width="20%" align="center">
          <%=rsMember("grade_desc") %>
          </td>
          <td width="20%" align="center">
          <% if rsMember("grade_cd") = "U" then %>
          <%=rsMember("point_total") %>
          <% else %>
          (-)
          <% end if %>
          </td>
          <td width="20%" align="center">
          <% if rsMember("grade_cd") = "U" then %>
          (-)
          <% else %>
          <%=rsMember("margin_rate") %>
          <% end if %>
          </td>
          <td width="20%" align="center">
          </td>
          </tr>     

        <%                                
        	RowCount = RowCount - 1
        	rsMember.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	회원이 없습니다.
        </td></tr>
        <% end if         
       	set rsMember = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataMember = false Then
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
	Response.Write ShowPageBar("member.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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
