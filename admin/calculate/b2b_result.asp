<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   if request("game_type") <> "" then
   game_type = request("game_type")
   else
   game_type = "U"
   end if

  'calculate_list 읽기
  strSQL = "p_sh_calculate_b2b_yyyymmdd "

  Set rsCalculateList = Server.CreateObject("ADODB.RecordSet")
  rsCalculateList.Open strSQL, DbCon, 1, 1

  if rsCalculateList.EOF or rsCalculateList.BOF then
	NoDataCalculateList = True
  Else
	NoDataCalculateList = False
  end if   
  'response.write strSQL
  'response.End


  if request("yyyymmdd") <> "" then
  
	yyyymmdd = request("yyyymmdd")

  end if 
  
  'calculate_list 읽기
  strSQL = "p_sh_calculate_b2b_table_list  '" & yyyymmdd & "'"

  Set rsB2BResult = Server.CreateObject("ADODB.RecordSet")
  rsB2BResult.Open strSQL, DbCon, 1, 1

  if rsB2BResult.EOF or rsB2BResult.BOF then
	NoDataResult = True
  Else
	NoDataResult = False
  end if   

 
%>
<div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="1024">
<tr>
<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>
<td width=754 valign=top>  

<% membermenu = "B2B"
   menu_desc = "B2B정산"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
<tr>
  <td width=84 valign=top>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="40%" align="center" style="border-right:dotted 1px #ffffff;">정산일</td>   
    </tr>
    
    	<% if NoDataCalculateList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsCalculateList.EOF %>
        <% if rsCalculateList("yyyymmdd")  = yyyymmdd then %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
        <% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;"   >
        <a href="b2b_result.asp?yyyymmdd=<%=rsCalculateList("yyyymmdd") %>">
        <span style="font-weight:bold; color:#3388CC;"><%=rsCalculateList("yyyymmdd") %></span></a>
        </td>
        </tr>
        <%                                
        	rsCalculateList.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			정산일이 없습니다.
        </div>
        <% end if         
       	set rsCalculateList = nothing
        %>   
    </table>
  
  </td>
  <td width=670 valign=top>
    <div style="padding:10px; text-align:center;">
    <% if yyyymmdd = "" then %>정산일을 선택하세요.<% else %><%=yyyymmdd %><% end if %>
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">구분</td> 
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">본사</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">부본사</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">총판</td>    
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">부총판</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">매장</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">사용자</td>    
    </tr>
    <% if NoDataResult = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsB2BResult.EOF    %> 
    <tr height="25"  style="border-bottom:solid 3px #888888;">  
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;">ID</div>
    <div style="padding:3px 0 3px 0; text-align:center;">마진율</div>
    <div style="padding:3px 0 3px 0; text-align:center;">수익</div>
    </td>
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("parent_id1") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("margin_rate1") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("fee_amt1") %></div>
    </td> 
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("parent_id2") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("margin_rate2") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("fee_amt2") %></div>
    </td>   
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("parent_id3") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("margin_rate3") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("fee_amt3") %></div>
    </td>   
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("parent_id4") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("margin_rate4") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("fee_amt4") %></div>
    </td>   
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("parent_id5") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("margin_rate5") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("fee_amt5") %></div>
    </td>   
    <td align="center">
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("member_id") %></div>
    <div style="padding:3px 0 3px 0; text-align:center;">-</div>
    <div style="padding:3px 0 3px 0; text-align:center;"><%=rsB2BResult("fee_amt") %></div>
    </td>       
    </tr>
    <% 	
        rsB2BResult.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="45">
    <td width="60" align="center" colspan="6">데이터가 없습니다.</td>
    </tr>
    <% end if         
    set rsB2BResult = nothing
    %>    
    </table>

  </td>
  </tr> 
  </table>
  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
