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
  

  if request("yyyymmdd") <> ""  then	
    yyyymmdd = request("yyyymmdd")
  else
    yyyymmdd = game_day
  end if


  
  ' UP&DOWN 시각 읽기
  strSQL = "p_sm_game_updown_time_read 'KOSPI','" & yyyymmdd & "'"

  'response.write strSQL
  'response.end

  Set rsGameTime = Server.CreateObject("ADODB.RecordSet")
  rsGameTime.Open strSQL, DbCon, 1, 1

  if rsGameTime.EOF or rsGameTime.BOF then
	NoDataGameTime = True
  Else
	NoDataGameTime = False
  end if   

  ' DAY list 읽기
  strSQL = "p_sm_game_updown_days 'KOSPI','" & mid(yyyymmdd,1,6) & "'"

  'response.write strSQL
  'response.end

  Set rsDays = Server.CreateObject("ADODB.RecordSet")
  rsDays.Open strSQL, DbCon, 1, 1

  if rsDays.EOF or rsDays.BOF then
	NoDataDays = True
  Else
	NoDataDays = False
  end if   

  
  
%>

  <div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="1024">
<tr>
<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>
<td width=754 valign=top>  

<% membermenu = "TRTIME"
   menu_desc = "UP&DOWN시간설정"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr height="25">
  <td width=154 valign=top>
  <div style="padding:5px;text-align:center;line-height:180%;background-color:#ffffff;">  
    <a href="updown_time_set.asp?game_day=<%=game_day %>"><input  name="button" type="button" value="생성"></a>    
  </div> 
     
  <div>
    	<% if NoDataDays = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsDays.EOF %>
        <% if rsDays("yyyymmdd") = yyyymmdd  then  %>
		<div style="padding:5px;text-align:center;background-color:#47B7AD;">
        <% else %>
		<div style="padding:5px;text-align:center;">
        <% end if %>
        <a href="updown_time.asp?yyyymmdd=<%=rsDays("yyyymmdd") %>">
        <span style="color:#3388cc;font-weight:bold;"><%=rsDays("yyyymmdd") %></span>
        </a>&nbsp;&nbsp;&nbsp;
        <a href="updown_time_set.asp?game_day=<%=rsDays("yyyymmdd") %>"><input  name="button" type="button" value="생성"></a>    
        </div>
        <%                                
        	rsDays.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			일자 없습니다.
        </div>
        <% end if         
       	set rsDays = nothing
        %>   
  </div>
  
  </td>
  <td width=600 valign=top>

    <div style="padding:8px;text-align:center;background-color:#ffffff;">
    <%=yyyymmdd %>일 UP&DOWN tr_time
    </div>

    <div style="0 0 10px 0;">
    
    	<% if NoDataGameTime = False then ' 데이터가 있으면 데이터 출력 %>    	
        <% tr_old = mid(rsGameTime("tr_time"),1,2) %>
        <table cellSpacing="0" cellPadding="0" border="1" ID="Table3" width="100%">
        <tr>
        <td width="14%" valign="top">
        <% Do While Not rsGameTime.EOF %>
        <div style="padding:5px;text-align:center;">
        <span style="color:#3388cc;font-weight:bold;"><%=rsGameTime("tr_time") %></span></a>   
        <% if rsGameTime("status_flag") = "0" then %>
          <%=rsGameTime("status_desc") %>
        <% elseif rsGameTime("status_flag") = "1" then %>
          <span style="color:#00ff66;font-weight:bold;"><%=rsGameTime("status_desc") %></span>
        <% elseif rsGameTime("status_flag") = "2" then %>
          <span style="color:#47B7AD;font-weight:bold;"><%=rsGameTime("status_desc") %></span>
        <% else %>
          <span style="color:#dddddd;"><%=rsGameTime("status_desc") %></span>
        <% end if %>
        </div>
        <% if tr_old <> mid(rsGameTime("tr_time"),1,2) then %></td><td width="14%" valign="top"><% end if %>
        <%  tr_old = mid(rsGameTime("tr_time"),1,2)
        	rsGameTime.MoveNext
	        Loop 
        %>
        </tr>
        </table>
		<% else %>
		<div style="padding:10px;text-align:center;">
			시각 없습니다.
        </div>
        <% end if         
       	set rsGameTime = nothing
        %>   
        
    </div>
    
 

  </td>
  </tr> 
  </table>
  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
