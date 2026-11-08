<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Quan li mat hang</title>
</head>
<body>
<%
    WarehouseStaff1 staff = (WarehouseStaff1) session.getAttribute("staff");
    if (staff == null) {
        // du an chua xu li dang nhap: vao tu trang chu de nap staff mau
        response.sendRedirect("UIWarehouseMain1.jsp");
        return;
    }
%>
<h2>Quản lí mặt hàng</h2>
<!-- subAddItem, subEditItem, subDeleteItem : link; subBack : submit.
     Them mat hang (Add Item 1) va Xoa mat hang (Delete Item 1) khong thuoc module sua thong tin mat hang. -->
<p><a href="#">Thêm mặt hàng</a></p>
<p><a href="UIItemSearch1.jsp">Sửa thông tin mặt hàng</a></p>
<p><a href="#">Xoá mặt hàng</a></p>
<button type="button" name="subBack" onclick="location.href='UIWarehouseMain1.jsp'">Quay lại</button>
</body>
</html>
