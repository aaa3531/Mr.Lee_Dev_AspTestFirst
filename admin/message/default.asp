<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("message_no") = "" then	
    message_no = "0"
  else
	message_no = request("message_no")


    strSQL = "p_sm_message_admin_detail '" & message_no & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      message_no = rs("message_no")
      game_type = rs("game_type")
      message_desc = rs("message_desc")
      order_seq = rs("order_seq")
      status_flag = rs("status_flag")
    end if 
    set rs = nothing
  end if 

  
  ' message 읽기
  strSQL = "p_sm_message_admin_list "

  'bRtn = dbcon.GetResult(strSQL, rsMessage)

  ' 페이지 작동되는 방식
  Set rsMessage = Server.CreateObject("ADODB.RecordSet")
  rsMessage.cursorlocation = 3
  rsMessage.Open strSQL, DbCon, 1, 3

  if rsMessage.EOF or rsMessage.BOF then
	NoDataMessage = True
  Else
	NoDataMessage = False
  end if 
  
  '페이징처리관련
  page =Cint(request("page"))
  If NoDataMessage = False then
		Cus_pageSize = 10
		rsMessage.PageSize = Cus_pageSize

		pagecount=rsMessage.pagecount
		totalRecord = rsMessage.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsMessage.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsMessage.PageSize) + 1)

		if page > lastpg then
			page = lastpg
		end If

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

<% membermenu = "MESSAGE"
   menu_desc = "메세지관리"
%>
<!-- #include virtual="/_include/guide_admin_site.inc" -->

  <div style="height:10px;"></div>

  <% if message_no > "0" then %>
    <form action="message_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="message_no" value="<%=message_no %>" ID="Hidden1"> 
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden2"> 	
    <table width="100%"  bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td style="color:#ff6600;" width="10%" align="center">  
    <% if game_type = "T" then %>테마주
    <% elseif game_type = "U" then %>UP&DOWN
    <% elseif game_type = "I" then %>종목별
    <% end if %>
    </td>
    <td width="50%" align=left>
    &nbsp;<input type="text" name="message_desc" style="width:370px;" class="input" ID="Text1" value="<%=message_desc %>" >
    </td>
    <td width="10%" align="right">순서
    <input type="text" name="order_seq" style="width:30px;" class="input" ID="Text5" value="<%=order_seq %>" >
    </td>
    <td width="15%"  align="center">
    <% if status_flag="1" then %>
    <input type="checkbox" name="status_flag" ID="Checkbox2" value="1" checked >표시
    <% else %>
    <input type="checkbox" name="status_flag" ID="Checkbox3" value="1">표시
    <% end if %>
    </td>
    <td width="15%" bgcolor="#ffffff" align="center">
    <a href="default.asp">[NEW]</a>
    <input id="submit1" name="submit1" type="submit" value="수정">
    </td>
    </tr>  
    </table>
    </form>
  <% else %>
    <form action="message_insert.asp" id="form1" name="formTool" method="post">
    <input type="hidden" name="message_no" value="<%=message_no %>" ID="Hidden3"> 
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden4"> 	
    <table width="100%"  bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="30%" align="left">
    <input type="radio" name="game_type" style="width:20px;" class="input" ID="Radio3" value="U" checked>업다운
    <input type="radio" name="game_type" style="width:20px;" class="input" ID="Radio2" value="I">종목
    <input type="radio" name="game_type" style="width:20px;" class="input" ID="Radio1" value="T">테마
    </td>
    <td width="60%" align=left>내용
    <input type="text" name="message_desc" style="width:400px;" class="input" ID="Text2" >
    </td>
    <td width="10%" bgcolor="#ffffff" align="center">
    <input id="submit2" name="submit1" type="submit" value="등록">
    </td>
    </tr>  
    </table>
    </form>
  <% end if %>
   
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#e8e8e8">  
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">#</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">게임종류</td>   
    <td width="70%"  align="center" style="border-right:dotted 1px #ffffff;">내용</td>     
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">순서</td>        
    </tr>


    <table width="100%" cellpadding=0 cellspacing=0 border=0>
    	<% if NoDataMessage = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsMessage.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsMessage.EOF and RowCount > 0 %>   
          <% if rsMessage("message_no") * 1 - message_no  = 0 then %>    
          <tr height="25" style="border-bottom:dotted 1px #dddddd; background-color:#47B7AD;">
          <% else %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <% end if %> 


          <td width="10%" align="center">
          <%=rsMessage("message_no") %>
          </td>
          <td width="10%" align="center" >
          <a href="default.asp?page=<%=cPage%>&message_no=<%=rsMessage("message_no") %>">
          <% if rsMessage("game_type") = "T" then %>테마주
          <% elseif rsMessage("game_type") = "U" then %>UP&DOWN
          <% elseif rsMessage("game_type") = "I" then %>종목별
          <% end if %>
          </a>
          </td>
          <td width="70%" align="center">
          <a href="default.asp?page=<%=cPage%>&message_no=<%=rsMessage("message_no") %>"><%=rsMessage("message_desc") %></a>
          </td>
          <td width="10%" align="center">
          <%=rsMessage("order_seq") %>
          </td>
          </tr>

        <%                                
        	RowCount = RowCount - 1
        	rsMessage.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	메세지가 없습니다.
        </td></tr>
        <% end if         
       	set rsMessage = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataMessage = false Then
	Cus_Tar = "peio_no=" & peio_no 
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
