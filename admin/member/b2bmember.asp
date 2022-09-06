<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<SCRIPT language="javascript">
    function gradeselect() {
        formGrade.submit();
    }
</SCRIPT>
<%

  if request("grade_cd") <> "" then	
     grade_cd = request("grade_cd")
  end if
  
  'response.write   grade_no & "..."
  
  if request("member_no") <> "" then	

	member_no = request("member_no")
    strSQL = "p_sm_member_detail '" & member_no & "' "
    'response.Write strSQL
    'bRtn = dbcon.GetResult(strSQL, rs)
    
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
    if NOT rs.EOF and NOT rs.BOF then
      member_id = rs("member_id")
      member_email = rs("member_email")
      member_alias = rs("member_alias")
      grade_desc = rs("grade_desc")
      margin_rate = rs("margin_rate")
      'grade_cd = rs("grade_cd")
    end if 
    set rs = nothing
    
  end if 
  
  ' member 읽기
  strSQL = "p_sm_member_b2b_list '" & grade_cd & "'"
  'response.Write strSQL  

  ' 페이지 작동되는 방식
  Set rsMember = Server.CreateObject("ADODB.RecordSet")
  rsMember.cursorlocation = 3
  rsMember.Open strSQL, DbCon, 1, 3

  if rsMember.EOF or rsMember.BOF then
	NoDataMember = True
  Else
	NoDataMember = False
  end if 
  
  '페이징처리관련
  page =request("page")
  If NoDataMember = False then
		Cus_pageSize = 20
		rsMember.PageSize = Cus_pageSize

		pagecount=rsMember.pagecount
		totalRecord = rsMember.RecordCount

		cPage = page
		if page <> "" Then
			if cPage < 1 Then 
				cPage = 1
			end if
		else
			page = 1
			cPage = 1
		end If	
		rsMember.AbsolutePage = cPage

		lastpg = int(((totalRecord -1) / rsMember.PageSize) + 1)

		if page > lastpg then
			page = lastpg
		end If

	end if
	'페이징처리관련 끝 

    strSQL = "p_sm_code_select_grade  "
    'response.Write strSQL
    
    Set rsGrade = Server.CreateObject("ADODB.RecordSet")
    rsGrade.Open strSQL, DbCon, 1, 1

    if rsGrade.EOF or rsGrade.BOF then
  	  NoDataGrade = True
    Else
	  NoDataGrade = False
    end if 


    strSQL = "p_sm_member_b2b_select  '" & member_no & "'"
    
    'response.Write strSQL
    
    Set rsMemberSelect = Server.CreateObject("ADODB.RecordSet")
    rsMemberSelect.Open strSQL, DbCon, 1, 1

    if rsMemberSelect.EOF or rsMemberSelect.BOF then
  	  NoDataMemberSelect = True
    Else
	  NoDataMemberSelect = False
    end if 

%>
<div style="height:20px;"></div>
<table width="1024" cellpadding="0" cellspacing="0" border="0">
<tr>
<td width=270 valign=top>

  <!-- #include virtual="/_include/menu_admin_customer.asp" -->
       
</td>

<td width=754 valign=top>  

<% membermenu = "B2B"
   menu_desc = "B2B회원관리"
%>
<!-- #include virtual="/_include/guide_admin_customer.inc" -->

  <table width="100%" cellpadding="0" cellspacing="0" border="1">
  <tr>
  <td width=300 valign=top>
       
    <div style="padding:10px;text-align:center;">
    <form action="b2bmember.asp" id="formGrade" name="formGrade" method="post">
      <select name="grade_cd" onChange="javascript:gradeselect();">
      <% if grade_cd = "" then %>   
      <option value="" selected>(전체)</option>
      <% else %>
      <option value="">(전체)</option>
      <% end if %>
      <% if NoDataGrade = False then ' 데이터가 있으면 데이터 출력 %>
      <% Do While Not rsGrade.EOF  %> 
      <% if rsGrade("grade_cd") <> grade_cd then %>   
      <option value="<%=rsGrade("grade_cd") %>"><%=rsGrade("grade_desc") %></option>
      <% else %>
      <option value="<%=rsGrade("grade_cd") %>" selected><%=rsGrade("grade_desc") %></option>
      <% end if %>
      <% rsGrade.MoveNext
	     Loop       
      end if         
      'set rsGrade = nothing
      %> 
      </select>
    </form>
    </div>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="30%" align="center" style="border-right:dotted 1px #ffffff;">ID</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">등급</td>  
    <td width="40%" align="center" style="border-right:dotted 1px #ffffff;">개인/마진</td>    
    <td width="25%" align="center" style="border-right:dotted 1px #ffffff;">CHILD</td>    
    </tr>
    	<% if NoDataMember = False then ' 데이터가 있으면 데이터 출력 %>
        <% if FirstPage <> 1 then
	       RowCount = rsMember.PageSize
	       end If ' 데이터가 있으면 데이터 출력 
           Do While Not rsMember.EOF and RowCount > 0    %>    
        <%   if rsMember("member_no") * 1 - member_no  = 0   then %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47B7AD;">
          <% else %>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;">
          <% end if %>        
          <td width="30%" align="center">&nbsp;
          <a href="b2bmember.asp?page=<%=cPage%>&member_no=<%=rsMember("member_no") %>&grade_cd=<%=grade_cd %>">
          <span style="color:#3388cc;font-weight:bold;"><%=rsMember("member_id") %></span></a>
          </td>
          <td width="25%" align="center">
          <%=rsMember("grade_desc") %>
          </td>
          <td width="30%" align="center">
          <a href="b2bmember.asp?page=<%=cPage%>&member_no=<%=rsMember("member_no") %>&grade_cd=<%=grade_cd %>"><span style="color:#ff6600;font-weight:bold;"><%=rsMember("margin_rate") %></span></a> /
          <%=rsMember("base_margin") %>
          </td>
          <td width="25%" align="center">
          <%=rsMember("child_cnt") %>
          </td>
          </tr>

        <%                                
        	RowCount = RowCount - 1
        	rsMember.MoveNext
	        Loop 
        %>
		<% else %>
		<tr height="35">
		<td align="center" colspan="3">
        	회원이 없습니다.
        </td></tr>
        <% end if         
       	set rsMember = nothing
        %> 
    </table>
    <!-- 페이징 처리-->					
<%if NoDataMember = false Then
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
	Response.Write ShowPageBar("b2bmember.asp", Cus_pageSize, totalRecord, cPage, "/images/btn_board_pre.gif","/images/btn_board_next.gif",Cus_Tar)
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
  <td width=454 valign=top>

  <% if member_no > "0" then %>
  
    <div style="padding:8px;text-align:center;background-color:#ffffff;">
    <form action="b2bmember_rate_set.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="member_no" value="<%=member_no %>" ID="Hidden1"> 
    <input type="hidden" name="page" value="<%=cPage %>" ID="Hidden2"> 
    <table width="100%"  bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
    <tr>
    <td width="40%" align=center>    
    <%=member_id %> (<%=grade_desc %>)
    </td>
    <td width="40%" align=center>    
    <input type="text" name="margin_rate" value="<%=margin_rate %>" style="width:80px;text-align:center;background-color:#ffff00;" />
    </td>
    <td width="20%" align="center">
    <input id="submit1" name="submit1" type="submit" value="설정">
    </td>
    </tr>  
    </table>
    </form>
    </div>    
    
    <div>
      <% if NoDataMemberSelect = False then ' 데이터가 있으면 데이터 출력 %>
      <table width="100%" cellpadding=0 cellspacing=0 border=0> 
        <tr  height="25" style="border-bottom:solid 1px #dddddd;background-color:#dddddd;">
        <td width="30%" align="center">ID</td>
        <td width="30%" align="center">등급</td>
        <td width="20%" align="center">마진율</td>
        <td width="20%" align="center"></td>
        </tr>
      <% Do While Not rsMemberSelect.EOF  %> 
        <tr  height="25" style="border-bottom:solid 1px #dddddd;">
        <td width="30%" align="center">
        <%=rsMemberSelect("member_id") %>
        </td>
        <td width="30%" align="center">
        <%=rsMemberSelect("grade_desc") %>
        </td>
        <td width="20%" align="center">
        <%=rsMemberSelect("margin_rate") %>
        </td>
        <td width="20%" align="center">
        <%=rsMemberSelect("parent_flag") %>
        </td>
        </tr>

      <% rsMemberSelect.MoveNext
	     Loop 
      %>
      </table>
      <%
      else
      %>
      <div style="padding:10px;text-align:center;">
      회원이 없습니다.
      </div>
      <%
      end if         
      set rsMemberSelect = nothing
      %>
  </div>
  <% else %>
    <table width="100%"  border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="100%" align="center">회원을 클릭하세요.
    </td>
    </tr>  
    </table>
  <% end if %>    
  </td>
  </table>

  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
