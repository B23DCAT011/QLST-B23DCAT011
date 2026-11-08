<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Trang chu nhan vien kho</title>
</head>
<body>
<%
    // staff : WarehouseStaff1 - du an chua xu li dang nhap (use case Login 1 khong thuoc module),
    // trang chu dung nhan vien kho mau cua du lieu mau: Tran Thi Binh (id 2)
    WarehouseStaff1 staff = (WarehouseStaff1) session.getAttribute("staff");
    if (staff == null) {
        staff = new WarehouseStaff1();
        staff.setId(2);
        FullName1 fullName = new FullName1();
        fullName.setFamilyName("Trần");
        fullName.setMiddleName("Thị");
        fullName.setGivenName("Bình");
        staff.setFullName(fullName);
        staff.setPosition("kho");
        session.setAttribute("staff", staff);
    }
    session.removeAttribute("customer");   // moi phien lam viec chi mot vai tro
    FullName1 fn = staff.getFullName();
    String hoten = fn.getFamilyName() + " " + (fn.getMiddleName() == null ? "" : fn.getMiddleName() + " ") + fn.getGivenName();
%>
<h2>Trang chủ nhân viên kho</h2>
<p>Nhân viên: <%=hoten%></p>
<!-- subManageItem : link -->
<p><a href="UIManageItem1.jsp">Quản lí mặt hàng</a></p>
</body>
</html>
