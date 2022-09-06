<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

   game_type = "I"

   if request("yyyymmdd") <> "" then
     yyyymmdd = request("yyyymmdd")
   else
     yyyymmdd = Session("yyyymmdd")
   end if

  'calculate_mater 읽기
  strSQL = "p_sm_calculate_item_yyyymmdd   'I'"

  Set rsDaily = Server.CreateObject("ADODB.RecordSet")
  rsDaily.Open strSQL, DbCon, 1, 1

  if rsDaily.EOF or rsDaily.BOF then
	NoDataDaily = True
  Else
	NoDataDaily = False
  end if   
  
  'response.write strSQL
  'response.End


  'calculate_list 읽기
  strSQL = "p_sm_calculate_game_item_list '" & yyyymmdd & "'"
  'response.write strSQL

  Set rsCalculateList = Server.CreateObject("ADODB.RecordSet")
  rsCalculateList.Open strSQL, DbCon, 1, 1

  if rsCalculateList.EOF or rsCalculateList.BOF then
	NoDataCalculateList = True
  Else
	NoDataCalculateList = False
  end if   
  'response.write strSQL
  'response.End


  if request("game_no") <> ""   then	

	game_no = request("game_no")

    strSQL = "p_sm_calculate_detail '" & game_no & "' "
    'response.Write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rsCalculateDetail = Server.CreateObject("ADODB.RecordSet")
    rsCalculateDetail.Open strSQL, DbCon, 1, 1
  
    if NOT rsCalculateDetail.EOF and NOT rsrsCalculateDetailBOF then
      game_no = rsCalculateDetail("game_no")
      game_type = rsCalculateDetail("game_type")
      tr_time = rsCalculateDetail("tr_time")
      status_flag = rsCalculateDetail("status_flag")
      
    end if 
    set rsCalculateDetail = nothing
  end if 
  
  'calculate_list 읽기
  strSQL = "p_sh_calculate_item_detail_list  '" & yyyymmdd & "'"

  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if rs.EOF or rs.BOF then
	NoData = True
  Else
	NoData = False
  end if   
  
  'response.write strSQL
  'response.End
 
%>

<div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="1024">
<tr>
<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>
<td width=754 valign=top>  

<% membermenu = "GAME"
   menu_desc = "게임별 정산내역(종목별)"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
<tr>
  <td width=204 valign=top>
  

    
      <% if NoDataDaily = False then ' 데이터가 있으면 데이터 출력 %>
      <% Do While Not rsDaily.EOF  %> 
        <% if rsDaily("yyyymmdd") = yyyymmdd  then  %>
		<div style="padding:5px;text-align:center;background-color:#47B7AD;">
        <% else %>
		<div style="padding:5px;text-align:center;">
        <% end if %>
        <a href="calculate_game_item.asp?yyyymmdd=<%=rsDaily("yyyymmdd") %>">
        <span style="color:#3388cc;font-weight:bold;"><%=rsDaily("yyyymmdd") %></span>
        </a>&nbsp;
        <a href="calculate_game_item_result.asp?yyyymmdd=<%=rsDaily("yyyymmdd") %>"><input type="button" value="결과"/></a>&nbsp;
        <a href="calculate_game_item_set.asp?yyyymmdd=<%=rsDaily("yyyymmdd") %>"><input type="button" value="정산"/></a>
        </div>
      <% rsDaily.MoveNext
	     Loop       
      end if         
      set rsDaily = nothing
      %> 

  
  </td>
  <td width=550 valign=top>
  
  
  
    <table  cellSpacing="0" cellPadding="0" border="0" ID="Table3" width="100%">
    <tr height="25" bgcolor="#dddddd">
    <td width="35%" align="center" style="border-right:dotted 1px #ffffff;">종목1(배당률)</td>    
    <td width="35%" align="center" style="border-right:dotted 1px #ffffff;">종목2(배당률)</td>   
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">결과</td>    
    <td width=상태</td>    
    </tr>
   
    <% if NoDataCalculateList = False then   %>
        <% Do While Not rsCalculateList.EOF %>
        <% if rsCalculateList("game_no") * 1 - game_no  = 0   then %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
        <% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <img src="/images/stock/<%=rsCalculateList("logo_img1") %>" style="height:20px;" /> <%=rsCalculateList("stock_name1") %>
        (<%=rsCalculateList("dividend_rate1") %>)
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;"  >
       <img src="/images/stock/<%=rsCalculateList("logo_img2") %>" style="height:20px;" /> <%=rsCalculateList("stock_name2") %>
       (<%=rsCalculateList("dividend_rate2") %>)
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <%=rsCalculateList("win_desc") %>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <%=rsCalculateList("game_status_desc") %>(<%=rsCalculateList("win_no") %>)
        </td>        
        </tr>
        <%                                
        	rsCalculateList.MoveNext
	        Loop 
        %>
    <% else %>
       <tr height="25">
       <td colspan="4" align="center">
       게임일을 선택하세요.
       </td></tr>
    <% end if %>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">ID</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">베팅#</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">금액</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">수수료</td>    
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">배당율</td>    
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">배당금액</td>    
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rs.EOF    %> 
    <tr height="25"  style="border-bottom:dotted 1px #dddddd;">  
    <td align="center"><%=rs("member_id") %></td> 
    <td align="center"><%=rs("betting_no") %></td> 
    <td align="center"><%=rs("bet_net_amt") %></td>    
    <td align="center"><%=rs("fee_amt") %></td>   
    <td align="center"><%=rs("dividend_rate") %></td>   
    <td align="center"><%=rs("dividend_amt") %></td>   
    </tr>
    <% 	
        rs.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="45" bgcolor="#ffffff">
    <td width="60" align="center" colspan="6">데이터가 없습니다.</td>
    </tr>
    <% end if         
    set rs = nothing
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
