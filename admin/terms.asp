<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("terms_no") = "" then	
    terms_no = "0"
  else
	terms_no = request("terms_no")
    strSQL = "p_sm_terms_detail '" & terms_no & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      terms_no = rs("terms_no")
      terms_desc = rs("terms_desc")
      terms_version = rs("terms_version")
      start_date = rs("start_date")
      update_date = rs("update_date")
    end if 
    set rs = nothing
  end if 
  
  ' terms 읽기
  strSQL = "p_sm_terms_list "

  'bRtn = dbcon.GetResult(strSQL, rsTerms)

  ' 페이지 작동되는 방식
  Set rsTerms = Server.CreateObject("ADODB.RecordSet")
  rsTerms.cursorlocation = 3
  rsTerms.Open strSQL, DbCon, 1, 3

  if rsTerms.EOF or rsTerms.BOF then
	NoDataTerms = True
  Else
	NoDataTerms = False
  end if 
  
  '페이징처리관련
  page =Cint(request("page"))
  If NoDataTerms = False then
		Cus_pageSize = 10
		rsTerms.PageSize = Cus_pageSize

		pagecount=rsTerms.pagecount
		totalRecord = rsTerms.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsTerms.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsTerms.PageSize) + 1)

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

<% membermenu = "TERMS"
   menu_desc = "이용약관"
%>
<!-- #include virtual="/_include/guide_admin_site.inc" -->

  <div style="height:10px;"></div>

  <% if terms_no > "0" then %>
    <form action="terms_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="terms_no" value="<%=terms_no %>" ID="Hidden1"> 
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden2"> 	
    <table width="100%"  bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="20%" align="center">문서명
    <input type="text" name="terms_desc" style="width:80px;" class="input" ID="Text3" value="<%=terms_desc %>" >
    </td>
    <td width="20%" align="center">문서Ver
    <input type="text" name="terms_version" style="width:80px;" class="input" ID="Text2" value="<%=terms_version %>" >
    </td>
    <td width="25%" align=center>시행일자
    <input type="text" name="start_date" style="width:80px;" class="input" ID="Text1" value="<%=start_date %>" >
    </td>
    <td width="15%" align="center">
    <a href="terms.asp">[NEW]</a>
    <input id="submit1" name="submit1" type="submit" value="약관수정">
    </td>
    </tr>  
    </table>
    </form>
  <% else %>
    <form action="terms_insert.asp" id="form1" name="formTool" method="post">
    <input type="hidden" name="terms_no" value="<%=terms_no %>" ID="Hidden3"> 
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden4"> 	
    <table width="100%"  bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="20%" align="center">문서명
    <input type="text" name="terms_desc" style="width:80px;" class="input" ID="Text5" >
    </td>
    <td width="20%" align="center">문서Ver
    <input type="text" name="terms_version" style="width:80px;" class="input" ID="Text6" >
    </td>
    <td width="25%" align=center>시행일자
    <input type="text" name="start_date" style="width:80px;" class="input" ID="Text7" >
    </td>
    <td width="15%" align="center">
    <input id="submit2" name="submit1" type="submit" value="약관등록">
    </td>
    </tr>  
    </table>
    </form>
  <% end if %>
   
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="10%" align="center" style="border-right:dotted 1px #ffffff;">NO</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">문서명</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">문서Ver.</td>    
    <td width="15%"  align="center" style="border-right:dotted 1px #ffffff;">시행일자</td>    
    <td width="15%"  align="center" style="border-right:dotted 1px #ffffff;">수정일</td>   
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">관리</td>      
    </tr>


    <table width="100%" cellpadding=0 cellspacing=0 border=0>
    	<% if NoDataTerms = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsTerms.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsTerms.EOF and RowCount > 0         
           if rsTerms("terms_no") * 1 - terms_no  = 0   then %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#ffffff;">
          <td width="10%" align="center">
          <%=rsTerms("terms_no") %>
          </td>
          <td width="20%" align="left">
          <a href="terms.asp?page=<%=cPage%>&terms_no=<%=rsTerms("terms_no") %>"><%=rsTerms("terms_desc") %></a>
          </td>
          <td width="20%" align="center">
          <a href="terms.asp?page=<%=cPage%>&terms_no=<%=rsTerms("terms_no") %>"><%=rsTerms("terms_version") %></a>
          </td>
          <td width="15%" align="center">
          <%=rsTerms("start_date") %>
          </td>
          <td width="15%" align="center">
          <%=rsTerms("update_date") %>
          </td>
          <td width="20%" align="center">
          <a href="terms_detail.asp?terms_no=<%=rsTerms("terms_no") %>"><span class="linkbtn">작성</span></a>
          &nbsp;<a href="terms_delete.asp?page=<%=cPage%>&terms_no=<%=rsTerms("terms_no") %>"><span class="linkbtn">삭제</span></a>
          </td>
          </tr>
          <% else %>
          
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <td width="10%" align="center">
          <%=rsTerms("terms_no") %>
          </td>
          <td width="20%" align="left">
          <a href="terms.asp?page=<%=cPage%>&terms_no=<%=rsTerms("terms_no") %>"><%=rsTerms("terms_desc") %></a>
          </td>
          <td width="20%" align="center">
          <a href="terms.asp?page=<%=cPage%>&terms_no=<%=rsTerms("terms_no") %>"><%=rsTerms("terms_version") %></a>
          </td>
          <td width="15%" align="center">
          <%=rsTerms("start_date") %>
          </td>
          <td width="15%" align="center">
          <%=rsTerms("update_date") %>
          </td>
          <td width="20%" align="center">
          <a href="terms_detail.asp?terms_no=<%=rsTerms("terms_no") %>"><span class="linkbtn">작성</span></a>
          &nbsp;<a href="terms_delete.asp?page=<%=cPage%>&terms_no=<%=rsTerms("terms_no") %>"><span class="linkbtn">삭제</span></a>
          </td>
          </tr>
          <% end if %>        

        <%                                
        	RowCount = RowCount - 1
        	rsTerms.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	회원이 없습니다.
        </td></tr>
        <% end if         
       	set rsTerms = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataTerms = false Then
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
	Response.Write ShowPageBar("terms.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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
