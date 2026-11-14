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
    // Trang dung chung cho hai module (use case Search Item By Name 1):
    // - nhan vien kho (module 1): cot so luong la SL ton, chon dong -> UIItemDetail1.jsp
    // - khach hang (module 2): cot so luong la SL co the ban, chon dong -> UIAddToCart1.jsp
    WarehouseStaff1 staff = (WarehouseStaff1) session.getAttribute("staff");
    Customer1 customer = (Customer1) session.getAttribute("customer");
    boolean forStaff = (staff != null);
    // keyword : String; listItem : Item1[] - nhan tu UIItemSearch1.jsp / UIOrder1.jsp
    String keyword = (String) session.getAttribute("keyword");
    ArrayList<Item1> listItem = (ArrayList<Item1>) session.getAttribute("listItem");
    if ((staff == null) && (customer == null)) {
        // du an chua xu li dang nhap: vao tu trang chu cua nhan vien kho hoac khach hang
        response.sendRedirect("../nhanvienkho/UIWarehouseMain1.jsp");
        return;
    }
    if ((listItem == null) || (listItem.size() == 0)) {
        // danh sach rong: quay lai trang tim kiem de thong bao (ngoai le 6.1 / 4.1)
        if (forStaff) {
            response.sendRedirect("../nhanvienkho/UIItemSearch1.jsp?err=notfound");
        } else {
            response.sendRedirect("../khachhang/UIOrder1.jsp?err=notfound");
        }
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Danh sach mat hang</title>
</head>
<body>
<%
    // listQuantity : integer[] - so luong cua tung dong
    ArrayList<Integer> listQuantity = new ArrayList<Integer>();
    StockUnitDAO1 suDAO = new StockUnitDAO1();
    for (Item1 it : listItem) {
        if (forStaff) {
            listQuantity.add(suDAO.getStockQuantity(it.getId()));
        } else {
            listQuantity.add(suDAO.getSellableQuantity(it.getId()));
        }
    }
    session.setAttribute("listQuantity", listQuantity);
    String backPage = forStaff ? "../nhanvienkho/UIItemSearch1.jsp" : "../khachhang/UIOrder1.jsp";
    String choosePage = forStaff ? "../nhanvienkho/UIItemDetail1.jsp" : "../khachhang/UIAddToCart1.jsp";
%>
<h2>Danh sách mặt hàng</h2>
<p>Từ khoá: "<%=esc(keyword)%>"</p>
<!-- outsubItemList : Table; subChoose : link -->
<table class="bang">
<thead>
    <td>TT</td>
    <td>Mã MH</td>
    <td>Tên mặt hàng</td>
    <td>Hãng</td>
<% if (forStaff) { %>
    <td>ĐVT</td>
    <td>Giá bán (đ)</td>
    <td>SL tồn</td>
<% } else { %>
    <td>Giá bán (đ)</td>
    <td>SL có thể bán</td>
    <td>Bảo hành</td>
<% } %>
    <td>Chọn</td>
</thead>
<%
    for (int i = 0; i < listItem.size(); i++) {
        Item1 it = listItem.get(i);
%>
<tr>
    <td style="text-align:center;"><%=(i + 1)%></td>
    <td><%=String.format("MH%03d", it.getId())%></td>
    <td><%=esc(it.getName())%></td>
    <td><%=esc(it.getBrand().getName())%></td>
<% if (forStaff) { %>
    <td><%=esc(it.getUnit().getName())%></td>
    <td style="text-align:right;"><%=money(it.getSellingPrice())%></td>
    <td style="text-align:center;"><%=listQuantity.get(i)%></td>
<% } else { %>
    <td style="text-align:right;"><%=money(it.getSellingPrice())%></td>
    <td style="text-align:center;"><%=listQuantity.get(i)%></td>
    <td style="text-align:center;"><%=it.getWarrantyPeriod()%> tháng</td>
<% } %>
    <td style="text-align:center;">
        <a href="<%=choosePage%>?idItem=<%=it.getId()%>"><%=forStaff ? "Sửa" : "Chọn mua"%></a></td>
</tr>
<% } %>
</table>
<br/>
<button type="button" name="subBack" onclick="location.href='<%=backPage%>'">Quay lại</button>
</body>
</html>
