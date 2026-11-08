-- Du lieu mau cho CSDL qlst1 (sinh boi tools/gen_data.py). Chay sau qlst1_schema.sql.
USE qlst1;
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO `tblAddress1` (`id`, `houseNumber`, `street`, `ward`, `district`, `province`) VALUES
  (1, 'Số 12', 'ngõ 90 Chiến Thắng', 'phường Văn Quán', 'quận Hà Đông', 'Hà Nội'),
  (2, 'Số 5', 'ngõ 32 Trần Phú', 'phường Mộ Lao', 'quận Hà Đông', 'Hà Nội'),
  (3, 'Số 168', 'đường Nguyễn Trãi', 'phường Thanh Xuân Trung', 'quận Thanh Xuân', 'Hà Nội'),
  (4, 'Số 45', 'đường Phạm Văn Đồng', 'phường Mai Dịch', 'quận Cầu Giấy', 'Hà Nội'),
  (5, 'Lô B2', 'khu công nghiệp Quang Minh', 'thị trấn Quang Minh', 'huyện Mê Linh', 'Hà Nội');

INSERT INTO `tblMember1` (`id`, `username`, `password`, `accountStatus`, `familyName`, `middleName`, `givenName`, `dateOfBirth`, `gender`, `email`, `phone`, `note`, `tblAddress1id`) VALUES
  (1, 'annv', 'e10adc3949ba59abbe56e057f20f883e', 'hoạt động', 'Nguyễn', 'Văn', 'An', '1995-05-20', 'Nam', 'an.nguyenvan@gmail.com', '0912345678', NULL, 1),
  (2, 'binhtt', 'e10adc3949ba59abbe56e057f20f883e', 'hoạt động', 'Trần', 'Thị', 'Bình', '1992-11-02', 'Nữ', 'binh.tranthi@qlst.vn', '0987654321', NULL, 2);

INSERT INTO `tblCustomer1` (`tblMember1id`, `registerDate`, `loyaltyPoints`) VALUES
  (1, '2025-03-10', 120);

INSERT INTO `tblEmployee1` (`tblMember1id`, `position`, `hireDate`) VALUES
  (2, 'kho', '2022-08-01');

INSERT INTO `tblWarehouseStaff1` (`tblEmployee1id`, `tblZone1id`) VALUES
  (2, 1);

INSERT INTO `tblSupermarket1` (`id`, `name`, `phone`, `description`, `tblAddress1id`) VALUES
  (1, 'Siêu thị điện máy QLST', '02435561234', NULL, 3);

INSERT INTO `tblWarehouse1` (`id`, `name`, `area`, `description`, `tblSupermarket1id`) VALUES
  (1, 'Kho hàng QLST', 1200, NULL, 1);

INSERT INTO `tblSalesFloor1` (`id`, `name`, `area`, `description`, `tblSupermarket1id`) VALUES
  (1, 'Sàn bán hàng QLST', 2500, NULL, 1);

INSERT INTO `tblZone1` (`id`, `name`, `zoneType`, `storageCondition`, `status`, `description`, `tblWarehouse1id`, `tblSalesFloor1id`) VALUES
  (1, 'Khu lưu trữ A', 'lưu trữ', 'Khô ráo, thoáng mát', 'hoạt động', NULL, 1, NULL),
  (2, 'Khu hàng lỗi', 'hàng lỗi', NULL, 'hoạt động', NULL, 1, NULL),
  (3, 'Kệ tự chọn 1', 'kệ tự chọn', NULL, 'hoạt động', NULL, NULL, 1),
  (4, 'Khu trưng bày', 'trưng bày', NULL, 'hoạt động', NULL, NULL, 1);

INSERT INTO `tblStorageLocation1` (`id`, `row`, `rack`, `level`, `capacity`, `maxLoad`, `status`, `tblZone1id`) VALUES
  (1, 'A', '01', 1, 40, 2000, 'đang chứa', 1),
  (2, 'A', '01', 2, 40, 2000, 'đang chứa', 1),
  (3, 'A', '02', 1, 40, 2000, 'đang chứa', 1),
  (4, 'A', '02', 2, 40, 2000, 'đang chứa', 1),
  (5, 'K', '01', 1, 30, 200, 'đang chứa', 3);

INSERT INTO `tblCategory1` (`id`, `name`, `description`) VALUES
  (1, 'Tủ lạnh', NULL),
  (2, 'Máy giặt', NULL),
  (3, 'Điều hoà', NULL),
  (4, 'Tủ đông', NULL),
  (5, 'Bàn là', NULL);

INSERT INTO `tblBrand1` (`id`, `name`, `country`, `description`) VALUES
  (1, 'Samsung', 'Hàn Quốc', NULL),
  (2, 'Panasonic', 'Nhật Bản', NULL),
  (3, 'LG', 'Hàn Quốc', NULL),
  (4, 'Daikin', 'Nhật Bản', NULL),
  (5, 'Sanaky', 'Việt Nam', NULL),
  (6, 'Philips', 'Hà Lan', NULL);

INSERT INTO `tblUnitOfMeasure1` (`id`, `name`) VALUES
  (1, 'Chiếc');

INSERT INTO `tblItem1` (`id`, `name`, `sellingPrice`, `warrantyPeriod`, `hasSerial`, `counterSaleMode`, `minShelfQuantity`, `description`, `image`, `status`, `tblCategory1id`, `tblBrand1id`, `tblUnitOfMeasure1id`) VALUES
  (1, 'Tủ lạnh Samsung Inverter 236 lít RT22M4032BY', 6490000, 24, 1, 'giao từ kho', NULL, NULL, NULL, 'đang kinh doanh', 1, 1, 1),
  (2, 'Tủ lạnh Panasonic Inverter 255 lít NR-BV280QSVN', 8190000, 24, 1, 'giao từ kho', NULL, NULL, NULL, 'đang kinh doanh', 1, 2, 1),
  (3, 'Tủ lạnh LG Inverter 335 lít GN-M332PS', 9990000, 24, 1, 'giao từ kho', NULL, NULL, NULL, 'đang kinh doanh', 1, 3, 1),
  (10, 'Máy giặt LG Inverter 9 kg FV1409S4W', 7490000, 24, 1, 'giao từ kho', NULL, NULL, NULL, 'đang kinh doanh', 2, 3, 1),
  (20, 'Điều hoà Daikin Inverter 9000 BTU FTKB25WAVMV', 12490000, 12, 1, 'giao từ kho', 2, 'Điều hoà 1 chiều, công nghệ Inverter, công suất 9000 BTU, phù hợp phòng dưới 15 m².', 'daikin-ftkb25wavmv.jpg', 'đang kinh doanh', 3, 4, 1),
  (21, 'Điều hoà LG Inverter 12000 BTU V13ENH1', 13990000, 12, 1, 'giao từ kho', NULL, NULL, NULL, 'đang kinh doanh', 3, 3, 1),
  (30, 'Tủ đông Sanaky Inverter 280 lít VH-4099W4K', 8990000, 24, 1, 'giao từ kho', NULL, NULL, NULL, 'đang kinh doanh', 4, 5, 1),
  (31, 'Bàn là hơi nước Philips GC1756', 590000, 24, 0, 'tự chọn trên kệ', 3, NULL, NULL, 'đang kinh doanh', 5, 6, 1);

INSERT INTO `tblSupplier1` (`id`, `name`, `phone`, `email`, `contactPerson`, `status`, `description`, `tblAddress1id`) VALUES
  (1, 'Công ty TNHH Điện máy Hưng Phát', '02437931234', 'kinhdoanh@hungphat.vn', 'Lê Văn Hùng', 'đang hợp tác', NULL, 4),
  (2, 'Công ty CP Thiết bị Nhiệt lạnh An Khang', '02438181234', 'sales@ankhang.vn', 'Phạm Thị Hoa', 'đang hợp tác', NULL, 5);

INSERT INTO `tblSupplyContract1` (`id`, `signDate`, `effectiveDate`, `expiryDate`, `paymentTerm`, `status`, `terminationReason`, `tblSupplier1id`) VALUES
  (1, '2026-01-05', '2026-01-15', '2027-01-14', 'Thanh toán trong 30 ngày', 'còn hiệu lực', NULL, 1),
  (2, '2026-02-20', '2026-03-01', '2027-02-28', 'Thanh toán trong 45 ngày', 'còn hiệu lực', NULL, 2);

INSERT INTO `tblSuppliedItem1` (`id`, `supplierItemCode`, `agreedPrice`, `minOrderQuantity`, `leadTime`, `supplierWarranty`, `status`, `tblSupplyContract1id`, `tblItem1id`) VALUES
  (1, 'NCC1-001', 5600000, 5, 7, 12, 'đang cung cấp', 1, 1),
  (2, 'NCC1-002', 7000000, 5, 7, 12, 'đang cung cấp', 1, 2),
  (3, 'NCC1-003', 8500000, 5, 7, 12, 'đang cung cấp', 1, 3),
  (4, 'NCC1-010', 6300000, 5, 7, 12, 'đang cung cấp', 1, 10),
  (5, 'NCC1-020', 10200000, 5, 7, 12, 'đang cung cấp', 1, 20),
  (6, 'NCC1-021', 11800000, 5, 7, 12, 'đang cung cấp', 1, 21),
  (7, 'NCC1-030', 7600000, 5, 7, 12, 'đang cung cấp', 1, 30),
  (8, 'NCC1-031', 420000, 5, 7, 12, 'đang cung cấp', 1, 31),
  (9, 'NCC2-020', 10500000, 5, 7, 12, 'đang cung cấp', 2, 20);

INSERT INTO `tblStockReceiptNote1` (`id`, `receiptDate`, `note`, `tblSupplyContract1id`, `tblWarehouseStaff1id`) VALUES
  (1, '2026-08-10', NULL, 1, 2),
  (2, '2026-09-02', NULL, 2, 2);

INSERT INTO `tblStockReceiptDetail1` (`id`, `receivedQuantity`, `defectQuantity`, `unitPrice`, `priceDifferenceReason`, `tblStockReceiptNote1id`, `tblSuppliedItem1id`) VALUES
  (1, 15, 0, 5600000, NULL, 1, 1),
  (2, 8, 0, 7000000, NULL, 1, 2),
  (3, 5, 0, 8500000, NULL, 1, 3),
  (4, 10, 0, 6300000, NULL, 1, 4),
  (5, 7, 0, 10200000, NULL, 1, 5),
  (6, 7, 0, 11800000, NULL, 1, 6),
  (7, 6, 0, 7600000, NULL, 1, 7),
  (8, 15, 0, 420000, NULL, 1, 8),
  (9, 5, 0, 10500000, NULL, 2, 9);

INSERT INTO `tblStockUnit1` (`id`, `internalCode`, `serialNumber`, `status`, `tblStockReceiptDetail1id`, `tblStorageLocation1id`, `tblInvoiceDetail1id`) VALUES
  (1, 'SP-000001', 'SN0100001', 'trong kho', 1, 1, NULL),
  (2, 'SP-000002', 'SN0100002', 'trong kho', 1, 1, NULL),
  (3, 'SP-000003', 'SN0100003', 'trong kho', 1, 1, NULL),
  (4, 'SP-000004', 'SN0100004', 'trong kho', 1, 1, NULL),
  (5, 'SP-000005', 'SN0100005', 'trong kho', 1, 1, NULL),
  (6, 'SP-000006', 'SN0100006', 'trong kho', 1, 1, NULL),
  (7, 'SP-000007', 'SN0100007', 'trong kho', 1, 1, NULL),
  (8, 'SP-000008', 'SN0100008', 'trong kho', 1, 1, NULL),
  (9, 'SP-000009', 'SN0100009', 'trong kho', 1, 1, NULL),
  (10, 'SP-000010', 'SN0100010', 'trong kho', 1, 1, NULL),
  (11, 'SP-000011', 'SN0100011', 'trong kho', 1, 1, NULL),
  (12, 'SP-000012', 'SN0100012', 'trong kho', 1, 1, NULL),
  (13, 'SP-000013', 'SN0100013', 'trong kho', 1, 1, NULL),
  (14, 'SP-000014', 'SN0100014', 'trong kho', 1, 1, NULL),
  (15, 'SP-000015', 'SN0100015', 'trong kho', 1, 1, NULL),
  (16, 'SP-000016', 'SN0200016', 'trong kho', 2, 1, NULL),
  (17, 'SP-000017', 'SN0200017', 'trong kho', 2, 1, NULL),
  (18, 'SP-000018', 'SN0200018', 'trong kho', 2, 1, NULL),
  (19, 'SP-000019', 'SN0200019', 'trong kho', 2, 1, NULL),
  (20, 'SP-000020', 'SN0200020', 'trong kho', 2, 1, NULL),
  (21, 'SP-000021', 'SN0200021', 'trong kho', 2, 1, NULL),
  (22, 'SP-000022', 'SN0200022', 'trong kho', 2, 1, NULL),
  (23, 'SP-000023', 'SN0200023', 'trong kho', 2, 1, NULL),
  (24, 'SP-000024', 'SN0300024', 'trong kho', 3, 2, NULL),
  (25, 'SP-000025', 'SN0300025', 'trong kho', 3, 2, NULL),
  (26, 'SP-000026', 'SN0300026', 'trong kho', 3, 2, NULL),
  (27, 'SP-000027', 'SN0300027', 'trong kho', 3, 2, NULL),
  (28, 'SP-000028', 'SN0300028', 'trong kho', 3, 2, NULL),
  (29, 'SP-000029', 'SN1000029', 'trong kho', 4, 2, NULL),
  (30, 'SP-000030', 'SN1000030', 'trong kho', 4, 2, NULL),
  (31, 'SP-000031', 'SN1000031', 'trong kho', 4, 2, NULL),
  (32, 'SP-000032', 'SN1000032', 'trong kho', 4, 2, NULL),
  (33, 'SP-000033', 'SN1000033', 'trong kho', 4, 2, NULL),
  (34, 'SP-000034', 'SN1000034', 'trong kho', 4, 2, NULL),
  (35, 'SP-000035', 'SN1000035', 'trong kho', 4, 2, NULL),
  (36, 'SP-000036', 'SN1000036', 'trong kho', 4, 2, NULL),
  (37, 'SP-000037', 'SN1000037', 'trong kho', 4, 2, NULL),
  (38, 'SP-000038', 'SN1000038', 'trong kho', 4, 2, NULL),
  (39, 'SP-000039', 'SN2000039', 'trong kho', 5, 3, NULL),
  (40, 'SP-000040', 'SN2000040', 'trong kho', 5, 3, NULL),
  (41, 'SP-000041', 'SN2000041', 'trong kho', 5, 3, NULL),
  (42, 'SP-000042', 'SN2000042', 'trong kho', 5, 3, NULL),
  (43, 'SP-000043', 'SN2000043', 'trong kho', 5, 3, NULL),
  (44, 'SP-000044', 'SN2000044', 'trong kho', 5, 3, NULL),
  (45, 'SP-000045', 'SN2000045', 'trong kho', 5, 3, NULL),
  (46, 'SP-000046', 'SN2100046', 'trong kho', 6, 3, NULL),
  (47, 'SP-000047', 'SN2100047', 'trong kho', 6, 3, NULL),
  (48, 'SP-000048', 'SN2100048', 'trong kho', 6, 3, NULL),
  (49, 'SP-000049', 'SN2100049', 'trong kho', 6, 3, NULL),
  (50, 'SP-000050', 'SN2100050', 'trong kho', 6, 3, NULL),
  (51, 'SP-000051', 'SN2100051', 'trong kho', 6, 3, NULL),
  (52, 'SP-000052', 'SN2100052', 'trong kho', 6, 3, NULL),
  (53, 'SP-000053', 'SN3000053', 'trong kho', 7, 4, NULL),
  (54, 'SP-000054', 'SN3000054', 'trong kho', 7, 4, NULL),
  (55, 'SP-000055', 'SN3000055', 'trong kho', 7, 4, NULL),
  (56, 'SP-000056', 'SN3000056', 'trong kho', 7, 4, NULL),
  (57, 'SP-000057', 'SN3000057', 'trong kho', 7, 4, NULL),
  (58, 'SP-000058', 'SN3000058', 'trong kho', 7, 4, NULL),
  (59, 'SP-000059', NULL, 'trên kệ bán', 8, 5, NULL),
  (60, 'SP-000060', NULL, 'trên kệ bán', 8, 5, NULL),
  (61, 'SP-000061', NULL, 'trên kệ bán', 8, 5, NULL),
  (62, 'SP-000062', NULL, 'trên kệ bán', 8, 5, NULL),
  (63, 'SP-000063', NULL, 'trên kệ bán', 8, 5, NULL),
  (64, 'SP-000064', NULL, 'trong kho', 8, 4, NULL),
  (65, 'SP-000065', NULL, 'trong kho', 8, 4, NULL),
  (66, 'SP-000066', NULL, 'trong kho', 8, 4, NULL),
  (67, 'SP-000067', NULL, 'trong kho', 8, 4, NULL),
  (68, 'SP-000068', NULL, 'trong kho', 8, 4, NULL),
  (69, 'SP-000069', NULL, 'trong kho', 8, 4, NULL),
  (70, 'SP-000070', NULL, 'trong kho', 8, 4, NULL),
  (71, 'SP-000071', NULL, 'trong kho', 8, 4, NULL),
  (72, 'SP-000072', NULL, 'trong kho', 8, 4, NULL),
  (73, 'SP-000073', NULL, 'trong kho', 8, 4, NULL),
  (74, 'SP-000074', 'SN2000074', 'trong kho', 9, 3, NULL),
  (75, 'SP-000075', 'SN2000075', 'trong kho', 9, 3, NULL),
  (76, 'SP-000076', 'SN2000076', 'trong kho', 9, 3, NULL),
  (77, 'SP-000077', 'SN2000077', 'trong kho', 9, 3, NULL),
  (78, 'SP-000078', 'SN2000078', 'trong kho', 9, 3, NULL);

-- don dat hang truc tuyen tiep theo co ma DH0125
ALTER TABLE `tblOnlineOrder1` AUTO_INCREMENT = 125;
SET FOREIGN_KEY_CHECKS = 1;
