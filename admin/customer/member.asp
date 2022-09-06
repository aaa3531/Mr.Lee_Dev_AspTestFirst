<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("member_no") = "" then	
    member_no = "0"
  else
	member_no = request("member_no")
    strSQL = "p_sm_member_detail '" & member_no & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      member_email = rs("member_email")
      member_alias = rs("member_alias")
      admin_flag = rs("admin_flag")
      b2b_flag = rs("b2b_flag")
      margin_rate = rs("margin_rate")
    end if 
    set rs = nothing
  end if 
  
  ' member 읽기
  strSQL = "p_sm_member_list "

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

  
  <!-- #include virtual="/_include/menu_admin_customer.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "CUSTOMER"
   menu_desc = "일반회원관리"
%>
<!-- #include virtual="/_include/guide_admin_customer.inc" -->

  <div style="height:10px;"></div>

  <% if member_no > "0" then %>
    <form action="member_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="member_no" value="<%=member_no %>" ID="Hidden1"> 
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden2"> 	
    <table width="100%"  bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="30%" align="center"><%=member_alias %>
    </td>
    <td width="30%" align="center"><%=member_email %>
    </td>
    <td width="20%">
    <% if admin_flag="1" then %>
    <input type="checkbox" name="admin_flag" ID="Text3" value="1" checked >관리자
    <% else %>
    <input type="checkbox" name="admin_flag" ID="Checkbox1" value="1">관리자
    <% end if %>
    </td>
    <td width="20%" bgcolor="#ffffff" align="center">
    <input id="submit1" name="submit1" type="submit" value="회원수정">
    </td>
    </tr>  
    </table>
    </form>
  <% else %>
    <table width="100%"  bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="100%" align="center">아래에서 회원을 클릭하여 설정하세요
    </td>
    </tr>  
    </table>
  <% end if %>
   
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#e8e8e8">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">닉네임</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">이메일</td>
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">계좌번호<br />예금주명<br />은행명</td>       
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">환전비번</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;"></td>    
    </tr>
    	<% if NoDataMember = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsMember.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsMember.EOF and RowCount > 0         
           if rsMember("member_no") * 1 - member_no  = 0   then %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47B7AD;">
          <% else %>          
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <% end if %>        
          <td  align="center">
          <a href="member.asp?page=<%=cPage%>&member_no=<%=rsMember("member_no") %>">
          <span style="color:#3388cc;font-weight:bold;"><%=rsMember("member_alias") %></span></a>
          </td>
          <td>
          <%=rsMember("member_email") %>
          </td>
          <td  align="center">
          <%=rsMember("account_no") %><br>
          <%=rsMember("bank_owner") %><br>
          <%=rsMember("bank_name") %>
          </td>
          <td  align="center">
          <%=rsMember("withdraw_pwd") %>
          </td>
          <td  align="center">
          <% if rsMember("admin_flag") = "1" then %> 관리자 <% end if %>
          </td>
          </tr>

        <%                                
        	RowCount = RowCount - 1
        	rsMember.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td colspan="5">
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
