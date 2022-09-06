<% 
     if request("member_no") <> "" then
     Session("member_no")= request("member_no")
     end if
%>
  
  <script language="javascript">
function menuShow() {
 //menuHide();
 //document.all(menuidx).style.display="inline";
 menu1.style.display="inline";
}
function menuHide() {
 menu1.style.display = "none";
}
</script>
  <script language="javascript">
    function ipcheck() {
    alert("진입 가능한 IP가 아닙니다.");
    //var strurl = "/_include/ipcheck_popup.asp";
    //window.open(strurl, 'popup', 'menubar=no, toolbar=no,location=no, directories=no, status=no, resizable=no, scrollbars=no, copyhistory=no, width=300, height=110,left=500,top=300');
    }

    function ToggleColor(obj, type) {
    if (type == 1) {
    if (obj.className == 'flag_ov') {
    obj.className = 'flag_normal';
    }
    } else
    if (obj.className == 'flag_normal') {
    obj.className = 'flag_ov';
    ipcheck();
    }
    }
  </script>
  
<script type="text/javascript">
  function CloseWindow() {
       window.close();
       alert('closing');
  }
  
  window.onload = function () {
          slideAni();
      }
  
      
  function displaySlide() {
  var slideno = document.getElementById("slide_no").value;
  if (slideno == 1)
  {
      document.getElementById('mainsection').className = "homeSlide01";
      document.getElementById('maintitle').innerHTML = "1052 항하사증권 소개";
      document.getElementById('mainimage').src = "img/section_title01.png";
      document.getElementById('mainimage').alt = "저희 항하사 증권게임은 국내,세계최초 각 나라의 주요지수와 테마 및 종목을 가지고 경기를 하는 증권게임입니다.";
      document.getElementById("slide_no").value = 2;
  }
  else if (slideno == 2)
  {
      document.getElementById('mainsection').className = "homeSlide02";
      document.getElementById('maintitle').innerHTML = "UP DOWN소개";
      document.getElementById('mainimage').src = "img/section_title02.png";
      document.getElementById('mainimage').alt = "실시간 KOSPI종합주가지수 1분봉 결과값으로 상승(UP), 보합(DRAW), 하락(DOWN)의 배팅을 즐길수있습니다. 빠른 경기진행으로 지루함에서 벗어나 누구나 쉬운 예측과 높은 승률을 올릴 수 있는 게임입니다. ";
      document.getElementById("slide_no").value = 3;
  }
  else if (slideno == 3)
  {
      document.getElementById('mainsection').className = "homeSlide03";
      document.getElementById('maintitle').innerHTML = "종목매치 소개";
      document.getElementById('mainimage').src = "img/section_title03.png";
      document.getElementById('mainimage').alt = "KOSPI/KOSDAQ종목 중 2개 종목을 선정하여 1시간 간격으로 상승률이 높은 종목을 예상하여 배팅하는 게임으로 분석이 쉬운 게임입니다. ";
      document.getElementById("slide_no").value = 4;
  }
  else if (slideno == 4)
  {
      document.getElementById('mainsection').className = "homeSlide04";
      document.getElementById('maintitle').innerHTML = "종목레이스 소개";
      document.getElementById('mainimage').src = "img/section_title04.png";
      document.getElementById('mainimage').alt = "KOSPI/KOSDAQ 종목 중 10개 종목을 선정하여 1시간 간격으로 상승률이 높은 단식 1위와 복식 1,2위의 종목을 예상하여 배팅하는 게임으로 소액으로 고배당이 가능한 게임입니다.";
      document.getElementById("slide_no").value = 1;
  }
  }
  
  
  function displayBackSlide() {
  var slideno = document.getElementById("slide_no").value;
  if (slideno == 1)
  {
      document.getElementById('mainsection').className = "homeSlide01";
      document.getElementById('maintitle').innerHTML = "1052 항하사증권 소개";
      document.getElementById('mainimage').src = "img/section_title01.png";
      document.getElementById('mainimage').alt = "저희 항하사 증권게임은 국내,세계최초 각 나라의 주요지수와 테마 및 종목을 가지고 경기를 하는 증권게임입니다.";
      document.getElementById("slide_no").value = 4;
  }
  else if (slideno == 2)
  {
      document.getElementById('mainsection').className = "homeSlide02";
      document.getElementById('maintitle').innerHTML = "UP DOWN소개";
      document.getElementById('mainimage').src = "img/section_title02.png";
      document.getElementById('mainimage').alt = "실시간 KOSPI종합주가지수 1분봉 결과값으로 상승(UP), 보합(DRAW), 하락(DOWN)의 배팅을 즐길수있습니다. 빠른 경기진행으로 지루함에서 벗어나 누구나 쉬운 예측과 높은 승률을 올릴 수 있는 게임입니다. ";
      document.getElementById("slide_no").value = 1;
  }
  else if (slideno == 3)
  {
      document.getElementById('mainsection').className = "homeSlide03";
      document.getElementById('maintitle').innerHTML = "종목매치 소개";
      document.getElementById('mainimage').src = "img/section_title03.png";
      document.getElementById('mainimage').alt = "KOSPI/KOSDAQ종목 중 2개 종목을 선정하여 1시간 간격으로 상승률이 높은 종목을 예상하여 배팅하는 게임으로 분석이 쉬운 게임입니다. ";
      document.getElementById("slide_no").value = 2;
  }
  else if (slideno == 4)
  {
      document.getElementById('mainsection').className = "homeSlide04";
      document.getElementById('maintitle').innerHTML = "종목레이스 소개";
      document.getElementById('mainimage').src = "img/section_title04.png";
      document.getElementById('mainimage').alt = "KOSPI/KOSDAQ 종목 중 10개 종목을 선정하여 1시간 간격으로 상승률이 높은 단식 1위와 복식 1,2위의 종목을 예상하여 배팅하는 게임으로 소액으로 고배당이 가능한 게임입니다.";
      document.getElementById("slide_no").value = 3;
  }
  }
  
  function slideAni() {
     displaySlide();
     setTimeout("slideAni()", 3000);
  }
  
</script>
  

  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <html lang="ko">
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="Content-Script-Type" content="text/javascript">
          <meta http-equiv="Content-Style-Type" content="text/css">
            <title>항하사증권에 오신것을 환영합니다.</title>
            <link rel="stylesheet" type="text/css" href="/_css/main.css">
    </head>
  
<body style="background-color:#f2f2f2;">
<frameset rows="*,0" border="0" >
 <frame name="bgm" src="bgm.html" scrolling=no>

</frameset>
  
<!-- 홈 메인화면 백그라운드 슬라이드 이미지 -->
<div id="homeSlides" class="homeSlides" style="width:100%;">
	<section id="mainsection" class="homeSlide01"><span id="maintitle" class="blind">1052 항하사증권 소개</span></section>
</div>
<!-- //홈 메인화면 백그라운드 슬라이드 이미지 -->
<a href="#" id="prevslide" class="prevslide" onclick="displayBackSlide()"></a>
<a href="#" id="nextslide" class="nextslide" onclick="displaySlide()"></a>

  <input type="hidden" id="slide_no" value="1" />
  
<div id="wrap">

  <!-- header -->
  <div id="sub_top">
    <div id="header">
      <h1>
        <a href="#" class="blind">1052항하사증권</a>
      </h1>
      <div class="gnb">
        <ul>
          <li style="margin-right:10px;">
            <ul class="lst_gnb">
              <% if Session("member_no") = "" then %>
              <li class="login">
                  <a href="#">로그인</a>
                <!--<a href="#">로그아웃</a>-->
              </li>
              <li class="intro">
                <a href="/intro/gameintro.asp?member_no=<%=Session("member_no")%>">게임소개</a>
              </li>
              <% else %>
              <li class="ID">
                 <span style="color:#FFFFFF;"><%=Session("member_id")%></span>
              </li>
              <li class="login">
                <a href="/sumember/logout.asp">로그아웃</a>
              </li>
              <li class="qna">
                <a href="/mypage/directask.asp">1:1문의</a>
              </li>
              <li class="charge">
                <a href="/mypage/charge.asp">충전하기</a>
              </li>
              <li class="exchange">
                <a href="/mypage/withdraw.asp">환전하기</a>
              </li>
              <li class="mypage">
                <a href="/mypage/bet_history_updown.asp">MYPAGE</a>
              </li>
              <% end if %>
            </ul>
          </li>
          <li>
            <ul class="lst_nation">
              <li class="usa">
                <span onmouseout="ToggleColor(this,1)" onclick="javascript: ToggleColor(this,0);" class="flag_normal">
                  <a href="#"><img src="/img/ico_usa.png" width="24" height="16" /></a>
                </span>
              </li>
              <li class="china">
                <span onmouseout="ToggleColor(this,1)" onclick="javascript: ToggleColor(this,0);" class="flag_normal">
                  <a href="#"><img src="/img/ico_china.png" width="24" height="16" /></a>
                </span>
              </li>
              <li class="japan">
                <span onmouseout="ToggleColor(this,1)" onclick="javascript: ToggleColor(this,0);" class="flag_normal">
                  <a href="#"><img src="/img/ico_japan.png" width="24" height="16" /></a>
                </span>
              </li>
              <li class="korea">
                <span class="flag_normal">
                  <a href="#"><img src="/img/ico_korea.png" width="24" height="16" /></a>
                </span>
              </li>
            </ul>
          </li>
        </ul>
      </div>

      <div class="lnb">
        <h2>
          <a href="/">항하사증권 메뉴</a>
        </h2><div>
                <ul class="sub_menu">
                  <% if menu_main = "intro" then %>
                  <li class="mnu" style="background:none">
                    <a href="/intro/gameintro.asp" class="mnu_title"><span>게임소개</span></a>
                  </li>
                  <% else %>
                  <li class="mnu" style="background:none">
                    <a href="/intro/gameintro.asp" class="mnu_title"><span>게임소개</span></a>
                  </li>
                  <% end if %>
                </ul>
                <ul class="sub_menu sub_menu_v1">
                  <% if menu_main = "intro" then %>
                  <li class="mnu mnu2" >
                    <a href="/suladder/default.asp" class="mnu_title"><span>주식홀짝</span></a>
                  </li>
                  <% else %>
                  <li class="mnu mnu2" >
                    <a href="/suladder/default.asp" class="mnu_title"><span>주식홀짝</span></a>
                  </li>
                  <% end if %>
                </ul>
              <ul class="sub_menu sub_menu_v2">
                <% if menu_main = "updown" then %>
                <li class="mnu mnu3">
                  <a href="/suupdown/kospi.asp" class="mnu_title"><span>UP&amp;DOWN</span></a>
                </li>
                <% else %>
                <li class="mnu mnu3">
                  <a href="/suupdown/kospi.asp" class="mnu_title"><span>UP&amp;DOWN</span></a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v3">
                <% if menu_main = "stock" then %>
                <li class="mnu mnu4">
                  <a href="/suitem/" class="mnu_title"><span>종목별매치</span></a>
                </li>
                <% else %>
                <li class="mnu mnu4">
                  <a href="/suitem/" class="mnu_title"><span>종목별매치</span></a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v4">
                <% if menu_main = "race" then %>
                <li class="mnu mnu5">
                  <a href="/sutheme/" class="mnu_title"><span>종목별레이스</span></a>
                </li>
                <% else %>
                <li class="mnu mnu5">
                  <a href="/sutheme/" class="mnu_title"><span>종목별레이스</span></a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v4">
                <% if menu_main = "result" then %>
                <li class="mnu mnu5">
                  <a href="/suresult/" class="mnu_title"><span>게임결과</span></a>
                </li>
                <% else %>
                <li class="mnu mnu5">
                  <a href="/suresult/" class="mnu_title"><span>게임결과</span></a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v4">
                <% if menu_main = "info" then %>
                <li class="mnu mnu5">
                  <a href="/suinfo/kospi.asp" class="mnu_title"><span>증권정보</span></a>
                </li>
                <% else %>
                <li class="mnu mnu5">
                  <a href="/suinfo/kospi.asp" class="mnu_title"><span>증권정보</span></a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v4">
                <% if menu_main = "customer" then %>
                <li class="mnu mnu5">
                  <a href="/sucustomer/notice.asp" class="mnu_title"><span>고객센터</span></a>
                </li>
                <% else %>
                <li class="mnu mnu5">
                  <a href="/sucustomer/notice.asp" class="mnu_title"><span>고객센터</span></a>
                </li>
                <% end if %>
              </ul>
            </div>
      
    </div>

<div style="clear:both;height:10px;"></div>
