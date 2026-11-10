<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Trang chu khach hang</title>
</head>
<body>
<%
    // customer : Customer1 - du an chua xu li dang nhap (use case Login 1 khong thuoc module),
    // trang chu dung khach hang mau cua du lieu mau: Nguyen Van An (id 1)
    Customer1 customer = (Customer1) session.getAttribute("customer");
    if (customer == null) {
        customer = new Customer1();
        customer.setId(1);
        FullName1 fullName = new FullName1();
        fullName.setFamilyName("Nguyễn");
        fullName.setMiddleName("Văn");
        fullName.setGivenName("An");
        customer.setFullName(fullName);
        session.setAttribute("customer", customer);
    }
    session.removeAttribute("staff");      // moi phien lam viec chi mot vai tro
    FullName1 fn = customer.getFullName();
    String hoten = fn.getFamilyName() + " " + (fn.getMiddleName() == null ? "" : fn.getMiddleName() + " ") + fn.getGivenName();
%>
<h2>Trang chủ khách hàng</h2>
<p>Khách hàng: <%=hoten%></p>
<!-- subPlaceOrder : link -->
<p><a href="UIOrder1.jsp">Đặt hàng</a></p>
</body>
</html>
