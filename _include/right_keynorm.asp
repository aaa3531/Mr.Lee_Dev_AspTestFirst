<div style="height:40px;"></div>
<%
    keynorm_no = request("keynorm_no")
    keynorm_search = request("keynorm_search")
%>
<div id="righttitle">Keynorm선택</div>  
<div class="rightbox">
<span class="contents">
	    <form action="default.asp" id="formKeynormSearch" name="formKeynormSearch" method="post">
        <input type="hidden" name="topic_no" value="<%=topic_no %>">
        <input type="text" name="keynorm_search" size="6" style="width:160" class="input" ID="Text3" value="<%=keynorm_search %>">
        <input id="submit1" name="submit1" type="submit" value="검색">
        </form>	
</span>
<div class="line"></div>
   <%
   
   
    if keynorm_search = "" then
      strSQL = "select top 20 * from gim_keynorm order by keynorm_no desc"
    else
      strSQL = "select * from gim_keynorm where keynorm_name like '%" & keynorm_search & "%'"
    end if
             
    bRtn = dbcon.GetResult(strSQL, rsKeynorm)
 
    if rsKeynorm.EOF or rsKeynorm.BOF then
    	NoDataKeynorm = True
    Else
    	NoDataKeynorm = False
    end if   

    if NoDataKeynorm = False then
    
    Do While Not rsKeynorm.EOF
    %>
    <% if rsKeynorm("keynorm_no") * 1 - keynorm_no <> 0 then  %>
    <div style="padding:5px 0 5px 0;border-bottom:dotted 1px #dddddd;">
    <a href="default.asp?keynorm_no=<%=rsKeynorm("keynorm_no") %>"><span style="color:#3388cc;font-weight:bold;"><%=rsKeynorm("keynorm_name") %></span></a>
    </div>
    <% else %>
    <div style="padding:5px 0 0 0;">
    <span style="color:#ff6600;font-weight:bold;"><%=rsKeynorm("keynorm_name") %></span>
    </div>
    <div style="padding:3px 0 5px 0;border-bottom:dotted 1px #dddddd;">
    <span><%=rsKeynorm("keynorm_desc") %></span>
    </div>
    <% end if %>
    <%                                     
     	rsKeynorm.MoveNext
	    Loop 
      	set rsKeynorm = nothing
    
    end if %>
</div>