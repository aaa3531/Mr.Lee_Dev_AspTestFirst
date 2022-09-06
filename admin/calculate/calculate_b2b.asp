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
  strSQL = "p_sh_calculate_b2b_list  '" & yyyymmdd & "'"

  Set rsDaily = Server.CreateObject("ADODB.RecordSet")
  rsDaily.Open strSQL, DbCon, 1, 1

  if rsDaily.EOF or rsDaily.BOF then
	NoDataDaily = True
  Else
	NoDataDaily = False
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
  <td width=254 valign=top>
    <div style="padding:10px; text-align:center;">
    B2B 정산일
    </div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="40%" align="center" style="border-right:dotted 1px #ffffff;">정산일</td>   
    <td width="60%" align="center" style="border-right:dotted 1px #ffffff;"></td>    
    </tr>
    
    	<% if NoDataCalculateList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsCalculateList.EOF %>
        <% if rsCalculateList("yyyymmdd")  = yyyymmdd then %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
        <% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;"   >
        <a href="calculate_b2b.asp?yyyymmdd=<%=rsCalculateList("yyyymmdd") %>">
        <span style="font-weight:bold; color:#3388CC;"><%=rsCalculateList("yyyymmdd") %></span></a>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;"  >
        <a href="calculate_b2b_set.asp?yyyymmdd=<%=rsCalculateList("yyyymmdd") %>"><input type="button" value="계산"/></a>
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
  <td width=500 valign=top>
    <div style="padding:10px; text-align:center;">
    <% if yyyymmdd = "" then %>정산일을 선택하세요.<% else %><%=yyyymmdd %><% end if %>
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">아이디</td>  
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">등급</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">수익</td>    
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">수수료<br />제외금액</td>    
    </tr>
    <% if NoDataDaily = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsDaily.EOF    %> 
    <tr height="25"  style="border-bottom:dotted 1px #dddddd;">  
    <td align="center"><%=rsDaily("member_id") %></td> 
    <td align="center"><%=rsDaily("grade_desc") %></td>    
    <td align="center"><%=rsDaily("profit_amt") %></td>   
    <td align="center"></td>    
    </tr>
    <% 	
        rsDaily.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="45">
    <td width="60" align="center" colspan="6">데이터가 없습니다.</td>
    </tr>
    <% end if         
    set rsDaily = nothing
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
