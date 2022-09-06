<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<SCRIPT language="javascript">
    function dayselect() {
        formDaily.submit();
    }
</SCRIPT>
<%

   game_type = "U"


   if request("yyyymmdd") <> "" then
     yyyymmdd = request("yyyymmdd")
   else
     yyyymmdd = Session("yyyymmdd")
   end if

  'calculate_mater 읽기
  strSQL = "p_sm_calculate_updown_yyyymmdd   'U'"


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
  strSQL = "p_sm_calculate_game_updown_list '" & yyyymmdd & "','" & game_type & "','KOSPI'"
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

    strSQL = "p_sm_calculate_updown_detail '" & game_no & "' "
    'response.Write strSQL
    'response.end
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rsCalculateDetail = Server.CreateObject("ADODB.RecordSet")
    rsCalculateDetail.Open strSQL, DbCon, 1, 1
  
    if NOT rsCalculateDetail.EOF and NOT rsrsCalculateDetailBOF then
    
      game_type = rsCalculateDetail("game_type")
      tr_time = rsCalculateDetail("tr_time")
      turn_no = rsCalculateDetail("turn_no")      
      status_flag = rsCalculateDetail("status_flag")
      status_desc = rsCalculateDetail("status_desc")

      win_no = rsCalculateDetail("win_no")      
      value_up = rsCalculateDetail("value_up")      
      value_draw = rsCalculateDetail("value_draw")      
      value_down = rsCalculateDetail("value_down")      
      updown_cd = rsCalculateDetail("updown_cd")      
      updown_desc = rsCalculateDetail("updown_desc")          
      index_variance = rsCalculateDetail("index_variance")    
      index_value = rsCalculateDetail("index_value")    
      index_last = rsCalculateDetail("index_last")          

      variance_origin = rsCalculateDetail("variance_origin")          
      index_flag = rsCalculateDetail("index_flag")          
          
    end if 
    set rsCalculateDetail = nothing
    
  end if 
  
  'calculate_list 읽기
  strSQL = "p_sh_calculate_updown_detail_list  '" & request("game_no") & "'"

  Set rs = Server.CreateObject("ADODB.RecordSet")
  rs.Open strSQL, DbCon, 1, 1

  if rs.EOF or rs.BOF then
	NoData = True
  Else
	NoData = False
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
   menu_desc = "게임별 정산내역(UP&DOWN)"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->

<table cellSpacing="0" cellPadding="0" border="1" ID="Table2" width="754">
<tr>
  <td width=334 valign=top>
  
    <div style="padding:10px;text-align:center;">
    <form action="calculate_game.asp" id="formDaily" name="formDaily" method="post">
      <select name="yyyymmdd" onChange="javascript:dayselect();">
      <% if NoDataDaily = False then ' 데이터가 있으면 데이터 출력 %>
      <% Do While Not rsDaily.EOF  %> 
      <% if rsDaily("yyyymmdd") <> yyyymmdd then %>   
      <option value="<%=rsDaily("yyyymmdd") %>"><%=rsDaily("yyyymmdd") %></option>
      <% else %>
      <option value="<%=rsDaily("yyyymmdd") %>" selected><%=rsDaily("yyyymmdd") %></option>
      <% end if %>
      <% rsDaily.MoveNext
	     Loop       
      end if         
      set rsDaily = nothing
      %> 
      </select>
      <input type="button" value="조회" onclick="javascript:dayselect();" />
    </form>
    </div>

   <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="18%" align="center" style="border-right:dotted 1px #ffffff;">tr_time</td>    
    <td width="18%" align="center" style="border-right:dotted 1px #ffffff;">등락</td>    
    <td width="18%" align="center">결과</td>           
    <td width="28%" align="center">상태/정산#</td>           
    <td width="18%" align="center" style="border-right:dotted 1px #ffffff;"></td>   
    </tr>
    </table>
    <table  cellSpacing="0" cellPadding="0" border="0" ID="Table3" width="100%">
    
    	<% if NoDataCalculateList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsCalculateList.EOF %>
        <% if rsCalculateList("game_no") * 1 - game_no  = 0   then %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
        <% else %>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;">
        <% end if %>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <a href="calculate_game.asp?yyyymmdd=<%=yyyymmdd %>&game_no=<%=rsCalculateList("game_no") %>&game_type=<%=rsCalculateList("game_type") %>">
        <span style="font-weight:bold;color:#3388cc;"><%=rsCalculateList("tr_time") %></span>
        </a>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <%=rsCalculateList("index_variance") %>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <% if rsCalculateList("updown_cd") <> "NA" then %>
        <%=rsCalculateList("updown_cd") %>
        <% else %>
        <span style="font-weight:bold;color:#ff6600;"><%=rsCalculateList("updown_cd") %></span>
        <% end if %>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <% if rsCalculateList("game_status") <> "3" then %>
        <span style="color:#ff6600;font-weight:bold;"><%=rsCalculateList("game_status_desc") %></span>
        <% else %>
        <%=rsCalculateList("game_status_desc") %>(<%=rsCalculateList("calculate_cnt") %>)
        <% end if %>
        </td>
        <td style="padding:5px; border-bottom:dotted 1px; text-align:center;" >
        <a href="calculate_item_manual.asp?yyyymmdd=<%=yyyymmdd %>&tr_time=<%=rsCalculateList("tr_time") %>&market_cd=KOSPI&game_no=<%=rsCalculateList("game_no") %>">
        <input type="button" value="정산↓" />
        </a>
        </td>
        </tr>
        <%                                
        	rsCalculateList.MoveNext
	        Loop 
        %>
		<% else %>
		<div style="padding:10px;text-align:center;">
			정산내역이 없습니다.
        </div>
        <% end if         
       	set rsCalculateList = nothing
        %>   
    </table>
  
  </td>
  <td width=420 valign=top>
  
    <% if game_no > "0" then %>
    <table  cellSpacing="0" cellPadding="0" border="0" ID="Table4" width="100%" bgcolor="#ffffff">
    <tr>
    <td width="85%">
    <div style="padding:5px; text-align:center;line-height:200%;">    
    <span style="margin:0 20px 0 0;font-weight:bold;color:#3388cc;"><%=yyyymmdd %>일    <%=turn_no %>회차 (<%=tr_time %>) <%=status_desc %></span>
    <span style="font-weight:bold;color:#ff6600;"><%=updown_cd %></span>
    
    <br />
    <form action="calculate_updown_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="game_no" value="<%=game_no %>" ID="Hidden1">
    <input type="hidden" name="yyyymmdd" value="<%=yyyymmdd %>" ID="Hidden2">&nbsp;
    등락<% =index_variance %>
    시가 <input type="text" name="index_value" style="width:70px;text-align:center;" class="input" ID="Text4" value="<%=index_value %>" placeholder="등락">
    종가 <input type="text" name="index_last" style="width:70px;text-align:center;" class="input" ID="Text1" value="<%=index_last %>" placeholder="등락">
    <input id="submit2" name="submit1" type="submit" value="수정">
    </form>
    </div>
    </td>
    <td width="15%" align="center">
    <a href="calculate_updown_set.asp?game_no=<%=game_no %>&yyyymmdd=<%=yyyymmdd %>"><input  type="button" value="정산"></a>
    </td>
    </tr>
    </table>
    <% else %>
    <div style="padding:10px; text-align:center;">    
    <%=yyyymmdd %>일 회차를 선택하세요.
    </div>
    <% end if %>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">회원</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">금액</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">수수료</td>
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">배당율</td>    
    <td width="25%" align="center" style="border-right:dotted 1px #ffffff;">배당금액</td>    
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rs.EOF    %> 
    <tr height="25"  style="border-bottom:dotted 1px #dddddd;">  
    <td align="center"><%=rs("member_id") %></td> 
    <td align="center"><%=rs("bet_net_amt") %></td>    
    <td align="center"><%=rs("fee_amt") %></td>   
    <td align="center"><%=rs("dividend_rate") %></td>   
    <td align="center"><%=rs("dividend_amt") %></td>   
    </tr>
    <% 	
        rs.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="45">
    <td width="60" align="center" colspan="6">데이터가 없습니다.</td>
    </tr>
    <% end if         
    set rs = nothing
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
