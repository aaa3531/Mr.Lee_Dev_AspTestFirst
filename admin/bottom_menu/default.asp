<!-- #include virtual="/_include/top_menu_admin.inc" -->
<!-- #include virtual="/_include/connect.inc" -->
<%
        
  if request("menu_no") <> "" then
  
  menu_no = request("menu_no") 
  
  strSQL = "p_sm_bottom_menu_read_detail '" & menu_no & "'"
  
    Set rs = Server.CreateObject("ADODB.RecordSet")
    rs.Open strSQL, DbCon, 1, 1
  
  menu_name = rs("menu_name")
  cat_desc = rs("cat_desc")
  menu_desc = rs("menu_desc")
  order_seq = rs("order_seq")
  source_link = rs("source_link")
  
  set rs = nothing

  end if
        

  strSQL = "p_sm_bottom_menu_read"
  

  Set rsMenu = Server.CreateObject("ADODB.RecordSet")
  rsMenu.Open strSQL, DbCon, 1, 1
    
  if rsMenu.EOF or rsMenu.BOF then
	NoDataMenu = True
  Else
	NoDataMenu = False
  end if  

%>

<table width=1024 align=center>
<tr>

<td width=270 valign=top>

  <div style="height:20px;"></div>
  
  <!-- #include virtual="/_include/menu_admin_site.asp" -->
       
</td>

<td width=754 valign=top>  


<div class="admintitle">▣ ADMIN - 회원/구독자</div>

  <div style="height:50px;margin:0 0 2px 0;">  
  
  <table width="100%" cellpadding="0" cellspacing="0" border="0">
  <% if menu_no > "0" then %>
  <form action="bottommenu_set.asp" id="form2" name="formPkg" method="post">
  <input type="hidden" name="flag" value="2">
  <input type="hidden" name="menu_no" value="<%=menu_no %>">  
  <tr height="22">
  <td width="100%" align="left" >
  카테고리 <input type="text" name="cat_desc" size="255" style="width:120" class="input" ID="Text2" value="<%=cat_desc %>">&nbsp;  
  메뉴명 <input type="text" name="menu_name" size="255" style="width:250" class="input" ID="Text3" value="<%=menu_name %>">&nbsp;  
  순서<input type="text" name="order_seq" size="255" style="width:60" class="input" ID="Text6" value="<%=order_seq %>">&nbsp;  
  <a href="default.asp">[New]</a>
  <a href="bottommenu_set.asp?flag=5&menu_no=<%=menu_no %>&menu_name=<%=menu_name %>&cat_desc=<%=cat_desc %>">[삭제]</a>
  <input id="submit2" name="submit1" type="submit" value="수정">
  </td>
  </tr>
  <tr height="22">
  <td width="100%" align="left" >
  설명 <input type="text" name="menu_desc" size="255" style="width:250" class="input" ID="Text9" value="<%=menu_name_en %>">&nbsp;  
  링크 <input type="text" name="source_link" size="255" style="width:250" class="input" ID="Text12" value="<%=source_link %>">&nbsp;  
  </td>
  </tr>
  </form>
  <% else %>
  <form action="bottommenu_set.asp" id="form3" name="formPkg" method="post">
  <input type="hidden" name="flag" value="1">
  <tr height="22">
  <td width="100%" align="left" >
  카테고리 <input type="text" name="cat_desc" size="255" style="width:120" class="input" ID="Text1" value="<%=cat_desc %>">&nbsp;  
  메뉴명 <input type="text" name="menu_name" size="255" style="width:250" class="input" ID="Text4" value="<%=menu_name %>">&nbsp;  
  순서<input type="text" name="order_seq" size="255" style="width:60" class="input" ID="Text5" value="<%=order_seq %>">&nbsp;  
  <input id="submit1" name="submit1" type="submit" value="설정">
  </td>
  </tr>
  <tr height="22">
  <td width="100%" align="left" >
  설명 <input type="text" name="menu_desc" size="255" style="width:250" class="input" ID="Text7" value="<%=menu_name_en %>">&nbsp;  
  링크 <input type="text" name="source_link" size="255" style="width:250" class="input" ID="Text8" value="<%=source_link %>">&nbsp;  
  </td>
  </tr>
  </form>
  <% end if %>  
  </table>  
  
  </div>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="25" bgcolor="#e8e8e8">
    <td width="15%" align="center" style="border-right:dotted 1px #ffffff;">카테고리</td>    
    <td width="20%"  align="center" style="border-right:dotted 1px #ffffff;">메뉴명</td>    
    <td width="10%"  align="center" style="border-right:dotted 1px #ffffff;">삭제</td>    
    <td width="40%"  align="center" style="border-right:dotted 1px #ffffff;">설명</td>    
    <td width="15%"  align="center">순서</td>    
    </tr>
    <% if NoDataMenu = False then ' 데이터가 있으면 데이터 출력 %>
    <% 
       Do While Not rsMenu.EOF    %> 
    <% if rsMenu("usage_flag") = "1" then %>
    <tr height="25" bgcolor="#ffffff" style="border-bottom:dotted 1px #dddddd;">
    <% else %>
    <tr height="25" bgcolor="#dddddd" style="border-bottom:dotted 1px #dddddd;">
    <% end if %>
    <td align="center"><%=rsMenu("cat_desc") %></td>    
    <td>
    <a href="default.asp?menu_no=<%=rsMenu("menu_no") %>"><span style="color:#000000;font-weight:bold;"><%=rsMenu("menu_name") %></span></a>
    </td>    
    <td align="center"><%=rsMenu("usage_flag") %></td>    
    <td>
    <% if rsMenu("source_link") <> "" then %>
    <a href="http://<%=rsMenu("source_link") %>"><span style="color:#ff6600;font-weight:bold;"><%=rsMenu("menu_desc") %></span></a>
    <% else %>
    <span style="color:#000000;font-weight:bold;"><%=rsMenu("menu_desc") %></span>
    <% end if %>
    </td>    
    <td><%=rsMenu("order_seq") %></td>    
    </tr>
    <% 	
        cat_old =  rsMenu("cat_desc")
        rsMenu.MoveNext
	    Loop 
    %>
	<% else %>
	<tr height="25" bgcolor="#ffffff">
    <td width="60" align="center" colspan="4">Bottom 메뉴가 없습니다.</td>
    </tr>
    <% end if         
    set rsMenu = nothing
    %>        
    </table>


  
</td>
</tr>
</table>
<!-- #include virtual="/_include/connect_close.inc" -->
<!-- #include virtual="/_include/bottom_menu.inc" -->
