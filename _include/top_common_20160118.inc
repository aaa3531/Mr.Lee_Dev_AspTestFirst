<Script language="javascript">
function menuShow() {
 //menuHide();
 //document.all(menuidx).style.display="inline";
 menu1.style.display="inline";
}
function menuHide() {
 menu1.style.display = "none";
}
</script>
<html>
<head>
<title>K-1 SECURITIES - 즐거움의 모든 것</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="description" content="즐거움의 모든 것">
<meta name="keywords" content="즐거움의 모든 것">
<link rel="stylesheet" href="/_css/common.css">
</head>
<body style="background-color:#f2f2f2;">
<frameset rows="*,0" border="0" >
 <frame name="bgm" src="bgm.html" scrolling=no>

</frameset>
<div id="wrap">
<p>
<div id="topnavleft" style="padding:20px 10px 0 0;">
<A href="/">
<span style="font-size:18pt;font-family:Arial,맑은 고딕;font-weight:bold;color:#444444;text-shadow: 3px 3px #dddddd;">K-1 SECURITIES</span>
<span style="font-size:18pt;font-family:Arial,맑은 고딕;font-weight:bold;color:#00856A;text-shadow: 3px 3px #dddddd;">- 즐거움의 모든 것</span>
</a>
</div>
<div id="topnav" style="line-height:260%;">
<ul>
  <% if Session("member_no") < "1" then %>
    <li><a href="/sumember/register_step1.asp">회원가입</a></li>
    <li><a href="#">게임방법</a></li>
    <li><a href="/mypage/directask.asp">1:1문의</a></li>
    <li><a href="#">공지사항</a></li>
	<li onmouseover="javascript:menuShow();"><img src="../images/flag_korea.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"><li>
	<div style="text-align:right; position:absolute; min-width:70px; top:33px; right:160px; z-index:9999; display:none;" ID="menu1" onmouseover="javascript:menuShow();" onmouseout="javascript:menuHide();"  >
	  <div>
	  <a href="#"><img src="../images/flag_korea.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"></a>
	  <a href="#"><img src="../images/flag_usa.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"></a>
	  </div>
	  <div>
	  <a href="#"><img src="../images/flag_japan.png" style="height:23px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"></a>
	  <a href="#"><img src="../images/flag_china.png" style="height:23px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"></a>
	  </div>
	</div>
  <% else %>
    <% if Session("admin_flag") > "0" then %>
    <li><a href="/admin/">ADMIN</a></li>
    <% end if %>
    <% if Session("grade_cd") <> "U" then %>
    <li><a href="/adminb2b/member/">B2B관리</a></li>
    <% end if %>
    <li><a href="#">게임방법</a></li>
    <li><a href="/mypage/directask.asp">1:1문의</a></li>
    <li><a href="#">공지사항</a></li>
    <li><a href="/mypage/">MYPAGE</a></li>
    <li><a href="/sumember/logout.asp">로그아웃</a></li>
	<li onmouseover="javascript:menuShow();"><img src="../images/flag_korea.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"><li>
	<div style="text-align:right; position:absolute; min-width:70px; top:33px; right:160px; z-index:9999; display:none;" ID="menu1" onmouseover="javascript:menuShow();" onmouseout="javascript:menuHide();"  >
	  <div>
	  <a href="#"><img src="../images/flag_korea.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"></a>
	  <a href="#"><img src="../images/flag_usa.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"></a>
	  </div>
	  <div>
	  <a href="#"><img src="../images/flag_japan.png" style="height:23px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"></a>
	  <a href="#"><img src="../images/flag_china.png" style="height:23px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;"></a>
	  </div>
	</div>
	<% end if %>
</ul><br>
</div>
</p>

<div style="clear:both;height:10px;"></div>

