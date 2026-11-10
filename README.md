# Bài tập 4 - Cài đặt hai module của hệ thống QLST (J2EE: JSP - DAO - MySQL)

Code cài đặt đúng theo thiết kế ở bài tập 3: biểu đồ lớp thiết kế Hình 6 (module 1) và Hình 11 (module 2),
Bảng 9, 10, 13, 14, biểu đồ hoạt động Hình 7, 12, kịch bản v3.0 / biểu đồ tuần tự Hình 8, 13, biểu đồ gói Hình 14,
CSDL Hình 3. Cách tổ chức và cách viết theo chương 5 của casestudy (mục 5.1, 5.2.1).

- Module 1: Nhân viên kho sửa thông tin mặt hàng (`Edit Item Information 1`)
- Module 2: Khách hàng đặt hàng trực tuyến (`Place Online Order 1`)

## 1. Cấu trúc thư mục

```
bài tập 4/
├── QLST1/                         dự án web (Eclipse Dynamic Web Project), đóng gói thành QLST1.war
│   ├── src/
│   │   ├── model/                 gói model (package model): 42 lớp thực thể (đúng Hình 2), sinh bởi tools/gen_code.py
│   │   └── dao/                   gói dao (package dao): DAO1 + 11 lớp DAO của hai module
│   ├── WebContent/
│   │   ├── view/                  gói view (Hình 14, Bảng 17), chia gói con theo người dùng
│   │   │   ├── thanhvien/         (trang đăng nhập, đăng kí, mật khẩu - không thuộc hai module)
│   │   │   ├── nhanvienkho/       UIWarehouseMain1, UIManageItem1, UIItemSearch1, UIItemDetail1, doUpdateItem1
│   │   │   ├── khachhang/         UICustomerMain1, UIOrder1, UIAddToCart1, UICart1, doSaveOrder1
│   │   │   ├── dungchung/         UIItemList1 (dùng chung cho hai module)
│   │   │   ├── nhanvienbanhang/   (trang bán hàng tại quầy - không thuộc hai module)
│   │   │   └── quanli/            (trang thống kê - không thuộc hai module)
│   │   ├── css/qlst1.css          giao diện chung theo mẫu Hình 5, Hình 10 (khung, nút, bảng)
│   │   ├── images/                ảnh mặt hàng (doUpdateItem1.jsp lưu ảnh tải lên vào đây)
│   │   └── WEB-INF/
│   │       ├── web.xml            cấu hình multipart cho doUpdateItem1.jsp (trường ảnh inoutImage : File)
│   │       └── lib/mysql-connector-j-8.3.0.jar   trình điều khiển JDBC
│   └── database/
│       ├── qlst1_schema.sql       35 bảng (đúng Hình 3), sinh bởi tools/gen_code.py
│       ├── qlst1_procedures.sql   stored procedure mà các hàm đọc của DAO gọi, xếp theo từng lớp DAO
│       └── qlst1_data.sql         dữ liệu mẫu theo kịch bản v1.0, sinh bởi tools/gen_data.py
├── chay_thu.bat, chay_thu.ps1     chạy thử nhanh trên máy (mục 5)
└── tools/
    ├── gen_code.py                sinh model/*.java từ 01_class_thucthe_thietke.puml và schema từ 02_csdl_hethong.puml
    └── gen_data.py                sinh dữ liệu mẫu
```

## 2. Quy ước chuyển từ thiết kế sang code

| Thiết kế | Code |
|---|---|
| Lớp thực thể, thuộc tính `-x : T` | `private T x;` kèm `getX()/setX()` (kiểu boolean: `isX()`), cùng tên, cùng thứ tự |
| `integer`, `float`, `boolean`, `Date`, `String` | `int`, `float`, `boolean`, `java.util.Date`, `String` |
| `Lop1[]` | `ArrayList<Lop1>` (giống casestudy: thiết kế ghi `Kihoc[]`, code trả về `ArrayList<Kihoc>`) |
| Kế thừa `A <|-- B` | `class B extends A` |
| `DAO1 { -con : Connection; +DAO1() }` | `protected static Connection con;` mở một lần trong `DAO1()`, mọi DAO `extends DAO1` |
| Phương thức DAO đọc dữ liệu | gọi stored procedure `{call tenHam(?)}`, đóng gói kết quả vào lớp thực thể |
| Phương thức DAO ghi dữ liệu | `PreparedStatement`; hàm nhiều câu lệnh chạy trong giao dịch (`setAutoCommit(false)` → `commit()` / `rollback()`) |
| Lớp giao diện `UIxxx1.jsp`, `doxxx1.jsp` | trang JSP cùng tên trong thư mục `WebContent/view/<gói con>` theo Hình 14, Bảng 17 |
| Thuộc tính `in/out/inout/sub...` của trang | trường form / nút / vùng hiển thị có `name` đúng bằng tên thuộc tính |
| Thuộc tính ẩn (`staff`, `customer`, `item`, `cart`, `listItem`, `keyword`...) | thuộc tính session (hoặc biến cục bộ của trang) cùng tên |

## 3. Bảng đối chiếu module 1 - Sửa thông tin mặt hàng

| Lớp thiết kế | File | Thuộc tính / phương thức → cách cài |
|---|---|---|
| UIWarehouseMain1.jsp | `WebContent/view/nhanvienkho/UIWarehouseMain1.jsp` | `staff` = session `staff` (chưa có thì nạp nhân viên kho mẫu id 2); `subManageItem` = link Quản lí mặt hàng |
| UIManageItem1.jsp | `WebContent/view/nhanvienkho/UIManageItem1.jsp` | `subAddItem`, `subEditItem`, `subDeleteItem` = 3 link; `subBack` = nút Quay lại; `staff` = session |
| UIItemSearch1.jsp | `WebContent/view/nhanvienkho/UIItemSearch1.jsp` | `inItemName` = ô nhập; `subSearch` = nút Tìm (trang gọi chính nó); `subBack`; `outMessage` = "Không tìm thấy mặt hàng" (6.1); `listItem` → session |
| UIItemList1.jsp | `WebContent/view/dungchung/UIItemList1.jsp` | `outsubItemList` = bảng; `subChoose` = link Chọn; `subBack`; `keyword`, `listItem` ← session; `listQuantity` → session (SL tồn với nhân viên kho) |
| UIItemDetail1.jsp | `WebContent/view/nhanvienkho/UIItemDetail1.jsp` | `inoutName`, `inoutSellingPrice`, `inoutWarrantyPeriod`, `inoutMinShelfQuantity` (Text); `inoutCategory`, `inoutBrand`, `inoutUnit`, `inoutCounterSaleMode` (Select); `outHasSerial` (Checkbox disabled); `inoutDescription` (TextArea); `inoutImage` (File: hiện ảnh hiện tại trong `images/`, chọn tệp mới thì xem trước); `subUpdate`, `subCancel`; `outMessage` hiện đỏ tại trường; `item`, `listCategory`, `listBrand`, `listUnit`, `maxAgreedPrice`, `unitsOnShelf` → session; `keyword` ← session ; mở trang khi chưa chọn mặt hàng (thiếu `idItem`) thì chuyển về `UIItemSearch1.jsp` |
| doUpdateItem1.jsp | `WebContent/view/nhanvienkho/doUpdateItem1.jsp` | `item` (giá trị mới), `oldCounterSaleMode`, `maxAgreedPrice`, `unitsOnShelf`, `confirmed`, `keyword` ← session; kiểm tra 10.1, 10.2, 10.4 tại trang; hộp cảnh báo 10.5, 10.6 với `subCancel` / `subConfirm`; hộp thành công với `subOK` → `UIItemSearch1.jsp?inItemName=<keyword>` |
| ItemDAO1 | `src/dao/ItemDAO1.java` | `getItemsByName(String name, boolean onlyActive)`, `getItemDetail(int idItem)`, `checkDuplicateName(String name, int idItem)` → procedure cùng tên; `updateItem(Item1 item)` → `UPDATE tblItem1` (không cập nhật `hasSerial`) |
| CategoryDAO1, BrandDAO1, UnitOfMeasureDAO1 | `src/dao/...` | `getAllCategories()`, `getAllBrands()`, `getAllUnits()` → procedure cùng tên |
| StockUnitDAO1 | `src/dao/StockUnitDAO1.java` | `getStockQuantity(int idItem)`, `countUnitsOnShelf(int idItem)` → procedure cùng tên |
| SuppliedItemDAO1 | `src/dao/SuppliedItemDAO1.java` | `getMaxAgreedPrice(int idItem)` → procedure cùng tên |

## 4. Bảng đối chiếu module 2 - Đặt hàng trực tuyến

| Lớp thiết kế | File | Thuộc tính / phương thức → cách cài |
|---|---|---|
| UICustomerMain1.jsp | `WebContent/view/khachhang/UICustomerMain1.jsp` | `customer` = session `customer` (chưa có thì tạo khách hàng mẫu id 1 - Nguyễn Văn An, thay cho đăng nhập); `subPlaceOrder` = link Đặt hàng |
| UIOrder1.jsp | `WebContent/view/khachhang/UIOrder1.jsp` | `inItemName`, `subSearch` (trang gọi chính nó); `outCartSummary` = bảng giỏ hàng hiện tại + tạm tính; `subViewCart`, `subHome`; `outMessage` + `outSuggestedItems` (4.1); `cart` → session; `listItem` → session |
| UIItemList1.jsp | `WebContent/view/dungchung/UIItemList1.jsp` | như module 1, `listQuantity` = SL có thể bán; Chọn → `UIAddToCart1.jsp` |
| UIAddToCart1.jsp | `WebContent/view/khachhang/UIAddToCart1.jsp` | `outItemInfo` = bảng thông tin MH; `inQuantity`; `subAddToCart` (trang gọi chính nó kiểm tra 7.1, 7.2); `subBack`; `outMessage`; `item`, `sellableQuantity`, `cart` ← session (chưa có `cart` thì quay về `UIOrder1.jsp`) |
| UICart1.jsp | `WebContent/view/khachhang/UICart1.jsp` | `outsubCartLines` = bảng; `chkSelect` = ô chọn mỗi dòng (đánh dấu sẵn); `inNewQuantity` + `subUpdateLine` (11.1); `subDeleteLine` (11.2); `outTotalAmount` = tổng tiền các dòng được chọn; `inoutDeliveryAddress`, `inoutReceiverPhone` điền sẵn; `subContinue` = Đặt thêm mặt hàng; `subSubmit`; `outMessage`; `customer`, `cart` ← session; `listCartItem` → session |
| doSaveOrder1.jsp | `WebContent/view/khachhang/doSaveOrder1.jsp` | `listCartItem` = các dòng được chọn; kiểm tra 12.1, 13.1, 13.2 (sai thì quay lại `UICart1.jsp` giữ nguyên lựa chọn); đóng gói `OrderDetail1`, `order : OnlineOrder1`; `outMessage` "Lưu đơn hàng thành công. Mã đơn hàng: DH0125"; `subOK` → trang chủ |
| CartDAO1 | `src/dao/CartDAO1.java` | `getActiveCart(int idCustomer)` → procedure; `clearCart(int idCart, ArrayList<CartItem1> listCartItem)` → `DELETE` các dòng đã đặt, giỏ hết dòng thì `status = 'đã đặt hàng'` |
| ItemDAO1 | `src/dao/ItemDAO1.java` | `getItemsByName(..., true)`; `getSuggestedItems(String keyword)` → procedure |
| StockUnitDAO1 | `src/dao/StockUnitDAO1.java` | `getSellableQuantity(int idItem)` → procedure |
| CartItemDAO1 | `src/dao/CartItemDAO1.java` | `addCartItem(Cart1 cart, Item1 item, int quantity)` (giao dịch: tạo giỏ nếu id = 0, cộng dồn 8.1 hoặc thêm dòng); `getCartItems(int idCart)` → procedure; `updateCartItem(CartItem1)`, `deleteCartItem(int)` |
| CustomerDAO1 | `src/dao/CustomerDAO1.java` | `getCustomerInfo(int idCustomer)` → procedure |
| OnlineOrderDAO1 | `src/dao/OnlineOrderDAO1.java` | `saveOrder(OnlineOrder1 order, int idCart, ArrayList<CartItem1> listCartItem)`: một giao dịch gồm thêm đơn (chờ duyệt) → `OrderDetailDAO1.saveOrderDetails()` → `CartDAO1.clearCart()`; lỗi thì rollback |
| OrderDetailDAO1 | `src/dao/OrderDetailDAO1.java` | `saveOrderDetails(int idOrder, ArrayList<OrderDetail1> listDetail)` |

## 5. Cách chạy

### Cách nhanh trên máy này: nhấp đúp `chay_thu.bat`

Script `chay_thu.ps1` dùng MySQL Server 8.0, JDK 21 và Tomcat 8.5 của xampp có sẵn trên máy:
hỏi mật khẩu root của MySQL, nạp lại CSDL `qlst1` (Enter) hoặc giữ dữ liệu cũ (K), biên dịch `model` + `dao`
vào thư mục chạy `%USERPROFILE%\QLST1_chaythu` (bản sao `DAO1.java` ở đó nhận mật khẩu vừa nhập, file gốc giữ nguyên),
bật Tomcat riêng trên cổng 8089 (cổng 8080 đang bị Apache của xampp dùng) rồi mở trình duyệt.
Tắt hệ thống: đóng cửa sổ "QLST1 - Tomcat".

### Cách làm bằng tay (Eclipse / máy khác)

1. Tạo CSDL (MySQL 8): chạy lần lượt `database/qlst1_schema.sql`, `database/qlst1_procedures.sql`,
   `database/qlst1_data.sql` (ví dụ trong MySQL Workbench, hoặc `mysql -u root -p < qlst1_schema.sql` ...).
2. Sửa tài khoản kết nối trong `src/dao/DAO1.java` (`dbUrl`, `"root"`, mật khẩu) cho khớp máy mình.
3. Tạo Dynamic Web Project tên `QLST1` trong Eclipse (hoặc NetBeans), chép `src` và `WebContent` vào,
   chạy trên Tomcat 9 (Java 8 trở lên).
4. Dự án chưa xử lí đăng nhập (use case Login 1 không thuộc hai module). Trang chủ nạp sẵn người dùng mẫu vào
   session (`staff`, `customer`); mở thẳng một trang con khi chưa qua trang chủ thì được chuyển về trang chủ:
   - `http://localhost:8080/QLST1/view/nhanvienkho/UIWarehouseMain1.jsp` - module 1 (nhân viên kho Trần Thị Bình, id 2)
   - `http://localhost:8080/QLST1/view/khachhang/UICustomerMain1.jsp` - module 2 (khách hàng Nguyễn Văn An, id 1)

   Mỗi phiên làm việc chỉ một vai trò: vào trang chủ của vai trò này thì vai trò kia được bỏ khỏi session.

Dữ liệu mẫu theo kịch bản v1.0: tìm "điều hoà" ra MH020 (tồn 12), MH021; giá nhập thoả thuận cao nhất của MH020 là
10.500.000 đ; MH031 (bàn là, hàng tự chọn) còn 5 sản phẩm trên kệ để thử 10.6; tìm "tủ lạnh" ra MH001, MH002, MH003
(có thể bán 15, 8, 5); "tủ đông mini" gợi ý MH030; đơn đầu tiên có mã DH0125.

## 6. Kết quả kiểm thử (đã chạy trên Tomcat 8.5 + MariaDB 10.4, CSDL riêng để thử)

- 30/30 kiểm thử các hàm DAO với số liệu kịch bản; giao dịch `saveOrder()` rollback đúng khi lỗi giữa chừng.
- 49/49 bước kiểm thử qua HTTP: luồng chính hai module và đủ các ngoại lệ 6.1, 10.1 - 10.6 (module 1);
  4.1, 7.1, 7.2, 8.1, 11.1, 11.2, 12.1, 13.1, 13.2 và đặt một phần giỏ hàng (module 2).
- Đối chiếu tự động: 11/11 trang JSP có đủ thuộc tính của Hình 6, Hình 11; 21/21 phương thức DAO đúng tên, tham số,
  kiểu trả về; 42/42 lớp model đúng thuộc tính Hình 2; 35/35 bảng đúng Hình 3.
