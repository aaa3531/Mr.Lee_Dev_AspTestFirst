<!-- #include virtual="/_include/connect.inc" -->


<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script> 

<script> 
    function RECOMMENDCheck(){     var mrecommend = $("input[name=recommend_id]").val();     
    if(mrecommend == undefined || mrecommend== null){ mrecommend = ""; }     
    $.ajax({        type: "POST",        url: "recommendcheck.asp",        data: "mrecommend="+mrecommend.replace(/\+/gi, '%2B'),        error:function(){           alert("오류입니다.\n");        },        success: function(msg){           $("body").append("<div id=\"Work\" style=\"display:none;\">" + msg + "</div>");      },        complete:function(){           $("#Work").remove();        }     });  }  

</script> 


<html>

<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/_css/common.css">
</head>

<body style="background-color:#47B7AD;">

            <table width="100%" style="margin:20px 0 0 0;">
                <tr>
                    <td style="padding:5px; text-align:center; border-top:solid 0px #47B7AD ; border-bottom:dotted 0px #47B7AD;">
                    <span style="color:#000000; font-weight:bold;">추천인 아이디 입력</span>
                    </td>
                </tr>
                <tr>
                    <td style="padding:10px;" align="center">
                      <input type="text" name=recommend_id style="width:110" class="input" onKeyUp="$('#recommendchkspan').html('<a onClick=RECOMMENDCheck()><input type=button value=확인 /></a>');"> 
                     <span  style="color:#ffffff; font-weight:bold;" id="recommendchkspan" >
                     <a onClick='RECOMMENDCheck();'><input type="button" value="확인" /></a>
                   </span>
                    </td>
                </tr>
            </table>
</body>
</html>
<!-- #include virtual="/_include/connect_close.inc" -->

