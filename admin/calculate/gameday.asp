<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  strSQL = "p_sm_gameday_read "

 ' response.write strSQL
 ' response.End
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if NOT rs.EOF and NOT rs.BOF then
    game_day = rs("game_day")
  end if   

  set rs = nothing

  strSQL = "p_sm_gameday_month_list "

 ' response.write strSQL
 ' response.End
  
  Set rsMonth = Server.CreateObject("ADODB.RecordSet")
  rsMonth.Open strSQL, DbCon, 1, 1

  if rsMonth.EOF or rsMonth.BOF then
	NoDataMonth = True
  Else
	NoDataMonth = False
  end if   


  if request("yyyymm") <> "" then  
	yyyymm = request("yyyymm")
  else
	yyyymm = mid(session("yyyymmdd"),1,6)
  end if 
  
  strSQL = "p_sm_gameday_list  '" & yyyymm & "'"

  'response.write strSQL
  'response.End

  Set rsDays = Server.CreateObject("ADODB.RecordSet")
  rsDays.Open strSQL, DbCon, 1, 1

  if rsDays.EOF or rsDays.BOF then
	NoDataDays = True
  Else
	NoDataDays = False
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

<% membermenu = "GAMEDAY"
   menu_desc = "게임일자관리"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr>
  <td width=254 valign=top>

    <div style="padding:10px 5px 10px 5px;text-align:center;border-bottom:dotted 1px #dddddd;">
    <a href="gameday_set.asp?yyyymm=<%=mid(Session("yyyymmdd"),1,6) %>"><input type="button" value="당월생성" /></a>
    <a href="gameday_set.asp"><input type="button" value="익월생성" /></a>
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">  
    	<% if NoDataMonth = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsMonth.EOF %>
        <% if rsMonth("yyyymm")  = yyyymm then %>
        <tr height="25" style="border-bottom:solid 1px #dddddd;background-color:#47b7ad;">
        <% else %>
          <tr height="25" style="border-bottom:solid 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; text-align:center;line-height:200%;"  >
        <a href="gameday.asp?yyyymm=<%=rsMonth("yyyymm") %>">
        <span style="font-weight:bold;color:#3388cc;"><%=rsMonth("yyyymm") %></span></a>
        </td>
        </tr>
        <%                                
        	rsMonth.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			월이 없습니다.
        </div>
        <% end if         
       	set rsMonth = nothing
        %>   
    </table>
  
  </td>
  <td width=500 valign=top>
  
    <div style="padding:10px; text-align:center;background-color:#ffffff;font-weight:bold;color:#ff6600;font-size:14pt;">
    현재 게임일 : <%=mid(game_day,1,4) %>년 <%=mid(game_day,5,2) %>월  <%=mid(game_day,7,2) %>일 
    </div>

    <% if yyyymm = "" then %>
    <div style="padding:10px; text-align:center;font-weight:bold;">
    월을 선택하세요.
    </div>
    <% else %>
    <div style="padding:10px; text-align:center;font-weight:bold;">
    <%=mid(yyyymm,1,4) %>년 <%=mid(yyyymm,5,2) %>월 영업일
    </div>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">일</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;"></td>   
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">요일</td>    
    <td width="30%" align="center" style="border-right:dotted 1px #ffffff;">상태</td>   
    <td width="25%" align="center" style="border-right:dotted 1px #ffffff;">비  고</td>   
    </tr>    
   	<% if NoDataDays = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsDays.EOF %>
        <% if rsDays("work_flag") = "1" then %>
          <% if rsDays("yyyymmdd") <> game_day then %>
            <% if rsDays("week_day") * 1 - 2 > 0 then %>
            <tr height="25" style="border-bottom:solid 1px #dddddd;background-color:#ffffff;">
            <% else %>
            <tr height="25" style="border-bottom:solid 1px #dddddd;border-top:solid 2px #888888;background-color:#ffffff;">
            <% end if %>
          <% else %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#ffff00;">
          <% end if %>
        <% else %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px;color:#000000;font-weight:bold;text-align:center;">
        <% if rsDays("work_flag") = "1" then %>
        <%=mid(rsDays("yyyymmdd"),7,2) %>
        <% else %>
        <span style="color:#ff6600;"><%=mid(rsDays("yyyymmdd"),7,2) %></span>
        <% end if %>
        </td>
        <td style="padding:5px;color:#000000;font-weight:bold;text-align:center;">
        <% if rsDays("work_flag") = "1" then %>
        <a href="gameday_workday_set.asp?yyyymm=<%=yyyymm %>&yyyymmdd=<%=rsDays("yyyymmdd") %>"><input type="button" value="게임일" /></a>
        <% end if %>
        </td>
        <td style="padding:5px;color:#000000;font-weight:bold;text-align:center;">
        <% if rsDays("work_flag") = "1" then %>
        <%=rsDays("week_day_desc") %>
        <% else %>
        <span style="color:#ff6600;"><%=rsDays("week_day_desc") %></span>
        <% end if %>
        </td>
        <td style="padding:5px;color:#000000;font-weight:bold;text-align:center;">
        <%=rsDays("work_desc") %>
        <a href="gameday_work_set.asp?yyyymm=<%=yyyymm %>&yyyymmdd=<%=rsDays("yyyymmdd") %>"><input type="button" value="토글" /></a>
        </td>
        <td style="padding:5px;color:#000000;font-weight:bold;text-align:center;">
        <%=rsDays("day_desc") %>
        </td>
        </tr>
        <%                                
        	rsDays.MoveNext
	        Loop 
        %>
	<% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <td style="padding:5px;" colspan="4">
			일자가 없습니다.
        </td></tr>
    <% end if         
       	set rsDays = nothing
    %>   
    </table>
    
    
    <% end if %>
        

  </td>
  </tr> 
  </table>
  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
