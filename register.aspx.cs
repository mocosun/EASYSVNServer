using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SQLite;

namespace SVNManage
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_CreateUser_Click(object sender, EventArgs e)
        {
            bool isRegisted = false;
            DataBase.DBOperator db = new DataBase.DBOperator();
            string sql = "select * from user where UserName=@name";
            db.NewSQL(sql);
            db.SetString("@name", tb_CreateName.Text);
            using (SQLiteDataReader dr = db.ExecuteReader())
            {
                if (dr.Read())
                {
                    isRegisted = true;
                }
            }

            if (true == isRegisted)
            {
                ClientScript.RegisterClientScriptBlock(Page.GetType(),
                      "success1", "<script>window.alert('用户名已存在！')</script>");
            }
            else
            {
                sql = "insert into user (UserName,UserPass,TrueName,Year) values(@name,@pass,@trueName,@year)";
                db.NewSQL(sql);
                db.SetString("@name", tb_CreateName.Text);
                db.SetString("@pass", tb_CreatePwd.Text);
                db.SetString("@trueName", tb_CreatTrueName.Text);
                db.SetString("@year", tb_CreateYear.Text);

                db.ExecuteNonQuery();
                ClientScript.RegisterClientScriptBlock(Page.GetType(),
                       "success1", "<script>window.alert('注册成功！');window.location.href='default.aspx';</script>");
            }
        }
    }
}
