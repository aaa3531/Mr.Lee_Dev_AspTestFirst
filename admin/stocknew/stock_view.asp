<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   if request("market_cd") <> "" then
     market_cd = request("market_cd")
   else
     market_cd = "KOSDAQ"
   end if

   if request("tr_time") <> "" then
     tr_time = request("tr_time")
   end if
   
  'tr_list 읽기
  strSQL = "p_sh_stock_history  '"& market_cd &"'"

  Set rsHistory = Server.CreateObject("ADODB.RecordSet")
  rsHistory.Open strSQL, DbCon, 1, 1

  if rsHistory.EOF or rsHistory.BOF then
	NoDataHistory = True
  Else
	NoDataHistory = False
  end if   
  
  '주가읽기
  strSQL = "p_sh_stock_history_list '" & tr_time & "', '" & market_cd & "'"
  
  'response.write strSQL
  
  Set rsList = Server.CreateObject("ADODB.RecordSet")
  rsList.Open strSQL, DbCon, 1, 1
    
  if rsList.EOF or rsList.BOF then
	NoDataList = True
  Else
	NoDataList = False
  end if  
  'response.write strSQL
  'response.End

 
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
<div style="padding:10px;text-align:center;">
<a href="stock_view.asp?market_cd=KOSDAQ"><span class="linkbtn">코스닥</span></a>
<a href="stock_view.asp?market_cd=KOSPI"><span class="linkbtn">코스피</span></a>
</div>


  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr>
  <td width=754 colspan="2">  
  <div style="padding:10px;text-align:center;font-weight:bold;"><%=market_cd %> 
  <a href="sh_stock_history_create_temp.asp?market_cd=<%=market_cd %>"><span class="linkbtn">거래 임시생성</span></a>
  </div>
  </td>
  </tr>
  <tr>
  <td width=124 valign=top>
  <div style="padding:5px;text-align:center;font-weight:bold;background-color:#ffffff;border-bottom:dotted 1px #888888;">거래시각</div>

    	<% if NoDataHistory = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsHistory.EOF %>
           <% if rsHistory("tr_time") = tr_time then %>
           <div style="padding:5px;text-align:center;font-weight:bold;border-bottom:dotted 1px #888888;background-color:#47B7AD;">
           <SPAN style="font-weight:bold;color:#ffffff;"><%=rsHistory("tr_time") %></SPAN>
           </div>  
           <% else %>
           <div style="padding:5px;text-align:center;font-weight:bold;border-bottom:dotted 1px #888888;">
           <a href="stock_view.asp?tr_time=<%=rsHistory("tr_time") %>&market_cd=<%=market_cd %>">
           <SPAN style="font-weight:bold;color:#3388cc;"><%=rsHistory("tr_time") %></SPAN>
           </a>
           </div>  
           <% end if %>
        <%                                
        	rsHistory.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			STOCK HISTORY가 없습니다.
        </div>
        <% end if         
       	set rsHistory = nothing
        %>   

  
  </td>
  <td width=630 valign=top>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#e8e8e8">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">주식코드</td>  
    <td width="5%" align="center" style="border-right:dotted 1px #ffffff;">순위</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">현재가</td>   
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">등락폭</td>
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">등락</td>
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">등락률</td>    
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">거래량</td>    
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">거래비중</td>    
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">시가총액</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">시가총액비</td>    
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">체결<br />강도</td>    
    </tr>

    <% if NoDataList = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsList.EOF    %> 
    <tr height="25" style="border-bottom:dotted 1px #dddddd;">  
    <td align="center"><%=rsList("stock_cd") %></td>    
    <td align="center"><%=rsList("order_no") %></td>   
    <td align="right"><%=rsList("now_price") %></td>    
    <td align="center"><%=rsList("price_variance") %></td>
    <td align="center"><%=rsList("updown_flag") %></td>
    <td align="center"><%=rsList("updown_rate") %></td>  
    <td align="right"><%=rsList("tr_amt") %></td>  
    <td align="center"><%=rsList("tr_weight") %></td>
    <td align="right"><%=rsList("total_amt") %></td>  
    <td align="center"><%=rsList("total_rate") %></td>  
    <td align="center"><%=rsList("tr_strength") %></td>  
    </tr>
    <% 	
        rsList.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="25" bgcolor="#ffffff">
    <td width="60" align="center" colspan="13">데이터가 없습니다.</td>
    </tr>
    <% end if         
    set rsList = nothing
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
