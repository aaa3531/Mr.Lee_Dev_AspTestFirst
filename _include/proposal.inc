<div style="height:10pt"></div>
<% if Session("member_no") > "" then %>
<script src="/common/editor/ckeditor.js"></script>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="270" align="center">
<tr>
<td align="center" valign="middle">
  <form name="form3" method="get" action="/econnect/send_gi.asp"  ID="form3">
  <table cellSpacing="0" cellPadding="0" border="0" ID="Table2" width="100%" align="center">
	    <tr height=25>
		<td width="270" align=center bgcolor="#ffffff">
		<a href="/giprosuming/propose.asp">정보제공</a>
		<select name="cat_no" ID="cat_no">
      <%
      Set Dbcon1 = Server.CreateObject("eDBConn.CQuery")
      strSQL = "select * from gim_category where usage_flag = '1' "
      'response.Write strSQL
      bRtn = dbcon1.GetResult(strSQL, rs)

      if rs.EOF or rs.BOF then
        NoData = True
      Else
	    NoData = False
      end if    
      
      if NoData = False then 

      Do While Not rs.EOF %>   
      <option value="<%=rs("cat_no") %>"><%=rs("cat_name") %></option>
      </a>
     
      <%
        rs.MoveNext
	    Loop 
	    
	    end if
        set rs = nothing
        Set Dbcon1 = Nothing
      %> 
      </select>
      		
      </td>
      </tr>
  </table>		
  <input type="hidden" name="serviceuser_no" value="255" ID="Hidden10"> 	    		    	    
  <table cellSpacing="0" cellPadding="0" border="0" ID="Table3" width="270"  bgcolor="#ddaaaa">        
        <tr>
	<td width=30 align=center>제목</td>
	<td width=240 align=left>
	<input type="text" name="report_name" size="255"  style="width:100%"  class="input" ID="Text5" required>
	</td>
	</tr>
        <tr>
        <td  align="left"  width="270" colspan="2">
        <textarea id="Textarea2" name="report_summary" cols="45" rows="2" style="width:100%" placeholder="여기에는 한줄요약,링크를 넣어주세요."></textarea>
        </td>
        </tr>
        <tr>
	<td width=30 align=center>LINK</td>
	<td width=240 align=left>
	<input type="text" name="source_link" size="255"  style="width:100%"  class="input" ID="Text5">
	</td>
	</tr>
        <tr>
	<td width=30 align=center>IMG</td>
	<td width=240 align=left>
	<input type="text" name="mainimage_url" size="255"  style="width:100%"  class="input" ID="Text5">
	</td>
	</tr>
        <tr>
	<td width=30 align=center>키</td>
	<td width=240 align=left>
	<input type="text" name="keyword_desc" size="255" style="width:120" class="input" ID="Text5" required>
	</td>
	</tr>
        <tr height="25">
	<td width="270" align=left colspan="2">
	<textarea id="editor1" name="report_note" cols="45" rows="5" style="width:260" class="inputtext" ID="Textarea1"></textarea>		
	<script>		
	CKEDITOR.replace('editor1',{
	toolbar : [
	[ 'Image', 'Table', 'Smiley', 'SpecialChar' ]
	]});
	</script>		
	</td>
	</tr>	
	<tr>
	<td width=30 align=center>필자</td>
	<td width=240 align=left>
        <% writer_desc = "세계화연구원 &quot;" & Session("member_alias") & "&quot;" %>
	<input type="text" name="writer_desc" size="255"  style="width:100%"  class="input" ID="Text1" value="<%=writer_desc  %>">
	</td>
	</tr>
	<tr>
	<td width=30 align=center>tag</td>
	<td width=240 align=left>
	<input type="text" name="report_tag" size="255" style="width:100%" class="input" ID="Text1">
	</td>
	</tr>
	<tr>
	<td width=35 align=center>
	<img src="/images/email_icon.jpg" id="Image3" width=15 height=11>
        </td>
	<td align=left>
	<input type="text" name="person_email" size="255" style="width:125" class="input" ID="Text6" value="<%=Session("member_email") %>">&nbsp;
	<img src="/images/telephone_icon.jpg" id="Image3" width=15 height=11>
	<input type="text" name="person_phone" size="255" style="width:80" class="input" ID="Text4" value="<%=Session("member_phone") %>">
	</td>
	</tr>
	<tr height=25>
	<td colspan=2 align=center>등록
        <input type="image" src="/images/minibtn_plus_on.jpg" id="Image3">&nbsp;</td>
	</tr>
    </table>      
</td>
</tr>	
</table>
<% else %>
<table cellSpacing="0" cellPadding="0" border="0" ID="Table1" width="270" align="center">
	<tr height="30"">
		<td align="center" valign="middle">로그인하여 정보제공
		</td>
	</tr>
</table>
<% end if %>
	