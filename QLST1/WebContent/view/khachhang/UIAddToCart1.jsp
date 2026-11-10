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
    // cart : Cart1 - UIOrder1.jsp da lay gio hang hien tai vao phien; mo trang khi chua qua UIOrder1.jsp thi quay ve do
    Cart1 cart = (Cart1) session.getAttribute("cart");
    if ((cart == null) || ((request.getParameter("idItem") != null) && (session.getAttribute("listItem") == null))) {
        response.sendRedirect("UIOrder1.jsp");
        return;
    }
    // item : Item1; sellableQuantity : integer
    Item1 item = null;
    int sellableQuantity = 0;
    String outMessage = "";
    String inQuantity = "";
    if (customer != null) {
        if (request.getParameter("idItem") != null) {
            // goi tu UIItemList1.jsp khi khach hang chon mot mat hang
            int idItem = Integer.parseInt(request.getParameter("idItem"));
            ArrayList<Item1> listItem = (ArrayList<Item1>) session.getAttribute("listItem");
            ArrayList<Integer> listQuantity = (ArrayList<Integer>) session.getAttribute("listQuantity");
            for (int i = 0; i < listItem.size(); i++) {
                if (listItem.get(i).getId() == idItem) {
                    item = listItem.get(i);
                    sellableQuantity = listQuantity.get(i);
                }
            }
            session.setAttribute("item", item);
            session.setAttribute("sellableQuantity", sellableQuantity);
        } else {
            item = (Item1) session.getAttribute("item");
            sellableQuantity = (session.getAttribute("sellableQuantity") == null) ? 0 : (Integer) session.getAttribute("sellableQuantity");
        }
        // khach hang nhap so luong va click Them vao gio: trang submit goi chinh no kiem tra so luong
        if ((item != null) && (request.getParameter("inQuantity") != null)) {
            inQuantity = request.getParameter("inQuantity").trim();
            int quantity = 0;
            try {
                quantity = Integer.parseInt(inQuantity);
            } catch (NumberFormatException e) {
                quantity = 0;
            }
            int inCart = 0;   // so luong mat hang nay da co trong gio
            for (CartItem1 ci : cart.getItems()) {
                if (ci.getItem().getId() == item.getId()) inCart += ci.getQuantity();
            }
            if (quantity <= 0) {
                outMessage = "Số lượng phải là số nguyên dương";                                   // ngoai le 7.2
            } else if (quantity + inCart > sellableQuantity) {
                outMessage = "Số lượng vượt quá số lượng có thể bán (còn " + sellableQuantity + ")"; // ngoai le 7.1
            } else if ((new CartItemDAO1()).addCartItem(cart, item, quantity)) {
                // them / cong don xong: quay ve giao dien dat hang de chon tiep
                response.sendRedirect("UIOrder1.jsp");
                return;
            } else {
                outMessage = "Thêm mặt hàng vào giỏ hàng không thành công, vui lòng thử lại";
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Nhap so luong</title>
</head>
<body>
<% if (item == null) { %>
    <h4>Chưa chọn mặt hàng.</h4>
    <button type="button" onclick="location.href='UIOrder1.jsp'">Quay lại</button>
<% } else { %>
<h2>Nhập số lượng</h2>
<form name="nhapsoluong" action="UIAddToCart1.jsp" method="post">
<!-- outItemInfo : Table -->
<table border="0">
    <tr><td>Mã mặt hàng:</td><td><%=String.format("MH%03d", item.getId())%></td></tr>
    <tr><td>Tên mặt hàng:</td><td><%=esc(item.getName())%></td></tr>
    <tr><td>Hãng:</td><td><%=esc(item.getBrand().getName())%></td></tr>
    <tr><td>Giá bán:</td><td><%=money(item.getSellingPrice())%> đ</td></tr>
    <tr><td>SL có thể bán:</td><td><%=sellableQuantity%></td></tr>
    <tr>
        <td>Số lượng:</td>
        <td><input type="text" name="inQuantity" value="<%=esc(inQuantity)%>" size="8" />
        <% if (outMessage.length() > 0) { %><span style="color:red;"> <%=outMessage%></span><% } %></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <button type="button" name="subBack" onclick="location.href='UIOrder1.jsp'">Quay lại</button>
            <input type="submit" name="subAddToCart" value="Thêm vào giỏ" />
        </td>
    </tr>
</table>
</form>
<% } %>
</body>
</html>
