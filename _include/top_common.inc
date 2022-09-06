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
  </script>

  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <html lang="ko">
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="Content-Script-Type" content="text/javascript">
          <meta http-equiv="Content-Style-Type" content="text/css">
            <title>항하사증권에 오신것을 환영합니다.</title>
            <link rel="stylesheet" type="text/css" href="/_css/sub.css">
</head>

    <body style="background-color:#ffffff;">
      <frameset rows="*,0" border="0" >
        <frame name="bgm" src="bgm.html" scrolling="no">
      </frameset>

      <div id="wrap">

        <!-- header -->
        <div id="sub_top">
          <div id="header">
            <h1>
              <a href="/" class="blind">1052항하사증권</a>
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
                      <a href="/intro/gameintro.asp">게임소개</a>
                    </li>
                    <% else %>
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
                    <li class="korea">
                      <span onmouseout="ToggleColor(this,1)" onmouseover="javascript: ToggleColor(this,0);" class="flag_normal">
                        <img src="../images/flag_usa.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;">
                </span>
                    </li>
                    <li class="usa">
                      <span onmouseout="ToggleColor(this,1)" onmouseover="javascript: ToggleColor(this,0);" class="flag_normal">
                        <img src="../images/flag_china.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;">
                </span>
                    </li>
                    <li class="china">
                      <span onmouseout="ToggleColor(this,1)" onmouseover="javascript: ToggleColor(this,0);" class="flag_normal">
                        <img src="../images/flag_japan.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;">
                </span>
                    </li>
                    <li class="japan">
                      <span class="flag_normal">
                        <img src="../images/flag_korea.png" style="height:20px; box-shadow: rgba(0, 0, 0, 0.498039) 0px 0px 1px 0px, rgba(0, 0, 0, 0.14902) 0px 1px 5px 0px;">
                </span>
                    </li>
                  </ul>
                </li>
              </ul>
            </div>

            <div class="lnb">
              <h2>
                <a href="/">항하사증권 메뉴</a>
              </h2>
              <ul class="sub_menu">
                <% if menu_main = "intro" then %>
                <li class="mnu">
                  <a href="/intro/gameintro.asp" class="mnu_title">게임소개</a>
                </li>
                <% else %>
                <li class="mnu">
                  <a href="/intro/gameintro.asp" class="mnu_title">게임소개</a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v1">
                <% if menu_main = "updown" then %>
                <li class="mnu mnu2">
                  <a href="/suupdown/kospi.asp" class="mnu_title">UP & DOWN</a>
                </li>
                <% else %>
                <li class="mnu mnu2">
                  <a href="/suupdown/kospi.asp" class="mnu_title">UP & DOWN</a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v2">
                <% if menu_main = "stock" then %>
                <li class="mnu mnu3">
                  <a href="#" class="mnu_title">종목매치</a>
                </li>
                <% else %>
                <li class="mnu mnu3">
                  <a href="#" class="mnu_title">종목매치</a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v3">
                <% if menu_main = "race" then %>
                <li class="mnu mnu4">
                  <a href="#" class="mnu_title">종목레이스</a>
                </li>
                <% else %>
                <li class="mnu mnu4">
                  <a href="#" class="mnu_title">종목레이스</a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v4">
                <% if menu_main = "result" then %>
                <li class="mnu mnu5">
                  <a href="/suresult/" class="mnu_title">게임결과</a>
                </li>
                <% else %>
                <li class="mnu mnu5">
                  <a href="/suresult/" class="mnu_title">게임결과</a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v4">
                <% if menu_main = "info" then %>
                <li class="mnu mnu5">
                  <a href="/suinfo/kospi.asp" class="mnu_title">증권정보</a>
                </li>
                <% else %>
                <li class="mnu mnu5">
                  <a href="/suinfo/kospi.asp" class="mnu_title">증권정보</a>
                </li>
                <% end if %>
              </ul>
              <ul class="sub_menu sub_menu_v4">
                <% if menu_main = "customer" then %>
                <li class="mnu mnu5">
                  <a href="#" class="mnu_title">고객센터</a>
                </li>
                <% else %>
                <li class="mnu mnu5">
                  <a href="#" class="mnu_title">고객센터</a>
                </li>
                <% end if %>
              </ul>
            </div>

          </div>
