<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%        
  strSQL = "p_sz_log_list"
  

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

  
  <!-- #include virtual="/_include/menu_admin_site.asp" -->
       
</td>

<td width=754 valign=top>  


<% membermenu = "DATA"
   menu_desc = "코스닥"
%>
<!-- #include virtual="/_include/guide_admin_site.inc" -->

    <table width="100%" border="1" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#e8e8e8">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">remote_addr</td>  
    <td width="20%" align="center" style="border-right:dotted 1px #ffffff;">log_url</td>  
    <td width="5%" align="center" style="border-right:dotted 1px #ffffff;">회원</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">log_time</td>   
    <td width="45%"  align="center" style="border-right:dotted 1px #ffffff;">http_user_agent</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">session_time</td>    
    <td width="5%"  align="center" style="border-right:dotted 1px #ffffff;">channel_code</td>  
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="25" bgcolor="#dddddd" style="border-bottom:dotted 1px #ffffff;">
    <td align="center"><%=rsData("remote_addr") %></td> 
    <td align="center"><%=rsData("log_url") %></td>   
    <td align="center"><%=rsData("member_no") %></td>    
    <td align="center"><%=rsData("log_time") %></td>    
    <td align="center"><%=rsData("http_user_agent") %></td>  
    <td align="center"><%=rsData("session_time") %></td>  
    <td align="center"><%=rsData("channel_code") %></td>  
    </tr>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="25" bgcolor="#ffffff">
    <td width="60" align="center" colspan="4">log가 없습니다.</td>
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
