<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("ip_address") <> "" then	
	ip_address = request("ip_address")
  end if 
  
  ' ip 읽기
  strSQL = "p_sz_ip_list"
  
  'bRtn = dbcon.GetResult(strSQL, rsIP)

  ' 페이지 작동되는 방식
  Set rsIP = Server.CreateObject("ADODB.RecordSet")
  rsIP.cursorlocation = 3
  rsIP.Open strSQL, DbCon, 1, 3

  if rsIP.EOF or rsIP.BOF then
	NoDataIP = True
  Else
	NoDataIP = False
  end if 
  
  'response.Write strSQL
  'response.End


  '페이징처리관련
  page =cint(request("page"))
  'response.Write page
  If NoDataIP = False then
		Cus_pageSize = 20
		rsIP.PageSize = Cus_pageSize

		pagecount=rsIP.pagecount
		totalRecord = rsIP.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsIP.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsIP.PageSize) + 1)
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

  
  <!-- #include virtual="/_include/menu_admin_site.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "IP"
   menu_desc = "IP관리"
%>
<!-- #include virtual="/_include/guide_admin_site.inc" -->

  <div style="margin:10px 0 0 0;padding: 5px;background-color:#ffffff;">
  <% if ip_address > "0" then %>
    <form action="ip_delete.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="ip_address" value="<%=ip_address %>" ID="Hidden1">
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden2"> 	
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="80%" align="center"> 
    <%=ip_address %>
    </td>
    <td width="20%" align="center">
    <a href="ip.asp">[NEW]</a>&nbsp;
    <input id="submit1" name="submit1" type="submit" value="IP삭제">
    </td>
    </tr>  
    </table>
    </form>
  <% else %>
    <form action="ip_insert.asp" id="form1" name="formTool" method="post">
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden3"> 	
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="80%" align="center">
    <input type="text" name="ip_address" style="width:400px;" class="input" ID="Text4" value="<%=ip_address %>" placeholder="IP주소">&nbsp;
    </td>
    <td width="20%"   align="left">
    <input id="submit2" name="submit1" type="submit" value="IP입력">
    </td>
    </tr>  
    </table>
    </form>
  <% end if %>
  </div>
   
    <table width=100% cellpadding=0 cellspacing=0 border=0>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#dddddd;">
          <td width="20%" align="center">IP</td>
          <td width="60%" align="center">Permission_Code</td>
          <td width="20%" align="center">remote_addr_end</td>
          </tr>
    	<% 
    	if NoDataIP = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsIP.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsIP.EOF and RowCount > 0  %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <td width="20%" align="center">
          <a href="ip.asp?ip_address=<%=rsIP("ip_address") %>"><%=rsIP("ip_address") %></a>
          </td>
          <td width="60%" align="center">
          <%=rsIP("Permission_Code") %>
          </td>
          <td width="20%" align="center">
          <%=rsIP("ip_address_end") %>
          </td>
          </tr>
        <%                                
        	RowCount = RowCount - 1
        	rsIP.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	IP가 없습니다.
        </td></tr>
        <% end if         
       	set rsIP = nothing
       	
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataIP = false Then
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
