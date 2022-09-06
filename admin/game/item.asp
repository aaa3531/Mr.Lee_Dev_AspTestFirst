<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("yyyymmdd") <> ""  then	
    yyyymmdd = request("yyyymmdd")
  end if

  if request("game_no") = "" or request("game_no") = "0" then	
    game_no = "0"
  else
	game_no = request("game_no")
  end if 
  
  ' game list 읽기
  strSQL = "p_sm_game_item_admin_yyyymmdd "

  'response.write strSQL
  'response.end

  Set rsGameDay = Server.CreateObject("ADODB.RecordSet")
  rsGameDay.Open strSQL, DbCon, 1, 1

  if rsGameDay.EOF or rsGameDay.BOF then
	NoDataGameDay = True
  Else
	NoDataGameDay = False
  end if   

  ' game list 읽기
  strSQL = "p_sm_game_item_admin_list '" & yyyymmdd & "'"

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
  strSQL = "p_sm_stock_item_admin_list  '" & request("keyword") & "', '" & game_no & "'"
	
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
   menu_desc = "종목별매치설정"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr height="25">
  <td width=204 valign=top>
  <div style="padding:5px;text-align:center;line-height:180%;background-color:#ffffff;">  
    <a href="item_insert.asp"><input  name="button" type="button" value="매치생성"></a>    
  </div> 
     
  <div>
    	<% if NoDataGameDay = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsGameDay.EOF %>
        <% if rsGameDay("yyyymmdd") = yyyymmdd  then  %>
		<div style="padding:5px;text-align:center;background-color:#47B7AD;">
        <% else %>
		<div style="padding:5px;text-align:center;">
        <% end if %>
        <a href="item.asp?yyyymmdd=<%=rsGameDay("yyyymmdd") %>">
        <span style="color:#3388cc;font-weight:bold;"><%=rsGameDay("yyyymmdd") %></span></a>&nbsp;
        <a href="item_insert.asp?yyyymmdd=<%=rsGameDay("yyyymmdd") %>"><input  name="button" type="button" value="매치생성"></a>
        </div>
        <%                                
        	rsGameDay.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			일자 없습니다.
        </div>
        <% end if         
       	set rsGameDay = nothing
        %>   
  </div>
  
  </td>
  <td width=550 valign=top>


    <div style="0 0 10px 0;">
    <table cellSpacing="0" cellPadding="0" border="0" ID="Table3" width="100%">
    	<% if NoDataGame = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsGame.EOF %>
        <% if rsGame("game_no") * 1 - game_no <> 0 then  %>
        <tr height=22 style="border-bottom:solid 1px #dddddd;">
        <% else %>
        <tr height=22 bgcolor="#47B7AD" style="border-bottom:solid 1px #dddddd;">
        <% end if %>
        <td width="14%" align="center">
        <div style="padding:5px;text-align:center;"> 
        <a href="item.asp?page=<%=cPage%>&game_no=<%=rsGame("game_no") %>&yyyymmdd=<%=yyyymmdd %>"><span style="color:#3388cc;font-weight:bold;"><%=rsGame("status_desc") %></span></a>
        </div>
        </td>
        <td width="23%" align="center">
          <% if rsGame("company_name1") > "" then  %>
            <% if rsGame("logo_img1") > "" then  %>
            <img src="/images/stock/<%=rsGame("logo_img1") %>" style="height:15px; width: 45px;"/>
            <% else %><%=rsGame("company_name1") %>
            <% end if %><br />
            <%=rsGame("stock_name1") %>
          <% else %>
            (미할당)
          <% end if %>
        </td>
        <td width="23%" align="center">
          <% if rsGame("company_name2") > "" then  %>
            <% if rsGame("logo_img2") > "" then  %>
              <img src="/images/stock/<%=rsGame("logo_img2") %>" style="height:15px; width: 45px;"/>
            <% else %>
              <%=rsGame("company_name2") %>
            <% end if %><br />
            <%=rsGame("stock_name2") %>
          <% else %>
            (미할당)
          <% end if %>
        </td>
        <td width="40%" align="center">
        <a href="item_update.asp?page=<%=cPage%>&game_no=<%=rsGame("game_no") %>&status_flag=0&yyyymmdd=<%=yyyymmdd %>">
        <input  name="button1" type="button" value="준비">
        </a>
        <a href="item_update.asp?page=<%=cPage%>&game_no=<%=rsGame("game_no") %>&status_flag=1&yyyymmdd=<%=yyyymmdd %>">
        <input  name="button2" type="button" value="베팅">
        </a>
        <a href="item_close.asp?page=<%=cPage%>&game_no=<%=rsGame("game_no") %>&status_flag=2&yyyymmdd=<%=yyyymmdd %>">
        <input name="button3" type="button" value="종료">
        </a>
        <span class="linkbtn">X</span>
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
    </div>


  <% if game_no > "0" then %>
    <div style="padding:5px 0 10px 0;background-color:#ffffff;">    
    </div>
  <% else %>
    <div style="margin:0 0 3px 0;padding:10px;text-align:center;background-color:#ffffff;font-weight:bold;">
    종목매치를 선택하여 종목할당 하세요.
    </div>    
  <% end if %>  
    
  <div style="margin:0 0 3px 0;padding:10px;text-align:center;background-color:#dddddd;">
  <form action="item.asp" id="form2" name="formTool" method="post">
  <input type="hidden" name="game_no" value="<%=game_no %>" ID="Hidden2"> 	
  <input type="hidden" name="yyyymmdd" value="<%=yyyymmdd %>" />
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
          <%=rsStock("company_name") %>&nbsp;&nbsp;&nbsp;
          <% if rsStock("logo_img") > "" then  %><img src="/images/stock/<%=rsStock("logo_img") %>" style="height:15px;"/><% end if %>
          </td>
          <td width="30%" align="right">
          <a href="item_stock_set.asp?page=<%=cPage%>&yyyymmdd=<%=yyyymmdd %>&game_no=<%=game_no %>&stock_no=<%=rsStock("stock_no") %>&order=1"><span class="linkbtn">종목1</span></a>
          <a href="item_stock_set.asp?page=<%=cPage%>&yyyymmdd=<%=yyyymmdd %>&game_no=<%=game_no %>&stock_no=<%=rsStock("stock_no") %>&order=2"><span class="linkbtn">종목2</span></a>
          &nbsp;
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
		<div style="padding:10px;text-align:center;background-color:#ffffff;">
			위에서 종목매치를 선택하세요.
        </div>
        </td>
        </tr>
        <% end if         
       	set rsStock = nothing
        %> 
    </table>
    
    <!-- 페이징 처리-->					
<%if NoDataStock = false Then
	Cus_Tar = "game_no=" & game_no  & "&yyyymmdd=" & yyyymmdd
%>
<!--#include virtual="/_include/asp_page_function.asp"-->
<table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="100%">
	<tr>
		<td align="center">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" ID="Table11" height="20">
				<tr>
					<td height="20" align="center" valign="middle">
<%
	Response.Write ShowPageBar("item.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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
