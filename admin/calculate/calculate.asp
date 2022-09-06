<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   if request("game_type") <> "" then
   game_type = request("game_type")
   else
   game_type = "U"
   end if

  'calculate_list 읽기
  strSQL = "p_sm_calculate_master_list ''"

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
  strSQL = "p_sm_calculate_daily_list  '" & yyyymmdd & "'"

  'response.write strSQL
  'response.End

  Set rsDaily = Server.CreateObject("ADODB.RecordSet")
  rsDaily.Open strSQL, DbCon, 1, 1

  if rsDaily.EOF or rsDaily.BOF then
	NoDataDaily = True
  Else
	NoDataDaily = False
  end if   
  'calculate_list 읽기

  strSQL = "p_sm_calculate_daily_list_detail  '" & request("calculate_no") & "'"

  'response.write strSQL
  'response.End

  Set rsDailyDetail = Server.CreateObject("ADODB.RecordSet")
  rsDailyDetail.Open strSQL, DbCon, 1, 1

  if rsDailyDetail.EOF or rsDailyDetail.BOF then
	NoDataDailyDetail = True
  Else
	NoDataDailyDetail = False
  end if   

  'response.write request("calculate_no") & "..."

  strSQL = "p_sm_calculate_day_list  '" & yyyymmdd & "'"

  'response.write strSQL
  'response.End

  Set rsCalculateDay = Server.CreateObject("ADODB.RecordSet")
  rsCalculateDay.Open strSQL, DbCon, 1, 1

  if rsCalculateDay.EOF or rsCalculateDay.BOF then
	NoDataCalculateDay = True
  Else
	NoDataCalculateDay = False
  end if   

  'response.write strSQL
 
 
%>
<div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="1024">
<tr>
<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>
<td width=754 valign=top>  

<% membermenu = "CALCULATE"
   menu_desc = "일일정산"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr>
  <td width=254 valign=top>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="80%" align="center" style="border-right:dotted 1px #ffffff;">정산일</td>  
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;"></td>    
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;"></td>   
    </tr>    
    	<% if NoDataCalculateList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsCalculateList.EOF %>
        <% if rsCalculateList("yyyymmdd")  = yyyymmdd then %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
        <% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;line-height:200%;"  >
        <a href="calculate.asp?yyyymmdd=<%=rsCalculateList("yyyymmdd") %>">
        <span style="color:#3388cc;font-weight:bold;"><%=rsCalculateList("yyyymmdd") %></span></a>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;line-height:200%;"  >
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;line-height:200%;" >
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
  
    <% if yyyymmdd = "" then %>
    <div style="padding:10px; text-align:center;background-color:#ffffff;font-weight:bold;">
    정산일을 선택하세요.
    </div>
    <% else %>
    <div style="padding:10px; text-align:center;background-color:#ffffff;font-weight:bold;">
    <%=yyyymmdd %> 정산내역
    </div>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">게임</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">코드</td>    
    <td width="30%" align="center" style="border-right:dotted 1px #ffffff;">상태</td>   
    <td width="40%" align="center" style="border-right:dotted 1px #ffffff;">횟수/건수</td>   
    </tr>    
   	<% if NoDataCalculateList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsCalculateDay.EOF %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <td style="padding:5px;color:#3388cc;font-weight:bold;text-align:center;">
        <%=rsCalculateDay("game_type") %>
        </td>
        <td style="padding:5px;color:#3388cc;font-weight:bold;text-align:center;">
        <%=rsCalculateDay("calculate_cd") %>
        </td>
        <td style="padding:5px;color:#3388cc;font-weight:bold;text-align:center;">
        <%=rsCalculateDay("calculate_status_desc") %>
        </td>
        <td style="padding:5px;color:#3388cc;font-weight:bold;text-align:center;">
        <%=rsCalculateDay("calculate_cnt") %> / <%=rsCalculateDay("record_cnt") %>
        </td>
        </tr>
        <%                                
        	rsCalculateDay.MoveNext
	        Loop 
        %>
	<% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <td style="padding:5px;" colspan="4">
			정산코드 없습니다.
        </td></tr>
    <% end if         
       	set rsCalculateDay = nothing
    %>   
    </table>
    
    
    <% end if %>
        
        
        
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">유형</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">시장</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">회차</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">베팅#</td>    
    <td width="8%" align="center" style="border-right:dotted 1px #ffffff;">#</td>    
    <td width="27%" align="center" style="border-right:dotted 1px #ffffff;">상태</td>    
    </tr>
    <% if NoDataDaily = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsDaily.EOF    %> 
    <tr height="25"  style="border-bottom:dotted 1px #dddddd;">  
    <td align="center">
    <%=rsDaily("game_type_desc") %>
    </td>    
    <td align="center"><%=rsDaily("market_cd") %>  <%=rsDaily("tr_time") %></td> 
    <td align="center"><%=rsDaily("turn_no") %></td> 
    <td align="center"><%=rsDaily("betting_no") %></td> 
    <td align="center"><%=rsDaily("calculate_cnt") %></td> 
    <td align="center"><%=rsDaily("status_desc") %></td>  
    </tr>
    <tr>
    <td colspan="6">
    <div style="padding:5px;text-align:center;">
    <% if request("calculate_no") =rsDaily("calculate_no") then %>
      <% if NoDataDailyDetail = False then ' 데이터가 있으면 데이터 출력 %>
      <% 
       Do While Not rsDailyDetail.EOF    %> 
       <%=rsDailyDetail("member_id") %> : <%=rsDailyDetail("bet_net_amt") %> 
      <% 	
        rsDailyDetail.MoveNext
	    Loop
	    else
        %>
        상세가 없습니다.
        <%
        end if   
    end if
    set rsDailyDetail = nothing
    %>
    </div>
    </td>  
    </tr>    
    <% 	
        rsDaily.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="45">
    <td width="60" align="center" colspan="5">데이터가 없습니다.</td>
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
