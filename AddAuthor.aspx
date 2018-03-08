<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddAuthor.aspx.cs" Inherits="AddAuthor" Title="Add author page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <strong>Add a new Author</strong><br />
    <br />
    First Name &nbsp;
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
    <br />
    Last Name&nbsp;
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><br />
    <br />
    Phone &nbsp; &nbsp; &nbsp; &nbsp;
    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox><br />
    <br />
    Address &nbsp; &nbsp;
    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox><br />
    <br />
    City &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox><br />
    <br />
    State &nbsp; &nbsp; &nbsp; &nbsp;
    <asp:TextBox ID="TextBox6" runat="server" MaxLength="2"></asp:TextBox><br />
    <br />
    Zip &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
    <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox><br />
    <br />
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add this Author" />
    &nbsp; &nbsp;
    <asp:Label ID="Label1" runat="server"></asp:Label>
</asp:Content>

