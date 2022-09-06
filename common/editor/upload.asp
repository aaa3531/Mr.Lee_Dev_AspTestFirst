<%@ Language=VBScript CODEPAGE="65001"%>
<%
	Dim funcNum
	Dim CKEditor
	Dim langCode
	Dim fileUrl
	Dim message
	Dim strType

	'UTF-8 한글깨짐 개선
	Response.CharSet = "UTF-8"

	' 파일 중복을 제거 하기 위해 고정 사이트 만큼 특정 문자를 채워 주는 함수
	Public Function LeftFillString ( strValue, fillChar, makeLength )
		Dim strRet
		Dim strLen, diff, i
		
		strRet  = ""
		strLen  = Len(strValue)
		diff    = CInt(makeLength) - strLen
		
		if diff > 0 then
				for i=1 to diff
						strRet = strRet & CStr(fillChar)
				next
		end if
		
		LeftFillString = strRet & CStr(strValue)
	End Function

	'유니크한 파일명 만들기
	Public Function MakeUniqueFileName( strPrename )
		Dim strFilename
		Dim dtNow
		dtNow = now()
		Randomize()
		strFilename = Year(dtNow)
		strFilename = strFilename & LeftFillString( Month(dtNow),   "0", 2 )
		strFilename = strFilename & LeftFillString( Day(dtNow),     "0", 2 )
		strFilename = strFilename & LeftFillString( Hour(dtNow),    "0", 2 )
		strFilename = strFilename & LeftFillString( Minute(dtNow),  "0", 2 )
		strFilename = strFilename & LeftFillString( Second(dtNow),  "0", 2 )
		strFilename = strFilename & "_"  
		strFilename = strFilename & LeftFillString ( Int(Rnd * 10000), "0", 5 )
		MakeUniqueFileName = strFilename
	End Function

	' 변수들은 위에서 말한 개발자 가이드 문서에서 뽑았습니다.
	' Required: anonymous function number as explained above.
	funcNum = Request("CKEditorFuncNum")
	'Optional: instance name (might be used to load specific configuration file or anything else)
	CKEditor = Request("CKEditor")
	' Optional: might be used to provide localized messages
	langCode = Request("langCode")
	' Check the $_FILES array and save the file. Assign the correct path to some variable ($url).
	'fileUrl = ""
	' Usually you will assign here something only if file could not be uploaded.
	'message = "성공적으로 파일 업로드"
	strType = Request("type")

  'DEXT Upload를 사용하고 있습니다.
	Set Upload = Server.CreateObject("DEXT.FileUpload")
	Upload.CodePage = 65001
	Upload.AutoMakeFolder = True
	Upload.DefaultPath = "C:\inetpub\wwwroot\hhs\images\stocktest"

	upload_filename = Upload("upload").Filename
	if IsNull(Upload("upload")) or Upload("upload").FileLen <= 0 then
		upload_filename = ""
		img_filesize = 0
		message = "업로드 파일이 존재하지 않습니다."
	else
		img_filesize = Upload("upload").FileLen
		file_path = Upload.DefaultPath & "\" & strType

		If strType = "Files" Then		
			upload_filename = Upload("upload").FileName
		ElseIf strType = "Images" Then
			if Upload("upload").IsImageItem Then
				upload_filename = MakeUniqueFileName("upload") & "." & Upload("upload").FileExtension
				'message = "정상적으로 파일을 업로드했습니다."
			else
				message = "이미지파일이 아닙니다"
			end if			
		ElseIf strType = "Flash" Then
			if GetFileExt(upload_filename) = "swf" then
				upload_filename = Upload("upload").FileName
				'message = "정상적으로 파일을 업로드했습니다."
			else
					message = "플래시파일이 아닙니다"
			end if				
		End If
			
		Upload.SaveAs file_path & "\" & upload_filename, False
	end if
    '로컬테스트용
		'fileUrl = "http://10.1.103.136:8088/" & strType & "/" & Upload("upload").LastSavedFileName
		'서버용
    fileUrl = "http://game.hhs1052.com/images/stocktest/" & Upload("upload").LastSavedFileName	
%>
<script type="text/javascript">
    // 가장 중요한 부분인것 같군요
    // ckeditor의 순번과 유효한 파일 경로만 넘기면 자동으로 이미지나 플래쉬 속성 변경 탭으로 이동합니다.
    window.parent.CKEDITOR.tools.callFunction(<%=funcNum %>, '<%=fileUrl %>', '<%=message%>');
</script>
<%
  Set Upload = Nothing  
%>
