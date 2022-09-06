<div style="width:100%;">
  <div style="padding:10px 0 10px 0;text-align:center;border-top:dotted 0px #eeeeee;">
  <span style="padding:0 10px 0 10px">
  <a href="/gimember/app_request.asp"><span style="color:#d71874;font-size:10pt;font-weight:bold;">무료앱신청☞</a>
  </span>
  </div>
  <div style="line-height:100%;">
  <%   
        strSQL = "p_gam_app_list_booksnack_read "

        bRtn = giDbcon.GetResult(strSQL, rsApp)         
        
        if rsApp.EOF or rsApp.BOF then
          NoDataApp = True
        Else
	      NoDataApp = False
        end if        


  if NoDataApp = False then   
    	rsApp.MoveFirst
  Do While Not rsApp.EOF 
  %>
  <span style="float:left;padding:0 0 0 6px;text-align:center;font-size:3px;">
  <% if rsApp("down_link") <> "" then %>
  <a href="http://<%=rsApp("down_link") %>"><img src="http://<%=rsApp("logo_src") %>" style="width:40px;height:40px;padding:1px;border:solid 0px #ffffff;" ></a>
  <% else %>
  <img src="http://<%=rsApp("logo_src") %>" style="width:40px;height:40px;padding:1px;border:solid 0px #ffffff;" >
  <% end if %><br />
  <%=left(rsApp("app_short"),4) %>
  </span>
  <%
  rsApp.MoveNext
  Loop                                    
  else
  %>
  <span style="color:#000000;font-weight:bold;">App이 없습니다.</span>
  <%
  end if
  set rsApp = nothing
  %>
  </div>
  <div style="height:5px;margin:5px 0 0 0;clear:both;"></div>  
</div>