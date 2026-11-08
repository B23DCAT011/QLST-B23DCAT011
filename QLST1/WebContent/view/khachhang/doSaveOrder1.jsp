<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,dao.*,model.*"%>
<%
    request.setCharacterEncoding("UTF-8");
    Customer1 customer = (Customer1) session.getAttribute("customer");
    if (customer == null) {
        // du an chua xu li dang nhap: vao tu trang chu de nap customer mau
        response.sendRedirect("UICustomerMain1.jsp");
        return;
    }
    // order : OnlineOrder1; cart : Cart1; listCartItem : CartItem1[] - cac dong duoc chon; outMessage : String
    OnlineOrder1 order = null;
    String outMessage = null;
    if (customer != null) {
        Cart1 cart = (Cart1) session.getAttribute("cart");
        ArrayList<CartItem1> allLines = (ArrayList<CartItem1>) session.getAttribute("listCartItem");
        String[] chkSelect = request.getParameterValues("chkSelect");
        String deliveryAddress = request.getParameter("inoutDeliveryAddress");
        String receiverPhone = request.getParameter("inoutReceiverPhone");
        deliveryAddress = (deliveryAddress == null) ? "" : deliveryAddress.trim();
        receiverPhone = (receiverPhone == null) ? "" : receiverPhone.trim();
        // nhan thong tin don hang: cac dong gio hang duoc chon
        ArrayList<CartItem1> listCartItem = new ArrayList<CartItem1>();
        if ((chkSelect != null) && (allLines != null)) {
            for (String id : chkSelect) {
                for (CartItem1 ci : allLines) {
                    if (String.valueOf(ci.getId()).equals(id)) listCartItem.add(ci);
                }
            }
        }
        // kiem tra SDT, mat hang duoc chon
        if (!receiverPhone.matches("0\\d{9}")) {
            outMessage = "Vui lòng nhập số điện thoại nhận hàng hợp lệ";                          // ngoai le 12.1
        } else if (listCartItem.size() == 0) {
            outMessage = "Vui lòng chọn ít nhất một mặt hàng cần đặt";                            // ngoai le 13.1
        } else {
            // kiem tra SL co the ban cua tung mat hang duoc chon
            StockUnitDAO1 suDAO = new StockUnitDAO1();
            for (CartItem1 ci : listCartItem) {
                if (ci.getQuantity() > suDAO.getSellableQuantity(ci.getItem().getId())) {
                    outMessage = "Mặt hàng " + ci.getItem().getName()
                            + " không còn đủ số lượng, vui lòng cập nhật lại giỏ hàng";           // ngoai le 13.2
                    break;
                }
            }
        }
        if (outMessage == null) {
            // dong goi cac dong chi tiet don hang tu cac mat hang duoc chon
            ArrayList<OrderDetail1> details = new ArrayList<OrderDetail1>();
            float totalAmount = 0;
            for (CartItem1 ci : listCartItem) {
                OrderDetail1 od = new OrderDetail1();
                od.setItem(ci.getItem());
                od.setQuantity(ci.getQuantity());
                od.setUnitPrice(ci.getUnitPrice());
                od.setAmount(ci.getQuantity() * ci.getUnitPrice());
                totalAmount += od.getAmount();
                details.add(od);
            }
            // dong goi thong tin don hang
            order = new OnlineOrder1();
            order.setOrderDate(new Date());
            order.setDeliveryAddress(deliveryAddress);
            order.setReceiverPhone(receiverPhone);
            order.setStatus("chờ duyệt");
            order.setCustomer(customer);
            order.setDetails(details);
            order.setTotalAmount(totalAmount);
            // luu don hang
            if ((new OnlineOrderDAO1()).saveOrder(order, cart.getId(), listCartItem)) {
                session.removeAttribute("cart");
                session.removeAttribute("listCartItem");
            } else {
                order = null;
                outMessage = "Lưu đơn hàng không thành công, vui lòng thử lại";
            }
        }
        if (outMessage != null) {
            // tra ve giao dien gio hang kem thong bao, giu nguyen lua chon va thong tin khach hang vua nhap
            request.setAttribute("outMessage", outMessage);
            request.getRequestDispatcher("UICart1.jsp").forward(request, response);
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Luu don hang</title>
</head>
<body class="hop">
    <h2>Thông báo</h2>
    <p>Lưu đơn hàng thành công.</p>
    <p>Mã đơn hàng: <%=String.format("DH%04d", order.getId())%></p>
    <button type="button" name="subOK" onclick="location.href='UICustomerMain1.jsp'">OK</button>
</body>
</html>
