<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect2.inc" -->
<%
   if request("market_cd") <> "" then
     market_cd = request("market_cd")
   else
     market_cd = "KOSDAQ"
   end if

   if request("yyyymmdd") <> "" then
     yyyymmdd = request("yyyymmdd")
   end if
   
  'tr_list 읽기
  strSQL = "p_sh_stock_index_admin_yyyymmdd  '"& market_cd &"'"

  Set rsHistory = Server.CreateObject("ADODB.RecordSet")
  rsHistory.Open strSQL, DbCon, 1, 1

  if rsHistory.EOF or rsHistory.BOF then
	NoDataHistory = True
  Else
	NoDataHistory = False
  end if   
  
  '주가읽기
  strSQL = "p_sh_stock_index_admin_list_4min '" & yyyymmdd & "', '" & market_cd & "'"
  
  'response.write strSQL
  'response.end

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
   menu_desc = "지수관리"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->
<div style="padding:10px;text-align:center;">
</div>


  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr>
  <td width=224 valign=top>
  <div style="padding:5px;text-align:center;font-weight:bold;background-color:#ffffff;border-bottom:dotted 1px #888888;">거래시각</div>

    	<% if NoDataHistory = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsHistory.EOF %>
           <% if rsHistory("yyyymmdd") = yyyymmdd then %>
           <div style="padding:5px;text-align:center;font-weight:bold;border-bottom:dotted 1px #888888;background-color:#47B7AD;">
           <SPAN style="font-weight:bold;color:#ffffff;"><%=rsHistory("yyyymmdd") %></SPAN>
               <a href="stock_index.asp?yyyymmdd=<%=rsHistory("yyyymmdd") %>&market_cd=KOSDAQ"><span class="linkbtn">코스닥</span></a>
               <a href="stock_index.asp?yyyymmdd=<%=rsHistory("yyyymmdd") %>&market_cd=KOSPI"><span class="linkbtn">코스피</span></a>
           </div>  
           <% else %>
           <div style="padding:5px;text-align:center;font-weight:bold;border-bottom:dotted 1px #888888;">
           <SPAN style="font-weight:bold;color:#3388cc;"><%=rsHistory("yyyymmdd") %></SPAN>
               <a href="stock_index.asp?yyyymmdd=<%=rsHistory("yyyymmdd") %>&market_cd=KOSDAQ"><span class="linkbtn">코스닥</span></a>
               <a href="stock_index.asp?yyyymmdd=<%=rsHistory("yyyymmdd") %>&market_cd=KOSPI"><span class="linkbtn">코스피</span></a>
           </div>  
           <% end if %>
        <%                                
        	rsHistory.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			STOCK INDEX가 없습니다.
        </div>
        <% end if         
       	set rsHistory = nothing
        %>   

  
  </td>
  <td width=530 valign=top>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <div style="background-color:#ffffff; text-align:center; font-weight:bold; height:30px; font-size:20px;" >
    <%=market_cd %>
    </div>
    <tr height="25" bgcolor="#e8e8e8">
    <td width="13%" align="center" style="border-right:dotted 1px #ffffff;">시간</td>  
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">등락</td>    
    <td width="13%"  align="center" style="border-right:dotted 1px #ffffff;">변동폭</td> 
    <td width="13%" align="center" style="border-right:dotted 1px #ffffff;">지수(시가)</td>    
    <td width="13%"  align="center" style="border-right:dotted 1px #ffffff;">종가</td>    
    <td width="13%"  align="center" style="border-right:dotted 1px #ffffff;">고가</td>    
    <td width="13%"  align="center" style="border-right:dotted 1px #ffffff;">저가</td>    
    <td width="12%"  align="center" style="border-right:dotted 1px #ffffff;">직전</td>    
    </tr>
    <% if NoDataList = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsList.EOF    %> 
    <tr height="25" style="border-bottom:dotted 1px #dddddd;">  
    <td align="center"><%=rsList("tr_time") %></td>    
    <td align="center"><%=rsList("updown_now") %></td>    
    <td align="center"><%=rsList("variance_now") %></td> 
    <td align="center"><%=rsList("index_value") %></td>   
    <td align="center"><%=rsList("index_last") %></td>
    <td align="center"><%=rsList("index_high") %></td>
    <td align="center"><%=rsList("index_low") %></td>
    <td align="center"><%=rsList("index_prev") %></td>
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
<!-- #include virtual="/_include/connect_close2.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
