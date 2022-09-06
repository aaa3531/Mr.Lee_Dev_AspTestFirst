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

  ' member 읽기
  strSQL = "p_sh_point_ledger_detail '" & member_no & "'"

  'bRtn = dbcon.GetResult(strSQL, rsMember)
  'response.write strSQL

  ' 페이지 작동되는 방식
  Set rsPoint = Server.CreateObject("ADODB.RecordSet")
  rsPoint.Open strSQL, DbCon, 1, 1

  if rsPoint.EOF or rsPoint.BOF then
	NoDataPoint = True
  Else
	NoDataPoint = False
  end if   

%>

<div style="height:20px;"></div>
<table width=1024 align=center>
<tr>
<td width=270 valign=top>
  
  <!-- #include virtual="/_include/menu_admin_customer.asp" -->
       
</td>

<td width=750 valign=top>  

  <% membermenu = "POINT"
   menu_desc = "고객충전이력"
  %>
  <!-- #include virtual="/_include/guide_admin_customer.inc" -->

  <table width="100%" border="1" cellpadding="0" cellspacing="0">
  <tr>
  <td width="350" valign="top"> 
   
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="30%"  align="center" style="border-right:dotted 1px #ffffff;">아이디</td>  
    <td width="30%" align="center" style="border-right:dotted 1px #ffffff;">닉네임</td>     
    <td width="40%"  align="center" style="border-right:dotted 1px #ffffff;">총POINT</td>    
    </tr>
    	<% if NoDataMember = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsMember.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsMember.EOF and RowCount > 0         
           if rsMember("member_no") * 1 - member_no  = 0   then %>
          <tr height="30" style="border-bottom:dotted 1px #dddddd;background-color:#47B7AD;">
          <td width="30%" align="center">
          <%=rsMember("member_id") %>
          </td>
          <td width="30%" align="left">
          <%=rsMember("member_alias") %>
          </td>
          <td width="40%" align="right">
          <span style="padding:0 10px 0 0;">
          <%=rsMember("point_total") %></span>
          </td>
          </tr>
          <% else %>          
          <tr height="30" style="border-bottom:dotted 1px #dddddd;">
          <td width="30%" align="center">
          <a href="point_history.asp?page=<%=cPage%>&member_no=<%=rsMember("member_no") %>">
          <span style="font-weight:bold;"><%=rsMember("member_id") %></span></a>
          </td>
          <td width="30%">
          <a href="point_history.asp?page=<%=cPage%>&member_no=<%=rsMember("member_no") %>"><%=rsMember("member_alias") %></a>
          </td>
          <td width="40%" align="right">
          <span style="padding:0 10px 0 0;">
          <%=rsMember("point_total") %></span>
          </td>
          </tr>
          <% end if %>        

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
	Response.Write ShowPageBar("point_history.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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
  <td width=404 valign=top>  

  <% if member_no > "0" then %>
  <div style="padding:5px;text-align:center;background-color:#dddddd;color:#00856a;font-weight:bold;">  
    <%=member_alias %> (<%=member_email %>)
  </div>
  
  <table cellSpacing="0" cellPadding="0" border="0" width="100%">  
  <% if NoDataPoint = False then ' 데이터가 있으면 데이터 출력 %>
  <% Do While Not rsPoint.EOF  %>
  <tr height="30">
    <td style="width:20%; text-align:center;">
  <% if rsPoint("inout_code") = "I" then %>충전
  <% else %>환전
  <% end if  %>
    </td>
    <td style="width:30%; padding:0 0 0 0px; text-align:right;">
        <span style="font-weight:bold;color:#ff6600;">
        <%=rsPoint("point_amt") %>원 </span>
    </td>
    <td style="width:50%; text-align:center; ">
        <%=rsPoint("register_date") %> 
    </td>
  </tr>
  <%                                
    rsPoint.MoveNext
    Loop 
  %>
  <% else %>
  <tr>
  <td colspan="3">
  <div style="padding:5px;text-align:center;">  
    		POINT이력이 없습니다.
  </div>
  </td>
  </tr>
  <% end if         
  set rsPoint = nothing
  %> 
  </table>
  <% else %>
  <div style="padding:5px;text-align:center;background-color:#dddddd;">  
    회원을 선택하세요.
  </div>
  <% end if %> 
  
  </td>
  </tr>
  </table>

</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
