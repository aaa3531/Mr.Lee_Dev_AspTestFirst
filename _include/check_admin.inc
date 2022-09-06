<% 
if Session("member_no") < "1" or Session("admin_flag") < "1" then
response.redirect "/"
end if
%>