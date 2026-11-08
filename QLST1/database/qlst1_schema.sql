-- CSDL qlst1 cua he thong QLST (35 bang), sinh tu bieu do thiet ke CSDL (Hinh 3, bai tap 3).
-- Quy uoc: PK = khoa chinh, FK = khoa ngoai, U = gia tri duy nhat, N = cho phep NULL.
DROP DATABASE IF EXISTS qlst1;
CREATE DATABASE qlst1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE qlst1;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `tblAddress1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `houseNumber` VARCHAR(255) NOT NULL,
  `street` VARCHAR(255) NOT NULL,
  `ward` VARCHAR(255) NOT NULL,
  `district` VARCHAR(255) NOT NULL,
  `province` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblMember1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `accountStatus` VARCHAR(50) NOT NULL,
  `familyName` VARCHAR(255) NOT NULL,
  `middleName` VARCHAR(255) NULL,
  `givenName` VARCHAR(255) NOT NULL,
  `dateOfBirth` DATE NULL,
  `gender` VARCHAR(10) NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `note` VARCHAR(255) NULL,
  `tblAddress1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblMember1_username` (`username`),
  UNIQUE KEY `uq_tblMember1_email` (`email`),
  UNIQUE KEY `uq_tblMember1_phone` (`phone`),
  CONSTRAINT `fk_tblMember1_tblAddress1id` FOREIGN KEY (`tblAddress1id`) REFERENCES `tblAddress1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblCustomer1` (
  `tblMember1id` INT(10) NOT NULL,
  `registerDate` DATE NOT NULL,
  `loyaltyPoints` INT(10) NOT NULL,
  PRIMARY KEY (`tblMember1id`),
  CONSTRAINT `fk_tblCustomer1_tblMember1id` FOREIGN KEY (`tblMember1id`) REFERENCES `tblMember1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblEmployee1` (
  `tblMember1id` INT(10) NOT NULL,
  `position` VARCHAR(50) NOT NULL,
  `hireDate` DATE NOT NULL,
  PRIMARY KEY (`tblMember1id`),
  CONSTRAINT `fk_tblEmployee1_tblMember1id` FOREIGN KEY (`tblMember1id`) REFERENCES `tblMember1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblWarehouseStaff1` (
  `tblEmployee1id` INT(10) NOT NULL,
  `tblZone1id` INT(10) NOT NULL,
  PRIMARY KEY (`tblEmployee1id`),
  CONSTRAINT `fk_tblWarehouseStaff1_tblEmployee1id` FOREIGN KEY (`tblEmployee1id`) REFERENCES `tblEmployee1` (`tblMember1id`),
  CONSTRAINT `fk_tblWarehouseStaff1_tblZone1id` FOREIGN KEY (`tblZone1id`) REFERENCES `tblZone1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblSalesperson1` (
  `tblEmployee1id` INT(10) NOT NULL,
  `tblCounter1id` INT(10) NOT NULL,
  PRIMARY KEY (`tblEmployee1id`),
  CONSTRAINT `fk_tblSalesperson1_tblEmployee1id` FOREIGN KEY (`tblEmployee1id`) REFERENCES `tblEmployee1` (`tblMember1id`),
  CONSTRAINT `fk_tblSalesperson1_tblCounter1id` FOREIGN KEY (`tblCounter1id`) REFERENCES `tblCounter1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblShipper1` (
  `tblEmployee1id` INT(10) NOT NULL,
  `licensePlate` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`tblEmployee1id`),
  CONSTRAINT `fk_tblShipper1_tblEmployee1id` FOREIGN KEY (`tblEmployee1id`) REFERENCES `tblEmployee1` (`tblMember1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblSupermarket1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `description` VARCHAR(255) NULL,
  `tblAddress1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblSupermarket1_tblAddress1id` FOREIGN KEY (`tblAddress1id`) REFERENCES `tblAddress1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblWarehouse1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `area` FLOAT NOT NULL,
  `description` VARCHAR(255) NULL,
  `tblSupermarket1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblWarehouse1_tblSupermarket1id` (`tblSupermarket1id`),
  CONSTRAINT `fk_tblWarehouse1_tblSupermarket1id` FOREIGN KEY (`tblSupermarket1id`) REFERENCES `tblSupermarket1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblSalesFloor1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `area` FLOAT NOT NULL,
  `description` VARCHAR(255) NULL,
  `tblSupermarket1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblSalesFloor1_tblSupermarket1id` (`tblSupermarket1id`),
  CONSTRAINT `fk_tblSalesFloor1_tblSupermarket1id` FOREIGN KEY (`tblSupermarket1id`) REFERENCES `tblSupermarket1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblCounter1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  `tblSalesFloor1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblCounter1_tblSalesFloor1id` FOREIGN KEY (`tblSalesFloor1id`) REFERENCES `tblSalesFloor1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblZone1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `zoneType` VARCHAR(50) NOT NULL,
  `storageCondition` VARCHAR(255) NULL,
  `status` VARCHAR(50) NOT NULL,
  `description` VARCHAR(255) NULL,
  `tblWarehouse1id` INT(10) NULL,
  `tblSalesFloor1id` INT(10) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblZone1_tblWarehouse1id` FOREIGN KEY (`tblWarehouse1id`) REFERENCES `tblWarehouse1` (`id`),
  CONSTRAINT `fk_tblZone1_tblSalesFloor1id` FOREIGN KEY (`tblSalesFloor1id`) REFERENCES `tblSalesFloor1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStorageLocation1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `row` VARCHAR(10) NOT NULL,
  `rack` VARCHAR(10) NOT NULL,
  `level` INT(10) NOT NULL,
  `capacity` INT(10) NOT NULL,
  `maxLoad` FLOAT NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `tblZone1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblStorageLocation1_tblZone1id` FOREIGN KEY (`tblZone1id`) REFERENCES `tblZone1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblCategory1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblCategory1_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblBrand1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `country` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblBrand1_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblUnitOfMeasure1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblUnitOfMeasure1_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblItem1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `sellingPrice` FLOAT NOT NULL,
  `warrantyPeriod` INT(10) NOT NULL,
  `hasSerial` TINYINT(1) NOT NULL,
  `counterSaleMode` VARCHAR(50) NOT NULL,
  `minShelfQuantity` INT(10) NULL,
  `description` VARCHAR(1000) NULL,
  `image` VARCHAR(255) NULL,
  `status` VARCHAR(50) NOT NULL,
  `tblCategory1id` INT(10) NOT NULL,
  `tblBrand1id` INT(10) NOT NULL,
  `tblUnitOfMeasure1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblItem1_name` (`name`),
  CONSTRAINT `fk_tblItem1_tblCategory1id` FOREIGN KEY (`tblCategory1id`) REFERENCES `tblCategory1` (`id`),
  CONSTRAINT `fk_tblItem1_tblBrand1id` FOREIGN KEY (`tblBrand1id`) REFERENCES `tblBrand1` (`id`),
  CONSTRAINT `fk_tblItem1_tblUnitOfMeasure1id` FOREIGN KEY (`tblUnitOfMeasure1id`) REFERENCES `tblUnitOfMeasure1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblSupplier1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `contactPerson` VARCHAR(255) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `description` VARCHAR(255) NULL,
  `tblAddress1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblSupplier1_name` (`name`),
  CONSTRAINT `fk_tblSupplier1_tblAddress1id` FOREIGN KEY (`tblAddress1id`) REFERENCES `tblAddress1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblSupplyContract1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `signDate` DATE NOT NULL,
  `effectiveDate` DATE NOT NULL,
  `expiryDate` DATE NOT NULL,
  `paymentTerm` VARCHAR(255) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `terminationReason` VARCHAR(255) NULL,
  `tblSupplier1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblSupplyContract1_tblSupplier1id` FOREIGN KEY (`tblSupplier1id`) REFERENCES `tblSupplier1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblSuppliedItem1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `supplierItemCode` VARCHAR(50) NOT NULL,
  `agreedPrice` FLOAT NOT NULL,
  `minOrderQuantity` INT(10) NOT NULL,
  `leadTime` INT(10) NOT NULL,
  `supplierWarranty` INT(10) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `tblSupplyContract1id` INT(10) NOT NULL,
  `tblItem1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblSuppliedItem1_tblSupplyContract1id` FOREIGN KEY (`tblSupplyContract1id`) REFERENCES `tblSupplyContract1` (`id`),
  CONSTRAINT `fk_tblSuppliedItem1_tblItem1id` FOREIGN KEY (`tblItem1id`) REFERENCES `tblItem1` (`id`),
  UNIQUE KEY `uq_tblSuppliedItem1_cap` (`tblSupplyContract1id`, `tblItem1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStockReceiptNote1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `receiptDate` DATE NOT NULL,
  `note` VARCHAR(255) NULL,
  `tblSupplyContract1id` INT(10) NOT NULL,
  `tblWarehouseStaff1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblStockReceiptNote1_tblSupplyContract1id` FOREIGN KEY (`tblSupplyContract1id`) REFERENCES `tblSupplyContract1` (`id`),
  CONSTRAINT `fk_tblStockReceiptNote1_tblWarehouseStaff1id` FOREIGN KEY (`tblWarehouseStaff1id`) REFERENCES `tblWarehouseStaff1` (`tblEmployee1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStockReceiptDetail1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `receivedQuantity` INT(10) NOT NULL,
  `defectQuantity` INT(10) NOT NULL,
  `unitPrice` FLOAT NOT NULL,
  `priceDifferenceReason` VARCHAR(255) NULL,
  `tblStockReceiptNote1id` INT(10) NOT NULL,
  `tblSuppliedItem1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblStockReceiptDetail1_tblStockReceiptNote1id` FOREIGN KEY (`tblStockReceiptNote1id`) REFERENCES `tblStockReceiptNote1` (`id`),
  CONSTRAINT `fk_tblStockReceiptDetail1_tblSuppliedItem1id` FOREIGN KEY (`tblSuppliedItem1id`) REFERENCES `tblSuppliedItem1` (`id`),
  UNIQUE KEY `uq_tblStockReceiptDetail1_cap` (`tblStockReceiptNote1id`, `tblSuppliedItem1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStockUnit1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `internalCode` VARCHAR(50) NOT NULL,
  `serialNumber` VARCHAR(100) NULL,
  `status` VARCHAR(50) NOT NULL,
  `tblStockReceiptDetail1id` INT(10) NOT NULL,
  `tblStorageLocation1id` INT(10) NULL,
  `tblInvoiceDetail1id` INT(10) NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblStockUnit1_internalCode` (`internalCode`),
  CONSTRAINT `fk_tblStockUnit1_tblStockReceiptDetail1id` FOREIGN KEY (`tblStockReceiptDetail1id`) REFERENCES `tblStockReceiptDetail1` (`id`),
  CONSTRAINT `fk_tblStockUnit1_tblStorageLocation1id` FOREIGN KEY (`tblStorageLocation1id`) REFERENCES `tblStorageLocation1` (`id`),
  CONSTRAINT `fk_tblStockUnit1_tblInvoiceDetail1id` FOREIGN KEY (`tblInvoiceDetail1id`) REFERENCES `tblInvoiceDetail1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblCart1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `createdDate` DATE NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `tblCustomer1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblCart1_tblCustomer1id` FOREIGN KEY (`tblCustomer1id`) REFERENCES `tblCustomer1` (`tblMember1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblCartItem1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `quantity` INT(10) NOT NULL,
  `unitPrice` FLOAT NOT NULL,
  `tblCart1id` INT(10) NOT NULL,
  `tblItem1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblCartItem1_tblCart1id` FOREIGN KEY (`tblCart1id`) REFERENCES `tblCart1` (`id`),
  CONSTRAINT `fk_tblCartItem1_tblItem1id` FOREIGN KEY (`tblItem1id`) REFERENCES `tblItem1` (`id`),
  UNIQUE KEY `uq_tblCartItem1_cap` (`tblCart1id`, `tblItem1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblOnlineOrder1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `orderDate` DATE NOT NULL,
  `deliveryAddress` VARCHAR(255) NOT NULL,
  `receiverPhone` VARCHAR(15) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `approvalDate` DATE NULL,
  `reason` VARCHAR(255) NULL,
  `tblCustomer1id` INT(10) NOT NULL,
  `tblWarehouseStaff1id` INT(10) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblOnlineOrder1_tblCustomer1id` FOREIGN KEY (`tblCustomer1id`) REFERENCES `tblCustomer1` (`tblMember1id`),
  CONSTRAINT `fk_tblOnlineOrder1_tblWarehouseStaff1id` FOREIGN KEY (`tblWarehouseStaff1id`) REFERENCES `tblWarehouseStaff1` (`tblEmployee1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblOrderDetail1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `quantity` INT(10) NOT NULL,
  `unitPrice` FLOAT NOT NULL,
  `tblOnlineOrder1id` INT(10) NOT NULL,
  `tblItem1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblOrderDetail1_tblOnlineOrder1id` FOREIGN KEY (`tblOnlineOrder1id`) REFERENCES `tblOnlineOrder1` (`id`),
  CONSTRAINT `fk_tblOrderDetail1_tblItem1id` FOREIGN KEY (`tblItem1id`) REFERENCES `tblItem1` (`id`),
  UNIQUE KEY `uq_tblOrderDetail1_cap` (`tblOnlineOrder1id`, `tblItem1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblInvoice1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `issueDate` DATE NOT NULL,
  `salesChannel` VARCHAR(50) NOT NULL,
  `buyerName` VARCHAR(255) NULL,
  `buyerPhone` VARCHAR(15) NULL,
  `paymentMethod` VARCHAR(50) NOT NULL,
  `tblOnlineOrder1id` INT(10) NULL,
  `tblCustomer1id` INT(10) NULL,
  `tblSalesperson1id` INT(10) NULL,
  `tblCounter1id` INT(10) NULL,
  `tblWarehouseStaff1id` INT(10) NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tblInvoice1_tblOnlineOrder1id` (`tblOnlineOrder1id`),
  CONSTRAINT `fk_tblInvoice1_tblOnlineOrder1id` FOREIGN KEY (`tblOnlineOrder1id`) REFERENCES `tblOnlineOrder1` (`id`),
  CONSTRAINT `fk_tblInvoice1_tblCustomer1id` FOREIGN KEY (`tblCustomer1id`) REFERENCES `tblCustomer1` (`tblMember1id`),
  CONSTRAINT `fk_tblInvoice1_tblSalesperson1id` FOREIGN KEY (`tblSalesperson1id`) REFERENCES `tblSalesperson1` (`tblEmployee1id`),
  CONSTRAINT `fk_tblInvoice1_tblCounter1id` FOREIGN KEY (`tblCounter1id`) REFERENCES `tblCounter1` (`id`),
  CONSTRAINT `fk_tblInvoice1_tblWarehouseStaff1id` FOREIGN KEY (`tblWarehouseStaff1id`) REFERENCES `tblWarehouseStaff1` (`tblEmployee1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblInvoiceDetail1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `receivingMode` VARCHAR(50) NOT NULL,
  `quantity` INT(10) NOT NULL,
  `unitPrice` FLOAT NOT NULL,
  `tblInvoice1id` INT(10) NOT NULL,
  `tblItem1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblInvoiceDetail1_tblInvoice1id` FOREIGN KEY (`tblInvoice1id`) REFERENCES `tblInvoice1` (`id`),
  CONSTRAINT `fk_tblInvoiceDetail1_tblItem1id` FOREIGN KEY (`tblItem1id`) REFERENCES `tblItem1` (`id`),
  UNIQUE KEY `uq_tblInvoiceDetail1_cap` (`tblInvoice1id`, `tblItem1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStockIssueNote1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `issueType` VARCHAR(50) NOT NULL,
  `issueDate` DATE NOT NULL,
  `reason` VARCHAR(255) NULL,
  `status` VARCHAR(50) NOT NULL,
  `deliveryConfirmDate` DATE NULL,
  `tblWarehouseStaff1id` INT(10) NOT NULL,
  `tblShipper1id` INT(10) NULL,
  `tblOnlineOrder1id` INT(10) NULL,
  `tblInvoice1id` INT(10) NULL,
  `tblSupplyContract1id` INT(10) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblStockIssueNote1_tblWarehouseStaff1id` FOREIGN KEY (`tblWarehouseStaff1id`) REFERENCES `tblWarehouseStaff1` (`tblEmployee1id`),
  CONSTRAINT `fk_tblStockIssueNote1_tblShipper1id` FOREIGN KEY (`tblShipper1id`) REFERENCES `tblShipper1` (`tblEmployee1id`),
  UNIQUE KEY `uq_tblStockIssueNote1_tblOnlineOrder1id` (`tblOnlineOrder1id`),
  CONSTRAINT `fk_tblStockIssueNote1_tblOnlineOrder1id` FOREIGN KEY (`tblOnlineOrder1id`) REFERENCES `tblOnlineOrder1` (`id`),
  UNIQUE KEY `uq_tblStockIssueNote1_tblInvoice1id` (`tblInvoice1id`),
  CONSTRAINT `fk_tblStockIssueNote1_tblInvoice1id` FOREIGN KEY (`tblInvoice1id`) REFERENCES `tblInvoice1` (`id`),
  CONSTRAINT `fk_tblStockIssueNote1_tblSupplyContract1id` FOREIGN KEY (`tblSupplyContract1id`) REFERENCES `tblSupplyContract1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStockIssueDetail1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `tblStockIssueNote1id` INT(10) NOT NULL,
  `tblStockUnit1id` INT(10) NOT NULL,
  `tblStorageLocation1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblStockIssueDetail1_tblStockIssueNote1id` FOREIGN KEY (`tblStockIssueNote1id`) REFERENCES `tblStockIssueNote1` (`id`),
  CONSTRAINT `fk_tblStockIssueDetail1_tblStockUnit1id` FOREIGN KEY (`tblStockUnit1id`) REFERENCES `tblStockUnit1` (`id`),
  CONSTRAINT `fk_tblStockIssueDetail1_tblStorageLocation1id` FOREIGN KEY (`tblStorageLocation1id`) REFERENCES `tblStorageLocation1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStockTransferNote1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `transferDate` DATE NOT NULL,
  `purpose` VARCHAR(50) NOT NULL,
  `note` VARCHAR(255) NULL,
  `tblWarehouseStaff1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblStockTransferNote1_tblWarehouseStaff1id` FOREIGN KEY (`tblWarehouseStaff1id`) REFERENCES `tblWarehouseStaff1` (`tblEmployee1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStockTransferDetail1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `defectDescription` VARCHAR(255) NULL,
  `tblStockTransferNote1id` INT(10) NOT NULL,
  `tblStockUnit1id` INT(10) NOT NULL,
  `fromStorageLocation1id` INT(10) NOT NULL,
  `toStorageLocation1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblStockTransferDetail1_tblStockTransferNote1id` FOREIGN KEY (`tblStockTransferNote1id`) REFERENCES `tblStockTransferNote1` (`id`),
  CONSTRAINT `fk_tblStockTransferDetail1_tblStockUnit1id` FOREIGN KEY (`tblStockUnit1id`) REFERENCES `tblStockUnit1` (`id`),
  CONSTRAINT `fk_tblStockTransferDetail1_fromStorageLocation1id` FOREIGN KEY (`fromStorageLocation1id`) REFERENCES `tblStorageLocation1` (`id`),
  CONSTRAINT `fk_tblStockTransferDetail1_toStorageLocation1id` FOREIGN KEY (`toStorageLocation1id`) REFERENCES `tblStorageLocation1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStocktakingSheet1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `startDate` DATE NOT NULL,
  `closeDate` DATE NULL,
  `status` VARCHAR(50) NOT NULL,
  `note` VARCHAR(255) NULL,
  `tblZone1id` INT(10) NOT NULL,
  `tblWarehouseStaff1id` INT(10) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblStocktakingSheet1_tblZone1id` FOREIGN KEY (`tblZone1id`) REFERENCES `tblZone1` (`id`),
  CONSTRAINT `fk_tblStocktakingSheet1_tblWarehouseStaff1id` FOREIGN KEY (`tblWarehouseStaff1id`) REFERENCES `tblWarehouseStaff1` (`tblEmployee1id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tblStocktakingDetail1` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `result` VARCHAR(50) NOT NULL,
  `differenceReason` VARCHAR(255) NULL,
  `tblStocktakingSheet1id` INT(10) NOT NULL,
  `tblStorageLocation1id` INT(10) NOT NULL,
  `tblStockUnit1id` INT(10) NULL,
  `tblItem1id` INT(10) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tblStocktakingDetail1_tblStocktakingSheet1id` FOREIGN KEY (`tblStocktakingSheet1id`) REFERENCES `tblStocktakingSheet1` (`id`),
  CONSTRAINT `fk_tblStocktakingDetail1_tblStorageLocation1id` FOREIGN KEY (`tblStorageLocation1id`) REFERENCES `tblStorageLocation1` (`id`),
  CONSTRAINT `fk_tblStocktakingDetail1_tblStockUnit1id` FOREIGN KEY (`tblStockUnit1id`) REFERENCES `tblStockUnit1` (`id`),
  CONSTRAINT `fk_tblStocktakingDetail1_tblItem1id` FOREIGN KEY (`tblItem1id`) REFERENCES `tblItem1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
