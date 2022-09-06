<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%        
  strSQL = "p_sh_game_point_list '"&request("game_type")&"'"
  
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


<% membermenu = "POINTHISTORY"
   menu_desc = "게임포인트이력"
%>
<!-- #include virtual="/_include/guide_admin_game.inc" -->
    <div style="padding : 10px;">
    <a href="point_history.asp"><span class="linkbtn">전체</span></a>
    <a href="point_history.asp?game_type=U"><span class="linkbtn">UP&DOWN</span></a>
    <a href="point_history.asp?game_type=I"><span class="linkbtn">종목</span></a>
    <a href="point_history.asp?game_type=T"><span class="linkbtn">테마</span></a>
    </div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#dddddd;">
    <td width="10%" align="center" >게임타입</td> 
    <td width="20%" align="center" >게임명</td>  
    <td width="30%" align="center" >아이디&nbsp;/&nbsp;닉네임</td>    
    <td width="10%" align="center" >베팅금액</td>  
    <td width="20%" align="center" >베팅시간</td>    
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#ffffff;">
    <td align="center"><%=rsData("game_type_desc") %></td>  
    <td align="center"><%=rsData("game_name") %></td>  
    <td align="center"><%=rsData("member_id") %>&nbsp;/&nbsp;<%=rsData("member_alias") %></td>  
    <td align="center"><%=rsData("bet_amt") %></td>    
    <td align="center"><%=rsData("register_date") %></td>  
    </tr>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="25" bgcolor="#ffffff">
    <td width="60" align="center" colspan="5">포인트 이력이 없습니다.</td>
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
