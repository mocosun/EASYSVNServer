<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SVNManage._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
  
</head>
<body>
   <form id="form1" runat="server">
<div style="background-color:Gray; width:100%; height:50px; text-align:center;">
    <div style="color:White; line-height:50px;">欢迎访问HRI实验室项目托管环境！</div>
</div>

<div style="width:100%; height:50px; text-align:center; line-height:50px;">
    <asp:LinkButton ID="btn_showPublic" runat="server" 
        onclick="btn_showPublic_Click">公开项目</asp:LinkButton>  
    <asp:LinkButton ID="btn_showPrivate" runat="server" 
        onclick="btn_showPrivate_Click">我的项目</asp:LinkButton>
     <asp:LinkButton ID="btn_quit" runat="server" 
         ForeColor="#3399FF" onclick="btn_quit_Click1">注销</asp:LinkButton>
</div>
 
      <div style="width: 800px; padding: 0px 40px;  margin:auto;" runat="server" id="content1">
          <h3>公开项目</h3>
          <asp:DataGrid ID="dg_List1" runat="server" AutoGenerateColumns="False" 
              BorderColor="#CCCCFF" BorderWidth="0px" CellPadding="0" Font-Size="14px" 
              ItemStyle-HorizontalAlign="Center"
              Width="697px" BorderStyle="None">
              <HeaderStyle BackColor="#FFFFCC" ForeColor="#0000CC" HorizontalAlign="Center" />
              <FooterStyle BackColor="#FFFF99" />
              <AlternatingItemStyle BackColor="#CCCCFF" />

<ItemStyle HorizontalAlign="Center"></ItemStyle>
              <Columns>
                  <asp:BoundColumn DataField="ProjectID" HeaderText="ID" Visible="false">
                      <HeaderStyle Width="50px" />
                  </asp:BoundColumn>
              	
              	<asp:TemplateColumn HeaderText="项目名称">
			    <HeaderStyle  Width="100px"/>
			        <ItemTemplate>
                        <%# Eval("ProjectName").ToString()%>
			        </ItemTemplate>
			    </asp:TemplateColumn>
    	
    			
			    <asp:BoundColumn DataField="TrueName" HeaderText="所有者"><HeaderStyle  Width="80px"/></asp:BoundColumn>
    			
			    <asp:TemplateColumn HeaderText="项目简介">
			    <HeaderStyle  Width="300px"/>
			        <ItemTemplate>
			        <%# Eval("ProjectIntro").ToString()%>
			        </ItemTemplate>
			    </asp:TemplateColumn>
    				
			  <asp:TemplateColumn HeaderText="地址">
			    <HeaderStyle  Width="80px"/>
			        <ItemTemplate>
			        <input type="hidden" name="path" value="<%# Eval("Path").ToString()%>" />	         
			          <a href="" onclick="copy(this)"> 复制</a>
			        </ItemTemplate>
			    </asp:TemplateColumn>
                  
              </Columns>
              <PagerStyle Mode="NumericPages" Width="200" />
          </asp:DataGrid>
&nbsp;<div></div>  
      </div>
      
       <div style="width: 800px; padding: 0px 40px;  margin:auto;" runat="server" id="content2">
       <h3>我的项目</h3>
        <asp:DataGrid ID="dg_List2" runat="server" AutoGenerateColumns="False" 
              BorderColor="#CCCCFF" BorderWidth="1" CellPadding="0" Font-Size="14px" 
              ItemStyle-HorizontalAlign="Center" OnItemCommand="dg_ItemCommand"
              Width="690px">
              <HeaderStyle BackColor="#FFFFCC" ForeColor="#0000CC" HorizontalAlign="Center" />
              <FooterStyle BackColor="#FFFF99" />
              <AlternatingItemStyle BackColor="#CCCCFF" />

<ItemStyle HorizontalAlign="Center"></ItemStyle>
              <Columns>
                  <asp:BoundColumn DataField="ProjectID" HeaderText="ID" Visible="false">
                      <HeaderStyle Width="50px" />
                  </asp:BoundColumn>
              	
              	<asp:TemplateColumn HeaderText="项目名称">
			    <HeaderStyle  Width="100px"/>
			        <ItemTemplate>
                        <asp:TextBox ID="tb_name" runat="server" Text='<%# Eval("ProjectName").ToString() %>'></asp:TextBox>
			        </ItemTemplate>
			        
			    </asp:TemplateColumn>
    	
    			
			    <asp:TemplateColumn HeaderText="项目简介">
			    <HeaderStyle  Width="300px"/>
			        <ItemTemplate>
			            <asp:TextBox ID="tb_intro" runat="server" Text='<%# Eval("ProjectIntro").ToString()%>' TextMode="MultiLine" Width="280px"  Height="100px" ></asp:TextBox>
			        </ItemTemplate>
			    </asp:TemplateColumn>
    				
			  <asp:TemplateColumn HeaderText="地址">
			    <HeaderStyle  Width="80px"/>
			        <ItemTemplate>
                       <%--  <input type="hidden" id="tb_path" name="path" value="<%# Eval("Path").ToString()%>" />	  --%>
                        <asp:HiddenField ID="hidden_path" runat="server"  value='<%# Eval("Path").ToString()%>'/>
                       
			          <a href="" onclick="copy(this)"> 复制</a>
			        </ItemTemplate>
			        <EditItemTemplate>
			          <asp:HiddenField ID="hidden_path" runat="server"  value='<%# Eval("Path").ToString()%>'/>
			        </EditItemTemplate>
			    </asp:TemplateColumn>
                  
                  
                <asp:TemplateColumn HeaderText="是否公开">
			    <HeaderStyle  Width="80px"/>
			        <ItemTemplate>
                        <asp:CheckBox ID="cb_statue" runat="server" Checked='<%# Eval("isPrivate").ToString()=="1"%>' />
			        </ItemTemplate>
			    </asp:TemplateColumn>
			    
             
                  <asp:ButtonColumn ButtonType="PushButton" CommandName="refresh" Text="更新">
                  </asp:ButtonColumn>
                 
                  <asp:ButtonColumn ButtonType="PushButton" CommandName="del" Text="删除" >
                  </asp:ButtonColumn>
                  
             
              </Columns>
              <PagerStyle Mode="NumericPages" Width="200" />
          </asp:DataGrid>
          <div>
         <div style="border:1px solid; margin:10px 0px 0px 20px; padding:5px; width:500px">
          <h4>添加项目</h4>
          <table style="width: 469px" >
          	<tr>
          		<td>项目名称：</td>
          		<td><asp:TextBox ID="tb_newName" runat="server"></asp:TextBox></td>
          	</tr>
          	<tr>
          		<td>项目简介：</td>
          		<td><asp:TextBox ID="tb_newInfo" runat="server" Text='<%# Eval("ProjectIntro").ToString()%>' TextMode="MultiLine" Width="280px"  Height="100px"></asp:TextBox></td>
          	</tr>
          	<tr>
          		<td>状态    ：</td>
          		<td>
          		  <asp:DropDownList ID="drop_statue" runat="server">
                       <asp:ListItem Value="1" Selected="True">公开</asp:ListItem>
                       <asp:ListItem Value="2">私有</asp:ListItem>
                  </asp:DropDownList>
          		</td>
          	</tr>
      
          </table>
             <asp:Button ID="btn_new" runat="server" Text="添加" onclick="btn_new_Click" />
           </div>
           
          </div>
      </div>
 
  
    </form>
    <script type="text/javascript">
        function copy(obj)
        {
           var inputObj = obj.parentNode.getElementsByTagName('input');
            _copy(inputObj[0].value);
        }
        function _copy(text){  
            var clipBoardContent="";   
            clipBoardContent += "https://";
            var host = window.location.host.split(':'); //去除端口号
            clipBoardContent += host[0];                //得到主机地址
            clipBoardContent += ":8443/svn/";
            clipBoardContent+=text; 
               
            if (window.clipboardData){  
                window.clipboardData.setData("Text", clipBoardContent); 
            }else if (window.netscape){  
                netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');  
                var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);  
                if (!clip) return;  
                var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);  
                if (!trans) return;  
                trans.addDataFlavor('text/unicode');  
                var str = new Object();  
                var len = new Object();  
                var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);  
                var copytext=clipBoardContent;  
                str.data=copytext;  
                trans.setTransferData("text/unicode",str,copytext.length*2);  
                var clipid=Components.interfaces.nsIClipboard;  
                if (!clip) return false;  
                clip.setData(trans,null,clipid.kGlobalClipboard);
            }  
             alert(clipBoardContent+"\n复制完成，可在SVN客户端软件中使用该地址！");
        }  
    </script>
 

        
</body>
</html>
