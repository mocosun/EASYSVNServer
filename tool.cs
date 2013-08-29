using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Timers;

namespace SVNManage
{
    public class tool
    {
        public tool()
        {

        }

        public static string getRandomStr()
        {
            string ret = "";
            ret += DateTime.Now.Year.ToString();
            ret += DateTime.Now.Month.ToString();
            ret += DateTime.Now.Day.ToString();
            ret += DateTime.Now.Hour.ToString();
            ret += DateTime.Now.Minute.ToString();
            ret += DateTime.Now.Second.ToString();
            return ret;
        }
    }
}
