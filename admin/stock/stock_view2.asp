<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->


<%
        
  strSQL = "p_ss_kosdaq_read"
  

  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
  end if  
  'response.write strSQL
  'response.End
%>

  <div style="height:20px;"></div>
<table width=1024 align=center>
<tr>

<td width=270 valign=top>

  
  <!-- #include virtual="/_include/menu_admin_game.asp" -->
       
</td>

<td width=754 valign=top>  


<% membermenu = "STOCKVIEW"
   menu_desc = "코스닥주가조회"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->


    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#e8e8e8">
    <td width="5%" align="center" style="border-right:dotted 1px #ffffff;">순위</td>  
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">종목코드</td>  
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">종목명</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">현재가</td>   
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">전일대비</td>    
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">F7</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">등락률</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">거래량</td>    
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">거래비중</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">시가총액</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">시가총액비</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">체결강도</td>    
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="25" bgcolor="#dddddd" style="border-bottom:dotted 1px #dddddd;">
    <td align="center"><%=rsData(0) %></td>     
    <td align="center"><%=rsData("종목코드") %></td> 
    <td align="center"><a href="http://finance.naver.com/item/main.nhn?code=<%=rsData("종목코드") %>"><%=rsData("종목명") %></a></td>    
    <td align="center"><%=rsData("현재가") %></td>    
    <td align="center"><%=rsData("전일대비") %></td>   
    <td align="center"><%=rsData("F7") %></td>    
    <td align="center"><%=rsData("등락률") %></td>    
    <td align="center"><%=rsData("거래량") %></td>  
    <td align="center"><%=rsData("거래비중") %></td>  
    <td align="center"><%=rsData("시가총액") %></td>  
    <td align="center"><%=rsData("시가총액비") %></td>
    <td align="center"><%=rsData("체결강도") %></td>  
    </tr>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="25" bgcolor="#ffffff">
    <td width="60" align="center" colspan="4">데이터가 없습니다.</td>
    </tr>
    <% end if         
    set rsData = nothing
    %>        
    </table>


  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
