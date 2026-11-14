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
    private String join(String a, String b) {
        if ((b == null) || (b.trim().length() == 0)) return a;
        return (a.length() == 0) ? b : a + ", " + b;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Gio hang</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    Customer1 customer = (Customer1) session.getAttribute("customer");
    if (customer == null) {
        // du an chua xu li dang nhap: vao tu trang chu de nap customer mau
        response.sendRedirect("UICustomerMain1.jsp");
        return;
    }
    // cart : Cart1; listCartItem : CartItem1[]; outMessage : String
    Cart1 cart = (Cart1) session.getAttribute("cart");
    if (cart == null) {
        // UIOrder1.jsp da lay gio hang hien tai vao phien; mo trang khi chua qua UIOrder1.jsp thi quay ve do
        response.sendRedirect("UIOrder1.jsp");
        return;
    }
    String outMessage = (String) request.getAttribute("outMessage");   // loi do doSaveOrder1.jsp tra ve (12.1, 13.1, 13.2)
    String action = request.getParameter("action");
    int editId = 0;   // dong dang sua so luong
    CartItemDAO1 ciDAO = new CartItemDAO1();
    if ("edit".equals(action)) {
        editId = Integer.parseInt(request.getParameter("idCartItem"));
    } else if ("update".equals(action)) {
        // ngoai le 11.1: khach hang sua so luong mot dong cua gio
        int idCartItem = Integer.parseInt(request.getParameter("idCartItem"));
        int idItem = Integer.parseInt(request.getParameter("idItem"));
        int quantity = 0;
        try {
            quantity = Integer.parseInt(request.getParameter("inNewQuantity").trim());
        } catch (Exception e) {
            quantity = 0;
        }
        int sellable = (new StockUnitDAO1()).getSellableQuantity(idItem);
        if (quantity <= 0) {
            outMessage = "Số lượng phải là số nguyên dương";
            editId = idCartItem;
        } else if (quantity > sellable) {
            outMessage = "Số lượng vượt quá số lượng có thể bán (còn " + sellable + ")";
            editId = idCartItem;
        } else {
            CartItem1 ci = new CartItem1();
            ci.setId(idCartItem);
            ci.setQuantity(quantity);
            ciDAO.updateCartItem(ci);
        }
    } else if ("delete".equals(action)) {
        // ngoai le 11.2: khach hang xoa mot mat hang khoi gio
        ciDAO.deleteCartItem(Integer.parseInt(request.getParameter("idCartItem")));
    }
    ArrayList<CartItem1> listCartItem = (cart.getId() > 0) ? ciDAO.getCartItems(cart.getId()) : new ArrayList<CartItem1>();
    session.setAttribute("listCartItem", listCartItem);
    // dia chi giao hang, so dien thoai nhan hang: dien san theo thong tin thanh vien,
    // hoac giu nguyen gia tri khach hang vua nhap khi doSaveOrder1.jsp tra ve kem loi
    String inoutDeliveryAddress = request.getParameter("inoutDeliveryAddress");
    String inoutReceiverPhone = request.getParameter("inoutReceiverPhone");
    String[] chkSelect = request.getParameterValues("chkSelect");
    boolean fromSubmit = (inoutDeliveryAddress != null);
    if (!fromSubmit) {
        Customer1 info = (new CustomerDAO1()).getCustomerInfo(customer.getId());
        Address1 ad = info.getAddress();
        inoutDeliveryAddress = join(join(join(join(ad.getHouseNumber(), ad.getStreet()), ad.getWard()), ad.getDistrict()), ad.getProvince());
        inoutReceiverPhone = info.getPhone();
    }
    Set<String> selected = new HashSet<String>();
    if (chkSelect != null) selected.addAll(Arrays.asList(chkSelect));
%>
<h2>Giỏ hàng</h2>
<% if (listCartItem.size() == 0) { %>
<p>Giỏ hàng chưa có mặt hàng nào.</p>
<% } %>
<form id="formCart" name="giohang" action="doSaveOrder1.jsp" method="post">
<!-- outsubCartLines : Table; chkSelect : Checkbox -->
<table class="bang">
<thead>
    <td>Chọn</td>
    <td>TT</td>
    <td>Mã MH</td>
    <td>Tên mặt hàng</td>
    <td>Đơn giá (đ)</td>
    <td>Số lượng</td>
    <td>Thành tiền (đ)</td>
    <td>Sửa SL</td>
    <td>Xoá</td>
</thead>
<%
    float outTotalAmount = 0;
    for (int i = 0; i < listCartItem.size(); i++) {
        CartItem1 ci = listCartItem.get(i);
        float thanhtien = ci.getQuantity() * ci.getUnitPrice();
        // mac dinh danh dau chon san moi dong; khi doSaveOrder1.jsp tra ve thi giu nguyen lua chon cua khach hang
        boolean checked = fromSubmit ? selected.contains(String.valueOf(ci.getId())) : true;
        if (checked) outTotalAmount += thanhtien;
%>
<tr>
    <td style="text-align:center;"><input type="checkbox" name="chkSelect" value="<%=ci.getId()%>"
        data-amount="<%=thanhtien%>" onchange="tinhTong()" <%=checked ? "checked" : ""%> /></td>
    <td style="text-align:center;"><%=(i + 1)%></td>
    <td><%=String.format("MH%03d", ci.getItem().getId())%></td>
    <td><%=esc(ci.getItem().getName())%></td>
    <td style="text-align:right;"><%=money(ci.getUnitPrice())%></td>
    <td style="text-align:center;">
    <% if (ci.getId() == editId) { %>
        <!-- inNewQuantity : Text; subUpdateLine : submit (form rieng formUpdate) -->
        <input type="text" name="inNewQuantity" form="formUpdate" value="<%=ci.getQuantity()%>" size="4" />
        <input type="submit" name="subUpdateLine" form="formUpdate" value="Cập nhật" />
    <% } else { %>
        <%=ci.getQuantity()%>
    <% } %>
    </td>
    <td style="text-align:right;"><%=money(thanhtien)%></td>
    <td style="text-align:center;"><a href="UICart1.jsp?action=edit&idCartItem=<%=ci.getId()%>">Sửa</a></td>
    <!-- subDeleteLine : submit -->
    <td style="text-align:center;"><button type="button" class="link" name="subDeleteLine"
        onclick="location.href='UICart1.jsp?action=delete&idCartItem=<%=ci.getId()%>'">Xoá</button></td>
</tr>
<% } %>
<tr>
    <td></td><td></td><td></td>
    <td><b>Tổng tiền các mặt hàng được chọn</b></td>
    <td></td><td></td>
    <!-- outTotalAmount : String -->
    <td style="text-align:right;"><b id="outTotalAmount"><%=money(outTotalAmount)%></b></td>
    <td></td><td></td>
</tr>
</table>
<br/>
<table border="0">
    <tr>
        <td>Địa chỉ giao hàng:</td>
        <td><input type="text" name="inoutDeliveryAddress" value="<%=esc(inoutDeliveryAddress)%>" size="70" required /></td>
    </tr>
    <tr>
        <td>Số điện thoại nhận hàng:</td>
        <td><input type="text" name="inoutReceiverPhone" value="<%=esc(inoutReceiverPhone)%>" size="20" /></td>
    </tr>
</table>
<% if ((outMessage != null) && (outMessage.length() > 0)) { %>
<p style="color:red;"><%=outMessage%></p>
<% } %>
<br/>
<button type="button" name="subContinue" onclick="location.href='UIOrder1.jsp'">Đặt thêm mặt hàng</button>
<input type="submit" name="subSubmit" value="Submit" />
</form>
<% for (CartItem1 ci : listCartItem) { if (ci.getId() == editId) { %>
<form id="formUpdate" action="UICart1.jsp" method="post">
    <input type="hidden" name="action" value="update" />
    <input type="hidden" name="idCartItem" value="<%=ci.getId()%>" />
    <input type="hidden" name="idItem" value="<%=ci.getItem().getId()%>" />
</form>
<% } } %>
<script type="text/javascript">
    // tinh lai tong tien cac mat hang duoc chon khi khach hang danh dau / bo chon
    function tinhTong() {
        var tong = 0;
        var ds = document.getElementsByName("chkSelect");
        for (var i = 0; i < ds.length; i++) {
            if (ds[i].checked) tong += parseFloat(ds[i].getAttribute("data-amount"));
        }
        document.getElementById("outTotalAmount").innerHTML = Math.round(tong).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    }
</script>
</body>
</html>
