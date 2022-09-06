<%
if Session("worldflower_flag") < "1" then
%>
<SCRIPT LANGUAGE=javascript>
<!--
    alert("로그인과 세계화체크가(참여) 필요합니다. (고객센터 > 회원정보변경)");
    location.href = "/gimember/change.asp"
//-->
</SCRIPT>
<% end if %>