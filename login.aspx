<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SVNManage.login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align:center; margin:auto;">
        <h3>HRI实验室代码托管环境-登陆</h3>
       <div>
               
                账户：
                    <asp:TextBox ID="tb_Name" runat="server" MaxLength="20" Width="120px" 
                        style="margin-left: 0px"></asp:TextBox> 
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="tb_Name" Display="Dynamic" ErrorMessage="*必填项"></asp:RequiredFieldValidator>
          </div>
           <div>
                    密码：
                    <asp:TextBox ID="tb_Pwd" runat="server" MaxLength="20" 
                        TextMode="Password" Width="120px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="tb_Pwd" Display="Dynamic" ErrorMessage="*必填项"></asp:RequiredFieldValidator>
          </div>
          <div  style="margin-bottom:10px;"></div>
          <div>
                   <asp:Button ID="btn_login" runat="server"  Text="登陆" 
            onclick="btn_login_Click" />
           <input  ID="btn_register"  type="button" value="注册"  onclick="javascript:window.location.href='register.aspx'"/>
           
           </div>
           
           <div  style="margin-bottom:100px;"></div>
            <h5 style="color: #808080">以下人员已经加入了该环境：</h5>
            <div style="margin:auto; width:230px;">
                 <asp:DataGrid ID="dg_uers_list" runat="server" AutoGenerateColumns="False" 
                  BorderColor="#CCCCFF" BorderWidth="0px" CellPadding="0" Font-Size="12px" 
                   BorderStyle="None" Width="226px">
                  <HeaderStyle BackColor="#FFFFCC" ForeColor="#0000CC" HorizontalAlign="Center" />
                  <FooterStyle BackColor="#FFFF99" />
                  <AlternatingItemStyle BackColor="#CCCCFF" />
                  <ItemStyle HorizontalAlign="Center"></ItemStyle>
                  <Columns>
                  <asp:BoundColumn DataField="Year" HeaderText="年级"><HeaderStyle  Width="100px"/></asp:BoundColumn>
                    <asp:BoundColumn DataField="TrueName" HeaderText="姓名"><HeaderStyle  Width="150px"/></asp:BoundColumn>
                    <asp:BoundColumn DataField="cnt" HeaderText="项目数"><HeaderStyle  Width="80px"/></asp:BoundColumn>
                  </Columns>
                  <PagerStyle Mode="NumericPages" Width="200" />
              </asp:DataGrid>
            </div>
       </div>
    </form>
</body>
</html>
