<%@ Page Language="C#" AutoEventWireup="true" CodeFile="upload_image.aspx.cs" Inherits="upload_image" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="padding: 0px; margin: 0px">
    <form id="frm_upload_image" runat="server">        
        <asp:FileUpload ID="fu" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField runat="server" ID="hf_status" />
        <asp:HiddenField runat="server" ID="hf_filetype" ClientIDMode="Static" />
    </form>
    <script type="text/javascript">
        var doc = document.getElementById("fu");
        doc.accept = "image/jpeg";

        document.empty_check = function () {
            return (doc.value == "") ? true : false;
        }

        document.simpan = function () {            
            var file = doc.files[0];            
            if (file != undefined) {
                document.getElementById("hf_filetype").value = file.type;
                document.getElementById("frm_upload_image").submit();
            }            
        }

        if (document.getElementById("hf_status").value == "simpan" && window.parent.document.doc_save) window.parent.document.doc_save();
    </script>
</body>
</html>
