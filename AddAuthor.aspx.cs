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

public partial class AddAuthor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlParameter[] parameters = new SqlParameter[]
        {       new SqlParameter("@au_lname", TextBox2.Text),
                new SqlParameter("@au_fname", TextBox1.Text),
                new SqlParameter("@phone", TextBox3.Text),
                new SqlParameter("@address", TextBox4.Text),
                new SqlParameter("@city", TextBox5.Text),
                new SqlParameter("@state", TextBox6.Text),
                new SqlParameter("@zip", TextBox7.Text)
        };

        DataAccess dbAcess = new DataAccess();

        bool retVal = dbAcess.ExecuteNonQuery("AddNewAuthor", CommandType.StoredProcedure, parameters);

        if (retVal == true)
        {
            Label1.Text = "Author Added Successfully";
        }
        else
        {
            Label1.Text = "Failed to add the author";
        }
    }
}
