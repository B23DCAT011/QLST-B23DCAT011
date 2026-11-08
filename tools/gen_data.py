# -*- coding: utf-8 -*-
"""Sinh du lieu mau cho CSDL qlst1 theo dung so lieu cua kich ban phien ban 1.0 (bai tap 2).

Chay tu thu muc `bài tập 4`:  python tools/gen_data.py  ->  QLST1/database/qlst1_data.sql
- Module 1: nhan vien kho Tran Thi Binh (binhtt) sua MH020 (12 san pham ton, gia nhap thoa thuan cao nhat
  10.500.000 d); MH021 trung ten o ngoai le 10.3; MH031 ban tu chon con 5 san pham tren ke (ngoai le 10.6).
- Module 2: khach hang Nguyen Van An (annv), gio hang rong; tim "tu lanh" ra MH001, MH002, MH003
  (co the ban 15, 8, 5); MH010 co the ban 10; "tu dong mini" goi y MH030; don moi sinh ma DH0125.
"""
import os

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(BASE, 'QLST1', 'database', 'qlst1_data.sql')


def q(v):
    if v is None:
        return 'NULL'
    if isinstance(v, (int, float)):
        return str(v)
    return "'" + str(v).replace("'", "''") + "'"


def ins(table, cols, rows):
    vals = ',\n'.join('  (' + ', '.join(q(v) for v in r) + ')' for r in rows)
    return 'INSERT INTO `%s` (%s) VALUES\n%s;\n' % (table, ', '.join('`%s`' % c for c in cols), vals)


out = ['-- Du lieu mau cho CSDL qlst1 (sinh boi tools/gen_data.py). Chay sau qlst1_schema.sql.',
       'USE qlst1;', 'SET FOREIGN_KEY_CHECKS = 0;', '']

out.append(ins('tblAddress1', ['id', 'houseNumber', 'street', 'ward', 'district', 'province'], [
    (1, 'Số 12', 'ngõ 90 Chiến Thắng', 'phường Văn Quán', 'quận Hà Đông', 'Hà Nội'),
    (2, 'Số 5', 'ngõ 32 Trần Phú', 'phường Mộ Lao', 'quận Hà Đông', 'Hà Nội'),
    (3, 'Số 168', 'đường Nguyễn Trãi', 'phường Thanh Xuân Trung', 'quận Thanh Xuân', 'Hà Nội'),
    (4, 'Số 45', 'đường Phạm Văn Đồng', 'phường Mai Dịch', 'quận Cầu Giấy', 'Hà Nội'),
    (5, 'Lô B2', 'khu công nghiệp Quang Minh', 'thị trấn Quang Minh', 'huyện Mê Linh', 'Hà Nội'),
]))
out.append(ins('tblMember1', ['id', 'username', 'password', 'accountStatus', 'familyName', 'middleName', 'givenName',
                              'dateOfBirth', 'gender', 'email', 'phone', 'note', 'tblAddress1id'], [
    (1, 'annv', 'e10adc3949ba59abbe56e057f20f883e', 'hoạt động', 'Nguyễn', 'Văn', 'An', '1995-05-20', 'Nam',
     'an.nguyenvan@gmail.com', '0912345678', None, 1),
    (2, 'binhtt', 'e10adc3949ba59abbe56e057f20f883e', 'hoạt động', 'Trần', 'Thị', 'Bình', '1992-11-02', 'Nữ',
     'binh.tranthi@qlst.vn', '0987654321', None, 2),
]))
out.append(ins('tblCustomer1', ['tblMember1id', 'registerDate', 'loyaltyPoints'], [(1, '2025-03-10', 120)]))
out.append(ins('tblEmployee1', ['tblMember1id', 'position', 'hireDate'], [(2, 'kho', '2022-08-01')]))
out.append(ins('tblWarehouseStaff1', ['tblEmployee1id', 'tblZone1id'], [(2, 1)]))

out.append(ins('tblSupermarket1', ['id', 'name', 'phone', 'description', 'tblAddress1id'],
               [(1, 'Siêu thị điện máy QLST', '02435561234', None, 3)]))
out.append(ins('tblWarehouse1', ['id', 'name', 'area', 'description', 'tblSupermarket1id'],
               [(1, 'Kho hàng QLST', 1200, None, 1)]))
out.append(ins('tblSalesFloor1', ['id', 'name', 'area', 'description', 'tblSupermarket1id'],
               [(1, 'Sàn bán hàng QLST', 2500, None, 1)]))
out.append(ins('tblZone1', ['id', 'name', 'zoneType', 'storageCondition', 'status', 'description',
                            'tblWarehouse1id', 'tblSalesFloor1id'], [
    (1, 'Khu lưu trữ A', 'lưu trữ', 'Khô ráo, thoáng mát', 'hoạt động', None, 1, None),
    (2, 'Khu hàng lỗi', 'hàng lỗi', None, 'hoạt động', None, 1, None),
    (3, 'Kệ tự chọn 1', 'kệ tự chọn', None, 'hoạt động', None, None, 1),
    (4, 'Khu trưng bày', 'trưng bày', None, 'hoạt động', None, None, 1),
]))
out.append(ins('tblStorageLocation1', ['id', 'row', 'rack', 'level', 'capacity', 'maxLoad', 'status', 'tblZone1id'], [
    (1, 'A', '01', 1, 40, 2000, 'đang chứa', 1),
    (2, 'A', '01', 2, 40, 2000, 'đang chứa', 1),
    (3, 'A', '02', 1, 40, 2000, 'đang chứa', 1),
    (4, 'A', '02', 2, 40, 2000, 'đang chứa', 1),
    (5, 'K', '01', 1, 30, 200, 'đang chứa', 3),
]))

out.append(ins('tblCategory1', ['id', 'name', 'description'], [
    (1, 'Tủ lạnh', None), (2, 'Máy giặt', None), (3, 'Điều hoà', None), (4, 'Tủ đông', None), (5, 'Bàn là', None)]))
out.append(ins('tblBrand1', ['id', 'name', 'country', 'description'], [
    (1, 'Samsung', 'Hàn Quốc', None), (2, 'Panasonic', 'Nhật Bản', None), (3, 'LG', 'Hàn Quốc', None),
    (4, 'Daikin', 'Nhật Bản', None), (5, 'Sanaky', 'Việt Nam', None), (6, 'Philips', 'Hà Lan', None)]))
out.append(ins('tblUnitOfMeasure1', ['id', 'name'], [(1, 'Chiếc')]))

# (id, ten, loai, hang, gia ban, bao hanh, co serial, cach ban tai quay, muc ton toi thieu tren ke, mo ta, anh)
ITEMS = [
    (1, 'Tủ lạnh Samsung Inverter 236 lít RT22M4032BY', 1, 1, 6490000, 24, 1, 'giao từ kho', None, None, None),
    (2, 'Tủ lạnh Panasonic Inverter 255 lít NR-BV280QSVN', 1, 2, 8190000, 24, 1, 'giao từ kho', None, None, None),
    (3, 'Tủ lạnh LG Inverter 335 lít GN-M332PS', 1, 3, 9990000, 24, 1, 'giao từ kho', None, None, None),
    (10, 'Máy giặt LG Inverter 9 kg FV1409S4W', 2, 3, 7490000, 24, 1, 'giao từ kho', None, None, None),
    (20, 'Điều hoà Daikin Inverter 9000 BTU FTKB25WAVMV', 3, 4, 12490000, 12, 1, 'giao từ kho', 2,
     'Điều hoà 1 chiều, công nghệ Inverter, công suất 9000 BTU, phù hợp phòng dưới 15 m².',
     'daikin-ftkb25wavmv.jpg'),
    (21, 'Điều hoà LG Inverter 12000 BTU V13ENH1', 3, 3, 13990000, 12, 1, 'giao từ kho', None, None, None),
    (30, 'Tủ đông Sanaky Inverter 280 lít VH-4099W4K', 4, 5, 8990000, 24, 1, 'giao từ kho', None, None, None),
    (31, 'Bàn là hơi nước Philips GC1756', 5, 6, 590000, 24, 0, 'tự chọn trên kệ', 3, None, None),
]
out.append(ins('tblItem1', ['id', 'name', 'sellingPrice', 'warrantyPeriod', 'hasSerial', 'counterSaleMode',
                            'minShelfQuantity', 'description', 'image', 'status', 'tblCategory1id', 'tblBrand1id',
                            'tblUnitOfMeasure1id'],
               [(i, n, p, w, s, m, ms, d, img, 'đang kinh doanh', c, b, 1) for i, n, c, b, p, w, s, m, ms, d, img in ITEMS]))

out.append(ins('tblSupplier1', ['id', 'name', 'phone', 'email', 'contactPerson', 'status', 'description', 'tblAddress1id'], [
    (1, 'Công ty TNHH Điện máy Hưng Phát', '02437931234', 'kinhdoanh@hungphat.vn', 'Lê Văn Hùng', 'đang hợp tác', None, 4),
    (2, 'Công ty CP Thiết bị Nhiệt lạnh An Khang', '02438181234', 'sales@ankhang.vn', 'Phạm Thị Hoa', 'đang hợp tác', None, 5),
]))
out.append(ins('tblSupplyContract1', ['id', 'signDate', 'effectiveDate', 'expiryDate', 'paymentTerm', 'status',
                                      'terminationReason', 'tblSupplier1id'], [
    (1, '2026-01-05', '2026-01-15', '2027-01-14', 'Thanh toán trong 30 ngày', 'còn hiệu lực', None, 1),
    (2, '2026-02-20', '2026-03-01', '2027-02-28', 'Thanh toán trong 45 ngày', 'còn hiệu lực', None, 2),
]))
# (id, hop dong, mat hang, gia nhap thoa thuan)
SUPPLIED = [(1, 1, 1, 5600000), (2, 1, 2, 7000000), (3, 1, 3, 8500000), (4, 1, 10, 6300000),
            (5, 1, 20, 10200000), (6, 1, 21, 11800000), (7, 1, 30, 7600000), (8, 1, 31, 420000),
            (9, 2, 20, 10500000)]
out.append(ins('tblSuppliedItem1', ['id', 'supplierItemCode', 'agreedPrice', 'minOrderQuantity', 'leadTime',
                                    'supplierWarranty', 'status', 'tblSupplyContract1id', 'tblItem1id'],
               [(i, 'NCC%d-%03d' % (c, it), p, 5, 7, 12, 'đang cung cấp', c, it) for i, c, it, p in SUPPLIED]))

out.append(ins('tblStockReceiptNote1', ['id', 'receiptDate', 'note', 'tblSupplyContract1id', 'tblWarehouseStaff1id'], [
    (1, '2026-08-10', None, 1, 2), (2, '2026-09-02', None, 2, 2)]))
# (dong chi tiet = lo, phieu nhap, mat hang cung cap, so luong: [(trang thai, vi tri, so san pham), ...])
LOTS = [(1, 1, 1, [('trong kho', 1, 15)]), (2, 1, 2, [('trong kho', 1, 8)]), (3, 1, 3, [('trong kho', 2, 5)]),
        (4, 1, 4, [('trong kho', 2, 10)]), (5, 1, 5, [('trong kho', 3, 7)]), (6, 1, 6, [('trong kho', 3, 7)]),
        (7, 1, 7, [('trong kho', 4, 6)]), (8, 1, 8, [('trên kệ bán', 5, 5), ('trong kho', 4, 10)]),
        (9, 2, 9, [('trong kho', 3, 5)])]
price = dict((i, p) for i, c, it, p in SUPPLIED)
item_of = dict((i, it) for i, c, it, p in SUPPLIED)
serial = dict((i[0], i[6]) for i in ITEMS)
out.append(ins('tblStockReceiptDetail1', ['id', 'receivedQuantity', 'defectQuantity', 'unitPrice',
                                          'priceDifferenceReason', 'tblStockReceiptNote1id', 'tblSuppliedItem1id'],
               [(d, sum(n for _, _, n in parts), 0, price[s], None, note, s) for d, note, s, parts in LOTS]))
units, uid = [], 0
for d, note, s, parts in LOTS:
    for st, loc, n in parts:
        for _ in range(n):
            uid += 1
            it = item_of[s]
            sn = 'SN%02d%05d' % (it, uid) if serial[it] else None
            units.append((uid, 'SP-%06d' % uid, sn, st, d, loc, None))
out.append(ins('tblStockUnit1', ['id', 'internalCode', 'serialNumber', 'status', 'tblStockReceiptDetail1id',
                                 'tblStorageLocation1id', 'tblInvoiceDetail1id'], units))

out.append('-- don dat hang truc tuyen tiep theo co ma DH0125')
out.append('ALTER TABLE `tblOnlineOrder1` AUTO_INCREMENT = 125;')
out.append('SET FOREIGN_KEY_CHECKS = 1;')
open(OUT, 'w', encoding='utf-8', newline='\n').write('\n'.join(out) + '\n')
print('Da ghi', OUT, '|', len(units), 'san pham')
