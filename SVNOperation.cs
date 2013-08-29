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
using System.Diagnostics;
using System.Web.Configuration;

namespace SVNManage
{
    public class cmdProcess
    {
        public Process proc;
        public string reposLocation;
        public string BinLocation;

        public cmdProcess()
        {
             proc = new Process();
             proc.StartInfo.CreateNoWindow = true;
             proc.StartInfo.FileName = "cmd.exe";
             proc.StartInfo.UseShellExecute = false;
             proc.StartInfo.RedirectStandardInput = true;
             proc.StartInfo.RedirectStandardOutput = true;
             proc.StartInfo.RedirectStandardError = true;
 
             reposLocation = WebConfigurationManager.AppSettings["ReposLocation"].ToString();
             BinLocation = WebConfigurationManager.AppSettings["SVNServerBinLocation"].ToString();
        }

     
        public void cd(string str)
        {
            proc.StandardInput.WriteLine("cd "+ @str);
        }

        public void rd(string str)
        {
               proc.StandardInput.WriteLine("rd " + @str + " /s /q");
        }

        public void ren(string origin, string dest)
        {
            proc.StandardInput.WriteLine("ren " + @origin + " " + @dest);
        }

        public void command(string cmd)
        {
            proc.StandardInput.WriteLine(@BinLocation + cmd);
        }

        public void start()
        {
            proc.Start();
            proc.StandardInput.WriteLine(reposLocation.Substring(0,2));
            cd(reposLocation);
        }

        public void end()
        {
           proc.StandardInput.WriteLine("exit");
           while (!proc.HasExited)
           {
               proc.WaitForExit(100);
           }

           string Result = proc.StandardOutput.ReadToEnd();

           proc.StandardOutput.Close();
           proc.Close();
        }
    }
    public class SVNOperation
    {
        public static void modify(string oldPath, string newPath)
        {
            cmdProcess proc = new cmdProcess();
            proc.start();
            proc.ren(oldPath, newPath);
            proc.end();
        }

        public static void delete(string path)
        {
            cmdProcess proc = new cmdProcess();
            proc.start();
            proc.rd(path);
            proc.end();
        }

        public static void create(string path)
        {
            cmdProcess proc = new cmdProcess();
            proc.start();
            proc.command("svnadmin create  " + @path);
            proc.end();
        }
    }
    
}
