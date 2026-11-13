<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.text.*,dao.*,model.*"%>
<%!
    private String money(float v) {
        DecimalFormatSymbols s = new DecimalFormatSymbols();
        s.setGroupingSeparator('.');
        return new DecimalFormat("#,##0", s).format(v);
    }
    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    Customer1 customer = (Customer1) session.getAttribute("customer");
    if (customer == null) {
        // du an chua xu li dang nhap: vao tu trang chu de nap customer mau
        response.sendRedirect("UICustomerMain1.jsp");
        return;
    }
    // khach hang nhap ten mat hang va click Tim: trang submit goi chinh no xu li
    String inItemName = request.getParameter("inItemName");
    if ((inItemName != null) && (inItemName.trim().length() > 0)) {
        String keyword = inItemName.trim();
        ArrayList<Item1> listItem = (new ItemDAO1()).getItemsByName(keyword, true);
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
<title>Dat hang</title>
</head>
<body>
<%
    // cart : Cart1 - gio hang dang dung kem cac dong
    Cart1 cart = (new CartDAO1()).getActiveCart(customer.getId());
    session.setAttribute("cart", cart);
    // ngoai le 4.1: UIItemList1.jsp nhan danh sach rong va goi lai trang nay -> thong bao, goi y cung loai
    String outMessage = "";
    ArrayList<Item1> listSuggested = null;
    String keyword = "";
    if ("notfound".equals(request.getParameter("err"))) {
        keyword = (String) session.getAttribute("keyword");
        outMessage = "Không tìm thấy mặt hàng phù hợp";
        listSuggested = (new ItemDAO1()).getSuggestedItems(keyword);
    }
%>
<h2>Đặt hàng</h2>
<form name="timmathang" action="UIOrder1.jsp" method="post">
    Tên mặt hàng: <input type="text" name="inItemName" value="<%=esc(keyword)%>" size="40" required />
    <input type="submit" name="subSearch" value="Tìm" />
</form>
<% if (outMessage.length() > 0) { %>
<p style="color:red;"><%=outMessage%></p>
<%     if ((listSuggested != null) && (listSuggested.size() > 0)) { %>
<p>Một số mặt hàng cùng loại:</p>
<!-- outSuggestedItems : Table -->
<table class="bang">
<thead>
    <td>TT</td>
    <td>Mã MH</td>
    <td>Tên mặt hàng</td>
    <td>Hãng</td>
    <td>Giá bán (đ)</td>
</thead>
<%         for (int i = 0; i < listSuggested.size(); i++) {
               Item1 it = listSuggested.get(i); %>
<tr>
    <td style="text-align:center;"><%=(i + 1)%></td>
    <td><%=String.format("MH%03d", it.getId())%></td>
    <td><%=esc(it.getName())%></td>
    <td><%=esc(it.getBrand().getName())%></td>
    <td style="text-align:right;"><%=money(it.getSellingPrice())%></td>
</tr>
<%         } %>
</table>
<%     } %>
<% } %>

<h3>Giỏ hàng hiện tại:</h3>
<!-- outCartSummary : Table -->
<table class="bang">
<thead>
    <td>TT</td>
    <td>Tên mặt hàng</td>
    <td>Số lượng</td>
    <td>Thành tiền (đ)</td>
</thead>
<%
    float tamtinh = 0;
    for (int i = 0; i < cart.getItems().size(); i++) {
        CartItem1 ci = cart.getItems().get(i);
        float thanhtien = ci.getQuantity() * ci.getUnitPrice();
        tamtinh += thanhtien;
%>
<tr>
    <td style="text-align:center;"><%=(i + 1)%></td>
    <td><%=esc(ci.getItem().getName())%></td>
    <td style="text-align:center;"><%=ci.getQuantity()%></td>
    <td style="text-align:right;"><%=money(thanhtien)%></td>
</tr>
<% } %>
<tr>
    <td></td>
    <td><b>Tạm tính</b></td>
    <td></td>
    <td style="text-align:right;"><b><%=money(tamtinh)%></b></td>
</tr>
</table>
<br/>
<button type="button" name="subHome" onclick="location.href='UICustomerMain1.jsp'">Về trang chủ</button>
<button type="button" name="subViewCart" onclick="location.href='UICart1.jsp'">Xem giỏ hàng</button>
</body>
</html>
