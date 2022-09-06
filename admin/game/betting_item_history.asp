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


  strSQL = "p_sh_game_betting_item_list '" & yyyymmdd & "' "
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
        <a href="betting_item_history.asp?yyyymmdd=<%=rsYyyymmdd("yyyymmdd") %>">
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

    
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% bet_dividend_rate = 1.0
       old_betting_no = rsData("betting_no")
       Do While Not rsData.EOF  %> 

    <% if old_betting_no * 1 - rsData("betting_no") <> 0 then 
       dividend_amt_total = round(bet_dividend_rate,2) * rsData("bet_net_amt") %>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" style="border-bottom:solid 2px #000000; background-color:#dddddd;">
    <td align="center" width="30%">아이디 : <%=rsData("member_id") %></td>   
    <td align="center" width="20%">베팅액 : <%=rsData("bet_net_amt") %></td>     
    <td align="center" width="20%">배당율 : <%=round(bet_dividend_rate,2) %></td>  
      <% if win_flag = "1" then %>
      <td align="center" width="20%" style="background-color:#ff6600;">
      배당금 : <%=dividend_amt_total %>
      </td>  
      <% else %>
      <td align="center" width="20%">
      배당금 : <%=dividend_amt_total %>
      </td>  
      <% end if %>  

      <% if win_total_desc = "승" then %>
      <td align="center" width="10%" style="background-color:#ff0000;" >
      승</td>
      <% elseif win_total_desc = "패" then %>
      <td align="center" width="10%">
      패</td>
      <% else %>
      <td align="center" width="10%">
      진행중</td>
      <% end if %>

    <% bet_dividend_rate = 1.0 %>
    </tr>
    </table>
    <% end if %>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" style="border-bottom:dotted 1px #dddddd;">
    <td width="10%"></td>   
    <td width="25%" align="center">
    <% if rsData("select_no") = "1" then%>
    <span style="color:#ff6600; font-weight:bold;"><%=rsData("stock_name1") %></span>
    <% else %>
    <%=rsData("stock_name1") %>
    <% end if %>
    </td>  
    <td width="25%" align="center">
    <% if rsData("select_no") = "2" then%>
    <span style="color:#ff6600; font-weight:bold;"><%=rsData("stock_name2") %></span>
    <% else %>
    <%=rsData("stock_name2") %>
    <% end if %>
    </td> 
    <td width="10%" align="center"><%=rsData("dividend_rate1") %></td>
    <td width="10%" align="center"><%=rsData("dividend_rate2") %></td>
    <td width="20%" align="center">
    <% if rsData("win_no") = "1" then %><%=rsData("stock_name1") %>승
    <% elseif rsData("win_no") = "2" then %><%=rsData("stock_name2") %>승
    <% else %>
    진행중
    <% end if %>
    </td> 
    </tr>
    </table>


    

    <% 	
        win_flag = rsData("win_flag")
        win_total_desc = rsData("win_total_desc")
        bet_dividend_rate = bet_dividend_rate * cDbl(rsData("dividend_rate"))
        old_betting_no = rsData("betting_no")
        member_id = rsData("member_id")
        bet_net_amt = rsData("bet_net_amt")
        rsData.MoveNext
	    Loop 
    %>
     <% dividend_amt_total = round(bet_dividend_rate,2) * bet_net_amt %>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" style="border-bottom:solid 2px #000000; background-color:#dddddd;">
    <td align="center" width="30%">아이디 : <%=member_id %></td>   
    <td align="center" width="20%">베팅액 : <%=bet_net_amt %></td>     
    <td align="center" width="20%">배당율 : <%=round(bet_dividend_rate,2) %></td>  
      <% if win_flag = "1" then %>
      <td align="center" width="20%" style="background-color:#ff6600;">
      배당금 : <%=dividend_amt_total %>
      </td>  
      <% else %>
      <td align="center" width="20%">
      배당금 : <%=dividend_amt_total %>
      </td>  
      <% end if %>  

      <% if win_total_desc = "승" then %>
      <td align="center" width="10%" style="background-color:#ff0000;" >
      승</td>
      <% elseif win_total_desc = "패" then %>
      <td align="center" width="10%">
      패</td>
      <% else %>
      <td align="center" width="10%">
      진행중</td>
      <% end if %>

    <% bet_dividend_rate = 1.0 %>
    </tr>
    </table>
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
