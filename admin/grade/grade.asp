<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%

  if request("grade_no") = "" then	
    grade_no = "0"
  else
	grade_no = request("grade_no")
    strSQL = "p_sm_grade_detail '" & grade_no & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      grade_no = rs("grade_no")
      grade_cd = rs("grade_cd")
      parent_cd = rs("parent_cd")
      grade_desc = rs("grade_desc")
      margin_rate = rs("margin_rate")
      order_seq = rs("order_seq")
    end if 
    set rs = nothing
  end if 
  
  ' grade 읽기
  strSQL = "p_sm_grade_list " 

  'bRtn = dbcon.GetResult(strSQL, rsGrade)

  ' 페이지 작동되는 방식
  Set rsGrade = Server.CreateObject("ADODB.RecordSet")
  rsGrade.cursorlocation = 3
  rsGrade.Open strSQL, DbCon, 1, 3

  if rsGrade.EOF or rsGrade.BOF then
	NoDataGrade = True
  Else
	NoDataGrade = False
  end if 
  
  'response.Write strSQL
  'response.End


  '페이징처리관련
  page =cint(request("page"))
  'response.Write page
  If NoDataGrade = False then
		Cus_pageSize = 20
		rsGrade.PageSize = Cus_pageSize

		pagecount=rsGrade.pagecount
		totalRecord = rsGrade.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsGrade.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsGrade.PageSize) + 1)
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

  
  <!-- #include virtual="/_include/menu_admin_customer.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "B2BGRADE"
   menu_desc = "B2B 등급관리"
%>
<!-- #include virtual="/_include/guide_admin_customer.inc" -->

  <div style="margin:10px 0 0 0;padding: 5px;background-color:#ffffff;">
  <% if grade_no > "0" then %>
    <form action="grade_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="grade_no" value="<%=grade_no %>" ID="Hidden1">
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden2"> 	
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="75%" align="center"> 
    <span style="color:#ff6600;font-weight:bold;"><%=grade_cd %></span>&nbsp;
    <input type="text" name="parent_cd" style="width:60px; text-align:center;" class="input" ID="Text9" value="<%=parent_cd %>" placeholder="부모">&nbsp;
    등급<input type="text" name="grade_desc" style="width:150px;" class="input" ID="Text1" value="<%=grade_desc %>" placeholder="등급">&nbsp;
    마진율<input type="text" name="margin_rate" style="width:50px; text-align:center;background-color:#ffff00;" class="input" ID="Text3" value="<%=margin_rate %>" placeholder="마진율">&nbsp;
    순서<input type="text" name="order_seq" style="width:50px; text-align:center;" class="input" ID="Text7" value="<%=order_seq %>" placeholder="순서">&nbsp;
    </td>
    <td width="25%" align="center">
    <a href="grade.asp">[NEW]</a>&nbsp;
    <input id="submit1" name="submit1" type="submit" value="등급수정">
    <a href="grade_delete.asp?grade_no=<%=grade_no %>&page=<%=page %>">[삭제]</a>&nbsp;
    </td>
    </tr>  
    </table>
    </form>
  <% else %>
    <form action="grade_insert.asp" id="form1" name="formTool" method="post">
    <input type="hidden" name="page" value="<%=page %>" ID="Hidden3"> 	
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="80%" align="center">
    <input type="text" name="grade_cd" style="width:70px;" class="input" ID="Text2" value="<%=grade_cd %>" placeholder="코드">&nbsp;
    <input type="text" name="parent_cd" style="width:80px;" class="input" ID="Text8" value="<%=parent_cd %>" placeholder="부모">&nbsp;
    등급<input type="text" name="grade_desc" style="width:150px;" class="input" ID="Text4" value="<%=grade_desc %>" placeholder="등급">&nbsp;
    마진율<input type="text" name="margin_rate" style="width:80px;background-color:#ffff00;" class="input" ID="Text6" value="<%=margin_rate %>" placeholder="마진율">&nbsp;
    </td>
    <td width="20%"   align="center">
    <input id="submit2" name="submit1" type="submit" value="등급입력">
    </td>
    </tr>  
    </table>
    </form>
  <% end if %>
  </div>
   
    <table width="100%" cellpadding=0 cellspacing=0 border=0>
          <tr height="30" style="border-bottom:dotted 1px #dddddd;background-color:#dddddd;">          
          <td width="10%" align="center">등급코드</td>
          <td width="10%" align="center">부모</td>
          <td width="25%" align="center">등급</td>
          <td width="15%" align="center">마진율</td>
          <td width="30%" align="center"></td>
          <td width="10%" align="center">순서</td>
          </tr>
    	<% if NoDataGrade = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsGrade.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsGrade.EOF and RowCount > 0   %> 
           <% if rsGrade("grade_no") * 1 - grade_no  = 0   then %>
          <tr height="30" style="border-bottom:dotted 1px #dddddd;background-color:#47b7ad;">
          <% else %>
          <tr height="30" style="border-bottom:dotted 1px #dddddd;">
          <% end if %> 
 
          <td align="center">
          <a href="grade.asp?page=<%=cPage%>&grade_no=<%=rsGrade("grade_no") %>"><span style="color:#3388cc;font-weight:bold;"><%=rsGrade("grade_cd") %></span></a>
          </td>
          <td  align="center">
          <%=rsGrade("parent_cd") %>
          </td>
          <td  align="center">
          <a href="grade.asp?page=<%=cPage%>&grade_no=<%=rsGrade("grade_no") %>"><%=rsGrade("grade_desc") %></a>
          </td>
          <td  align=center>
          <a href="grade.asp?page=<%=cPage%>&grade_no=<%=rsGrade("grade_no") %>"><%=rsGrade("margin_rate") %></a>
          </td>
          <td width="20%" align="center">
          <a href="grade_rate_set.asp?page=<%=cPage%>&grade_no=<%=rsGrade("grade_no") %>&grade_cd=<%=rsGrade("grade_cd") %>"><input type="button" value="마진율전체설정" /></a>
          </td>
          <td align=center>
          <a href="grade.asp?page=<%=cPage%>&grade_no=<%=rsGrade("grade_no") %>"><%=rsGrade("order_seq") %></a>
          </td>          
          </tr>       

        <%                                
        	RowCount = RowCount - 1
        	rsGrade.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td colspan="4">
        	등급이 없습니다.
        </td></tr>
        <% end if         
       	set rsGrade = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataGrade = false Then
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
	Response.Write ShowPageBar("grade.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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
