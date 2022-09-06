<% 
if Session("member_no") < "1" then
response.redirect "/mobile/login.asp"
end if
%>