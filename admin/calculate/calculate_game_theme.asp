<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
   game_type = "T"

   if request("yyyymmdd") <> "" then
     yyyymmdd = request("yyyymmdd")
     game_no = request("game_no")
   else
     yyyymmdd = Session("yyyymmdd")
   end if

  'calculate_mater 읽기
  strSQL = "p_sm_calculate_theme_yyyymmdd   'T'"

  Set rsDaily = Server.CreateObject("ADODB.RecordSet")
  rsDaily.Open strSQL, DbCon, 1, 1

  if rsDaily.EOF or rsDaily.BOF then
	NoDataDaily = True
  Else
	NoDataDaily = False
  end if   
  
  'response.write strSQL
  'response.End


  'calculate_list 읽기
  strSQL = "p_sm_calculate_game_theme_list '" & game_no & "'"
  'response.write strSQL

  Set rsCalculateList = Server.CreateObject("ADODB.RecordSet")
  rsCalculateList.Open strSQL, DbCon, 1, 1

  if rsCalculateList.EOF or rsCalculateList.BOF then
	NoDataCalculateList = True
  Else
	NoDataCalculateList = False
  end if   
  'response.write strSQL
  'response.End

  if request("game_no") <> "" then	
  
	game_no = request("game_no")

    strSQL = "p_sm_calculate_detail '" & game_no & "' "
    'response.Write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rsCalculateDetail = Server.CreateObject("ADODB.RecordSet")
    rsCalculateDetail.Open strSQL, DbCon, 1, 1
  
    if NOT rsCalculateDetail.EOF and NOT rsrsCalculateDetailBOF then
      game_no = rsCalculateDetail("game_no")
      game_type = rsCalculateDetail("game_type")
      tr_time = rsCalculateDetail("tr_time")
      status_flag = rsCalculateDetail("status_flag")
      
    end if 
    set rsCalculateDetail = nothing
    
  end if 
  
  'calculate_list 읽기
  strSQL = "p_sh_calculate_theme_detail_list  '" & request("game_no") & "'"

  Set rsDetail = Server.CreateObject("ADODB.RecordSet")
  rsDetail.Open strSQL, DbCon, 1, 1

  if rsDetail.EOF or rsDetail.BOF then
	NoDataDetail = True
  Else
	NoDataDetail = False
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
   menu_desc = "게임별 정산내역(테마별)"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

  <table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
  <tr>
  <td width=254 valign=top>  
    
    <% if NoDataDaily = False then ' 데이터가 있으면 데이터 출력 %>
    <table  cellSpacing="0" cellPadding="0" border="0" ID="Table4" width="100%">
    <% Do While Not rsDaily.EOF  %> 
    <% if rsDaily("yyyymmdd") = yyyymmdd  and rsDaily("game_no") * 1 - game_no = 0  then  %>
    <tr height="25" bgcolor="#47B7AD" style="border-right:dotted 1px #ffffff;border-bottom:dotted 1px #888888;">
    <% else %>
    <tr height="25" style="border-right:dotted 1px #ffffff;border-bottom:dotted 1px #888888;">
    <% end if %>
    <td width="40%" align="center">
        <a href="calculate_game_theme.asp?yyyymmdd=<%=rsDaily("yyyymmdd") %>&game_no=<%=rsDaily("game_no") %>">
        <span style="color:#3388cc;font-weight:bold;"><%=rsDaily("yyyymmdd") %></span>
        </a><br />
        <a href="calculate_game_theme.asp?yyyymmdd=<%=rsDaily("yyyymmdd") %>&game_no=<%=rsDaily("game_no") %>">
        <span style="color:#3388cc;font-weight:bold;">게임 : <%=rsDaily("game_no") %></span>
        </a>
    </td>   
    <td width="35%" align="center">
        <a href="calculate_game_theme_result.asp?yyyymmdd=<%=rsDaily("yyyymmdd") %>&game_no=<%=rsDaily("game_no") %>"><input type="button" value="결과"/></a><br />
        <a href="calculate_game_theme_set.asp?yyyymmdd=<%=rsDaily("yyyymmdd") %>&game_no=<%=rsDaily("game_no") %>"><input type="button" value="정산"/></a>
    </td>   
    <td width="25%" align="center">
    <%=rsDaily("status_flag_desc") %>
    </td>   
    </tr>
    <% 
      yyyymmdd_old = rsDaily("yyyymmdd")
      rsDaily.MoveNext 
      
      Loop       
      end if         
      set rsDaily = nothing
    %>
    </table>
  </td>
  <td width=500 valign=top>    
  
    <table  cellSpacing="0" cellPadding="0" border="0" ID="Table3" width="100%">
    <tr height="25" bgcolor="#dddddd">
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">테마</td>    
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">순위</td>   
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">배당률</td>    
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">상태</td>    
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">테마(복식2)</td>    
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">배당률(복식)</td>    
    </tr>
    
    <% if NoDataCalculateList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsCalculateList.EOF %>
        <% if rsCalculateList("order_no") = "1" or rsCalculateList("order_no") = "2" then %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#ffff66;">
        <% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <%=rsCalculateList("theme_name") %>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <%=rsCalculateList("order_no") %>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <%=rsCalculateList("dividend_rate") %>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <%=rsCalculateList("game_status_desc") %>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <% if rsCalculateList("order_no") = "1" or rsCalculateList("order_no") = "2" then %>
        <%=rsCalculateList("theme_name2") %>
        <% end if %>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <% if rsCalculateList("order_no") = "1" or rsCalculateList("order_no") = "2" then %>
        <%=rsCalculateList("dividend_rate2") %>
        <% end if %>
        </td>
        </tr>
        <%                                
        	rsCalculateList.MoveNext
	        Loop 
        %>
	<% else %>
	    <tr height="35">
	    <td colspan="6" align="center">
	    	테마 없습니다.
        </td></tr>
	<% end if         
       	set rsCalculateList = nothing
    %>   
    </table>
    
    
  <div style="padding:10px; text-align:center;background-color:#ffffff;font-weight:bold;">    
    테마 : <%=game_no %>
  </div>
  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">회원</td>  
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">금액</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">수수료</td>    
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">배당율</td>    
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">배당금액</td>    
    </tr>
    <% if NoDataDetail = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsDetail.EOF    %> 
    <tr height="25"  style="border-bottom:dotted 1px #dddddd;">  
    <td align="center"><%=rsDetail("member_id") %></td> 
    <td align="center"><%=rsDetail("bet_net_amt") %></td>    
    <td align="center"><%=rsDetail("fee_amt") %></td>   
    <td align="center"><%=rsDetail("dividend_rate") %></td>   
    <td align="center"><%=rsDetail("dividend_amt") %></td>   
    </tr>
    <% 	
        rsDetail.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="45">
    <td width="60" align="center" colspan="6">데이터가 없습니다.</td>
    </tr>
    <% end if         
    set rsDetail = nothing
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
