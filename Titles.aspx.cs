using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class Titles : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            DataAccess dbAccess = new DataAccess();

            DropDownList1.DataSource = dbAccess.ExecuteSelectCommand("select pub_id from publishers", CommandType.Text);
            DropDownList1.DataTextField = "pub_id";
            DropDownList1.DataValueField = "pub_id";
            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new ListItem("ALL", "ALL"));
                        
            GridView1.DataSource = dbAccess.ExecuteSelectCommand("select * from titles", CommandType.Text);
            GridView1.DataBind();            
        }
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataAccess dbAccess = new DataAccess();

        if (DropDownList1.SelectedValue.Trim() == "ALL")
        {
            GridView1.DataSource = dbAccess.ExecuteSelectCommand("select * from titles", CommandType.Text);
            GridView1.DataBind();    
        }
        else
        {
            string query = "select * from titles where pub_id = @pubid";
            SqlParameter param = new SqlParameter("@pubid", DropDownList1.SelectedValue);
            GridView1.DataSource = dbAccess.ExecuteParamerizedSelectCommand(query, CommandType.Text, new SqlParameter[] { param});
            GridView1.DataBind();    
        }
    }
}
