<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("game_no") = "" or request("game_no") = "0" then	
    game_no = "0"
  else
	game_no = request("game_no")
    strSQL = "p_sm_game_item_detail '" & game_no & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
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
      theme_type = rs("theme_type")
      status_flag = rs("status_flag")
    end if 
    set rs = nothing
  end if 
  
  ' game list 읽기
  strSQL = "p_sm_game_theme_kospi_list "

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
  ' stock 읽기
  strSQL = "p_sh_game_theme_list '" & game_no & "'"
	
  ' 페이지 작동되는 방식
  Set rsGameTheme = Server.CreateObject("ADODB.RecordSet")
  rsGameTheme.cursorlocation = 3
  rsGameTheme.Open strSQL, DbCon, 1, 3
  
  if rsGameTheme.EOF or rsGameTheme.BOF then
	NoDataGameTheme = True
  Else
	NoDataGameTheme = False
  end if 
  
  
%>

  <div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="1024">
<tr>
<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>
<td width=754 valign=top>  

<% membermenu = "GAME"
   menu_desc = "KOSPI 테마별매치설정"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

 <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="784">
  <tr>
  <td width=254 valign=top>
  <div style="margin:0 0 3px 0;padding:10px;text-align:center;background-color:#dddddd;">테마별매치</div>
  <div style="margin:0 0 10px 0;padding:5px;text-align:center;line-height:180%;">

    <form action="theme_game_kospi_insert.asp" id="form4" name="formTool" method="post">
    <input id="submit5" name="submit1" type="submit" value="매치생성">
    </form>

  </div> 
     
    <table cellSpacing="0" cellPadding="0" border="0" ID="Table3" width="100%">
    	<% if NoDataGame = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsGame.EOF %>
        <tr height=25>
        <td width="25%">
        <div style="padding:5px;text-align:left;"> 
        <a href="kospitheme_game.asp?game_no=<%=rsGame("game_no") %>"><%=rsGame("turn_no") %>회차</a>
        </div>
        </td>        
        <td width="45%">
        <div style="padding:5px;text-align:center;"> 
        <%=rsGame("yyyymmdd") %><br /><%=rsGame("tr_time") %>
        </div>
        </td>

        <td width="30%">
        <div style="padding:5px;text-align:center;"> 
        <% if rsGame("status_flag") = "0" then %> 준비
        <% else %>
        <% end if %>
        <% if rsGame("status_flag") = "1" then %> 배팅중
        <% else %>
        <% end if %>
        <% if rsGame("status_flag") = "2" then %> 종료
        <% else %>
        <% end if %>
        <% if rsGame("status_flag") = "3" then %> 정산
        <% else %>
        <% end if %>
        </div>
        </td>

        </tr>
        <%                                
        	rsGame.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			테마별매치 없습니다.
        </div>
        <% end if         
       	set rsGame = nothing
        %>   
    </table>
  
  </td>
  <td width=500 valign=top>


  <% if game_no > "0" then %>

    <div style="margin:0 0 3px 0;padding:10px 3px 10px 3px;text-align:center;background-color:#dddddd;font-weight:bold;">
    <%=market_cd %> : 테마별매치 <%=game_name %>
    <span style="margin:0 0 0 20px;color:#ff6600;">종료시간 : <%=end_time %></span>
     
    <form action="theme_game_kospi_update.asp" id="form3" name="formTool" method="post">
    <input type="hidden" name="game_no" value="<%=game_no %>" ID="Hidden3"> 

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

    <input id="submit4" name="submit1" type="submit" value="매치수정">
    </form>
     
    </div>
    
    <table cellpadding=0 cellspacing=0 border=0 width="100%">
    	<% if NoDataGameTheme = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsGameTheme.EOF    %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">          
          <td width="15%" align="center">
          <%=rsGameTheme("theme_type_desc") %>
          </td>         
          <td width="10%" align="center">
          <%=rsGameTheme("order_no") %>
          </td>
          <td width="20%" align="center">
          <%=rsGameTheme("theme_name") %> (<%=rsGameTheme("theme_no") %>)
          </td>
          <td width="20%" align="center">
          <%=rsGameTheme("theme_name2") %> (<%=rsGameTheme("theme_no2") %>)
          </td>
          <td width="15%" align="center">
          <%=rsGameTheme("dividend_rate") %>
          </td>
          </tr>     

        <%                            
        	rsGameTheme.MoveNext
	        Loop 
        %>
		<% else %>
		<tr>
		<td>
		<div style="padding:10px;text-align:center;">
			테마가 없습니다.
        </div>
        </td>
        </tr>
        <% end if         
       	set rsGameTheme = nothing
        %> 
    </table>


  <% else %>
    <div style="margin:0 0 3px 0;padding:10px;text-align:center;background-color:#dddddd;font-weight:bold;">
    왼쪽에서 테마별매치를 선택하세요.
    </div>
  <% end if %>
   

  </td>
  </tr> 
  </table>
  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
