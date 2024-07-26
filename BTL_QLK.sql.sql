CREATE DATABASE BTL_QLVT

-- TẠO BẢNG NHÀ CUNG CẤP
CREATE TABLE NhaCungCap (
    MaNCC CHAR(10) PRIMARY KEY,
    TenNCC NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200) NOT NULL,
    SDT CHAR(12) NOT NULL
);

-- TẠO BẢNG NGƯỜI GIAO
CREATE TABLE NguoiGiao (
    MaNG CHAR(10) PRIMARY KEY,
    TenNG NVARCHAR(100) NOT NULL,
    SDT CHAR(12) NOT NULL,
    MaNCC CHAR(10),
    FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC)
);

-- TẠO BẢNG ĐƠN VỊ NHẬN
CREATE TABLE DonViNhan (
    MaDVN CHAR(10) PRIMARY KEY,
    TenDVN NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200)NOT NULL,
    SDT CHAR(15) NOT NULL
);

-- TẠO BẢNG NGƯỜI NHẬN
CREATE TABLE NguoiNhan (
    MaNN CHAR(10) PRIMARY KEY,
    TenNN NVARCHAR(100) NOT NULL,
    SDT CHAR(15) NOT NULL,
    MaDVN CHAR(10),
    FOREIGN KEY (MaDVN) REFERENCES DonViNhan(MaDVN)
);


--TẠO BẢNG LƯƠNG
CREATE TABLE Luong (
    MaCV CHAR(10) PRIMARY KEY,
    TenCV NVARCHAR(100)NOT NULL,
    LuongCB DECIMAL(18, 2) DEFAULT(5000000),
    HSL DECIMAL(18, 2),
);

-- TẠO BẢNG KHO
CREATE TABLE KHO (
    MaKho CHAR(10) PRIMARY KEY,
    TenKho NVARCHAR(100),
    DiaDiem NVARCHAR(200),
    ChiNhanh VARCHAR(10)
);

-- TẠO BẢNG LOẠI VẬT TƯ
CREATE TABLE LoaiVatTu (
    MaLoaiVT CHAR(10) PRIMARY KEY,
    LoaiVT NVARCHAR(100),
    Mota NVARCHAR(200)
);

-- TẠO BẢNG VẬT TƯ
CREATE TABLE VatTu (
    MaVT CHAR(10) PRIMARY KEY,
    TenVT NVARCHAR(100),
    DonViTinh NVARCHAR(50),
    SoLuong INT,
    MaLoaiVT CHAR(10),
    FOREIGN KEY (MaLoaiVT) REFERENCES LoaiVatTu(MaLoaiVT)
);

-- TẠO BẢNG TỒN KHO
CREATE TABLE TonKho (
    MaVT CHAR(10) NOT NULL,
    NamThang DATE,
    SoLuongTon INT,
    MaKho CHAR(10),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT),
    FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
);

-- TẠO BẢNG NHÂN VIÊN VÀ SỐ ĐIỆN THOẠI
CREATE TABLE NhanVien_SDT (
    MaNV CHAR(10),
    SDT CHAR(15),
    PRIMARY KEY (MaNV, SDT),
	FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);


-- TẠO BẢNG NHÂN VIÊN
CREATE TABLE NhanVien (
    MaNV CHAR(10) PRIMARY KEY,
    TenNV NVARCHAR(100),
    GioiTinh NVARCHAR(3),
    DiaChi NVARCHAR(200),
    Ngayvaolam DATE,
    MaCV CHAR(10),
    MaKho CHAR(10),
    FOREIGN KEY (MaCV) REFERENCES Luong(MaCV),
    FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
);

--TẠO BẢNG PHIẾU NHẬP
CREATE TABLE PhieuNhap (
    SoPhieuN CHAR(10) PRIMARY KEY,
    NgayNhap DATE,
    MaNG CHAR(10),
    MaNV CHAR(10),
    MaKho CHAR(10),
    FOREIGN KEY (MaNG) REFERENCES NguoiGiao(MaNG),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
);

-- TẠO BẢNG CHI TIẾT PHIẾU NHẬP
CREATE TABLE ChiTietPhieuN (
    SoPhieuN CHAR(10) NOT NULL,
    MaVT CHAR(10) NOT NULL ,
    SoLuongN INT CHECK(SoLuongN > 0),
    DonGiaN DECIMAL(18, 2) CHECK(DonGiaN > 0),
    FOREIGN KEY (SoPhieuN) REFERENCES PhieuNhap(SoPhieuN),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT),
    PRIMARY KEY (SoPhieuN ,MaVT)
);


-- TẠO BẢNG PHIẾU XUẤT
CREATE TABLE PhieuXuat (
    SoPhieuX CHAR(10) PRIMARY KEY,
    NgayXuat DATE,
    MaNN CHAR(10),
    MaNV CHAR(10),
    MaKho CHAR(10),
    FOREIGN KEY (MaNN) REFERENCES NguoiNhan(MaNN),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
);

-- TẠO BẢNG CHI TIẾT PHIẾU XUẤT
CREATE TABLE ChiTietPhieuX (
    SoPhieuX CHAR(10) NOT NULL ,
    MaVT CHAR(10) NOT NULL,
    SoLuongX INT CHECK(SoLuongX > 0),
    DonGiaX DECIMAL(18, 2) CHECK(DonGiaX > 0),
    FOREIGN KEY (SoPhieuX) REFERENCES PhieuXuat(SoPhieuX),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT),
    PRIMARY KEY (SoPhieuX ,MaVT)
);

INSERT INTO NhaCungCap (MaNCC, TenNCC, DiaChi, SDT) VALUES
('NCC001', N'Công ty A', N'Hà Nội', '0123456789'),
('NCC002', N'Công ty B', N'TP HCM', '0123456790'),
('NCC003', N'Công ty C', N'Đà Nẵng', '0123456791'),
('NCC004', N'Công ty D', N'Hải Phòng', '0123456792'),
('NCC005', N'Công ty E', N'Cần Thơ', '0123456793'),
('NCC006', N'Công ty F', N'Bình Dương', '0123456794'),
('NCC007', N'Công ty G', N'Đồng Nai', '0123456795'),
('NCC008', N'Công ty H', N'Khánh Hòa', '0123456796'),
('NCC009', N'Công ty I', N'Bắc Ninh', '0123456797'),
('NCC010', N'Công ty J', N'Nghệ An', '0123456798');


-- INSERT DATA INTO NguoiGiao
INSERT INTO NguoiGiao (MaNG, TenNG, SDT, MaNCC) VALUES
('NG001', N'Nguyễn Văn A', '0123456799', 'NCC001'),
('NG002', N'Trần Văn B', '0123456800', 'NCC002'),
('NG003', N'Lê Thị C', '0123456801', 'NCC003'),
('NG004', N'Phạm Văn D', '0123456802', 'NCC004'),
('NG005', N'Ngô Thị E', '0123456803', 'NCC005'),
('NG006', N'Đặng Văn F', '0123456804', 'NCC006'),
('NG007', N'Bùi Thị G', '0123456805', 'NCC007'),
('NG008', N'Hồ Văn H', '0123456806', 'NCC008'),
('NG009', N'Vũ Thị I', '0123456807', 'NCC009'),
('NG010', N'Cao Văn J', '0123456808', 'NCC010');

-- INSERT DATA INTO DonViNhan
INSERT INTO DonViNhan (MaDVN, TenDVN, DiaChi, SDT) VALUES
('DVN001', N'Công ty K', N'Hà Nội', '0123456809'),
('DVN002', N'Công ty L', N'TP HCM', '0123456810'),
('DVN003', N'Công ty M', N'Đà Nẵng', '0123456811'),
('DVN004', N'Công ty N', N'Hải Phòng', '0123456812'),
('DVN005', N'Công ty O', N'Cần Thơ', '0123456813'),
('DVN006', N'Công ty P', N'Bình Dương', '0123456814'),
('DVN007', N'Công ty Q', N'Đồng Nai', '0123456815'),
('DVN008', N'Công ty R', N'Khánh Hòa', '0123456816'),
('DVN009', N'Công ty S', N'Bắc Ninh', '0123456817'),
('DVN010', N'Công ty T', N'Nghệ An', '0123456818');

-- INSERT DATA INTO NguoiNhan
INSERT INTO NguoiNhan (MaNN, TenNN, SDT, MaDVN) VALUES
('NN001', N'Phạm Văn K', '0123456819', 'DVN001'),
('NN002', N'Nguyễn Thị L', '0123456820', 'DVN002'),
('NN003', N'Trần Văn M', '0123456821', 'DVN003'),
('NN004', N'Lê Văn N', '0123456822', 'DVN004'),
('NN005', N'Đỗ Thị O', '0123456823', 'DVN005'),
('NN006', N'Ngô Văn P', '0123456824', 'DVN006'),
('NN007', N'Đặng Thị Q', '0123456825', 'DVN007'),
('NN008', N'Bùi Văn R', '0123456826', 'DVN008'),
('NN009', N'Hồ Thị S', '0123456827', 'DVN009'),
('NN010', N'Vũ Văn T', '0123456828', 'DVN010');

-- INSERT DATA INTO Luong
INSERT INTO Luong (MaCV, TenCV, LuongCB, HSL) VALUES
('CV001', N'Thủ kho', 15000000, 3.5),
('CV002', N'Kế toán', 12000000, 3.0),
('CV003', N'Nhân viên', 10000000, 2.5)

-- INSERT DATA INTO KHO
INSERT INTO KHO (MaKho, TenKho, DiaDiem,ChiNhanh) VALUES
('K001', N'Kho Hà Nội', N'Hà Nội','CN01'),
('K002', N'Kho TP HCM', N'TP HCM','CN02'),
('K003', N'Kho Đà Nẵng', N'Đà Nẵng','CN01'),
('K004', N'Kho Hải Phòng', N'Hải Phòng','CN01'),
('K005', N'Kho Cần Thơ', N'Cần Thơ','CN02'),
('K006', N'Kho Bình Dương', N'Bình Dương','CN02'),
('K007', N'Kho Đồng Nai', N'Đồng Nai','CN02'),
('K008', N'Kho Khánh Hòa', N'Khánh Hòa','CN02'),
('K009', N'Kho Bắc Ninh', N'Bắc Ninh','CN01'),
('K010', N'Kho Nghệ An', N'Nghệ An','CN01')


-- INSERT DATA INTO LoaiVatTu
INSERT INTO LoaiVatTu (MaLoaiVT, LoaiVT, Mota) VALUES
('LVT001', N'Loại A', N'Mô tả A'),
('LVT002', N'Loại B', N'Mô tả B'),
('LVT003', N'Loại C', N'Mô tả C'),
('LVT004', N'Loại D', N'Mô tả D'),
('LVT005', N'Loại E', N'Mô tả E'),
('LVT006', N'Loại F', N'Mô tả F'),
('LVT007', N'Loại G', N'Mô tả G'),
('LVT008', N'Loại H', N'Mô tả H'),
('LVT009', N'Loại I', N'Mô tả I'),
('LVT010', N'Loại J', N'Mô tả J');

-- INSERT DATA INTO VatTu
INSERT INTO VatTu (MaVT, TenVT, DonViTinh, SoLuong, MaLoaiVT) VALUES
('VT001', N'Vật tư A', N'Cái', 100, 'LVT001'),
('VT002', N'Vật tư B', N'Cái', 200, 'LVT002'),
('VT003', N'Vật tư C', N'Cái', 300, 'LVT003'),
('VT004', N'Vật tư D', N'Cái', 400, 'LVT004'),
('VT005', N'Vật tư E', N'Cái', 500, 'LVT005'),
('VT006', N'Vật tư F', N'Cái', 600, 'LVT006'),
('VT007', N'Vật tư G', N'Cái', 700, 'LVT007'),
('VT008', N'Vật tư H', N'Cái', 800, 'LVT008'),
('VT009', N'Vật tư I', N'Cái', 900, 'LVT009'),
('VT010', N'Vật tư J', N'Cái', 1000, 'LVT010');

-- INSERT DATA INTO TonKho
INSERT INTO TonKho (MaVT, NamThang, SoLuongTon, MaKho) VALUES
('VT001', '2023-01-01', 50, 'K001'),
('VT002', '2023-02-01', 150, 'K002'),
('VT003', '2023-03-01', 250, 'K003'),
('VT004', '2023-04-01', 350, 'K004'),
('VT005', '2023-05-01', 450, 'K005'),
('VT006', '2023-06-01', 550, 'K006'),
('VT007', '2023-07-01', 650, 'K007'),
('VT008', '2023-08-01', 750, 'K008'),
('VT009', '2023-09-01', 850, 'K009'),
('VT010', '2023-10-01', 950, 'K010');

-- INSERT DATA INTO NhanVien
INSERT INTO NhanVien (MaNV, TenNV, GioiTinh, DiaChi, Ngayvaolam, MaCV, MaKho) VALUES
('NV001', N'Nguyễn Văn A', N'Nam', N'Hà Nội', '2020-01-01', 'CV001', 'K001'),
('NV002', N'Trần Thị B', N'Nu', N'TP HCM', '2020-02-01', 'CV002', 'K002'),
('NV003', N'Lê Văn C', N'Nam', N'Đà Nẵng', '2020-03-01', 'CV003', 'K003'),
('NV004', N'Phạm Thị D', N'Nữ', N'Hải Phòng', '2020-04-01', 'CV001', 'K004'),
('NV005', N'Ngô Văn E', N'Nam', N'Cần Thơ', '2020-05-01', 'CV002', 'K005'),
('NV006', N'Đặng Thị F', N'Nữ', N'Bình Dương', '2020-06-01', 'CV001', 'K006'),
('NV007', N'Bùi Văn G', N'Nam', N'Đồng Nai', '2020-07-01', 'CV002', 'K007'),
('NV008', N'Hồ Thị H', N'Nữ', N'Khánh Hòa', '2020-08-01', 'CV002', 'K008'),
('NV009', N'Vũ Văn I', N'Nam', N'Bắc Ninh', '2020-09-01', 'CV003', 'K009'),
('NV010', N'Cao Thị J', N'Nữ', N'Nghệ An', '2020-10-01', 'CV001', 'K010')


-- INSERT DATA INTO NhanVien_SDT
INSERT INTO NhanVien_SDT (MaNV, SDT) VALUES
('NV001', '0123456829'),
('NV002', '0123456831'),
('NV003', '0123456834'),
('NV004', '0123456836'),
('NV005', '0123456838'),
('NV006', '0123456839'),
('NV007', '0123456841'),
('NV008', '0123456843'),
('NV009', '0123456846'),
('NV010', '0123456847')


-- INSERT DATA INTO PhieuNhap
INSERT INTO PhieuNhap (SoPhieuN, NgayNhap, MaNG, MaNV, MaKho) VALUES
('PN001', '2023-01-01', 'NG001', 'NV001', 'K001'),
('PN002', '2023-02-01', 'NG002', 'NV002', 'K002'),
('PN003', '2023-03-01', 'NG003', 'NV003', 'K003'),
('PN004', '2023-04-01', 'NG004', 'NV004', 'K004'),
('PN005', '2023-05-01', 'NG005', 'NV005', 'K005'),
('PN006', '2023-06-01', 'NG006', 'NV006', 'K006'),
('PN007', '2023-07-01', 'NG007', 'NV007', 'K007'),
('PN008', '2023-08-01', 'NG008', 'NV008', 'K008'),
('PN009', '2023-09-01', 'NG009', 'NV009', 'K009'),
('PN010', '2023-10-01', 'NG010', 'NV010', 'K010');

-- INSERT DATA INTO ChiTietPhieuN
INSERT INTO ChiTietPhieuN (SoPhieuN, MaVT, SoLuongN, DonGiaN) VALUES
('PN001', 'VT001', 10, 50000),
('PN002', 'VT002', 20, 100000),
('PN003', 'VT003', 30, 150000),
('PN004', 'VT004', 40, 200000),
('PN005', 'VT005', 50, 250000),
('PN006', 'VT006', 60, 300000),
('PN007', 'VT007', 70, 350000),
('PN008', 'VT008', 80, 400000),
('PN009', 'VT009', 90, 450000),
('PN010', 'VT010', 100, 500000);

-- INSERT DATA INTO PhieuXuat
INSERT INTO PhieuXuat (SoPhieuX, NgayXuat, MaNN, MaNV, MaKho) VALUES
('PX001', '2023-01-01', 'NN001', 'NV001', 'K001'),
('PX002', '2023-02-01', 'NN002', 'NV002', 'K002'),
('PX003', '2023-03-01', 'NN003', 'NV003', 'K003'),
('PX004', '2023-04-01', 'NN004', 'NV004', 'K004'),
('PX005', '2023-05-01', 'NN005', 'NV005', 'K005'),
('PX006', '2023-06-01', 'NN006', 'NV006', 'K006'),
('PX007', '2023-07-01', 'NN007', 'NV007', 'K007'),
('PX008', '2023-08-01', 'NN008', 'NV008', 'K008'),
('PX009', '2023-09-01', 'NN009', 'NV009', 'K009'),
('PX010', '2023-10-01', 'NN010', 'NV010', 'K010');

-- INSERT DATA INTO ChiTietPhieuX
INSERT INTO ChiTietPhieuX (SoPhieuX, MaVT, SoLuongX, DonGiaX) VALUES
('PX001', 'VT001', 5, 55000),
('PX002', 'VT002', 10, 105000),
('PX003', 'VT003', 15, 155000),
('PX004', 'VT004', 20, 205000),
('PX005', 'VT005', 25, 255000),
('PX006', 'VT006', 30, 305000),
('PX007', 'VT007', 35, 355000),
('PX008', 'VT008', 40, 405000),
('PX009', 'VT009', 45, 455000),
('PX010', 'VT010', 50, 505000);

--TẠO VIEW

-- Tìm các nhân viên lam cho kho số 7-Lê Hoàng Phong-12/07/2024
CREATE VIEW vw_Timnhanvienkho7 AS
SELECT MaNV,TenNV,MaKho
FROM NhanVien
WHERE MaKho= 'K007'     

SELECT * FROM vw_Timnhanvienkho7

-- Tìm các nhân viên có mức lương trên 20000000-Lê Hoàng Phong- 12/07/2024
CREATE VIEW vw_nhanvienluongtren20000000 AS
SELECT NV.TenNV,L.TenCV,FLOOR((L.LuongCB*L.HSL)) AS Luong
FROM Luong L JOIN NhanVien NV ON
     L.MaCV=NV.MaCV

SELECT * FROM vw_nhanvienluongtren20000000

-- Cho biết các vật tư đã bán trong năm 2024-Lê Hoàng Phong- 15/07/2024
CREATE VIEW vw_cacvattudabannam2024 AS
SELECT VT.MaVT,VT.TenVT
FROM PhieuXuat PX,ChiTietPhieuX CTPX,VatTu VT
WHERE PX.SoPhieuX=CTPX.SoPhieuX AND CTPX.MaVT=VT.MaVT AND
	  YEAR(PX.NgayXuat) = 2024

SELECT * FROM vw_cacvattudabannam2024

--Cho biết thông tin của người nhận phiếu xuất PX008-Lê Hoàng Phong- 15/07/2024

CREATE VIEW vw_thongtinnguoinhan AS
SELECT NN.MaNN,NN.TenNN,NN.SDT
FROM PhieuXuat PX JOIN NguoiNhan]NN ON
	 PX.MaNN=NN.MaNN
WHERE PX.SoPhieuX='PX008'

SELECT * FROM vw_thongtinnguoinhan

-- hiển thị tổng số lượng và giá trị nhập kho theo từng nhà cung cấp trong mỗi tháng-Lê Hoàng Phong- 15/07/2024

CREATE VIEW vw_soluongnhapkho AS
SELECT NCC.MaNCC,NCC.TenNCC,
	   SUM(CTPN.SoLuongN) AS Tongsoluong,
	   MONTH(PN.NgayNhap) AS Thang 
FROM NhaCungCap NCC 
	 JOIN NguoiGiao NG ON NCC.MaNCC= NG.MaNCC
	 JOIN PhieuNhap PN ON PN.MaNG = NG.MaNG
	 JOIN ChiTietPhieuN CTPN ON CTPN.SoPhieuN=PN.SoPhieuN
GROUP BY NCC.MaNCC,NCC.TenNCC,MONTH(PN.NgayNhap) 

SELECT * FROM vw_soluongnhapkho

-- hiển thị tồn kho hiện tại của mỗi vật tư trong từng kho-Lê Hoàng Phong-15/07/2024

ALTER VIEW vw_Tonkhovattu AS
SELECT VT.MaVT,VT.TenVT,SUM(TK.SoLuongTon) AS Ton_Kho,TK.MaKho
FROM TonKho TK JOIN VatTu VT ON
	 TK.MaVT=VT.MaVT
GROUP BY VT.MaVT,VT.TenVT,TK.MaKho

SELECT * FROM vw_Tonkhovattu

--hiển thị chi tiết các phiếu nhập và xuất của mỗi nhân viên trong tháng-Lê Hoàng Phong-15/07/2024

CREATE VIEW vw_Chitietnhapxuatnhanvien AS
SELECT  NV.MaNV,
		NV.TenNV,
		'Nhap' AS LoaiPhieu,
		PN.SoPhieuN AS SoPhieu,
		PN.NgayNhap AS Ngay,
		NG.TenNG AS TenDoiTac
FROM   NhanVien NV
		JOIN PhieuNhap PN ON NV.MaNV = PN.MaNV
		JOIN NguoiGiao NG ON PN.MaNG = NG.MaNG
UNION ALL
SELECT  NV.MaNV,
		NV.TenNV,
		'Xuat' AS LoaiPhieu,
		PX.SoPhieuX AS SoPhieu,
		PX.NgayXuat AS Ngay,
		NN.TenNN AS TenDoiTac
FROM  NhanVien NV
	  JOIN PhieuXuat PX ON NV.MaNV = PX.MaNV
      JOIN NguoiNhan NN ON PX.MaNN = NN.MaNN;

SELECT * FROM vw_Chitietnhapxuatnhanvien

-- hiển thị danh sách vật tư sắp hết hàng (số lượng tồn kho dưới ngưỡng 10 vật tư)-Lê Hoàng Phong-15/07/2024

CREATE VIEW vw_VatTuSapHetHang AS
SELECT 
    VT.MaVT,
    VT.TenVT,
    VT.DonViTinh,
	TK.MaKho,
    SUM(TK.SoLuongTon) AS TongSoLuongTon
FROM VatTu VT JOIN TonKho TK ON VT.MaVT = TK.MaVT
GROUP BY VT.MaVT, VT.TenVT,TK.MaKho, VT.DonViTinh
HAVING SUM(TK.SoLuongTon) < 10; 

SELECT * FROM vw_VatTuSapHetHang

--hiển thị danh sách các kho có số lượng tồn kho lớn nhất cho mỗi loại vật tư-Lê Hoàng Phong-15/07/2024

CREATE VIEW vw_KhoCoLuongTonLonNhat AS
SELECT 
    TK.MaVT,
    VT.TenVT,
    TK.MaKho,
    K.TenKho,
    TK.SoLuongTon
FROM 
    TonKho TK
    JOIN VatTu VT ON TK.MaVT = VT.MaVT
    JOIN KHO K ON TK.MaKho = K.MaKho
WHERE 
    TK.SoLuongTon = (
        SELECT 
            MAX(TK1.SoLuongTon)
        FROM 
            TonKho TK1
        WHERE 
            TK1.MaVT = TK.MaVT
    );

SELECT * FROM vw_KhoCoLuongTonLonNhat

--hiển thị giá trung bình nhập và xuất của từng loại vật tư theo năm-Lê Hoàng Phong-15/07/2024
CREATE VIEW vw_GiaTrungBinhVatTuTheoNam AS
SELECT 
    YEAR(PN.NgayNhap) AS Nam,
    VT.MaVT,
    VT.TenVT,
    AVG(CTPN.DonGiaN) AS GiaTrungBinhNhap,
    AVG(CTPX.DonGiaX) AS GiaTrungBinhXuat
FROM 
    VatTu VT
    LEFT JOIN ChiTietPhieuN CTPN ON VT.MaVT = CTPN.MaVT
    LEFT JOIN PhieuNhap PN ON CTPN.SoPhieuN = PN.SoPhieuN
    LEFT JOIN ChiTietPhieuX CTPX ON VT.MaVT = CTPX.MaVT
    LEFT JOIN PhieuXuat PX ON CTPX.SoPhieuX = PX.SoPhieuX
WHERE 
    YEAR(PN.NgayNhap) = YEAR(PX.NgayXuat)
GROUP BY 
    YEAR(PN.NgayNhap), VT.MaVT, VT.TenVT;

SELECT * FROM vw_GiaTrungBinhVatTuTheoNam



--TRIGGER
-- Thông báo khi có dữ liệu được nhập vào bản vật tư-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER tr_Vattu_thongbao
ON [dbo].[VatTu]
AFTER INSERT , UPDATE
AS
	RAISERROR(N'Bạn đang thêm dữ liệu', 16, 10)


-- Kiểm soát trường giới tính của nhân viên chỉ nhận Nam hoặc Nữ-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER tr_Nhanvien_Gioitinh
ON [dbo].[NhanVien]
FOR INSERT
AS
	BEGIN
		DECLARE @GT CHAR(10)
		SELECT @GT=GioiTinh FROM [dbo].[NhanVien]
		IF(@GT NOT IN (N'Nam',N'Nữ'))
			BEGIN
				PRINT(N'Dữ liệu không hợp lệ')
				ROLLBACK TRAN
			END
	END


--Đồng bộ số lượng tồn kho khi nhập-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER tr_CTPhieunhap_Soluong
ON [dbo].[ChiTietPhieuN]
FOR INSERT
AS
	BEGIN
		
		DECLARE @Soluong INT
		DECLARE @Mavt CHAR(10)
		DECLARE @NgayThang DATE

		SELECT @Soluong=SoLuongN, @Mavt=MaVT,@NgayThang=PN.NgayNhap
		FROM inserted I 
			 JOIN [dbo].[PhieuNhap] PN ON I.SoPhieuN=PN.SoPhieuN

		UPDATE [dbo].[TonKho]
		SET [SoLuongTon]+=@Soluong
		WHERE MaVT =@Mavt AND NamThang=@NgayThang
	END

INSERT INTO [dbo].[ChiTietPhieuN] ([SoPhieuN],[MaVT],[SoLuongN],[DonGiaN]) 
VALUES ('PN005','VT002',77,500000)


--Đồng bộ số lượng tồn kho khi xuất-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER tr_CTPhieuxuat_Soluong
ON [dbo].[ChiTietPhieuX]
FOR INSERT
AS
	BEGIN
		
		DECLARE @Soluong INT
		DECLARE @Mavt CHAR(10)
		DECLARE @NgayThang DATE

		SELECT @Soluong=I.SoLuongX, @Mavt=I.MaVT,@NgayThang=PX.NgayXuat
		FROM inserted I 
			 JOIN [dbo].[PhieuXuat] PX ON I.SoPhieuX=PX.SoPhieuX

		UPDATE [dbo].[TonKho]
		SET [SoLuongTon]-=@Soluong
		WHERE MaVT =@Mavt AND NamThang=@NgayThang
	END

INSERT INTO [dbo].[ChiTietPhieuX] (SoPhieuX,MaVT,SoLuongX,DonGiaX)
VALUES('PX007','VT002',34,546000)


--Kiểm tra cập nhật mã nhân viên trong bảng phiếu nhập-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER trg_Phieunhap_Manv
ON [dbo].[PhieuNhap]
FOR UPDATE
AS
BEGIN
    IF UPDATE(MaNV)
    BEGIN
        DECLARE @MaNV CHAR(10)
        SELECT @MaNV = inserted.MaNV FROM inserted
        IF NOT EXISTS (SELECT 1 FROM [dbo].[NhanVien] WHERE MaNV = @MaNV)
        BEGIN
            RAISERROR('Mã nhân viên không tồn tại', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
END


--Kiểm tra cập nhật mã nhân viên trong bảng phiếu xuất-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER trg_Phieuxuat_Manv
ON [dbo].[PhieuXuat]
FOR UPDATE
AS
BEGIN
    IF UPDATE(MaNV)
    BEGIN
        DECLARE @MaNV CHAR(10)
        SELECT @MaNV = inserted.MaNV FROM inserted
        IF NOT EXISTS (SELECT 1 FROM [dbo].[NhanVien] WHERE MaNV = @MaNV)
        BEGIN
            RAISERROR('Mã nhân viên không tồn tại', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
END


--Không cho phép sửa cột giới tính-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER tr_Nhanvien_suagioitinh
ON [dbo].[NhanVien]
FOR UPDATE
AS
	BEGIN
		IF(UPDATE(GioiTinh))
			BEGIN
				PRINT(N'Không thể sửa giới tính')
				ROLLBACK TRAN
			END
	END

UPDATE [dbo].[NhanVien]
SET GioiTinh =N'Nữ'
WHERE MaNV ='NV001'


-- Không cho phép sửa MaNV-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER tr_Nhanvien_suamanv
ON [dbo].[NhanVien]
FOR UPDATE
AS
	BEGIN
		IF(UPDATE(Manv))
			BEGIN
				PRINT(N'Không thể sửa mã nhân viên')
				ROLLBACK TRAN
			END
	END

UPDATE [dbo].[NhanVien]
SET MaNV='NV013'
WHERE MaNV='NV012'


--Xóa một NV thì xóa các phân công tương ứng-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER tr_Nhanvien_Xoanv
ON [dbo].[NhanVien]
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @Manv CHAR(10)
    DECLARE @MaPhieuN CHAR(10)
    DECLARE @MaPhieuX CHAR(10)

    SELECT @Manv = D.MaNV FROM deleted D


    SELECT @MaPhieuN=CTPN.SoPhieuN 
    FROM [dbo].[PhieuNhap] PN,[dbo].[ChiTietPhieuN] CTPN 
    WHERE MaNV=@Manv AND PN.SoPhieuN=CTPN.SoPhieuN

    SELECT @MaPhieuX=PX.SoPhieuX
    FROM [dbo].[PhieuXuat] PX,[dbo].[ChiTietPhieuX] CTPX
    WHERE MaNV=@Manv AND PX.SoPhieuX=CTPX.SoPhieuX

    IF EXISTS(SELECT * FROM [dbo].[NhanVien_SDT] WHERE MaNV=@Manv)
        BEGIN
            DELETE FROM [dbo].[NhanVien_SDT] WHERE MaNV=@Manv
        END

    IF(EXISTS (SELECT * FROM [dbo].[PhieuNhap] PN WHERE SoPhieuN=@MaPhieuN) )
        BEGIN
            DELETE FROM [dbo].[ChiTietPhieuN] WHERE SoPhieuN=@MaPhieuN
            DELETE FROM [dbo].[PhieuNhap]  WHERE SoPhieuN=@MaPhieuN
        END

    IF EXISTS( (SELECT * FROM [dbo].[PhieuXuat]  WHERE SoPhieuX=@MaPhieuX))
        BEGIN
            DELETE FROM [dbo].[ChiTietPhieuX] WHERE SoPhieuX=@MaPhieuX
            DELETE FROM [dbo].[PhieuXuat] WHERE SoPhieuX=@MaPhieux
        END

        DELETE FROM [dbo].[NhanVien] where [MaNV] = @Manv
END

DELETE FROM [dbo].[NhanVien]
WHERE MaNV='NV004'


-- Tự đông cập nhật ngày vào làm cho nhân viên mới-Lê Hoàng Phong-16/07/2024
CREATE TRIGGER tr_Nhanvien_ngayvaolam
ON [dbo].[NhanVien]
INSTEAD OF INSERT
AS
	BEGIN
		INSERT INTO [dbo].[NhanVien] (MaNV, TenNV, GioiTinh, DiaChi, Ngayvaolam, MaCV, MaKho)
		SELECT MaNV, TenNV, GioiTinh, DiaChi, GETDATE(), MaCV, MaKho FROM inserted
	END

INSERT INTO [dbo].[NhanVien] (MaNV, TenNV, GioiTinh, DiaChi, MaCV, MaKho)
VALUES('NV012','Bui Chi N','Nam','Ha Noi','CV001','K004')




--STORED PROCEDURES

--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Thêm loại vật tư 
CREATE PROCEDURE ThemLoaiVatTu
    @MaLoaiVT CHAR(10),
    @TenLoaiVT NVARCHAR(50),
    @MoTa NVARCHAR(200)
AS
BEGIN
    INSERT INTO LoaiVatTu ([MaLoaiVT],[LoaiVT],[Mota])
    VALUES (@MaLoaiVT, @TenLoaiVT ,@MoTa)
END

EXEC ThemLoaiVatTu 'LVT013', N'Loại H', N'Mô tả H'


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Sửa loại vật tư 
CREATE PROCEDURE SuaLoaiVatTu
    @MaLoaiVT CHAR(10),
    @TenLoaiVT NVARCHAR(50),
    @MoTa NVARCHAR(50)
AS
BEGIN
    UPDATE [dbo].[LoaiVatTu]
    SET [MaLoaiVT] = @MaLoaiVT ,
        [LoaiVT] = @TenLoaiVT ,
        [Mota] = @MoTa 
    WHERE [MaLoaiVT] = @MaLoaiVT 
END

EXEC SuaLoaiVatTu 'LVT012', N'Loại K', N'Mô tả K'


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Xóa loại vật tư 
CREATE PROCEDURE XoaLoaiVatTu
    @MaLoaiVT CHAR(10)
AS
BEGIN
    DELETE 
    FROM LoaiVatTu 
    WHERE MaLoaiVT = @MaLoaiVT
END

EXEC XoaLoaiVatTu 'LVT012'


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Lấy thông tin loại vật tư 
CREATE PROCEDURE LayThongTinLoaiVatTu 
    @MaLoaiVT CHAR(10) 
AS 
BEGIN 
    SELECT * 
    FROM [dbo].[LoaiVatTu]
    WHERE [MaLoaiVT] = @MaLoaiVT 
END 

EXEC LayThongTinLoaiVatTu 'LVT001'


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Thêm vật tư 
CREATE PROCEDURE ThemVatTu
    @MaVT CHAR(10),
    @TenVT NVARCHAR(50),
    @DonViTinh NVARCHAR(12),
    @MaLoaiVT CHAR(10)
AS
BEGIN
    INSERT INTO VatTu (MaVT, TenVT, DonViTinh, MaLoaiVT)
    VALUES (@MaVT, @TenVT, @DonViTinh, @MaLoaiVT);
END

EXEC ThemVatTu @MaVT = 'VT013', @TenVT = N'Vật tư K', @DonViTinh = N'Cái', @MaLoaiVT = 'LVT001';


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Sửa vật tư 
CREATE PROCEDURE SuaVatTu
    @MaVT CHAR(10),
    @TenVT NVARCHAR(50),
    @DonViTinh NVARCHAR(12),
    @SoLuong INT ,
    @MaLoaiVT CHAR(10)
AS
BEGIN
    UPDATE VatTu
    SET TenVT = @TenVT, DonViTinh = @DonViTinh , SoLuong = @SoLuong  , MaLoaiVT = @MaLoaiVT
    WHERE MaVT = @MaVT;
END

EXEC SuaVatTu @MaVT = 'VT001', @TenVT = N'Vật tư A Updated', @DonViTinh = N'Cái', @SoLuong = 110, @MaLoaiVT = 'LVT001';


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Xóa vật tư 
CREATE PROCEDURE XoaVatTu
    @MaVT CHAR(10)
AS
BEGIN
    DELETE 
    FROM VatTu
    WHERE MaVT = @MaVT;
END

EXEC XoaVatTu @MaVT = 'VT011';


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Lấy thông tin vật tư 
CREATE PROCEDURE LayVatTu
    @MaVT CHAR(10)
AS
BEGIN
    SELECT * FROM VatTu
    WHERE MaVT = @MaVT;
END

EXEC LayVatTu @MaVT = 'VT002'


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Thêm lương
CREATE PROCEDURE ThemLuong
    @MaCV CHAR(10),
    @TenCV NVARCHAR(50),
    @HSL DECIMAL,
    @LuongCB FLOAT = 5000000
AS
BEGIN
    INSERT INTO Luong (MaCV, TenCV, HSL, LuongCB)
    VALUES (@MaCV, @TenCV, @HSL, @LuongCB);
END

EXEC ThemLuong @MaCV = 'CV011', @TenCV = N'Chức vụ F', @HSL = 3.5, @LuongCB = 6000000


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Sửa lương
CREATE PROCEDURE SuaLuong
    @MaCV CHAR(10),
    @TenCV NVARCHAR(50),
    @HSL DECIMAL,
    @LuongCB FLOAT = 5000000
AS
BEGIN
    UPDATE Luong
    SET TenCV = @TenCV, HSL = @HSL, LuongCB = @LuongCB
    WHERE MaCV = @MaCV;
END

EXEC SuaLuong @MaCV = 'CV001', @TenCV = N'Chức vụ A', @HSL = 3.5, @LuongCB = 6000000


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Lấy thông tin lương
CREATE PROCEDURE LayThongTinLuong
    @MaCV CHAR(10)
AS
BEGIN
    SELECT *
    FROM [dbo].[Luong]
    WHERE MaCV = @MaCV 
END

EXEC LayThongTinLuong @MaCV = 'CV001';


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Thêm nhân viên
CREATE PROCEDURE ThemNhanVien
    @MaNV CHAR(10),
    @TenNV NVARCHAR(50),
    @GioiTinh CHAR(3),
    @DiaChi NVARCHAR(70),
    @MaCV CHAR(10),
    @MaKho CHAR(10)
AS
BEGIN
    INSERT INTO NhanVien (MaNV, TenNV, GioiTinh, DiaChi, MaCV ,MaKho)
    VALUES (@MaNV, @TenNV, @GioiTinh, @DiaChi,  @MaCV,@MaKho)
END

EXEC ThemNhanVien @MaNV = 'NV013', @TenNV = N'Nguyễn Văn H', @GioiTinh = 'Nam',
 @DiaChi = N'123 FBC Street', @MaCV = 'CV001', @MaKho = 'K003';


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Xóa nhân viên
CREATE PROCEDURE XoaNhanVien
    @MaNV CHAR(10)
AS
BEGIN
    DELETE FROM NhanVien
    WHERE MaNV = @MaNV
END

EXEC XoaNhanVien @MaNV = 'NV001'

--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Lấy dữ liệu nhân viên
CREATE PROCEDURE LayTTNhanVien
    @MaNV CHAR(10)
AS
BEGIN
    SELECT *
    FROM NhanVien
    WHERE MaNV = @MaNV
END

EXEC LayTTNhanVien 'NV005'

--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Thêm nhân viên - SDT 
CREATE PROCEDURE ThemNV_SDT
    @MaNV CHAR(10),
    @SDT Char(15)
AS
BEGIN 
    INSERT INTO NhanVien_SDT (MaNV,SDT)
    VALUES(@MaNV,@SDT)
END

EXEC ThemNV_SDT 'NV013', '0123456789';


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Sửa nhân viên - SDT 
CREATE PROCEDURE SuaNV_SDT
    @MaNV CHAR(10),
    @SDT Char(15)
AS
BEGIN 
    UPDATE [dbo].[NhanVien_SDT]
    SET SDT = @SDT 
    WHERE MaNV = @MaNV 
END

EXEC SuaNV_SDT 'NV002', '0123556789'


--Người viết : Bùi Chí Nhật
--Ngày viết : 22/7/2024
--Lấy thông tin nhân viên - SDT 
CREATE PROCEDURE LayTTNV_SDT
    @MaNV CHAR(10)
AS
BEGIN
    SELECT * FROM [dbo].[NhanVien_SDT]
    WHERE MaNV = @MaNV
END

EXEC LayTTNV_SDT @MaNV = 'NV002';


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Thêm dữ liệu kho
CREATE PROCEDURE ThemKho
    @MaKho Char(10) ,
    @TenKho NVARCHAR(100),
    @DiaDiem NVARCHAR(200),
    @ChiNhanh VARCHAR(10)
AS
BEGIN
    INSERT INTO KHO([MaKho],[TenKho],[DiaDiem],[ChiNhanh])
    VALUES(@MaKho,@TenKho,@DiaDiem,@ChiNhanh)
END

EXEC ThemKho @MaKho = 'K011', @TenKho = N'Kho A', @DiaDiem = N'123 ABC Street',@ChiNhanh = 'CN1' ;


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Sửa dữ liệu kho
CREATE PROCEDURE SuaKho
    @MaKho CHAR(10),
    @TenKho NVARCHAR(100),
    @DiaDiem NVARCHAR(200),
    @ChiNhanh VARCHAR(10)
AS
BEGIN
    UPDATE KHO
    SET MaKho = @MaKho, TenKho = @TenKho, DiaDiem =@DiaDiem ,ChiNhanh = @ChiNhanh
    WHERE MaKho = @MaKho
END

EXEC SuaKho @MaKho = 'K011', @TenKho = N'Kho F', @DiaDiem = N'123 ABC Street',@ChiNhanh = 'CN1' ;


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Xóa dữ liệu kho
CREATE PROCEDURE XoaKho
    @MaKho CHAR(10)
AS
BEGIN
    DELETE FROM KHO
    WHERE MaKho = @MaKho
END

EXEC XoaKho 'K011'


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Lấy dữ liệu kho
CREATE PROCEDURE LayTTKho
    @MaKho CHAR(10)
AS
BEGIN
    SELECT * 
    FROM KHO
    WHERE MaKho = @MaKho;
END

EXEC LayTTKho 'K001'


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Thêm dữ liệu tồn kho
CREATE PROCEDURE ThemTonKho
    @MaVT CHAR(10),
    @NamThang DATE,
    @SoLuongTon INT,
    @MaKho CHAR(10)
AS
BEGIN
    INSERT INTO TonKho ([MaVT],[NamThang],[SoLuongTon],[MaKho])
    VALUES (@MaVT, @NamThang, @SoLuongTon,@MaKho)
END

EXEC ThemTonKho @MaVT = 'VT001', @NamThang = '2024-07-24', @SoLuongTon = 100, @MaKho = 'K001';


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Sửa dữ liệu tồn kho
CREATE PROCEDURE SuaTonKho
    @MaVT CHAR(10),
    @NamThang DATE,
    @SoLuongTon INT,
    @MaKho CHAR(10)
AS
BEGIN
    UPDATE TonKho
    SET SoLuongTon = @SoLuongTon , [NamThang] = @NamThang , [MaKho] = @MaKho 
    WHERE MaKho = @MaKho AND MaVT = @MaVT;
END

EXEC SuaTonKho @MaVT = 'VT001', @NamThang = '2024-07-24', @SoLuongTon = 105, @MaKho = 'K001';


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Xóa dữ liệu tồn kho
CREATE PROCEDURE XoaTonKho
    @MaKho CHAR(10),
    @MaVT CHAR(10)
AS
BEGIN
    DELETE FROM TonKho
    WHERE MaKho = @MaKho AND MaVT = @MaVT;
END

EXEC XoaTonKho 'K001' , 'VT001'


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Lấy dữ liệu tồn kho
CREATE PROCEDURE LayTTTonKho
    @MaKho CHAR(10),
    @MaVT CHAR(10)
AS
BEGIN
    SELECT * FROM TonKho
    WHERE MaKho = @MaKho AND MaVT = @MaVT;
END

EXEC LayTTTonKho 'K003' , 'VT003'


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Thêm dữ liệu nhà cung cấp
CREATE PROCEDURE ThemNhaCungCap
    @MaNCC CHAR(10),
    @TenNCC NVARCHAR(50),
    @DiaChi NVARCHAR(70),
    @SDT CHAR(12)
AS
BEGIN
    INSERT INTO NhaCungCap (MaNCC, TenNCC, SDT, DiaChi)
    VALUES (@MaNCC, @TenNCC, @SDT, @DiaChi)
END

EXEC ThemNhaCungCap @MaNCC = 'NCC011', @TenNCC = N'Nhà cung cấp A', @DiaChi = N'789 GHI Street', @SDT = '0123456789';


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Sửa dữ liệu nhà cung cấp
CREATE PROCEDURE SuaNhaCungCap
    @MaNCC CHAR(10),
    @TenNCC NVARCHAR(50),
    @DiaChi NVARCHAR(70),
    @SDT CHAR(12)
AS
BEGIN
    UPDATE NhaCungCap
    SET  [TenNCC] = @TenNCC,[DiaChi] =@DiaChi , [SDT] = @SDT
    WHERE [MaNCC] = @MaNCC 
END

EXEC SuaNhaCungCap @MaNCC = 'NCC011', @TenNCC = N'Nhà cung cấp B', @DiaChi = N'101 JKL Street', @SDT = '0987654321';


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Xóa dữ liệu nhà cung cấp
CREATE PROCEDURE XoaNhaCungCap
    @MaNCC CHAR(10)
AS
BEGIN 
    DELETE
    FROM NhaCungCap
    WHERE [MaNCC] = @MaNCC 
END

EXEC XoaNhaCungCap @MaNCC = 'NCC011';


--Người viết : Bùi Chí Nhật
--Ngày viết : 24/7/2024
--Lấy dữ liệu nhà cung cấp
CREATE PROCEDURE LayTTNhaCungCap
    @MaNCC CHAR(10)
AS
BEGIN
    SELECT * FROM NhaCungCap
    WHERE MaNCC = @MaNCC
END

EXEC LayTTNhaCungCap @MaNCC = 'NCC001';




--TẠO LOGIN     

--Tạo tài khoản người dùng với mỗi thành viên
--Tạo người dùng
CREATE LOGIN manh WITH PASSWORD = 'manh1111'
CREATE LOGIN nhat WITH PASSWORD = 'nhat1111'
CREATE LOGIN phong WITH PASSWORD = 'phong1111'
CREATE LOGIN nghia WITH PASSWORD = 'nghia1111'

--Tạo tài khoản với mỗi thành viên
CREATE USER manhh FOR LOGIN manh
CREATE USER nhatt FOR LOGIN nhat
CREATE USER phongg FOR LOGIN phong
CREATE USER nghiaa FOR LOGIN nghia

--cấp quyền
--manh
GRANT ALL ON [dbo].[DonViNhan] TO manhh
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[KHO] TO manhh
GRANT SELECT,INSERT ,UPDATE ON [dbo].[LoaiVatTu] TO manhh
GRANT EXECUTE ON [dbo].[LayThongTinLoaiVatTu] TO manhh
GRANT EXECUTE ON [dbo].[LayThongTinLuong] TO manhh

--nhat
GRANT SELECT,INSERT ,UPDATE ON [dbo].[Luong] TO nhatt
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[NguoiGiao] TO nhatt
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[NguoiNhan] TO nhatt
GRANT EXECUTE ON [dbo].[LayTTKho] TO nhatt


--phong
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[NhaCungCap] TO phongg
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[NhanVien] TO phongg
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[NhanVien_SDT] TO phongg
GRANT EXECUTE ON [dbo].[SuaNhaCungCap] TO phongg
GRANT EXECUTE ON [dbo].[LayTTNhaCungCap] TO phongg

--nghia
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[PhieuNhap] TO nghiaa
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[PhieuXuat] TO nghiaa
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[TonKho] TO nghiaa
GRANT SELECT,INSERT ,UPDATE,DELETE ON [dbo].[VatTu] TO nghiaa
GRANT EXECUTE ON [dbo].[ThemLoaiVatTu] TO nghiaa
GRANT EXECUTE ON [dbo].[ThemTonKho] TO nghiaa

--cấm/xóa quyền
REVOKE DELETE ON [dbo].[DonViNhan] FROM manhh
DENY UPDATE,DELETE ON [dbo].[KHO] TO manhh

DENY UPDATE ,DELETE ON [dbo].[NguoiGiao] TO nhatt
DENY UPDATE ON [dbo].[NguoiNhan]([MaNN],[TenNN]) TO nhatt

REVOKE ALL ON [dbo].[NhaCungCap] FROM phongg
DENY INSERT ,UPDATE,DELETE ON [dbo].[NhanVien] TO phongg

DENY SELECT ON  [dbo].[TonKho]([SoLuongTon]) TO nghiaa



--PHÂN TÁN
CREATE DATABASE KV1

-- TẠO BẢNG NHÂN VIÊN_SDT
CREATE TABLE NhanVien_SDT (
    MaNV CHAR(10),
    SDT CHAR(15),
    PRIMARY KEY (MaNV, SDT),
	FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

-- TẠO BẢNG KHO
CREATE TABLE KHO (
    MaKho CHAR(10) PRIMARY KEY,
    TenKho NVARCHAR(100),
    DiaDiem NVARCHAR(200),
    ChiNhanh VARCHAR(10)
);

-- TẠO BẢNG NHÂN VIÊN
CREATE TABLE NhanVien (
    MaNV CHAR(10) PRIMARY KEY,
    TenNV NVARCHAR(100),
    GioiTinh NVARCHAR(3),
    DiaChi NVARCHAR(200),
    Ngayvaolam DATE,
    MaCV CHAR(10),
    MaKho CHAR(10),
    FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
);

--ccèn dữ liệu vào kho của kv1 với đk những kho có mã chi nhanh là CN01
INSERT INTO KV1.dbo.KHO
SELECT * FROM KHO
WHERE [ChiNhanh]='CN01'

--chèn dữ liệu vào bảng nhân viên của kv1 với đk nhân viên làm tại những chi nhanh có mã là CN01
INSERT INTO KV1.dbo.NhanVien
SELECT nv.* FROM NhanVien nv
JOIN KHO ON nv.MaKho=KHO.MaKho
WHERE ChiNhanh='CN01'

--chèn dữ liệu vào kho của kv2 với đk những kho có mã chi nhanh là CN02
INSERT INTO MANGNHAT.KV2.dbo.KHO
SELECT * FROM KHO
WHERE [ChiNhanh]='CN02'

--chèn dữ liệu vào bảng nhân viên của kv2 với đk nhân viên làm tại những chi nhanh có mã là CN02
INSERT INTO MANGNHAT.KV2.dbo.NhanVien
SELECT nv.*FROM NhanVien nv
JOIN KHO ON nv.MaKho=KHO.MaKho
WHERE ChiNhanh='CN02'

--truy vấn mã kho,ten kho , địa điểm của bảng kho của kv1 và kv2
SELECT MaKho,TenKho,DiaDiem FROM  KV1.dbo.KHO
SELECT MaKho,TenKho,DiaDiem FROM  MANGNHAT.KV2.dbo.KHO

--nhân viên làm việc trên 3 năm ở kv1
SELECT TenNV,Ngayvaolam FROM KV1.dbo.NhanVien
WHERE DATEDIFF(YEAR,[Ngayvaolam],GETDATE())>3

--nhân viên làm việc dưới 2 năm ở kv2
SELECT TenNV,Ngayvaolam FROM MANGNHA.KV2.dbo.NhanVien
WHERE DATEDIFF(YEAR,[Ngayvaolam],GETDATE())<2

