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

  if request("yyyymmdd") = "" then
    yyyymmdd = game_day
  else
    yyyymmdd = request("yyyymmdd")
  end if

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
      yyyymm = mid(yyyymmdd,1,6)
    end if
  
  end if


  ' member 읽기
  strSQL = "p_sh_calculate_history_yyyymmdd '" & yyyymm & "','" &  game_type & "'"
  'response.Write strSQL
  
  ' 페이지 작동되는 방식
  Set rsYyyymmdd = Server.CreateObject("ADODB.RecordSet")
  rsYyyymmdd.cursorlocation = 3
  rsYyyymmdd.Open strSQL, DbCon, 1, 3

  if rsYyyymmdd.EOF or rsYyyymmdd.BOF then
	NoDataYyyymmdd = True
  Else
	NoDataYyyymmdd = False
  end if 
  

   strSQL = "p_sh_calculate_history_list '" & yyyymmdd & "','" &  request("game_type") & "'"
    
    'response.write strSQL
    'response.end

    Set rsDetail = Server.CreateObject("ADODB.RecordSet")
    rsDetail.Open strSQL, DbCon, 1, 1
   
    if rsDetail.EOF or rsDetail.BOF then
    	NoDataDetail = True
    Else
    	NoDataDetail = False
    end if 

%>
<div style="height:20px;"></div>
<table width="1024" cellpadding="0" cellspacing="0" border="0">
<tr>
<td width=270 valign=top>

  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "CALCULATE HISTORY"
   menu_desc = "정산HISTORY"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

    <div style="margin:10px 5px 0 0;padding:5px;text-align:left;text-align:center;">    
    <form action="calculate_history.asp" id="formCalendar" name="formCalendar" method="post">
    <input type="hidden" name="today"  value="<%=today %>">
    <a href="calculate_history.asp?yyyymm=<%=yyyymm%>&date_arrow=0"><span class="linkbtn" >-</span></a>
    <input type="text" name="yyyymm" style="width:80px;text-align:center;" class="input" ID="Text2" value="<%=yyyymm%>">
    <a href="calculate_history.asp?yyyymm=<%=yyyymm%>&date_arrow=1"><span class="linkbtn" >+</span></a>
    <span class="linkbtn" onclick="yyyymmselect();" >조회</span>&nbsp;&nbsp;&nbsp;
    </form>	
    </div>

  <table width="100%" cellpadding="0" cellspacing="0" border="1">
  <tr>
  <td width=200 valign=top>
         <div style="padding:5px;text-align:center;background-color:#dddddd;">날짜</div>

    <table width="100%" cellpadding=0 cellspacing=0 border=0>
    	<% if NoDataYyyymmdd = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsYyyymmdd.EOF %>    
        <% if rsYyyymmdd("yyyymmdd") = yyyymmdd then %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47B7AD;">
          <% else %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <% end if %>         
          <td width="40%" align="center">
          <a href="calculate_history.asp?yyyymmdd=<%=rsYyyymmdd("yyyymmdd") %>">
          <span style="font-weight:bold;color:#3388cc;"><%=rsYyyymmdd("yyyymmdd") %></span></a>
          </td>  
          <td width="20%" align="center">
          <a href="calculate_history.asp?yyyymmdd=<%=rsYyyymmdd("yyyymmdd") %>&game_type=U">U/D</a>
          </td>  
          <td width="20%" align="center">
          <a href="calculate_history.asp?yyyymmdd=<%=rsYyyymmdd("yyyymmdd") %>&game_type=I">종목</a>
          </td>
          <td width="20%" align="center">
          <a href="calculate_history.asp?yyyymmdd=<%=rsYyyymmdd("yyyymmdd") %>&game_type=T">테마</a>
          </td>  
          </tr>

        <%                          
        	rsYyyymmdd.MoveNext
	        Loop 
        %>
		<% else %>
		<tr height="25">
		<td align="center" colspan="3">
        	정산일이 없습니다.
        </td></tr>
        <% end if         
       	set rsYyyymmdd = nothing
        %> 
    </table>
  
  </td>


  <td width=554 valign=top>

  <% if yyyymmdd <> "" then %>
  <div style="padding:5px;text-align:center;background-color:#dddddd;"><%=yyyymmdd %> (<%=game_type %>)
  </div>

      <% if NoDataDetail = False then ' 데이터가 있으면 데이터 출력 %>
      <table width="100%" cellpadding=0 cellspacing=0 border=0> 
        <tr height="25" bgcolor="#dddddd" style="border-top:solid 1px #ffffff;">
           <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">게임#</td> 
           <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">종류</td> 
           <td width="70%"  align="center" style="border-right:dotted 1px #ffffff;">정산내용</td> 
           <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">#</td>  
        </tr>
      <% Do While Not rsDetail.EOF  %>
        <tr  height="25" style="border-bottom:solid 1px #dddddd;">
        <td width="10%" align="center">
        <%=rsDetail("game_no") %>
        </td>
        <td width="10%" align="center">
        <%=rsDetail("game_type") %>
        </td>
        <td width="75%" align="left">
        <%=rsDetail("calculate_desc") %>
        </td>
        <td width="5%" align="center">
        <%=rsDetail("result_no") %>
        </td>
        </tr>

      <% rsDetail.MoveNext
	     Loop 
      %>
      </table>
      <%
      else
      %>
      <table width="100%" cellpadding=0 cellspacing=0 border=0> 
        <tr height="25">
        <td align="center" colspan="4">
      정산이 없습니다.
        </td>
        </tr>
      </table>
      <%
      end if         
      set rsDetail = nothing
      %>


  <% else %>
    <table width="100%"  border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="100%" align="center">날짜를 클릭하세요
    </td>
    </tr>  
    </table>
  <% end if %>    
  </td>
  </table>

  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
