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
using System.Diagnostics;
using System.IO;
using System.Data.SQLite;

namespace SVNManage
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"] == null || Session["login"].ToString() != "1")
                Response.Redirect("login.aspx");
            if (!IsPostBack)
            {
                setBind();
                if (Session["show"] == null || Session["show"].ToString() == "1")
                {
                    content1.Style["display"] = "block";
                    content2.Style["display"] = "none";
                }
                else
                {
                    content2.Style["display"] = "block";
                    content1.Style["display"] = "none";
                }
            }
          
        }
        protected void setBind()
        {

            string sql = "Select * From project,user where project.UserID=user.UserID and isPrivate=1";
            sql += " order by project.ProjectID DESC ";
            setBind(sql, dg_List1);

            sql = "select * from project where project.UserID=@userid";
            sql = sql.Replace("@userid", Session["loginUserID"].ToString());
            setBind(sql, dg_List2);

            addDelCommandButtonConfirm();
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

        protected void addDelCommandButtonConfirm()
        {
            for (int i = 0; i < dg_List2.Items.Count; i++)
            {
                Button btn = (Button)dg_List2.Items[i].Cells[6].Controls[0];
                btn.Attributes["onclick"] = "javascript:return window.confirm('操作不可恢复，确认删除吗?')";
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            DataBase.DBOperator db = new DataBase.DBOperator();
            string sql = "insert into project (UserID,ProjectName,ProjectIntro,isPrivate,Path) values(@userid,@name,@info,@isPrivate,@path)";
            db.NewSQL(sql);
            db.SetString("@userid", Session["loginUserID"].ToString());  
            db.SetString("@name", tb_newName.Text);
            db.SetString("@info", tb_newInfo.Text);
            db.SetInt("@isPrivate", int.Parse(drop_statue.SelectedValue));
            string path = tool.getRandomStr();
            db.SetString("@path", path);


            if (1 == db.ExecuteNonQuery())
            {
                ClientScript.RegisterClientScriptBlock(Page.GetType(),
                   "add", "<script>window.alert('添加成功！');window.location='default.aspx';</script>");
                SVNOperation.create(path);
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(Page.GetType(),
                  "", "<script>window.alert('添加失败！');</script>");
            }
        }

        protected void dg_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            DataGridItem i = e.Item;
            DataBase.DBOperator db = new DataBase.DBOperator();
            if (e.CommandName == "del")
            {
                string sql = "delete from project where projectID=@id";
                db.NewSQL(sql);
                
                int Cid = int.Parse(i.Cells[0].Text);
                db.SetInt("@id", Cid);

                if (1 == db.ExecuteNonQuery())
                {
                    ClientScript.RegisterClientScriptBlock(Page.GetType(),
                        "success1", "<script>window.alert('删除成功！')</script>");
                    setBind();
                    string path = (i.FindControl("hidden_path") as HiddenField).Value;
                    SVNOperation.delete(path);
                }
                else
                    ClientScript.RegisterClientScriptBlock(Page.GetType(), "alert1",
                        "<script>window.alert('删除失败，请重试！')</script>");
            }
            if (e.CommandName == "refresh")
            {
                int old_isPrivate = -1;
                string sql = "select * from project where ProjectID=@projectid";
                db.NewSQL(sql);
                db.SetInt("@projectid", int.Parse(e.Item.Cells[0].Text));
                using (SQLiteDataReader dr = db.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        old_isPrivate = int.Parse(dr["isPrivate"].ToString());
                    }
                }

                sql = "update  project set ProjectName=@name, ProjectIntro=@intro, isprivate=@isPrivate, path=@path where projectID=@projectid";
                db.NewSQL(sql);
                db.SetInt("@projectid", int.Parse(e.Item.Cells[0].Text));

                string projectName = (i.FindControl("tb_name") as TextBox).Text;
                db.SetString("@name", projectName);

                string projectIntro = (i.FindControl("tb_intro") as TextBox).Text;
                db.SetString("@intro", projectIntro);

                int isPrivate = (i.FindControl("cb_statue") as CheckBox).Checked?1:2;
                db.SetInt("@isPrivate", isPrivate);

                string oldPath = (i.FindControl("hidden_path") as HiddenField).Value;
                string newPath = tool.getRandomStr();
                if (old_isPrivate != isPrivate)
                {
                    db.SetString("@path", newPath);
                }
                else
                    db.SetString("@path", oldPath);
               
                if (1 == db.ExecuteNonQuery())
                {
                    ClientScript.RegisterClientScriptBlock(Page.GetType(),
                       "", "<script>window.alert('更新成功！');window.location='default.aspx';</script>");
                    if (old_isPrivate != isPrivate)
                        SVNOperation.modify(oldPath, newPath);
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(Page.GetType(),
                      "", "<script>window.alert('更新失败！');</script>");
                }
            }
        }

        protected void btn_showPublic_Click(object sender, EventArgs e)
        {
            Session["show"] = "1";
            Response.Redirect("default.aspx");
        }

        protected void btn_showPrivate_Click(object sender, EventArgs e)
        {
            Session["show"] = "2";
            Response.Redirect("default.aspx");
        }

        protected void btn_quit_Click1(object sender, EventArgs e)
        {
            Session["login"] = "-1";
            Session["loginUserID"] = "-1";
            Response.Redirect("login.aspx");
        }
    }


}
