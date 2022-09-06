<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

 if request("memo_no") <> "" then
  memo_no = request("memo_no")
  end if
  
  strSQL = "p_sh_memo_directask_admin_list '" & session("member_no") & "'"
  'response.write strSQL
  'response.End
  Set rsData = Server.CreateObject("ADODB.RecordSet")
  rsData.Open strSQL, DbCon, 1, 1
    
  if rsData.EOF or rsData.BOF then
	NoData = True
  Else
	NoData = False
  end if  
    

%>

<div style="height:20px;"></div>
<table width=1024 align=center>
<tr>

<td width=270 valign=top>
  
  <!-- #include virtual="/_include/menu_admin_customer.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "MONEY"
   menu_desc = "1:1문의 관리"
%>
<!-- #include virtual="/_include/guide_admin_customer.inc" -->

  <table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <td width="754" valign="top"> 

  



   
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#00856A"> 
    <td width="60%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">내용</td>  
    <td width="40%" align="center" style="border-right:dotted 1px #ffffff;color:#ffffff;">보낸날짜</td>  
    </tr>
    <% if NoData = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsData.EOF    %> 
    <tr height="25" style="border-bottom:dotted 1px #dddddd;">
    <td align="left"><a href="directask_manager.asp?memo_no=<%=rsData("memo_no") %>"><%=rsData("memo_desc") %></a></td>   
    <td align="center"><%=rsData("register_date") %></td>   
    </tr>
    <% if rsData("memo_no") * 1 - memo_no = 0 then %>
    <tr height="25" style="border-bottom:dotted 1px #dddddd;">
    <td align="left" colspan="2">
    <div style="background-color:#f8f8f8; line-height:200%; border:solid 1px #dddddd;">
    <%=rsData("memo_note") %>
    </div>
    </td>   
    </tr>
    <% end if %>
    <% 	
        rsData.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="55" >
    <td width="60" align="center" colspan="5">메모가 없습니다.</td>
    </tr>
    <% end if         
    set rsData = nothing
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
