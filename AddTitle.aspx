<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddTitle.aspx.cs" Inherits="AddTitle" Title="Add title page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <strong>Add a new Title<br />
    </strong>
    <br />
    Title &nbsp;&nbsp;
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
    <br />
    type &nbsp;&nbsp;
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><br />
    <br />
    pub_id &nbsp;&nbsp;&nbsp;
    <asp:DropDownList ID="DropDownList1" runat="server">
    </asp:DropDownList><br />
    <br />
    price &nbsp;&nbsp;
    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox><br />
    <br />
    advance &nbsp;&nbsp;
    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox><br />
    <br />
    royality &nbsp;&nbsp;
    <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox><br />
    <br />
    ytd sales &nbsp;&nbsp;
    <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox><br />
    <br />
    notes &nbsp;&nbsp;
    <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox><br />
    <br />
    <asp:Button ID="Button1" runat="server" Text="Add the Title" OnClick="Button1_Click" />
    &nbsp; &nbsp;&nbsp;
    <asp:Label ID="Label1" runat="server"></asp:Label>
</asp:Content>

