<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%!
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    WarehouseStaff1 staff = (WarehouseStaff1) session.getAttribute("staff");
    if (staff == null) {
        // du an chua xu li dang nhap: vao tu trang chu de nap staff mau
        response.sendRedirect("UIWarehouseMain1.jsp");
        return;
    }
    // nhan vien nhap ten mat hang va click Tim: trang submit goi chinh no xu li
    // (cung duoc doUpdateItem1.jsp goi lai voi tu khoa cu sau khi sua thanh cong)
    String inItemName = request.getParameter("inItemName");
    if ((inItemName != null) && (inItemName.trim().length() > 0)) {
        String keyword = inItemName.trim();
        ArrayList<Item1> listItem = (new ItemDAO1()).getItemsByName(keyword, false);
        session.setAttribute("listItem", listItem);
        session.setAttribute("keyword", keyword);
        response.sendRedirect("../dungchung/UIItemList1.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Tim mat hang</title>
</head>
<body>
<%
    // outMessage : String - ngoai le 6.1 (UIItemList1.jsp nhan danh sach rong va goi lai trang nay)
    String outMessage = "";
    String keyword = "";
    if ("notfound".equals(request.getParameter("err"))) {
        outMessage = "Không tìm thấy mặt hàng";
        keyword = (String) session.getAttribute("keyword");
    }
%>
<h2>Tìm mặt hàng</h2>
<form name="timmathang" action="UIItemSearch1.jsp" method="post">
<table border="0">
    <tr>
        <td>Tên mặt hàng:</td>
        <td><input type="text" name="inItemName" value="<%=esc(keyword)%>" size="40" required /></td>
    </tr>
    <% if (outMessage.length() > 0) { %>
    <tr>
        <td></td>
        <td style="color:red;"><%=outMessage%></td>
    </tr>
    <% } %>
    <tr>
        <td></td>
        <td>
            <button type="button" name="subBack" onclick="location.href='UIManageItem1.jsp'">Quay lại</button>
            <input type="submit" name="subSearch" value="Tìm" />
        </td>
    </tr>
</table>
</form>
</body>
</html>
