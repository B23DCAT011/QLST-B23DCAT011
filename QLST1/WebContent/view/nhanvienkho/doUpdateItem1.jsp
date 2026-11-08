<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.io.*,java.net.*,java.text.*,javax.servlet.http.Part,dao.*,model.*"%>
<%!
    private String money(float v) {
        DecimalFormatSymbols s = new DecimalFormatSymbols();
        s.setGroupingSeparator('.');
        return new DecimalFormat("#,##0", s).format(v);
    }
    // canh bao doi cach ban tu tu chon sang giao tu kho khi ke van con hang (ngoai le 10.6)
    private boolean modeWarning(String oldMode, Item1 item, int unitsOnShelf) {
        return "tự chọn trên kệ".equals(oldMode) && "giao từ kho".equals(item.getCounterSaleMode()) && (unitsOnShelf > 0);
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
    // item : Item1 (gia tri moi); oldCounterSaleMode : String; maxAgreedPrice : float; unitsOnShelf : integer;
    // confirmed : boolean; keyword : String
    Item1 shown = (Item1) session.getAttribute("item");
    String oldCounterSaleMode = (String) session.getAttribute("oldCounterSaleMode");
    float maxAgreedPrice = (session.getAttribute("maxAgreedPrice") == null) ? 0 : (Float) session.getAttribute("maxAgreedPrice");
    int unitsOnShelf = (session.getAttribute("unitsOnShelf") == null) ? 0 : (Integer) session.getAttribute("unitsOnShelf");
    String keyword = (String) session.getAttribute("keyword");
    Item1 item = null;
    int showWarning = 0;        // 1: canh bao ban duoi gia von, 2: canh bao doi cach ban
    boolean saved = false;
    boolean confirmed = false;
    String outMessage = null;
    String errField = null;
    String action = request.getParameter("action");

    if ((staff != null) && (shown != null) && (action == null) && (request.getParameter("inoutName") != null)) {
        // ---- nhan thong tin MH tu form ----
        item = new Item1();
        item.setId(shown.getId());
        item.setHasSerial(shown.isHasSerial());     // chi hien thi, giu nguyen
        item.setStatus(shown.getStatus());
        item.setImage(shown.getImage());
        String name = request.getParameter("inoutName").trim();
        String txtPrice = request.getParameter("inoutSellingPrice").trim().replace(".", "").replace(",", "").replace(" ", "");
        String txtWarranty = request.getParameter("inoutWarrantyPeriod").trim();
        String txtMinShelf = request.getParameter("inoutMinShelfQuantity").trim();
        String mode = request.getParameter("inoutCounterSaleMode");
        item.setName(name);
        item.setCounterSaleMode(mode);
        item.setDescription(request.getParameter("inoutDescription"));
        int idCategory = Integer.parseInt(request.getParameter("inoutCategory"));
        int idBrand = Integer.parseInt(request.getParameter("inoutBrand"));
        int idUnit = Integer.parseInt(request.getParameter("inoutUnit"));
        for (Category1 c : (ArrayList<Category1>) session.getAttribute("listCategory")) {
            if (c.getId() == idCategory) item.setCategory(c);
        }
        for (Brand1 b : (ArrayList<Brand1>) session.getAttribute("listBrand")) {
            if (b.getId() == idBrand) item.setBrand(b);
        }
        for (UnitOfMeasure1 u : (ArrayList<UnitOfMeasure1>) session.getAttribute("listUnit")) {
            if (u.getId() == idUnit) item.setUnit(u);
        }
        // ---- kiem tra du lieu nhap (ngoai le 10.1, 10.2, 10.4) ----
        if (name.length() == 0) {
            outMessage = "Vui lòng nhập tên mặt hàng"; errField = "name";
        } else if (txtPrice.length() == 0) {
            outMessage = "Vui lòng nhập giá bán"; errField = "sellingPrice";
        } else {
            try {
                item.setSellingPrice(Float.parseFloat(txtPrice));
                if (!(item.getSellingPrice() > 0)) throw new NumberFormatException();
            } catch (NumberFormatException e) {
                outMessage = "Giá bán phải là số dương"; errField = "sellingPrice";
            }
        }
        if (outMessage == null) {
            if (txtWarranty.length() == 0) {
                outMessage = "Vui lòng nhập thời gian bảo hành"; errField = "warrantyPeriod";
            } else {
                try {
                    item.setWarrantyPeriod(Integer.parseInt(txtWarranty));
                    if (item.getWarrantyPeriod() < 0) throw new NumberFormatException();
                } catch (NumberFormatException e) {
                    outMessage = "Thời gian bảo hành phải là số nguyên không âm"; errField = "warrantyPeriod";
                }
            }
        }
        if (outMessage == null) {
            boolean selfService = "tự chọn trên kệ".equals(mode);
            if (txtMinShelf.length() == 0) {
                if (selfService) {
                    outMessage = "Vui lòng nhập mức tồn tối thiểu trên kệ"; errField = "minShelfQuantity";
                }
            } else {
                try {
                    item.setMinShelfQuantity(Integer.parseInt(txtMinShelf));
                    if (item.getMinShelfQuantity() < (selfService ? 1 : 0)) throw new NumberFormatException();
                } catch (NumberFormatException e) {
                    outMessage = "Mức tồn tối thiểu trên kệ phải là số nguyên " + (selfService ? "dương" : "không âm");
                    errField = "minShelfQuantity";
                }
            }
        }
        // ---- kiem tra trung ten (ngoai le 10.3) ----
        if ((outMessage == null) && (new ItemDAO1()).checkDuplicateName(name, item.getId())) {
            outMessage = "Tên mặt hàng đã tồn tại"; errField = "name";
        }
        if (outMessage != null) {
            // tra ve form kem gia tri vua nhap va thong bao loi tai truong tuong ung
            request.setAttribute("outMessage", outMessage);
            request.setAttribute("errField", errField);
            request.getRequestDispatcher("UIItemDetail1.jsp?action=back").forward(request, response);
            return;
        }
        // anh moi (neu nhan vien chon tep)
        Part part = request.getPart("inoutImage");
        if ((part != null) && (part.getSize() > 0) && (part.getSubmittedFileName() != null)) {
            String fileName = new File(part.getSubmittedFileName()).getName();
            File dir = new File(application.getRealPath("/images"));
            if (!dir.exists()) dir.mkdirs();
            part.write(new File(dir, fileName).getAbsolutePath());
            item.setImage(fileName);
        }
        session.setAttribute("item", item);
        session.setAttribute("confirmed", false);
        // ---- kiem tra gia ban, cach ban tai quay (ngoai le 10.5, 10.6) ----
        if ((maxAgreedPrice > 0) && (item.getSellingPrice() < maxAgreedPrice)) {
            showWarning = 1;
        } else if (modeWarning(oldCounterSaleMode, item, unitsOnShelf)) {
            showWarning = 2;
        }
    } else if ((staff != null) && (shown != null) && "confirm".equals(action)) {
        // nhan vien click Xac nhan tren hop canh bao
        item = shown;
        confirmed = true;
        session.setAttribute("confirmed", true);
        if ("1".equals(request.getParameter("w")) && modeWarning(oldCounterSaleMode, item, unitsOnShelf)) {
            showWarning = 2;
        }
    }
    // ---- luu thong tin MH ----
    if ((item != null) && (showWarning == 0)) {
        saved = (new ItemDAO1()).updateItem(item);
        if (!saved) {
            request.setAttribute("outMessage", "Lưu thông tin mặt hàng không thành công, vui lòng thử lại");
            request.setAttribute("errField", "save");
            request.getRequestDispatcher("UIItemDetail1.jsp?action=back").forward(request, response);
            return;
        }
    }
    String backToList = "UIItemSearch1.jsp?inItemName=" + URLEncoder.encode(keyword == null ? "" : keyword, "UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Sua thong tin mat hang</title>
</head>
<body class="hop">
<% if (item == null) { %>
    <h4>Không có mặt hàng nào đang được sửa.</h4>
    <button type="button" onclick="location.href='UIItemSearch1.jsp'">Tìm mặt hàng</button>
<% } else if (showWarning == 1) { %>
    <!-- Hop canh bao ban duoi gia von (ngoai le 10.5) -->
    <h2>Cảnh báo bán dưới giá vốn</h2>
    <p>Giá bán thấp hơn giá nhập thoả thuận cao nhất (<%=money(maxAgreedPrice)%> đ), bạn có chắc muốn lưu?</p>
    <button type="button" name="subCancel" onclick="location.href='UIItemDetail1.jsp?action=back'">Huỷ</button>
    <button type="button" name="subConfirm" onclick="location.href='doUpdateItem1.jsp?action=confirm&w=1'">Xác nhận</button>
<% } else if (showWarning == 2) { %>
    <!-- Hop canh bao doi cach ban (ngoai le 10.6) -->
    <h2>Cảnh báo đổi cách bán</h2>
    <p>Trên kệ tự chọn còn <%=unitsOnShelf%> sản phẩm, cần điều chuyển về kho. Bạn có chắc muốn lưu?</p>
    <button type="button" name="subCancel" onclick="location.href='UIItemDetail1.jsp?action=back'">Huỷ</button>
    <button type="button" name="subConfirm" onclick="location.href='doUpdateItem1.jsp?action=confirm&w=2'">Xác nhận</button>
<% } else if (saved) { %>
    <!-- Hop thong bao sua thanh cong (buoc 11 - 12) -->
    <h2>Thông báo</h2>
    <p>Sửa thông tin mặt hàng thành công</p>
    <% if (confirmed && modeWarning(oldCounterSaleMode, item, unitsOnShelf)) { %>
    <p>Vui lòng lập phiếu điều chuyển hàng hoá đưa <%=unitsOnShelf%> sản phẩm trên kệ tự chọn về kho.</p>
    <% } %>
    <button type="button" name="subOK" onclick="location.href='<%=backToList%>'">OK</button>
<% } %>
</body>
</html>
