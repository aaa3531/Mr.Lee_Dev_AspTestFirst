<!-- #include virtual="/_include/connect.inc" -->
<!-- #include virtual="/_include/login_check.inc" -->
<!-- #include virtual="/_include/connect_close.inc" -->
<% 
     if request("member_no") <> "" then
     Session("member_no")= request("member_no")
     end if
%>
  
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

    <body style="background-color:#ffffff;" oncontextmenu="return false">
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
                    <li class="usa">
                      <span onmouseout="ToggleColor(this,1)" onclick="javascript: ToggleColor(this,0);" class="flag_normal">
                        <a href="#">
                          <img src="/img/ico_usa.png" width="24" height="16" />
                        </a>
                      </span>
                    </li>
                    <li class="china">
                      <span onmouseout="ToggleColor(this,1)" onclick="javascript: ToggleColor(this,0);" class="flag_normal">
                        <a href="#">
                          <img src="/img/ico_china.png" width="24" height="16" />
                        </a>
                      </span>
                    </li>
                    <li class="japan">
                      <span onmouseout="ToggleColor(this,1)" onclick="javascript: ToggleColor(this,0);" class="flag_normal">
                        <a href="#">
                          <img src="/img/ico_japan.png" width="24" height="16" />
                        </a>
                      </span>
                    </li>
                    <li class="korea">
                      <span class="flag_normal">
                        <a href="#">
                          <img src="/img/ico_korea.png" width="24" height="16" />
                        </a>
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
              <div>
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
            <div class="spot">
              <div class="snb_menu">
                <ul>
                  <li class="snb_menu01">게임결과</li>
                  <li>
                    <a href="/suresult/">UP&amp;DOWN 결과</a>
                  </li>
                  <li>
                    <a href="/suresult/item_result.asp">종목매치 결과</a>
                  </li>
                  <li>
                    <a href="/suresult/theme_result.asp">종목레이스 결과</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <!-- //header -->

