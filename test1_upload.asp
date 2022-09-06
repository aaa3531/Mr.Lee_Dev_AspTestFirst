<%@ Language=VBScript %>
<%
    Dim UploadForm
    Dim TempFilePath
    Dim FilePath
    
    'DEXT.FileUpload 개체 생성
    Set UploadForm = Server.CreateObject("DEXT.FileUpload")
    
    'AutoMakeFolder 를 TRUE로 설정하면 DefaultPath, SaveAs 등등에서 지정한 폴더가 존재하지 않을 경우 폴더를 자동으로 생성한다.
    UploadForm.AutoMakeFolder = True
    UploadForm.DefaultPath ="C:\inetpub\wwwroot\hhs\images\stocktest"

    'TempFilePath는 파일을 저장하기 전에 구해야 한다. 파일을 저장하고 나면 Temp File은 삭제된다.
    TempFilePath = UploadForm("file").TempFilePath

    'Save 메소드의 첫 번째 인자는 저장될 경로다. 기본값은 DefaultPath로 지정된 폴더이다.
    'Save 메소드의 두 번째 인자는 같은 파일이 존재할 경우 덮어쓸 것인지의 여부이다. 기본값은 True(파일을 덮어씀)이다.
    FilePath = UploadForm("file").Save("C:\inetpub\wwwroot\hhs\images\stocktest", False)
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <meta content="text/html; charset=ks_c_5601-1987" http-equiv="content-Type" />
    <link rel="Stylesheet" type="text/css" href="../../../Supports/Styles/Default.css" /> 
</head>
<body>
	<div class="leftTopIndentOne">
        <p>TempFilePath :          <%= TempFilePath                            %></p>
        <p>Original Path :         <%= UploadForm("file").FilePath             %></p>
        <p>Upload Path :           <%= FilePath                                %></p>
        <p>File Size :             <%= UploadForm("file").FileLen              %> bytes</p>
        <p>MimeType :              <%= UploadForm("file").MimeType             %></p>
        <p>LastSavedFileName :     <%= UploadForm("file").LastSavedFileName    %></p>
        <p>LastSavedFilePath :     <%= UploadForm("file").LastSavedFilePath    %></p>
        <p>FileNameWithoutExt :    <%= UploadForm("file").FileNameWithoutExt   %></p>
        <p>FileExtension :         <%= UploadForm("file").FileExtension        %></p>
    </div>		
</body>
</html>

<%
    Set UploadForm = Nothing
%>
