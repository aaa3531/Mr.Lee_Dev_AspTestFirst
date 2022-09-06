<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("stock_no") = "" then	
    stock_no = "0"
  else
	stock_no = request("stock_no")
    strSQL = "p_sm_stock_detail '" & stock_no & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      market_cd = rs("market_cd")
      stock_cd = rs("stock_cd")
      company_name = rs("company_name")
      stock_name = rs("stock_name")
    end if 
    set rs = nothing
  end if 
  
  ' stock 읽기
  strSQL = "p_sm_stock_kosdaq_list '" & Request("key") & "'"

  'bRtn = dbcon.GetResult(strSQL, rsStock)

  ' 페이지 작동되는 방식
  Set rsStock = Server.CreateObject("ADODB.RecordSet")
  rsStock.cursorlocation = 3
  rsStock.Open strSQL, DbCon, 1, 3

  if rsStock.EOF or rsStock.BOF then
	NoDataStock = True
  Else
	NoDataStock = False
  end if 
  
  'response.Write strSQL
  'response.End


  '페이징처리관련
  page =cint(request("page"))
  'response.Write page
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
        'response.write lastpg
		if page > lastpg then
			page = lastpg
		end If
        
        'response.write page
	end if
	'페이징처리관련 끝 
%>

  <div style="height:20px;"></div>
<table width=1024 align=center>
<tr>

<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "KOSDAQ"
   menu_desc = "KOSDAQ 종목관리"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <div style="margin:10px 0 0 0;padding: 5px;background-color:#ffffff;">
  <% if stock_no > "0" then %>
    <form action="stock_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="stock_no" value="<%=stock_no %>" ID="Hidden1">
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden2"> 	
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="80%" align="center"> 
    <input type="text" name="stock_cd" style="width:60px;" class="input" ID="Text5" value="<%=stock_cd %>" placeholder="종목코드">&nbsp;
    종목명<input type="text" name="stock_name" style="width:200px;" class="input" ID="Text1" value="<%=stock_name %>" placeholder="종목명">&nbsp;
    회사명<input type="text" name="company_name" style="width:200px;" class="input" ID="Text3" value="<%=company_name %>" placeholder="회사명">&nbsp;
    </td>
    <td width="20%" align="center">
    <a href="default.asp">[NEW]</a>&nbsp;
    <input id="submit1" name="submit1" type="submit" value="종목수정">
    </td>
    </tr>  
    </table>
    </form>
  <% else %>
    <form action="stock_insert.asp" id="form1" name="formTool" method="post">
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden3"> 	
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="80%" align="center">  
    <input type="text" name="stock_cd" style="width:60px;" class="input" ID="Text2" value="<%=stock_cd %>" placeholder="종목코드">&nbsp;
    종목명<input type="text" name="stock_name" style="width:200px;" class="input" ID="Text4" value="<%=stock_name %>" placeholder="종목명">&nbsp;
    회사명<input type="text" name="company_name" style="width:200px;" class="input" ID="Text6" value="<%=company_name %>" placeholder="회사명">&nbsp;
    </td>
    <td width="20%"   align="center">
    <input id="submit2" name="submit1" type="submit" value="종목입력">
    </td>
    </tr>  
    </table>
    </form>
  <% end if %>
  </div>
   
    <table cellpadding=0 cellspacing=0 border=0>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#dddddd;">
          <td width="80" align="center">시장</td>
          <td width="80" align="center"><a href="default.asp?key=CODE">종목코드</a></td>
          <td width="200" align="center"><a href="default.asp?key=NAME">종목명</a></td>
          <td width="200" align="center">회사명</td>
          <td width="97"  align="center">로고          </td>
          <td width="97" align="center">로고설정          </td>
          </tr>
    	<% if NoDataStock = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsStock.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsStock.EOF and RowCount > 0         
           if rsStock("stock_no") * 1 - stock_no  = 0   then %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
          <td width="80" align="center">
          <%=rsStock("market_cd") %>
          </td>
          <td width="80" align="center">
          <a href="default.asp?page=<%=cPage%>&key=<%=request("key") %>&stock_no=<%=rsStock("stock_no") %>"><%=rsStock("stock_cd") %></a>
          </td>
          <td width="200">
          <a href="default.asp?page=<%=cPage%>&key=<%=request("key") %>&stock_no=<%=rsStock("stock_no") %>">
          <input type="button" value="<%=rsStock("stock_name") %>" />
          </a>
          </td>
          <td width="200">
          <a href="default.asp?page=<%=cPage%>&key=<%=request("key") %>&stock_no=<%=rsStock("stock_no") %>"><%=rsStock("company_name") %></a>
          </td>
          <td width="97" align="center">
          <% if rsStock("logo_img") > "" then %> <img src = "/images/stock/<%=rsStock("logo_img") %>" style="height:15px; border-radius: 2px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;"/> <% else %> (logo) <% end if %>
          </td>
          <td width="97" align="center">
          <a href="stock_image_set.asp?page=<%=cPage%>&stock_no=<%=rsStock("stock_no") %>"><span class="linkbtn">SET</span></a>
          </td>
          </tr>
          <% else %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <td width="80">
          <%=rsStock("market_cd") %>
          </td>
          <td width="80" align="center">
          <a href="default.asp?page=<%=cPage%>&key=<%=request("key") %>&stock_no=<%=rsStock("stock_no") %>"><%=rsStock("stock_cd") %></a>
          </td>
          <td width="200">
          <a href="default.asp?page=<%=cPage%>&key=<%=request("key") %>&stock_no=<%=rsStock("stock_no") %>"><input type="button" value="<%=rsStock("stock_name") %>" /></a>
          </td>
          <td width="200">
          <a href="default.asp?page=<%=cPage%>&key=<%=request("key") %>&stock_no=<%=rsStock("stock_no") %>"><%=rsStock("company_name") %></a>
          </td>
          <td width="97" align="center">
          <% if rsStock("logo_img") > "" then %> <img src = "/images/stock/<%=rsStock("logo_img") %>" style="height:15px; border-radius: 2px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 10px 0px;"/> <% else %> (logo) <% end if %>
          </td>
          <td width="97" align="center">
          <a href="stock_image_set.asp?page=<%=cPage%>&stock_no=<%=rsStock("stock_no") %>"><span class="linkbtn">SET</span></a>
          </td>
          </tr>
          <% end if %>        

        <%                                
        	RowCount = RowCount - 1
        	rsStock.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	주식코드가 없습니다.
        </td></tr>
        <% end if         
       	set rsStock = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataStock = false Then
	Cus_Tar = "key=" & request("key") 
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
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
