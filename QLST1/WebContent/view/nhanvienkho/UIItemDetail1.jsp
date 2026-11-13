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
    private String err(String field, String errField, String outMessage) {
        if ((errField != null) && errField.equals(field) && (outMessage != null)) {
            return "<span style=\"color:red;\"> " + outMessage + "</span>";
        }
        return "";
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="../../css/qlst1.css" />
<title>Sua thong tin mat hang</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    WarehouseStaff1 staff = (WarehouseStaff1) session.getAttribute("staff");
    if (staff == null) {
        // du an chua xu li dang nhap: vao tu trang chu de nap staff mau
        response.sendRedirect("UIWarehouseMain1.jsp");
        return;
    }
    Item1 item = null;
    ArrayList<Category1> listCategory = null;
    ArrayList<Brand1> listBrand = null;
    ArrayList<UnitOfMeasure1> listUnit = null;
    String action = request.getParameter("action");
    // mo trang khi chua chon mat hang (thieu idItem) hoac mat du lieu phien: quay ve trang tim mat hang
    if (((action == null) && ((request.getParameter("idItem") == null) || !request.getParameter("idItem").matches("\\d+")))
            || ((action != null) && (session.getAttribute("item") == null))) {
        response.sendRedirect("UIItemSearch1.jsp");
        return;
    }
    if (action == null) {
        // goi tu UIItemList1.jsp khi nhan vien chon mot mat hang
        int idItem = Integer.parseInt(request.getParameter("idItem"));
        item = (new ItemDAO1()).getItemDetail(idItem);
        if (item == null) {
            response.sendRedirect("UIItemSearch1.jsp");
            return;
        }
        listCategory = (new CategoryDAO1()).getAllCategories();
        listBrand = (new BrandDAO1()).getAllBrands();
        listUnit = (new UnitOfMeasureDAO1()).getAllUnits();
        float maxAgreedPrice = (new SuppliedItemDAO1()).getMaxAgreedPrice(idItem);
        int unitsOnShelf = (new StockUnitDAO1()).countUnitsOnShelf(idItem);
        session.setAttribute("item", item);
        session.setAttribute("listCategory", listCategory);
        session.setAttribute("listBrand", listBrand);
        session.setAttribute("listUnit", listUnit);
        session.setAttribute("maxAgreedPrice", maxAgreedPrice);
        session.setAttribute("unitsOnShelf", unitsOnShelf);
        session.setAttribute("oldCounterSaleMode", item.getCounterSaleMode());
    } else {
        // action = back: doUpdateItem1.jsp tra ve form (du lieu khong hop le, hoac nhan vien click Huy tren hop canh bao)
        item = (Item1) session.getAttribute("item");
        listCategory = (ArrayList<Category1>) session.getAttribute("listCategory");
        listBrand = (ArrayList<Brand1>) session.getAttribute("listBrand");
        listUnit = (ArrayList<UnitOfMeasure1>) session.getAttribute("listUnit");
    }
    // keyword : String - tu khoa tim kiem cu, de doUpdateItem1.jsp goi lai UIItemSearch1.jsp sau khi sua (buoc 12)
    String keyword = (String) session.getAttribute("keyword");
    // outMessage : String - loi hien ngay tai truong tuong ung (ngoai le 10.1 - 10.4)
    String outMessage = (String) request.getAttribute("outMessage");
    String errField = (String) request.getAttribute("errField");
    // gia tri hien tren form: lay lai dung gia tri nhan vien vua nhap neu doUpdateItem1.jsp tra ve kem loi
    boolean fromInput = (request.getParameter("inoutName") != null);
    String vName = fromInput ? request.getParameter("inoutName") : item.getName();
    String vPrice = fromInput ? request.getParameter("inoutSellingPrice") : money(item.getSellingPrice());
    String vWarranty = fromInput ? request.getParameter("inoutWarrantyPeriod") : String.valueOf(item.getWarrantyPeriod());
    String vMinShelf = fromInput ? request.getParameter("inoutMinShelfQuantity")
            : (item.getMinShelfQuantity() > 0 ? String.valueOf(item.getMinShelfQuantity()) : "");
    String vDescription = fromInput ? request.getParameter("inoutDescription") : item.getDescription();
    String vMode = fromInput ? request.getParameter("inoutCounterSaleMode") : item.getCounterSaleMode();
    int vCategory = fromInput ? Integer.parseInt(request.getParameter("inoutCategory")) : item.getCategory().getId();
    int vBrand = fromInput ? Integer.parseInt(request.getParameter("inoutBrand")) : item.getBrand().getId();
    int vUnit = fromInput ? Integer.parseInt(request.getParameter("inoutUnit")) : item.getUnit().getId();
    String[] modes = {"tự chọn trên kệ", "giao từ kho"};
%>
<h2>Sửa thông tin mặt hàng</h2>
<form name="suamathang" action="doUpdateItem1.jsp" method="post" enctype="multipart/form-data">
<table border="0">
    <tr>
        <td>Mã mặt hàng:</td>
        <td><b><%=String.format("MH%03d", item.getId())%></b></td>
    </tr>
    <tr>
        <td>Tên mặt hàng:</td>
        <td><input type="text" name="inoutName" value="<%=esc(vName)%>" size="50" />
            <%=err("name", errField, outMessage)%></td>
    </tr>
    <tr>
        <td>Loại mặt hàng:</td>
        <td><select name="inoutCategory">
        <% for (Category1 c : listCategory) { %>
            <option value="<%=c.getId()%>" <%=(c.getId() == vCategory) ? "selected" : ""%>><%=esc(c.getName())%></option>
        <% } %>
        </select></td>
    </tr>
    <tr>
        <td>Hãng sản xuất:</td>
        <td><select name="inoutBrand">
        <% for (Brand1 b : listBrand) { %>
            <option value="<%=b.getId()%>" <%=(b.getId() == vBrand) ? "selected" : ""%>><%=esc(b.getName())%></option>
        <% } %>
        </select></td>
    </tr>
    <tr>
        <td>Đơn vị tính:</td>
        <td><select name="inoutUnit">
        <% for (UnitOfMeasure1 u : listUnit) { %>
            <option value="<%=u.getId()%>" <%=(u.getId() == vUnit) ? "selected" : ""%>><%=esc(u.getName())%></option>
        <% } %>
        </select></td>
    </tr>
    <tr>
        <td>Giá bán (đ):</td>
        <td><input type="text" name="inoutSellingPrice" value="<%=esc(vPrice)%>" />
            <%=err("sellingPrice", errField, outMessage)%></td>
    </tr>
    <tr>
        <td>Thời gian bảo hành (tháng):</td>
        <td><input type="text" name="inoutWarrantyPeriod" value="<%=esc(vWarranty)%>" />
            <%=err("warrantyPeriod", errField, outMessage)%></td>
    </tr>
    <tr>
        <td>Có ghi số serial của hãng:</td>
        <!-- outHasSerial : Checkbox - chi hien thi, khong cho sua -->
        <td><input type="checkbox" name="outHasSerial" <%=item.isHasSerial() ? "checked" : ""%> disabled /></td>
    </tr>
    <tr>
        <td>Cách bán tại quầy:</td>
        <td><select name="inoutCounterSaleMode">
        <% for (String m : modes) { %>
            <option value="<%=m%>" <%=m.equals(vMode) ? "selected" : ""%>><%=m.substring(0, 1).toUpperCase() + m.substring(1)%></option>
        <% } %>
        </select></td>
    </tr>
    <tr>
        <td>Mức tồn tối thiểu trên kệ:</td>
        <td><input type="text" name="inoutMinShelfQuantity" value="<%=esc(vMinShelf)%>" />
            <%=err("minShelfQuantity", errField, outMessage)%></td>
    </tr>
    <tr>
        <td>Mô tả:</td>
        <td><textarea name="inoutDescription" rows="4" cols="50"><%=esc(vDescription)%></textarea></td>
    </tr>
    <tr>
        <td>Ảnh:</td>
        <!-- inoutImage : File - ten tep anh hien tai va nut chon tep moi -->
        <td><%=esc(item.getImage())%> <input type="file" name="inoutImage" accept="image/*" /></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <button type="button" name="subCancel" onclick="location.href='../dungchung/UIItemList1.jsp'">Huỷ</button>
            <input type="submit" name="subUpdate" value="Sửa" />
        </td>
    </tr>
</table>
</form>
</body>
</html>
