<% 
if Session("admin_flag") < "1" then
response.redirect "/"
end if
%>