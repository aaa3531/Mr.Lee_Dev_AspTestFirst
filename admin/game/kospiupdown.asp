<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
  
<SCRIPT language="javascript">
      function yyyymmselect() {
          formCalendar.submit();
      }
</SCRIPT>

<%

  Session("yyyymm") = mid(now(),1,4) + mid(now(),6,2) 

  ' 월 읽기
  if request("yyyymm") = "" then
  
    yyyymm = Session("yyyymm")

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

  ' 그 달의 일수 읽기
  strSQL = "p_sm_game_updawn_days '" & yyyymm & "'"
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
    end if 
    set rs = nothing
  end if 
  
  ' game list 읽기
  strSQL = "p_sm_game_item_list "

  'response.write strSQL
  'response.end

  Set rsGame = Server.CreateObject("ADODB.RecordSet")
  rsGame.Open strSQL, DbCon, 1, 1

  if rsGame.EOF or rsGame.BOF then
	NoDataGame = True
  Else
	NoDataGame = False
  end if     
  
  ' stock 읽기
  strSQL = "p_sm_stock_item_list '" & market_cd & "', '" & request("keyword") & "', '" & game_no & "'"
	
  'response.write strSQL
  'response.end
  ' 페이지 작동되는 방식
  Set rsStock = Server.CreateObject("ADODB.RecordSet")
  rsStock.cursorlocation = 3
  rsStock.Open strSQL, DbCon, 1, 3
  
  if rsStock.EOF or rsStock.BOF then
	NoDataStock = True
  Else
	NoDataStock = False
  end if 
  
  '페이징처리관련
  page =request("page")
  If NoDataStock = False then
		Cus_pageSize = 20
		rsStock.PageSize = Cus_pageSize

		pagecount=rsStock.pagecount
		totalRecord = rsStock.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsStock.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsStock.PageSize) + 1)

		if page > lastpg then
			page = lastpg
		end If

	end if
	'페이징처리관련 끝 

  'response.write strSQL
  'response.end
  

  
%>

  <div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="1024">
<tr>
<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>
<td width=754 valign=top>  

<% membermenu = "GAME"
   menu_desc = "KOSPI UP & DOWN"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

    <div style="margin:10px 5px 0 0;padding:5px;text-align:left;text-align:center;">    
    <form action="updown.asp" id="formCalendar" name="formCalendar" method="post">
    <input type="hidden" name="today"  value="<%=today %>">
    <a href="updown.asp?yyyymm=<%=yyyymm%>&date_arrow=0"><span class="linkbtn" >-</span></a>
    <input type="text" name="yyyymm" style="width:80px;text-align:center;" class="input" ID="Text2" value="<%=yyyymm%>">
    <a href="updown.asp?yyyymm=<%=yyyymm%>&date_arrow=1"><span class="linkbtn" >+</span></a>
    <span class="linkbtn" onclick="yyyymmselect();" >조회</span>&nbsp;&nbsp;&nbsp;
        
    <% if NoDataDays = False then
    Do While Not rsDays.EOF  %> 
      <% if rsDays("yyyymmdd") = today then  %>
      <span style="color:#ff6600;font-weight:bold;font-size:11pt;padding:2px;"> <%=rsDays("topicday") %></span>
      <% else %>
      <a href="default.asp?yyyymm=<%=yyyymm %>&today=<%=rsDays("yyyymmdd") %>">
      <span style="color:#000000;font-weight:bold;font-size:11pt;padding:2px;"> <%=rsDays("topicday") %></span>
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
    
    
  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr>
  <td width=254 valign=top>
  <div style="margin:0 0 3px 0;padding:10px;text-align:center;background-color:#dddddd;">UP&DOWN</div>
  <div style="margin:0 0 10px 0;padding:5px;text-align:center;line-height:180%;">
  <% if game_no > "0" then %>
    <form action="game_item_update.asp" id="form3" name="formTool" method="post">
    <input type="hidden" name="game_no" value="<%=game_no %>" ID="Hidden3"> 	
    <% if market_cd = "KOSDAQ" then %>
    <input type="radio" name="market_cd"   ID="Text7" value="KOSDAQ" checked>KOSDAQ&nbsp;
    <input type="radio" name="market_cd"   ID="Radio7" value="KOSPI">KOSPI<br />
    <% else %>
    <input type="radio" name="market_cd"   ID="Radio10" value="KOSDAQ">KOSDAQ&nbsp;
    <input type="radio" name="market_cd"   ID="Radio11" value="KOSPI" checked>KOSPI<br />
    <% end if %>
    <input type="text" name="game_cd" style="width:45%;text-align:center;" class="input" ID="Text6" value="<%=game_cd %>" placeholder="매치코드">&nbsp;
    <a href="item.asp">[NEW]</a>&nbsp;
    <input id="submit4" name="submit1" type="submit" value="게임수정">
    </form>
  <% else %>
    <form action="game_item_insert.asp" id="form4" name="formTool" method="post">
    <input type="radio" name="market_cd"   ID="Radio8" value="KOSDAQ" checked>KOSDAQ&nbsp;
    <input type="radio" name="market_cd"   ID="Radio9" value="KOSPI">KOSPI<br />
    <input type="text" name="game_cd" style="width:45%;text-align:center;" class="input" ID="Text9" value="<%=mid(now(),1,4) & mid(now(),6,2) & mid(now(),9,2) %>" placeholder="매치코드">&nbsp;
    <input id="submit5" name="submit1" type="submit" value="게임생성">
    </form>
  <% end if %>
  </div> 
     
    <table cellSpacing="0" cellPadding="0" border="0" ID="Table3" width="100%">
    	<% if NoDataGame = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsGame.EOF %>
        <tr height=25>
        <td width="50%">
        <div style="padding:5px;text-align:left;"> 
        <a href="item.asp?game_no=<%=rsGame("game_no") %>"><%=rsGame("game_name") %></a>
        </div>
        </td>
        <td width="25%">
          <% if rsGame("company_name1") > "" then  %>
            <% if rsGame("logo_img1") > "" then  %><img src="/images/stock/<%=rsGame("logo_img1") %>" style="height:15px;"/><% else %><%=rsGame("company_name1") %><% end if %>
          <% else %>
            (미할당)
          <% end if %>
        </td>
        <td width="25%">
          <% if rsGame("company_name2") > "" then  %>
            <% if rsGame("logo_img2") > "" then  %><img src="/images/stock/<%=rsGame("logo_img2") %>" style="height:15px;"/><% else %><%=rsGame("company_name2") %><% end if %>
          <% else %>
            (미할당)
          <% end if %>
        </td>
        </tr>
        <%                                
        	rsGame.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			종목매치 없습니다.
        </div>
        <% end if         
       	set rsGame = nothing
        %>   
    </table>
  
  </td>
  <td width=500 valign=top>


  <% if game_no > "0" then %>

    <div style="margin:0 0 3px 0;padding:10px 3px 10px 3px;text-align:center;background-color:#dddddd;font-weight:bold;">
     <%=market_cd %> : 종목매치 <%=game_name %>
     <span style="margin:0 0 0 20px;color:#ff6600;">종료시간 : <%=end_time %></span>
    </div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
    <td width="50%" align="center">
    <div style="margin:5px;padding:10px;line-height:200%;background-color:#ffffff;border-radius: 2px;box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;">
          <% if company_name1 <> "" then  %>
            <% if logo_img1 <> "" then  %><img src="/images/stock/<%=logo_img1 %>" style="height:30px;"/><% else %>(로고)<% end if %><br />
            <%=company_name1 %>
          <% else %>
            (종목1 미할당)
          <% end if %>
    </div>
    </td>
    <td width="50%" align="center">
    <div style="margin:5px;padding:10px;line-height:200%;background-color:#ffffff;border-radius: 2px;box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;">
          <% if company_name2 <> "" then  %>
            
            <% if logo_img2 <> "" then  %><img src="/images/stock/<%=logo_img2 %>" style="height:30px;"/><% else %>(로고)<% end if %><br />
            <%=company_name2 %>
          <% else %>
            (종목2 미할당)
          <% end if %>
    </div>
    </td>
    </tr>
    </table>

  <% else %>
    <div style="margin:0 0 3px 0;padding:10px;text-align:center;background-color:#dddddd;font-weight:bold;">
    왼쪽에서 종목매치를 선택하여 종목할당 하세요.
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
    <td width="50%" align="center">
    <div style="margin:5px;padding:10px;border:dotted 1px #888888;">
            (종목1)
    </div>
    </td>
    <td width="50%" align="center">
    <div style="margin:5px;padding:10px;border:dotted 1px #888888;">
            (종목2)
    </div>
    </td>
    </tr>
    </table>
  <% end if %>
   

  <div style="margin:10px 0 3px 0;padding:10px;text-align:center;background-color:#dddddd;">
  <form action="item.asp" id="form2" name="formTool" method="post">
  <input type="hidden" name="game_no" value="<%=game_no %>" ID="Hidden2"> 	
  <input type="text" name="keyword" style="width:160px;" class="input" ID="Text3"  placeholder="종목명이나 코드">
  <input id="submit3" name="submit1" type="submit" value="종목검색">  
  </form>
  </div>
 
 
    <table cellpadding=0 cellspacing=0 border=0 width="100%">
    	<% if NoDataStock = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsStock.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsStock.EOF and RowCount > 0     %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">

          <td width="15%" align="center">
          <%=rsStock("market_cd") %>
          </td>
          <td width="15%" align="center">
          <%=rsStock("stock_cd") %>
          </td>
          <td width="40%">
          <%=rsStock("company_name") %>
          </td>
          <td width="30%" align="center">
          <a href="game_item_stock_set.asp?game_no=<%=game_no %>&stock_no=<%=rsStock("stock_no") %>&order=1"><span class="linkbtn">종목1</span></a>
          <a href="game_item_stock_set.asp?game_no=<%=game_no %>&stock_no=<%=rsStock("stock_no") %>&order=2"><span class="linkbtn">종목2</span></a>
          </td>
          </tr>      

        <%                                
        	RowCount = RowCount - 1
        	rsStock.MoveNext
	        Loop 
        %>
		<% else %>
		<tr>
		<td>
		<div style="padding:10px;text-align:center;">
			왼쪽에서 종목매치를 선택하세요.
        </div>
        </td>
        </tr>
        <% end if         
       	set rsStock = nothing
        %> 
    </table>
    
    <!-- 페이징 처리-->					
    <%if NoDataStock = false Then
	Cus_Tar = "game_no=" & game_no 
    %>
    <!--#include virtual="/_include/asp_page_function.asp"-->
    <table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="100%">
	<tr>
		<td align="center">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" ID="Table11" height="20">
				<tr>
					<td height="20" align="center" valign="middle">
    <%
	Response.Write ShowPageBar("default.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
    %>
					</td>
				</tr>
			</table>
		</td>
	</tr>
    </table>	
	<%end if%>		
	<!-- 페이징 처리 끝-->

  </td>
  </tr> 
  </table>
  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
