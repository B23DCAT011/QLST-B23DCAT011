-- Cac stored procedure duoc cac lop DAO goi ({call ...}), xep theo tung lop DAO.
-- Chay sau qlst1_schema.sql:  mysql -u root -p qlst1 < qlst1_procedures.sql
USE qlst1;

DELIMITER $$

-- ======================================================================
-- Lop ItemDAO1
-- ======================================================================
DROP PROCEDURE IF EXISTS getItemsByName $$
CREATE PROCEDURE getItemsByName(IN keyword VARCHAR(255), IN onlyActive TINYINT(1))
BEGIN
    SELECT i.*, c.name AS categoryName, b.name AS brandName, u.name AS unitName
    FROM tblItem1 i, tblCategory1 c, tblBrand1 b, tblUnitOfMeasure1 u
    WHERE i.name LIKE CONCAT('%', keyword, '%')
      AND (onlyActive = 0 OR i.status = 'đang kinh doanh')
      AND c.id = i.tblCategory1id AND b.id = i.tblBrand1id AND u.id = i.tblUnitOfMeasure1id
    ORDER BY i.id;
END $$

DROP PROCEDURE IF EXISTS getItemDetail $$
CREATE PROCEDURE getItemDetail(IN idItem INT)
BEGIN
    SELECT i.*, c.name AS categoryName, b.name AS brandName, u.name AS unitName
    FROM tblItem1 i, tblCategory1 c, tblBrand1 b, tblUnitOfMeasure1 u
    WHERE i.id = idItem
      AND c.id = i.tblCategory1id AND b.id = i.tblBrand1id AND u.id = i.tblUnitOfMeasure1id;
END $$

DROP PROCEDURE IF EXISTS checkDuplicateName $$
CREATE PROCEDURE checkDuplicateName(IN itemName VARCHAR(255), IN idItem INT)
BEGIN
    SELECT COUNT(*) AS total FROM tblItem1 WHERE name = itemName AND id <> idItem;
END $$

DROP PROCEDURE IF EXISTS getSuggestedItems $$
CREATE PROCEDURE getSuggestedItems(IN keyword VARCHAR(255))
BEGIN
    SELECT i.*, c.name AS categoryName, b.name AS brandName, u.name AS unitName
    FROM tblItem1 i, tblCategory1 c, tblBrand1 b, tblUnitOfMeasure1 u
    WHERE i.status = 'đang kinh doanh'
      AND keyword LIKE CONCAT('%', c.name, '%')
      AND c.id = i.tblCategory1id AND b.id = i.tblBrand1id AND u.id = i.tblUnitOfMeasure1id
    ORDER BY i.id
    LIMIT 5;
END $$

-- ======================================================================
-- Lop CategoryDAO1, BrandDAO1, UnitOfMeasureDAO1
-- ======================================================================
DROP PROCEDURE IF EXISTS getAllCategories $$
CREATE PROCEDURE getAllCategories()
BEGIN
    SELECT * FROM tblCategory1 ORDER BY name;
END $$

DROP PROCEDURE IF EXISTS getAllBrands $$
CREATE PROCEDURE getAllBrands()
BEGIN
    SELECT * FROM tblBrand1 ORDER BY name;
END $$

DROP PROCEDURE IF EXISTS getAllUnits $$
CREATE PROCEDURE getAllUnits()
BEGIN
    SELECT * FROM tblUnitOfMeasure1 ORDER BY name;
END $$

-- ======================================================================
-- Lop StockUnitDAO1 (san pham -> lo hang = dong chi tiet phieu nhap -> mat hang cung cap -> mat hang)
-- ======================================================================
DROP PROCEDURE IF EXISTS getStockQuantity $$
CREATE PROCEDURE getStockQuantity(IN idItem INT)
BEGIN
    SELECT COUNT(*) AS stockQuantity
    FROM tblStockUnit1 su, tblStockReceiptDetail1 rd, tblSuppliedItem1 si
    WHERE rd.id = su.tblStockReceiptDetail1id AND si.id = rd.tblSuppliedItem1id
      AND si.tblItem1id = idItem
      AND su.status IN ('trong kho', 'trên kệ bán');
END $$

DROP PROCEDURE IF EXISTS countUnitsOnShelf $$
CREATE PROCEDURE countUnitsOnShelf(IN idItem INT)
BEGIN
    SELECT COUNT(*) AS unitsOnShelf
    FROM tblStockUnit1 su, tblStockReceiptDetail1 rd, tblSuppliedItem1 si,
         tblStorageLocation1 sl, tblZone1 z
    WHERE rd.id = su.tblStockReceiptDetail1id AND si.id = rd.tblSuppliedItem1id
      AND si.tblItem1id = idItem
      AND su.status = 'trên kệ bán'
      AND sl.id = su.tblStorageLocation1id AND z.id = sl.tblZone1id
      AND z.zoneType = 'kệ tự chọn';
END $$

DROP PROCEDURE IF EXISTS getSellableQuantity $$
CREATE PROCEDURE getSellableQuantity(IN idItem INT)
BEGIN
    SELECT
      (SELECT COUNT(*)
         FROM tblStockUnit1 su, tblStockReceiptDetail1 rd, tblSuppliedItem1 si
        WHERE rd.id = su.tblStockReceiptDetail1id AND si.id = rd.tblSuppliedItem1id
          AND si.tblItem1id = idItem AND su.status IN ('trong kho', 'trên kệ bán'))
    - (SELECT IFNULL(SUM(od.quantity), 0)
         FROM tblOrderDetail1 od, tblOnlineOrder1 o
        WHERE o.id = od.tblOnlineOrder1id AND od.tblItem1id = idItem
          AND o.status = 'đã duyệt')
    - (SELECT IFNULL(SUM(ivd.quantity), 0)
         FROM tblInvoiceDetail1 ivd, tblStockIssueNote1 sin
        WHERE sin.tblInvoice1id = ivd.tblInvoice1id AND ivd.tblItem1id = idItem
          AND ivd.receivingMode = 'giao từ kho' AND sin.status = 'chờ xuất')
      AS sellableQuantity;
END $$

-- ======================================================================
-- Lop SuppliedItemDAO1
-- ======================================================================
DROP PROCEDURE IF EXISTS getMaxAgreedPrice $$
CREATE PROCEDURE getMaxAgreedPrice(IN idItem INT)
BEGIN
    SELECT IFNULL(MAX(si.agreedPrice), 0) AS maxAgreedPrice
    FROM tblSuppliedItem1 si, tblSupplyContract1 sc
    WHERE sc.id = si.tblSupplyContract1id AND si.tblItem1id = idItem
      AND si.status = 'đang cung cấp'
      AND sc.status = 'còn hiệu lực'
      AND sc.effectiveDate <= CURDATE() AND CURDATE() <= sc.expiryDate;
END $$

-- ======================================================================
-- Lop CartDAO1
-- ======================================================================
DROP PROCEDURE IF EXISTS getActiveCart $$
CREATE PROCEDURE getActiveCart(IN idCustomer INT)
BEGIN
    SELECT ca.id AS idCart, ca.createdDate, ca.status,
           ci.id AS idCartItem, ci.quantity, ci.unitPrice,
           i.id AS idItem, i.name AS itemName, i.sellingPrice
    FROM tblCart1 ca
         LEFT JOIN tblCartItem1 ci ON ci.tblCart1id = ca.id
         LEFT JOIN tblItem1 i ON i.id = ci.tblItem1id
    WHERE ca.tblCustomer1id = idCustomer AND ca.status = 'đang dùng'
    ORDER BY ci.id;
END $$

-- ======================================================================
-- Lop CartItemDAO1
-- ======================================================================
DROP PROCEDURE IF EXISTS getCartItems $$
CREATE PROCEDURE getCartItems(IN idCart INT)
BEGIN
    SELECT ci.id, ci.quantity, ci.unitPrice,
           i.id AS idItem, i.name AS itemName, i.sellingPrice, b.name AS brandName
    FROM tblCartItem1 ci, tblItem1 i, tblBrand1 b
    WHERE ci.tblCart1id = idCart AND i.id = ci.tblItem1id AND b.id = i.tblBrand1id
    ORDER BY ci.id;
END $$

-- ======================================================================
-- Lop CustomerDAO1
-- ======================================================================
DROP PROCEDURE IF EXISTS getCustomerInfo $$
CREATE PROCEDURE getCustomerInfo(IN idCustomer INT)
BEGIN
    SELECT m.id, m.familyName, m.middleName, m.givenName, m.dateOfBirth, m.gender,
           m.email, m.phone, m.note, c.registerDate, c.loyaltyPoints,
           a.id AS idAddress, a.houseNumber, a.street, a.ward, a.district, a.province
    FROM tblCustomer1 c
         JOIN tblMember1 m ON m.id = c.tblMember1id
         LEFT JOIN tblAddress1 a ON a.id = m.tblAddress1id
    WHERE c.tblMember1id = idCustomer;
END $$

DELIMITER ;
