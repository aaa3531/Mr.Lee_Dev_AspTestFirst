<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
    'terms 읽기
   if request("terms_no") = "" then	
      terms_no = "0"
   else
   	terms_no = request("terms_no")
    strSQL = "p_sm_terms_detail '" & terms_no & "' "
    
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
  

  'detail 읽기
   if request("detail_no") = "" then	
      detail_no = "0"
   else
   	detail_no = request("detail_no")
    strSQL = "p_sm_terms_detail_detail '" & detail_no & "' "
    
    Set rsDetail = Server.CreateObject("ADODB.RecordSet")
    rsDetail.Open strSQL, DbCon, 1, 1
  
    if NOT rsDetail.EOF and NOT rsDetail.BOF then
      detail_no = rsDetail("detail_no")
      section_cd = rsDetail("section_cd")
      section_desc = rsDetail("section_desc")
      detail_desc = rsDetail("detail_desc")
      order_seq = rsDetail("order_seq")
    end if 
    set rsDetail = nothing
  end if 


  ' terms list 뿌리기
  strSQL = "p_sm_terms_list "

  Set rsTerms = Server.CreateObject("ADODB.RecordSet")
  rsTerms.cursorlocation = 3
  rsTerms.Open strSQL, DbCon, 1, 3

  if rsTerms.EOF or rsTerms.BOF then
	NoDataTerms = True
  Else
	NoDataTerms = False
  end if 


   ' terms Detail 뿌리기
  strSQL = "p_sm_terms_detail_list '" & terms_no & "' "

  Set rsDetailList = Server.CreateObject("ADODB.RecordSet")
    rsDetailList.Open strSQL, DbCon, 1, 1

  if rsDetailList.EOF or rsDetailList.BOF then
	NoDataDetailList = True
  Else
	NoDataDetailList = False
  end if 
  
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
    <input type="hidden" name="terms_no" value="<%=terms_no %>" ID="Hidden1"> 	
    <table width="100%"  bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
    <tr height="35">
    <td width="20%" align="center">
    <%=terms_desc %>
    </td>
    <td width="20%" align="center">
    <%=terms_version %>
    </td>
    <td width="25%" align=center>
    <%=start_date %>
    </td>
    <td width="10%" align=center>
    <a href="terms.asp"><input type="button" value="목록"></a>
    </td>
    </tr>  
    </table>
  <% else %>
  <% end if %>
   


    <% if detail_no > 0  then %>
    <form action="terms_detail_update.asp" id="form1" name="formTool" method="post">
    <input type="hidden" name="detail_no" value="<%=detail_no %>" ID="Hidden3"> 
    <input type="hidden" name="terms_no" value="<%=terms_no %>" ID="Hidden4"> 
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="60%" align=center>Section
    <input type="text" name="section_desc" style="width:300px;" class="input" ID="Text2" value="<%=section_desc %>" >
    </td>
    <td width="25%" align=center>순서
    <input type="text" name="order_seq" style="width:80px;" class="input" ID="Text1" value="<%=order_seq %>" >
    <a href="terms_detail.asp?terms_no=<%=terms_no%>">[NEW]</a> 
    </td>
    </table>
    
    <table width="100%" cellpadding=0 cellspacing=0 border=0>
          <tr height="150">
          <td width="100%" align="left" >
          <textarea name="detail_desc" style="width:754px;" class="input" rows="10" ID="Textarea2" ><%=detail_desc %></textarea>
          </td>
          </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" >
    <td width="25%" align=right>
    <input id="submit1" name="submit1" type="submit" value="수정">
    </td>
    </tr>
    </table>
    </form>

    <% else %>
    <form action="terms_detail_insert.asp" id="form2" name="formTool" method="post">
    <input type="hidden" name="detail_no" value="<%=detail_no %>" ID="Hidden2"> 
    <input type="hidden" name="terms_no" value="<%=terms_no %>" ID="Hidden5"> 
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#dddddd">
    <td width="60%" align=center>Section
    <input type="text" name="section_desc" style="width:300px;" class="input" ID="Text4" >
    </td>
    <td width="25%" align=center>순서
    <input type="text" name="order_seq" style="width:80px;" class="input" ID="Text5" >
    </td>
    </tr>
    </table>
    <table width="100%" cellpadding=0 cellspacing=0 border=0>
          <tr height="150">
          <td width="100%" align="left" >
          <textarea name="detail_desc" style="width:754px;" class="input" rows="10" ID="Textarea1" ></textarea>
          </td>
          </tr>
    </table>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" >
    <td width="25%" align=right>
    <input id="submit2" name="submit1" type="submit" value="저장">
    </td>
    </tr>
    </table>
    </form>
    <% end if %>

    
    
    
    
    	<% if NoDataDetailList = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsDetailList.EOF   %>
           <div style="padding:5px; background:#dddddd; font-size:14px; font-weight:bold;"><%=rsDetailList("section_desc") %> &nbsp;순서:<%=rsDetailList("order_seq") %></div>
           <div style="padding:50px;"><a href="terms_detail.asp?terms_no=<%=terms_no%>&detail_no=<%=rsDetailList("detail_no") %>"><%=rsDetailList("detail_desc") %></a></div>
        <%                           
        	rsDetailList.MoveNext
	        Loop 
        %>
		<% else %>
		<tr><td>
        	이용약관이 없습니다.
        </td></tr>
        <% end if
       	set DetailList = nothing
        %> 
        
  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
