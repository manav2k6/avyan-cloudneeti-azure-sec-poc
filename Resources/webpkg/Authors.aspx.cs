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

public partial class Authors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            DataAccess dbAccess = new DataAccess();

            DropDownList1.DataSource = dbAccess.ExecuteSelectCommand("GetAuthorStates", CommandType.StoredProcedure);
            DropDownList1.DataTextField = "state";
            DropDownList1.DataValueField = "state";
            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new ListItem("ALL", "ALL"));

            GridView1.DataSource = dbAccess.ExecuteSelectCommand("GetAuthors", CommandType.StoredProcedure);
            GridView1.DataBind();
        }
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataAccess dbAccess = new DataAccess();

        if (DropDownList1.SelectedValue.Trim() == "ALL")
        {
            GridView1.DataSource = dbAccess.ExecuteSelectCommand("GetAuthors", CommandType.StoredProcedure);
            GridView1.DataBind();
        }
        else
        {            
            SqlParameter param = new SqlParameter("@state", DropDownList1.SelectedValue);
            GridView1.DataSource = dbAccess.ExecuteParamerizedSelectCommand("GetAuthorByState", CommandType.StoredProcedure, new SqlParameter[] { param });
            GridView1.DataBind();
        }
    }
}
