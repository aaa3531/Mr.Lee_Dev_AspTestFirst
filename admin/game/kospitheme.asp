<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("theme_no") = "" or request("theme_no") = "0" then	
    theme_no = "0"
  else
	theme_no = request("theme_no")
    strSQL = "p_sm_theme_detail '" & theme_no & "' "
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      theme_name = rs("theme_name")
      market_cd = rs("market_cd")
    end if 
    set rs = nothing
  end if 
  
  ' Theme list 읽기
  strSQL = "p_sm_theme_kospi_list"
  
    'response.Write theme_no
    'response.End

  Set rsTheme = Server.CreateObject("ADODB.RecordSet")
  rsTheme.Open strSQL, DbCon, 1, 1

  if rsTheme.EOF or rsTheme.BOF then
	NoDataTheme = True
  Else
	NoDataTheme = False
  end if 
  
    'response.Write strSQL
    'response.End
    
    
   'theme_stock 읽기
  strSQL = "p_sm_stock_theme_exist_list '" & request("theme_no") & "'"
	
  'response.write strSQL
  'response.end
   '페이지 작동되는 방식
  Set rsStockExist = Server.CreateObject("ADODB.RecordSet")
  rsStockExist.Open strSQL, DbCon, 1, 1
  
  if rsStockExist.EOF or rsStockExist.BOF then
	NoDataStockExist = True
  Else
	NoDataStockExist = False
  end if 

    ' stock 읽기
  strSQL = "p_sm_stock_theme_list '" & request("keyword") & "', '" & theme_no & "'"
	
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


%>

  <div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="1024">
<tr>
<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>
<td width=754 valign=top>  

<% membermenu = "GAME"
   menu_desc = "KOSPI 테마설정"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr>
  <td width=254 valign=top>
  


  <div style="margin:0 0 0 0;padding:10px;text-align:center;background-color:#dddddd; font-weight:bold;">KOSPI 테마</div>
  <div style="padding:5px; text-align:center; background-color:#ffffff;">
  
  <% if theme_no > "0" then %>
    <form action="theme_kospi_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="theme_no" value="<%=theme_no %>" ID="Hidden1"> 	
    <input type="text" name="theme_name" style="width:120px;" class="input" ID="Text1" value="<%=theme_name %>" placeholder="테마명">&nbsp;
    
    <a href="kospitheme.asp">[NEW]</a>&nbsp;
    <input id="submit1" name="submit1" type="submit" value="테마수정">
    </form>
  <% else %>
    <form action="theme_kospi_insert.asp" id="form1" name="formTool" method="post">
    <input type="text" name="theme_name" style="width:150px;" class="input" ID="Text4" value="<%=theme_name %>" placeholder="테마명">&nbsp;

    <input id="submit2" name="submit1" type="submit" value="테마입력">
    </form>
  <% end if %>
  </div>

  
        <table width="254" border="0" cellpadding="0" cellspacing="0">
        <tr height="25" bgcolor="#e8e8e8"> 
        <td width="30%" align="center" style="border-right:dotted 1px #ffffff;">테마명</td>    
        <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">주식#</td>    
        <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">순서</td> 
        <td width="30%" align="center" style="border-right:dotted 1px #ffffff;">삭제</td> 
        </tr>

    	<% if NoDataTheme = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsTheme.EOF %>
        <tr height="25" style="border-bottom:dotted 1px #888888;"> 
        <td width="30%" align="center" style="border-right:dotted 1px #ffffff;"><a href="kospitheme.asp?page=<%=cPage%>&theme_no=<%=rsTheme("theme_no")%>"><%=rsTheme("theme_name") %></a></td>    
        <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;"><%=rsTheme("stock_cnt") %></td>    
        <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;"><%=rsTheme("order_seq") %></td>
        <td width="30%"  align="center" style="border-right:dotted 1px #ffffff;">
        <a href="theme_kospi_delete.asp?page=<%=cPage%>&theme_no=<%=rsTheme("theme_no") %>"><span class="linkbtn">-</span></a>
        </td> 
        </tr>
        <%                                
        	rsTheme.MoveNext
	        Loop 
        %>
		<% else %>
        <tr height="25" bgcolor="#e8e8e8"> 
        <td width="100%" align="center" style="border-right:dotted 1px #ffffff;" colspan="3">테마가 없습니다.</td>  
        </tr>
        <% end if         
       	set rsTheme = nothing
        %>   
        </table>

  </td>



  <td width=500 valign=top>
  
  <div style="margin:0 0 0 0; padding:10px;text-align:center;background-color:#dddddd; font-weight:bold;">
  <% if theme_name = "" then %>왼쪽에서 테마명을 선택하세요.<% else %><%=market_cd %> : <%=theme_name %><% end if %>
  </div>




   <table cellpadding=0 cellspacing=0 border=0 width="100%">
    	<% if NoDataStockExist = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsStockExist.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsStockExist.EOF and RowCount > 0    %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd; background-color:#FFFFFF;">
          <td width="20%" align="center">
          <%=rsStockExist("stock_cd") %>
          </td>
          <td width="30%">
          <%=rsStockExist("company_name") %>
          </td>
          <td width="20%">
          <%=rsStockExist("now_price") %>
          </td>
          <td width="20%">
          <%=rsStockExist("price_variance") %>
          </td>
          <td width="10%">
          <a href="theme_kospi_stock_set.asp?page=<%=cPage%>&theme_no=<%=theme_no %>&stock_no=<%=rsStockExist("stock_no") %>"><span class="linkbtn">-</span></a>
          </td>
          </tr>
         
        <%                                
        	RowCount = RowCount - 1
        	rsStockExist.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        <div style="padding:10px; text-align:center;">
        	테마종목이 없습니다.
        </div>
        </td></tr>
        <% end if         
       	set rsStockExist = nothing
        %> 
    </table>





   

  <div style="margin:0px 0 3px 0;padding:10px;text-align:center;background-color:#dddddd;">
  <form action="kospitheme.asp" id="form2" name="formTool" method="post">
  <input type="hidden" name="theme_no" value="<%=theme_no %>" ID="Hidden2"> 	
  <input type="text" name="keyword" style="width:160px;" class="input" ID="Text3"  placeholder="종목명이나 코드">
  <input id="submit3" name="submit1" type="submit" value="종목검색">  
  </form>
  </div>
 
 
    <table width="100%" cellpadding=0 cellspacing=0 border=0>
    	<% if NoDataStock = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsStock.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsStock.EOF and RowCount > 0        
        %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <td width="20%" align="center">
          <%=rsStock("market_cd") %>
          </td>
          <td width="20%" align="center">
          <%=rsStock("stock_cd") %>
          </td>
          <td width="50%">
          <%=rsStock("company_name") %>
          </td>
          <% if theme_no > 0 then %>
          <td width="10%">
          <a href="theme_kospi_stock_set.asp?page=<%=cPage%>&theme_no=<%=theme_no %>&stock_no=<%=rsStock("stock_no") %>"><span class="linkbtn">+</span></a>
          </td>
          <% else %>
          <% end if %>
          </tr>

               

        <%                                
        	RowCount = RowCount - 1
        	rsStock.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	주식종목 없습니다.
        </td></tr>
        <% end if         
       	set rsStock = nothing
        %> 
    </table>
    
    <!-- 페이징 처리-->					
    <%if NoDataStock = false Then
	Cus_Tar = "theme_no=" & theme_no 
    %>
    <!--#include virtual="/_include/asp_page_function.asp"-->
    <table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="100%">
	<tr>
		<td align="center">
			<table border="0" width="100%" cellpadding="0" cellspacing="0" ID="Table11" height="20">
				<tr>
					<td height="20" align="center" valign="middle">
    <%
	Response.Write ShowPageBar("kospitheme.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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
