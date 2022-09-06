<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<SCRIPT language="javascript">
    function codetypeselect() {
        formCODETYPE.submit();
    }
</SCRIPT>

<%

  ' flag 1:신규, 2:수정 3:수집종료, 4:수집시작, 5:삭제    

  ' Code type list 읽기
  strSQL = "p_sm_codetype_list"
  
  'response.Write strSQL
  'response.End

  Set rsCodetype = Server.CreateObject("ADODB.RecordSet")
  rsCodetype.Open strSQL, DbCon, 1, 1
  
  if rsCodetype.EOF or rsCodetype.BOF then
	NoDataCodetype = True
  Else
	NoDataCodetype = False
  end if
   
  'response.Write strSQL
  'response.End

  ' Code type 읽기
  if request("codetype_cd") <> "" then

    codetype_cd = request("codetype_cd")

    strSQL = "p_sm_codetype_detail'" & codetype_cd & "'"
      
    'response.Write strSQL
    'response.End

    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1

   'response.Write strSQL
   'response.End

    codetype_desc = rs("codetype_desc")
      
    set rs = nothing
  end if
  
  'response.Write strSQL

  ' Code list 읽기

  strSQL = "p_sm_code_list '" & request("codetype_cd") & "'"
  
  Set rsCode = Server.CreateObject("ADODB.RecordSet")
  rsCode.Open strSQL, DbCon, 1, 1

  if rsCode.EOF or rsCode.BOF then
	NoDataCode = True
  Else
	NoDataCode = False
  end if

  ' Code 읽기
  if request("code_no") <> "" then

    code_no = request("code_no")
    
    strSQL = "p_sm_code_detail'" & code_no & "'"
    
    Set rsData = Server.CreateObject("ADODB.RecordSet")
    rsData.Open strSQL, DbCon, 1, 1
        
    code_cd = rsData("code_cd")
    code_desc = rsData("code_desc")
    order_seq = rsData("order_seq")
    code_value = rsData("code_value")

    set rsData = nothing
  end if

%>

<div style="height:20px;"></div>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table9" width="1024">
<tr>
<td width=270 valign=top>  
  <!-- #include virtual="/_include/menu_admin_site.asp" -->       
</td>
<td width=754 valign=top>  

<% membermenu = "CODE"
   menu_desc = "통합코드관리"
%>
<!-- #include virtual="/_include/guide_admin_site.inc" -->


  <div style="margin:10px 0 0 0;">
  
  <table width="100%" cellpadding=0 cellspacing=0 border=1>
  <tr>
  <td width="50%" valign="top">

    <div style="padding: 5px;background-color:#ffffff; ">

    <% if codetype_cd <> "" then %>
    <form action="codetype_update.asp" id="form2" name="formTool" method="post">
    <input type="hidden" name="codetype_cd" value="<%=codetype_cd %>" ID="Hidden4">
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="25">
    <td width="70%" align="center"> 
    <%=codetype_cd %>  
    <input type="text" name="codetype_desc" style="width:160px;" class="input" ID="Text1" value="<%=codetype_desc %>" placeholder="TYPE">&nbsp;
    </td>
    <td width="30%" align="center">
    <a href="default.asp">[N]</a> 
    <input id="submit3" name="submit1" type="submit" value="TYPE수정">
    </td>
    </tr>  
    </table>
    </form>
    <% else %>
    <form action="codetype_insert.asp" id="form3" name="formTool" method="post"> 	
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="25">
    <td width="70%" align="center"> 
    <input type="text" name="codetype_cd" style="width:60px;" class="input" ID="Text3" value="<%=codetype_cd %>" placeholder="TYPE코드">&nbsp;
    <input type="text" name="codetype_desc" style="width:160px;" class="input" ID="Text6" value="<%=codetype_desc %>" placeholder="TYPE">&nbsp;
    </td>
    <td width="30%"   align="center">
    <input id="submit4" name="submit1" type="submit" value="TYPE입력">
    </td>
    </tr>  
    </table>
    </form>
    <% end if %>
    </div>
    
    <div style="padding: 5px;">
    
    <table width="100%" cellpadding=0 cellspacing=0 border=0>
        <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#dddddd;">
        <td width="30%" align="center">TYPE코드</td>
        <td width="70%" align="center">TYPE</td>
        </tr>
    	<% if NoDataCodetype = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsCodeType.EOF   %>    
          <% if rsCodeType("codetype_cd") = codetype_cd  then %>
          <tr width="100%" height="25" style="border-bottom:dotted 1px #dddddd;background-color:#47B7AD;">
          <% else %>
          <tr width="100%" height="25" style="border-bottom:dotted 1px #dddddd;">
          <% end if %>        
          <td width="30%" align="center">
          <%=rsCodeType("codetype_cd") %>
          </td>
          <td width="70%" align="left">
          <a href="default.asp?codetype_cd=<%=rsCodeType("codetype_cd") %>"><%=rsCodeType("codetype_desc") %></a>
          </td>
          </tr>
        <%                            
        	rsCodeType.MoveNext
	        Loop 
        %>
		<% else %>
		<tr>
		<td colspan="2" align="center">
            코드TYPE 없습니다.
        </td>
        </tr>
        <% end if         
       	set rsCodeType = nothing
        %> 
    </table>

    
    </div>

  
  
  </td>
  <td width="50%" valign="top">

    <% if codetype_cd <> "" then %>
    <div style="padding: 5px;text-align:center;color:#3388cc;font-weight:bold;">
    <%=codetype_cd %>:<%=codetype_desc %>
    </div>

    <div style="padding: 5px;background-color:#ffffff; ">
    <% if code_no > "0" then %>
    <form action="code_update.asp" id="formTool" name="formTool" method="post">
    <input type="hidden" name="codetype_cd" value="<%=codetype_cd %>" ID="Hidden1">
    <input type="hidden" name="code_no" value="<%=code_no %>" ID="Hidden2">
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="25">
    <td width="70%" align="center">
    <%=code_cd %> 
    <input type="text" name="code_desc" style="width:100px;" class="input" ID="Text7" value="<%=code_desc %>" placeholder="코드설명">
    <input type="text" name="order_seq" style="width:50px;text-align:center;" class="input" ID="Text2" value="<%=order_seq %>" placeholder="순서">
    </td>
    <td width="30%" align="center">
    <a href="default.asp?codetype_cd=<%=codetype_cd %>">[NEW]</a>
    <input id="submit1" name="submit1" type="submit" value="수정">
    </td>
    </tr>  
    </table>
    </form>
    <% else %>
    <form action="code_insert.asp" id="form1" name="formTool" method="post">
    <input type="hidden" name="codetype_cd" value="<%=codetype_cd %>" ID="Hidden3">
    <table width="100%"   border="0" cellpadding="0" cellspacing="0">
    <tr height="25">
    <td width="70%" align="center">
    <input type="text" name="code_cd" style="width:60px;" class="input" ID="Text4" value="<%=code_cd %>" placeholder="코드">
    <input type="text" name="code_desc" style="width:100px;" class="input" ID="Text8" value="<%=code_desc %>" placeholder="코드설명">
    </td>
    <td width="30%"   align="center">
    <input id="submit2" name="submit1" type="submit" value="입력">
    </td>
    </tr>  
    </table>
    </form>
    <% end if %>
    </div>
    <div style="padding: 5px;">    

    <table width="100%" cellpadding=0 cellspacing=0 border=0>
          <tr height="25" style="border-bottom:dotted 1px #dddddd;background-color:#dddddd;">
          <td width="30%" align="center">코드</td>
          <td width="50%" align="center">코드설명</td>
          <td width="20%" align="center">순서</td>
          </tr>

    	<% if NoDataCode = False then ' 데이터가 있으면 데이터 출력 %>
        <% Do While Not rsCode.EOF     %>  
          <%   if rsCode("code_no") * 1 - code_no  = 0   then %>
          <tr width="100%" height="22" style="border-bottom:dotted 1px #dddddd;background-color:#47B7AD;">
          <% else %>
          <tr width="100%" height="22" style="border-bottom:dotted 1px #dddddd;">
          <% end if %>        
          <td width="30%" align="center">
          <a href="default.asp?codetype_cd=<%=codetype_cd %>&code_no=<%=rsCode("code_no") %>&"><%=rsCode("code_cd") %></a>
          </td>
          <td width="50%" align="center">
          <a href="default.asp?codetype_cd=<%=codetype_cd %>&code_no=<%=rsCode("code_no") %>&"><%=rsCode("code_desc") %></a>
          </td>
          <td width="20%" align="center">
          <%=rsCode("order_seq") %>
          </td>
          </tr>

        <%                            
        	rsCode.MoveNext
	        Loop 
        %>
		<% else %>
		<tr>
		<td colspan="3" align="center">
            코드가 없습니다.
        </td>
        </tr>
        <% end if         
       	set rsCode = nothing
        %> 
    </table>
    </div>
    <% else %>
    <div style="padding: 5px;background-color:#ffffff;text-align:center;">
    TYPE을 선택하여 코드를 관리하세요.
    </div>
    <% end if %> 
  </td>
  </tr>
  </table>
  </div>
   


  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->