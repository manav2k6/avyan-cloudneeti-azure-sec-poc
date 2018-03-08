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

public partial class AddTitle : System.Web.UI.Page
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
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string insertCommand = "insert into titles values(@title, @type, @pubid, @price, @advance, @royalty , @ytd, @notes, GetDate())";
        SqlParameter[] parameters = new SqlParameter[]
        {
            new SqlParameter("@title", TextBox1.Text),
            new SqlParameter("@type", TextBox2.Text),
            new SqlParameter("@pubid", DropDownList1.SelectedValue),
            new SqlParameter("@price", TextBox4.Text),
            new SqlParameter("@advance", TextBox5.Text),
            new SqlParameter("@royalty", TextBox6.Text),
            new SqlParameter("@ytd", TextBox7.Text),
            new SqlParameter("@notes", TextBox8.Text)
        };

        DataAccess dbAccess = new DataAccess();
        bool retVal = dbAccess.ExecuteNonQuery(insertCommand, CommandType.Text, parameters);

        if (retVal == true)
        {
            Label1.Text = "Title Added Successfully";
        }
        else
        {
            Label1.Text = "Failed to add the title";
        }
    }
}
