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


  strSQL = "p_sm_game_theme_today "

 ' response.write strSQL
 ' response.End
  
  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if NOT rs.EOF and NOT rs.BOF then
    game_no = rs("game_no")
  end if   

  set rs = nothing


  strSQL = "p_sz_test_member_user_list "

 ' response.write strSQL
 ' response.End
  
  Set rsUser = Server.CreateObject("ADODB.RecordSet")
  rsUser.Open strSQL, DbCon, 1, 1

  if rsUser.EOF or rsUser.BOF then
	NoDataUser = True
  Else
	NoDataUser = False
  end if   


  if request("member_id") <> "" then  
	member_id = request("member_id")
	member_no = request("member_no")
  end if 
  
  strSQL = "p_sz_test_item_list  '" & game_day & "'"

  'response.write strSQL
  'response.End

  Set rsItems = Server.CreateObject("ADODB.RecordSet")
  rsItems.Open strSQL, DbCon, 1, 1

  if rsItems.EOF or rsItems.BOF then
	NoDataItems = True
  Else
	NoDataItems = False
  end if   
  
  
  strSQL = "p_sz_test_theme_list  '" & game_no & "'"
  
  Set rsTheme = Server.CreateObject("ADODB.RecordSet")
  rsTheme.Open strSQL, DbCon, 1, 1

  if rsTheme.EOF or rsTheme.BOF then
	NoDataTheme = True
  Else
	NoDataTheme = False
  end if  
 
 
%>
<SCRIPT language="javascript">
    function updownBet() {
        formUpdown.submit();
    }
</SCRIPT>

<div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="1024">
<tr>
<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>
<td width=754 valign=top>  

<% membermenu = "BETTEST"
   menu_desc = "베팅TEST"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr>
  <td width=204 valign=top>

    <div style="padding:5px;text-align:center;border-bottom:dotted 1px #dddddd;">    
    <form action="#" id="formTool" name="formTool" method="post">
      <input type="text" name="prefix" style="width:100px;text-align:center;" value="" placeholder="9자이하 prefix" />
      <input type="submit" value="ID생성" />
    </form>
    </div>
    <div style="padding:5px;text-align:center;border-bottom:dotted 1px #dddddd;">    
    <form action="sz_test_member_charge.asp" id="form2" name="formCharge" method="post">
      <input type="text" name="charge_amt" style="width:100px;text-align:center;" value="1000000" />
      <input type="submit" value="일괄충전" />
    </form>
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">  
    	<% if NoDataUser = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsUser.EOF %>
        <% if rsUser("member_id") = member_id then %>
          <tr height="22" style="border-bottom:solid 1px #dddddd;background-color:#47b7ad;">
        <% else %>
          <tr height="22" style="border-bottom:solid 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; text-align:center;line-height:200%;"  >
        <a href="bettest.asp?member_id=<%=rsUser("member_id") %>&member_no=<%=rsUser("member_no") %>">
        <span style="font-weight:bold;color:#3388cc;"><%=rsUser("member_id") %></span></a>
        <%=rsUser("point_total") %>
        </td>
        </tr>
        <%                                
        	rsUser.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			Test아이디가 없습니다.
        </div>
        <% end if         
       	set rsUser = nothing
        %>   
    </table>
  
  </td>
  <td width=550 valign=top>
  
    <div style="padding:10px; text-align:center;font-weight:bold;color:#3388cc;font-size:12pt;">
    현재 게임일 : <%=mid(game_day,1,4) %>년 <%=mid(game_day,5,2) %>월  <%=mid(game_day,7,2) %>일 <br /><%=member_id %> <a href="bettest.asp"><input type="button" value="NEW" /></a>
    </div>
    <div style="padding:10px; text-align:center;background-color:#ffffff;font-weight:bold;color:#000000;font-size:12pt;">
        UP&DOWN
    </div>

    <div style="padding:10px 5px 10px 5px;text-align:center;border-bottom:dotted 1px #dddddd;"> 
    <table>
    <tr>
    <td width="80%" align="center">
    <% if member_id <> "" then %>   
    <form action="sz_test_updown_bet.asp" id="form1" name="formUpdown" method="post">
      <input type="hidden" name="member_id" value="<%=member_id %>" checked>
      <input type="hidden" name="member_no" value="<%=member_no %>" checked>
      <input type="radio" name="updown_cd" value="UP" checked>UP
      <input type="radio" name="updown_cd" value="DRAW">DRAW
      <input type="radio" name="updown_cd" value="DOWN">DOWN
      <input type="text" name="bet_amt" value="5000" style="width:100px;text-align:center;" placeholder="베팅금액" /><br />
      <input type="submit" value="<%=member_id %>자동베팅" />
    </form>
    <% else %>
    회원을 선택하여 베팅하세요.
    <% end if %>
    </td>
    <td width="20%" align="center">      
    <a href="sz_test_updown_bet.asp?updown_cd=UP&bet_amt=50000">
      <input type="button" value="전체50000자동베팅" /></a>
    </td>
    </tr>
    </table>
    </div>

    <div style="padding:10px; text-align:center;background-color:#ffffff;font-weight:bold;color:#000000;font-size:12pt;">
        종목별
    </div>


    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25">
    <td width="50%">
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="50%" align="center" style="border-right:dotted 1px #ffffff;">종목1</td>  
    <td width="50%" align="center" style="border-right:dotted 1px #ffffff;">종목2</td>
    </tr>    
   	<% if NoDataItems = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsItems.EOF %>       
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <td style="padding:5px;color:#000000;font-weight:bold;text-align:center;">
        <%=rsItems("company_name1") %>
        </td>
        <td style="padding:5px;color:#000000;font-weight:bold;text-align:center;">
        <%=rsItems("company_name2") %>
        </td>
        </tr>
        <%                                
        	rsItems.MoveNext
	        Loop 
        %>
	<% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <td style="padding:5px;" colspan="4">
			게임이 없습니다.
        </td></tr>
    <% end if         
       	set rsItems = nothing
    %>   
    </table>
    </td>  
    <td width="50%" align="center">
      <form action="sz_test_item_bet.asp" id="form3" name="formItem" method="post">
      <input type="hidden" name="yyyymmdd" value="<%=game_day %>" checked>
      <input type="text" name="bet_amt" value="50000" style="width:100px;text-align:center;" placeholder="베팅금액" />
      <input type="submit" value="베팅" />
      </form>
    </td>  
    </table>
    
    <div style="padding:10px; text-align:center;background-color:#ffffff;font-weight:bold;color:#000000;font-size:12pt;">
        테마별
    </div>  
        

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25">
    <td width="50%">
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="50%" align="center" style="border-right:dotted 1px #ffffff;">테마</td>  
    <td width="50%" align="center" style="border-right:dotted 1px #ffffff;"></td>
    </tr>    
   	<% if NoDataTheme = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsTheme.EOF %>       
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <td style="padding:5px;color:#000000;font-weight:bold;text-align:center;">
        <%=rsTheme("theme_name") %>
        </td>
        <td style="padding:5px;color:#000000;font-weight:bold;text-align:center;">
        </td>
        </tr>
        <%                                
        	rsTheme.MoveNext
	        Loop 
        %>
	<% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <td style="padding:5px;" colspan="4">
			테마가 없습니다.
        </td></tr>
    <% end if         
       set rsTheme = nothing
    %>   
    </table>
    </td>  
    <td width="50%" align="center">
      <form action="sz_test_theme_bet.asp" id="form4" name="formTheme" method="post">
      <input type="hidden" name="game_no" value="<%=game_no %>" checked>
      <input type="text" name="bet_amt" value="50000" style="width:100px;text-align:center;" placeholder="베팅금액" />
      <input type="submit" value="베팅" />
      </form>
    </td>  
    </table>
    
  </td>
  </tr> 
  </table>
  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
