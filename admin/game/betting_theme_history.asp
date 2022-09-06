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

  if request("yyyymmdd") <> "" then  
	yyyymmdd = request("yyyymmdd")
  else
	yyyymmdd = game_day
  end if 

  'calculate_list 읽기
  strSQL = "p_sh_betting_yyyymmdd_list "

  Set rsYyyymmdd = Server.CreateObject("ADODB.RecordSet")
  rsYyyymmdd.Open strSQL, DbCon, 1, 1

  if rsYyyymmdd.EOF or rsYyyymmdd.BOF then
	NoDataYyyymmdd = True
  Else
	NoDataYyyymmdd = False
  end if   
  'response.write strSQL
  'response.End


  strSQL = "p_sh_game_betting_single_theme_list '" & yyyymmdd & "' "
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
  end if  
%>

  <div style="height:20px;"></div>
    <table width="1024" border="0" cellpadding="0" cellspacing="0">
<tr>

<td width=270 valign=top>

  <!-- #include virtual="/_include/menu_admin_game.asp" -->
</td>
<td width=754> 
<% membermenu = "BETHISTORY"
   menu_desc = "베팅 HISTORY"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->
    <table width="100%" border="1" cellpadding="0" cellspacing="0">
    <tr>

  <td width=84 valign=top>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#00856A">
    <td width="40%" align="center" style="border-right:dotted 1px #ffffff; color:#ffffff;">게임일</td>   
    </tr>
    
    	<% if NoDataYyyymmdd = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsYyyymmdd.EOF %>
        <% if rsYyyymmdd("yyyymmdd")  = yyyymmdd then %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
        <% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;"   >
        <a href="betting_updown_history.asp?yyyymmdd=<%=rsYyyymmdd("yyyymmdd") %>">
        <span style="font-weight:bold; color:#3388CC;"><%=rsYyyymmdd("yyyymmdd") %></span></a>
        </td>
        </tr>
        <%                                
        	rsYyyymmdd.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			게임일이 없습니다.
        </div>
        <% end if         
       	set rsYyyymmdd = nothing
        %>   
    </table>
  
  </td>


<td width=670 valign=top>  


    <div style="padding : 10px;">
    <a href="betting_updown_history.asp"><span class="linkbtn">UP&DOWN</span></a>
    <a href="betting_item_history.asp"><span class="linkbtn">종목</span></a>
    <a href="betting_single_theme_history.asp"><span class="linkbtn">테마(단식)</span></a>
    <a href="betting_double_theme_history.asp"><span class="linkbtn">테마(복식)</span></a>
    </div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#00856A">
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">아이디</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">게임</td>  
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">금액</td>    
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">베팅</td>     
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">결과</td>
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">배당률</td>
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">배당금</td>  
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="25" style="border-bottom:dotted 1px #dddddd;">
    <td align="center"><%=rsData("member_id") %></td>   
    <td align="center"><%=rsData("game_type_desc") %> - <%=rsData("tr_time") %></td>   
    <td align="center"><%=rsData("bet_net_amt") %></td>    
    <td align="center"><%=rsData("auto_desc") %> - <%=rsData("updown_cd") %></td>    
    <td align="center"><%=rsData("updown_cd_result") %></td>    
    <td align="center"><%=rsData("dividend_rate") %></td>  
    <% if rsData("dividend_amt") > 0 then %>
    <td align="center" style="background-color:#47B7AD;">
    <%=rsData("dividend_amt") %>
    </td>  
    <% else %>
    <td align="center">
    <%=rsData("dividend_amt") %>
    </td>  
    <% end if %>
    </tr>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="55" >
    <td width="60" align="center" colspan="7">오늘의 베팅이 없습니다.</td>
    </tr>
    <% end if         
    set rsData = nothing
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
