<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
  
<SCRIPT language="javascript">
      function yyyymmselect() {
          formCalendar.submit();
      }
</SCRIPT>

<%

  'Session("yyyymmdd") = mid(now(),1,4) + mid(now(),6,2)  + mid(now(),9,2) 

  strSQL = "p_config_datetime_read "

  'response.write strSQL
  'response.end
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1
      
  yyyymmdd = rs("yyyymmdd")
  hhmmsss = rs("hhmmsss")
  set rs = nothing

  ' 월 읽기
  if request("yyyymm") = "" then
  
    yyyymm = mid(yyyymmdd,1,6)

  else
  
    if request("date_arrow") = "1" then    ' 후월
      strSQL = "p_config_yyyymm_read '"& request("yyyymm") &"','F'"
      Set rsData = Server.CreateObject("ADODB.RecordSet")
      rsData.Open strSQL, DbCon, 1, 1
      
      yyyymm = rsData("yyyymm")
      set rsData = nothing
    elseif request("date_arrow") = "0" then    ' 전월
      strSQL = "p_config_yyyymm_read '"& request("yyyymm") &"','P'"
      Set rsData = Server.CreateObject("ADODB.RecordSet")
      rsData.Open strSQL, DbCon, 1, 1

      yyyymm = rsData("yyyymm")
      set rsData = nothing
    else 
      yyyymm = Session("yyyymm")
    end if
  
  end if


  ' 일 읽기
  if request("today") = "" then  
    today = yyyymmdd
  else
    today = request("today")
  end if

  ' 그 달의 일수 읽기
  strSQL = "p_sm_game_updawn_days '" & yyyymm & "'"
  

  'response.write strSQL
  'response.end  
  
  Set rsDays = Server.CreateObject("ADODB.RecordSet")
  rsDays.Open strSQL, DbCon, 1, 1

  if rsDays.EOF or rsDays.BOF then
    NoDataDays = True
  Else
    NoDataDays = False
  end if  
  
  
  if request("game_no") = "" or request("game_no") = "0" then	
    game_no = "0"
  else
	game_no = request("game_no")
    strSQL = "p_sm_game_item_detail '" & game_no & "' "
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      market_cd = rs("market_cd")
      game_cd = rs("game_cd")
      game_name = rs("game_name")
      stock_no1 = rs("stock_no1")
      stock_no2 = rs("stock_no2")
      logo_img1 = rs("logo_img1")
      company_name1 = rs("company_name1")
      logo_img2 = rs("logo_img2")
      company_name2 = rs("company_name2")
      end_time = rs("end_time")
      status_flag = rs("status_flag")
      yyyymmdd = rs("yyyymmdd")
      market_cd = rs("market_cd")
      turn_no = rs("turn_no")
    end if 
    set rs = nothing
  end if 
  
  ' game list 읽기
  strSQL = "p_sm_game_updown_kospi_list '" & today & "'"

  'response.write strSQL
  'response.end

  Set rsGame = Server.CreateObject("ADODB.RecordSet")
  rsGame.Open strSQL, DbCon, 1, 1

  if rsGame.EOF or rsGame.BOF then
	NoDataGame = True
  Else
	NoDataGame = False
  end if     
  
  'response.write strSQL
  'response.end  
  
%>

<div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="1024">
<tr>
<td width=240 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>
<td width=784 valign=top>  

<% membermenu = "GAME"
   menu_desc = "KOSPI UP & DOWN"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

    <div style="margin:10px 5px 0 0;padding:5px;text-align:left;text-align:center;">    
    <form action="updown_kospi.asp" id="formCalendar" name="formCalendar" method="post">
    <input type="hidden" name="today"  value="<%=today %>">
    <a href="updown_kospi.asp?yyyymm=<%=yyyymm%>&date_arrow=0"><span class="linkbtn" >-</span></a>
    <input type="text" name="yyyymm" style="width:80px;text-align:center;" class="input" ID="Text2" value="<%=yyyymm%>">
    <a href="updown_kospi.asp?yyyymm=<%=yyyymm%>&date_arrow=1"><span class="linkbtn" >+</span></a>
    <span class="linkbtn" onclick="yyyymmselect();" >조회</span>&nbsp;&nbsp;&nbsp;
        
    <% if NoDataDays = False then
    Do While Not rsDays.EOF  %> 
      <% if rsDays("yyyymmdd") = today then  %>
      <a href="updown_kospi.asp?today=<%=rsDays("yyyymmdd") %>">
      <span style="color:#ff6600;font-weight:bold;padding:2px;"><%=rsDays("gameday") %></span>
      </a>
      <% else %>
      <a href="updown_kospi.asp?yyyymm=<%=yyyymm %>&today=<%=rsDays("yyyymmdd") %>">
      <span style="color:#000000;font-weight:bold;padding:2px;"><%=rsDays("gameday") %></span>
      </a>
      <% end if %>
    <%     
      rsDays.MoveNext
      Loop 
      set rsDays = nothing
         
      else %>         
        일자가 없습니다.
    <% end if %>
    </form>	
    </div>
    
    

  <div style="padding:10px;text-align:center;background-color:#dddddd;font-weight:bold;">KOSPI UP&DOWN</div>
  <div style="margin:0 0 10px 0;padding:5px;text-align:center;line-height:180%;background-color:#ffffff;">
  <% if game_no > "0" then %>
    <form action="updown_kospi_update.asp" id="form3" name="formTool" method="post">
    <input type="hidden" name="game_no" value="<%=game_no %>" ID="Hidden3"> 	
    <%=market_cd %> &nbsp;<%=yyyymmdd %>일 - <%=turn_no %>회
    <input id="submit4" name="submit1" type="submit" value="수정">&nbsp;&nbsp;&nbsp;
    <a href="updown_insert.asp"><input id="submit1" name="submit1" type="button" value="생성"></a><br />
    
    <% if status_flag = "0"  then %>
    <input type="radio" name="status_flag" value="0" checked  /> 준비
    <% else %>
    <input type="radio" name="status_flag" value="0" /> 준비
    <% end if %>

    <% if status_flag = "1"  then %>
    <input type="radio" name="status_flag" value="1" checked  /> 배팅중
    <% else %>
    <input type="radio" name="status_flag" value="1" /> 배팅중
    <% end if %>

    <% if status_flag = "2"  then %>
    <input type="radio" name="status_flag" value="2" checked  /> 종료
    <% else %>
    <input type="radio" name="status_flag" value="2" /> 종료
    <% end if %>

    <% if status_flag = "3"  then %>
    <input type="radio" name="status_flag" value="3" checked  /> 정산
    <% else %>
    <input type="radio" name="status_flag" value="3" /> 정산
    <% end if %>

    </form>
  <% else %>
    <form action="updown_kospi_insert.asp" id="form4" name="formTool" method="post">
    <input id="submit5" name="submit1" type="submit" value="생성">
    </form>
  <% end if %>
  </div> 
     
    <table cellSpacing="0" cellPadding="0" border="1" ID="Table3" width="100%">
        <tr height=25  style="background-color:#dddddd;">
        <td width="30%" style="text-align:center;font-weight:bold;">게임
        </td>
        <td width="15%" style="text-align:center;font-weight:bold;">상태
        </td>
        <td width="15%" style="text-align:center;font-weight:bold;">지수
        </td>
        <td width="15%" style="text-align:center;font-weight:bold;">UP DOWN
        </td>
        <td width="15%" style="text-align:center;font-weight:bold;">변동값
        </td>
        <td width="10%" style="text-align:center;font-weight:bold;">
        </td>
        </tr>
    	<% if NoDataGame = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsGame.EOF %>
        <tr height=25>
        <td width="30%">
        <div style="padding:5px;text-align:center;"> 
        <a href="updown_kospi.asp?game_no=<%=rsGame("game_no") %>"><%=rsGame("yyyymmdd") %>일 <%=rsGame("turn_no") %>회차</a>
        </div>
        </td>
        <td width="15%">
        <div style="padding:5px;text-align:center;"> 
        <% if rsGame("status_flag") = "0" then %> 준비
        <% elseif rsGame("status_flag") = "1" then %> 배팅중
        <% elseif rsGame("status_flag") = "2" then %> 종료
        <% elseif rsGame("status_flag") = "3" then %> 정산
        <% end if %>
        </div>
        </td>
        <td width="15%" style="text-align:center;font-weight:bold;"><%=rsGame("index_value") %>
        </td>
        <td width="15%" style="text-align:center;font-weight:bold;"><%=rsGame("updown_cd") %>
        </td>
        <td width="15%" style="text-align:center;font-weight:bold;"><%=rsGame("index_variance") %>
        </td>
        <td width="10%" style="text-align:center;font-weight:bold;"><%=rsGame("game_no_prev") %> ▶ <%=rsGame("game_no") %>
        </td>
        </tr>
        <%                                
        	rsGame.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			UP&DOWN매치 없습니다.
        </div>
        <% end if         
       	set rsGame = nothing
        %>   
    </table>

  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
