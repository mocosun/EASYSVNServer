<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="SVNManage.register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
    <style type="text/css">

table {   
	border-collapse: collapse;   
	border-spacing: 0;
	margin-right: 0px;
}

td
{
	border:none;
}
td {
	padding: 0;
	margin: 0;
}
        .style1
        {
            width: 174px;
        }
        .style2
        {
            width: 86px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align:center">
        <h3>用户注册</h3>
        <table id="loginTable" border="0" cellpadding="1" cellspacing="1" style="width: 500px;
                    height: 352px">
            <tr>
                <td class="style2">
                    基本信息 
                </td>
                <td class="style1">
                    (都为必填） 
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 账户：
                </td>
                <td class="style1">
                    <asp:TextBox ID="tb_CreateName" runat="server" MaxLength="20" Width="120px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="tb_CreateName" Display="Dynamic" ErrorMessage="*必填项"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="tb_CreateName" ErrorMessage="用户名需以字母开头，数字、字母、下划线组成，长度3-15" 
                        ValidationExpression="^[a-zA-Z]{1}([a-zA-Z0-9]|[_]){2,14}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    <font face="宋体">&nbsp;&nbsp; 密码</font>：</td>
                <td class="style1">
                    <asp:TextBox ID="tb_CreatePwd" runat="server" MaxLength="20" 
                        TextMode="Password" Width="120px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="tb_CreatePwd" Display="Dynamic" ErrorMessage="*必填项"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="tb_CreatePwd" ErrorMessage="密码带有非法字符,或长度过长或不够3位" 
                        ValidationExpression="[^&lt;,&gt;,\,@,$,&amp;]{3,20}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    <font face="宋体">重复密码：</font>
                </td>
                <td class="style1">
                    <asp:TextBox ID="tb_CreatePwd2" runat="server" MaxLength="20" 
                        TextMode="Password" Width="120px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="tb_CreatePwd2" Display="Dynamic" ErrorMessage="*必填项"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator" runat="server" 
                        ControlToCompare="tb_CreatePwd" ControlToValidate="tb_CreatePwd2" 
                        ErrorMessage="两次密码不相同。"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 姓名： 
                </td>
                <td class="style1">
                    <asp:TextBox ID="tb_CreatTrueName" runat="server" MaxLength="50" Width="120px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="tb_CreatTrueName" Display="Dynamic" ErrorMessage="*必填项"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" 
                        ControlToValidate="tb_CreatTrueName" ErrorMessage="只允许中文字符" 
                        ValidationExpression="^([\u4e00-\u9fa5])*$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    年级： 
                </td>
                <td class="style1">
                    <asp:TextBox ID="tb_CreateYear" runat="server" MaxLength="50" Width="120px"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="tb_CreateYear" Display="Dynamic" ErrorMessage="*必填项"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                        ControlToValidate="tb_CreateYear" ErrorMessage="请勿输入无效符号" 
                        ValidationExpression="[^&lt;,&gt;,/,',\,@,$,&amp;]*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="style2">
                </td>
                <td class="style1">
                    &nbsp;</td>
                <td>
                </td>
            </tr>
            </table>
           <div>
                                      
         <asp:Button ID="btn_CreateUser" runat="server" OnClick="btn_CreateUser_Click"  Text="创建用户" />
           <input  ID="btn_register" class="regButton" type="button" value="返回"  onclick="javascript:window.location.href='default.aspx'"/>
        </div> 
    </div>
    </form>
</body>
</html>
