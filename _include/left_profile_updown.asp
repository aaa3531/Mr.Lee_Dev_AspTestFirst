

 <SCRIPT language="javascript">
     function FormatNumber(num) {
         var str = num;
         var Re = /[^0-9]/g;
         var ReN = /(-?[0-9]+)([0-9]{3})/;
         str = str.replace(Re, '');
         while (ReN.test(str)) {
             str = str.replace(ReN, "$1,$2");
         }
         return str;
     }
</script>

 <SCRIPT language="javascript">
    var xhr;
    function readprofilePoint() {
        xhr = new XMLHttpRequest();
        xhr.onreadystatechange = setprofilePoint;
        xhr.open("POST", "/_include/left_profile_read.asp");
        xhr.send(null);
    }
    function setprofilePoint() {
        //alert("111");
        if (xhr.readyState == 4) {
            //alert("33");
            var data = xhr.responseText;
            var pdata = data.split(',');
            document.getElementById("pointtotal").innerHTML = FormatNumber(pdata[0]);
            document.getElementById("memocount").innerHTML = "(" + pdata[1] + ")";
            //var pre1 = document.getElementById("pointtotal");
            //pre1.innerHTML = "보유금액 ( " + FormatNumber("" + "<%=point_total %>") + " )";
        }
        //setTimeout("readprofilePoint()", 5000);
       
    }
     
</script>

<div class="top" oncontextmenu="return false">
						<div class="myinfo">
						<div class="myinfo_top">
						<span><a href="/mypage/update.asp"><%=session("member_alias") %></a> 님</span>
						<a href="/sumember/logout.asp" class="btn_logout"><img src="/img/btn_logout.gif" width="47" height="18" /></a>
						</div>
						<div class="myinfo_center">
						<dl >
							<dt>쪽지 : </dt>
							<dd class="txt1"><a href="/mypage/memo.asp">
                            <img src="/img/new_message.gif" width="9" height="9" style="padding-right:3px"/>
                            <span id="memocount" style="font-weight:bold; color:#e4ff00"></span>통</a></dd>
							<dd><a href="/mypage/memo.asp" class="btn_notice"><img src="/img/btn_notice.gif" width="28" height="18" /></a></dd>
						</dl>
						<dl>
							<dt>보유금액 : </dt>
							<dd class="txt2"><span id="pointtotal" style="margin:0 10px 0 0 ; color:#FFD595;"></span>원</dd>
							<dd><a href="/mypage/charge.asp" class="btn_charge"><img src="/img/btn_charge.gif" width="28" height="18" /></a></dd>
						</dl>
						</div>
    
    <script>
    readprofilePoint();
    setInterval("readprofilePoint()",5000);
    </script>

    
