<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Browse A Book--The Ultimate Library" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    Please select the operation to perform<br />
    <br />
    <asp:Menu ID="Menu1" runat="server" BackColor="#FFFBD6" DynamicHorizontalOffset="2"
        Font-Names="Verdana" Font-Size="0.8em" ForeColor="#990000" StaticSubMenuIndent="10px">
        <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
        <DynamicHoverStyle BackColor="#990000" ForeColor="White" />
        <DynamicMenuStyle BackColor="#FFFBD6" />
        <StaticSelectedStyle BackColor="#FFCC66" />
        <DynamicSelectedStyle BackColor="#FFCC66" />
        <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
        <Items>
            <asp:MenuItem NavigateUrl="~/Default.aspx" Text="Home" Value="Home"></asp:MenuItem>
            <asp:MenuItem NavigateUrl="~/Authors.aspx" Text="View Authors" Value="View Authors">
            </asp:MenuItem>
            <asp:MenuItem NavigateUrl="~/Titles.aspx" Text="View Titles" Value="View Titles"></asp:MenuItem>
            <asp:MenuItem NavigateUrl="~/AddAuthor.aspx" Text="Add Author" Value="View Publishers">
            </asp:MenuItem>
            <asp:MenuItem NavigateUrl="~/AddTitle.aspx" Text="Add Title" Value="New Item"></asp:MenuItem>
        </Items>
        <StaticHoverStyle BackColor="#990000" ForeColor="White" />
    </asp:Menu>
</asp:Content>

