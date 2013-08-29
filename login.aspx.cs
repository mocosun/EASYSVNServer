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
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string sql = "select truename, Year, count(projectID) cnt from project a,user b where a.userid=b.userid group by a.userid";
            sql += " union ";
            sql += " select truename,Year,0 cnt from user a  where a.userid not in ( select distinct userid from project) ";
            setBind(sql, dg_uers_list);
        }

        protected void setBind(string sql, DataGrid dg)
        {
            DataBase.DBOperator db = new DataBase.DBOperator();
            db.NewSQL(sql);
            using (DataSet ds = db.ExecuteDataSet())
            {
                if (ds.Tables.Count == 0)
                    return;

                using (DataTable dt = ds.Tables[0])
                {
                    dg.DataSource = dt;
                    dg.DataBind();
                }
            }
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            bool isRegisted = false;
            DataBase.DBOperator db = new DataBase.DBOperator();
            string sql = "select * from user where UserName=@name and UserPass=@pass";
            db.NewSQL(sql);
            db.SetString("@name", tb_Name.Text);
            db.SetString("@pass", tb_Pwd.Text);
            using (SQLiteDataReader dr = db.ExecuteReader())
            {
                if (dr.Read())
                {
                    isRegisted = true;
                    Session["login"] = "1";
                    Session["loginUserID"] = dr["UserID"].ToString();
                }
            }

            if (true == isRegisted)
            {
                ClientScript.RegisterClientScriptBlock(Page.GetType(),
                "", "<script>window.location.href='default.aspx';</script>");
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(Page.GetType(),
                          "", "<script>window.alert('用户名或密码错误！')</script>");
            }
        }
    }
}
