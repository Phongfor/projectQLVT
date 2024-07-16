CREATE DATABASE QLK

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
    DiaDiem NVARCHAR(200)
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
    TenNV VARCHAR(100),
    GioiTinh CHAR(3),
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
    SoPhieuN CHAR(10) PRIMARY KEY,
    MaVT CHAR(10),
    SoLuongN INT CHECK(SoLuongN > 0),
    DonGiaN DECIMAL(18, 2) CHECK(DonGiaN > 0),
    FOREIGN KEY (SoPhieuN) REFERENCES PhieuNhap(SoPhieuN),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT)
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
    SoPhieuX CHAR(10) PRIMARY KEY,
    MaVT CHAR(10),
    SoLuongX INT CHECK(SoLuongX > 0),
    DonGiaX DECIMAL(18, 2) CHECK(DonGiaX > 0),
    FOREIGN KEY (SoPhieuX) REFERENCES PhieuXuat(SoPhieuX),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT)
);

--Thêm dữ liệu cho bảng VatTu
INSERT INTO [dbo].[VatTu] ([MaVT],[TenVT],[DonViTinh],[MaLoaiVT])
VALUES ('VT001',N'Sắt','Kg','xaydung') ,
       ('VT002',N'Thép','Kg','xaydung'),
       ('VT003',N'Gạch','Kg','xaydung'),
       ('VT004',N'Bàn','Cái','noithat'),
       ('VT005',N'Ghế','Cái','noithat')

--Thêm dữ liệu cho bảng LoaiVatTu
INSERT INTO [dbo].[LoaiVatTu] ([MaLoaiVT],[LoaiVT])
VALUES ('xaydung',N'Xây dựng') ,
       ('noithat',N'Nội thất'),
       ('tbdien',N'Thiết bị điện'),
       ('trangtri',N'Trang trí'),
       ('ngoaithat',N'Ngoại thất')

--Thêm dữ liệu cho bảng KHO
INSERT INTO [dbo].[KHO] ([MaKho],[TenKho],[DiaDiem])
VALUES ('K001',N'Kho VT Xây dựng' , N'6 Định Công') ,
       ('K002',N'Kho VL Nội thất' , N'96 Định Công'),
       ('K003',N'Kho VL Thiết bị điện ', N'99 Định Công' ),
       ('K004',N'Kho VL Trang trí' , N'175 Định Công') ,
       ('K005',N'Kho VL Ngoại thất',N'178 Hoàng Mai')

--Thêm dữ liệu cho bảng NhanVien
INSERT INTO NhanVien (MaNV, TenNV , GioiTinh, DiaChi, Ngayvaolam, MaCV, MaKho)
VALUES ('NV001', N'Nhân viên A', N'Nam', N'123 Đường A', '2023-01-01', 'CV001', 'K001'),
       ('NV002', N'Nhân viên B', N'Nữ', N'456 Đường B', '2023-02-01', 'CV002', 'K002'),
       ('NV003', N'Nhân viên C', N'Nam', N'789 Đường C', '2023-03-01', 'CV003', 'K003'),
       ('NV004', N'Nhân viên D', N'Nữ', N'101 Đường D', '2023-04-01', 'CV004', 'K004'),
       ('NV005', N'Nhân viên E', N'Nam', N'202 Đường E', '2023-05-01', 'CV005', 'K005')

--Thêm dữ liệu cho bảng NhaCungCap
INSERT INTO NhaCungCap (MaNCC, TenNCC, DiaChi, SDT)
VALUES ('NCC001', N'Nhà cung cấp A', N'123 Đường A', '0123456789'),
       ('NCC002', N'Nhà cung cấp B', N'456 Đường B', '0987654321'),
       ('NCC003', N'Nhà cung cấp C', N'789 Đường C', '0112233445'),
       ('NCC004', N'Nhà cung cấp D', N'101 Đường D', '0223344556'),
       ('NCC005', N'Nhà cung cấp E', N'202 Đường E', '0334455667')

--Thêm dữ liệu cho bảng NguoiGiao
INSERT INTO NguoiGiao (MaNG, TenNG, SDT, MaNCC)
VALUES ('NG001', N'Người giao A', '0123456780', 'NCC001'),
       ('NG002', N'Người giao B', '0987654322', 'NCC002'),
       ('NG003', N'Người giao C', '0112233446', 'NCC003'),
       ('NG004', N'Người giao D', '0223344557', 'NCC004'),
       ('NG005', N'Người giao E', '0334455668', 'NCC005')

--Thêm dữ liệu cho bảng DonViNhan
INSERT INTO DonViNhan (MaDVN, TenDVN, DiaChi, SDT)
VALUES ('DVN001', N'Đơn vị nhận A', N'100 Đường A', '0123456780'),
       ('DVN002', N'Đơn vị nhận B', N'200 Đường B', '0987654322'),
       ('DVN003', N'Đơn vị nhận C', N'300 Đường C', '0112233446'),
       ('DVN004', N'Đơn vị nhận D', N'400 Đường D', '0223344557'),
       ('DVN005', N'Đơn vị nhận E', N'500 Đường E', '0334455668')

--Thêm dữ liệu cho bảng NguoiNhan
INSERT INTO NguoiNhan (MaNN, TenNN, SDT, MaDVN)
VALUES ('NN001', N'Người nhận A', '0123456780', 'DVN001'),
       ('NN002', N'Người nhận B', '0987654322', 'DVN002'),
       ('NN003', N'Người nhận C', '0112233446', 'DVN003'),
       ('NN004', N'Người nhận D', '0223344557', 'DVN004'),
       ('NN005', N'Người nhận E', '0334455668', 'DVN005')

--Thêm dữ liệu cho bảng Luong
INSERT INTO Luong (MaCV, TenCV, LuongCB, HSL)
VALUES ('CV001', N'Chức vụ A', 5000000, 1.2),
       ('CV002', N'Chức vụ B', 6000000, 1.5),
       ('CV003', N'Chức vụ C', 7000000, 1.8),
       ('CV004', N'Chức vụ D', 8000000, 2.0),
       ('CV005', N'Chức vụ E', 9000000, 2.2)

--Thêm dữ liệu cho bảng NhanVien
INSERT INTO NhanVien (MaNV, TenNV, GioiTinh, DiaChi, Ngayvaolam, MaCV, MaKho)
VALUES ('NV001', N'Nhân viên A', N'Nam', N'123 Đường A', '2023-01-01', 'CV001', 'K001'),
       ('NV002', N'Nhân viên B', N'Nữ', N'456 Đường B', '2023-02-01', 'CV002', 'K002'),
       ('NV003', N'Nhân viên C', N'Nam', N'789 Đường C', '2023-03-01', 'CV003', 'K003'),
       ('NV004', N'Nhân viên D', N'Nữ', N'101 Đường D', '2023-04-01', 'CV004', 'K004'),
       ('NV005', N'Nhân viên E', N'Nam', N'202 Đường E', '2023-05-01', 'CV005', 'K005')

--Thêm dữ liệu cho bảng NhanVien_SDT
INSERT INTO NhanVien_SDT (MaNV, SDT)
VALUES ('NV001', '0123456780'),
       ('NV002', '0987654322'),
       ('NV003', '0112233446'),
       ('NV004', '0223344557'),
       ('NV005', '0334455668')

--Thêm dữ liệu cho bảng PhieuNhap
INSERT INTO PhieuNhap (SoPhieuN, NgayNhap, MaNG, MaNV, MaKho)
VALUES ('PN001', '2023-01-01', 'NG001', 'NV001', 'K001'),
       ('PN002', '2023-02-01', 'NG002', 'NV002', 'K002'),
       ('PN003', '2023-03-01', 'NG003', 'NV003', 'K003'),
       ('PN004', '2023-04-01', 'NG004', 'NV004', 'K004'),
       ('PN005', '2023-05-01', 'NG005', 'NV005', 'K005')

--Thêm dữ liệu cho bảng ChiTietPhieuN
INSERT INTO ChiTietPhieuN (SoPhieuN, MaVT, SoLuongN, DonGiaN)
VALUES ('PN001', 'VT001', 100, 20000),
       ('PN002', 'VT002', 150, 25000),
       ('PN003', 'VT003', 200, 30000),
       ('PN004', 'VT004', 250, 35000),
       ('PN005', 'VT005', 300, 40000)

--Thêm dữ liệu cho bảng PhieuXuat
INSERT INTO PhieuXuat (SoPhieuX, NgayXuat, MaNN, MaNV, MaKho)
VALUES ('PX001', '2023-06-01', 'NN001', 'NV001', 'K001'),
       ('PX002', '2023-07-01', 'NN002', 'NV002', 'K002'),
       ('PX003', '2023-08-01', 'NN003', 'NV003', 'K003'),
       ('PX004', '2023-09-01', 'NN004', 'NV004', 'K004'),
       ('PX005', '2023-10-01', 'NN005', 'NV005', 'K005')

--Thêm dữ liệu cho bảng ChiTietPhieuX
INSERT INTO ChiTietPhieuX (SoPhieuX, MaVT, SoLuongX, DonGiaX)
VALUES ('PX001', 'VT001', 50, 21000),
       ('PX002', 'VT002', 75, 26000),
       ('PX003', 'VT003', 100, 31000),
       ('PX004', 'VT004', 125, 36000),
       ('PX005', 'VT005', 150, 41000)

--Thêm dữ liệu cho bảng TonKho
INSERT INTO TonKho (MaVT, NamThang, SoLuongTon, MaKho)
VALUES ('VT001', '2023-06-01', 1000, 'K001'),
       ('VT002', '2023-07-01', 1500, 'K002'),
       ('VT003', '2023-08-01', 2000, 'K003'),
       ('VT004', '2023-09-01', 2500, 'K004'),
       ('VT005', '2023-10-01', 3000, 'K005')


--Bảng LoaiVatTu 
--Thêm
CREATE PROCEDURE ThemLoaiVatTu
    @MaLoaiVT CHAR(10),
    @TenLoaiVT NVARCHAR(50)
AS
BEGIN
    INSERT INTO LoaiVatTu ([MaLoaiVT],[LoaiVT])
    VALUES (@MaLoaiVT, @TenLoaiVT)
END

EXEC ThemLoaiVatTu 'ngoaithatcc' , N'Ngoại thất CC' 

--Sửa 
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

EXEC SuaLoaiVatTu 'ngoaithat' , N'Ngoại Thất' , N'Mô tả ngoại thất '

--Xóa 
CREATE PROCEDURE XoaLoaiVatTu
    @MaLoaiVT CHAR(10)
AS
BEGIN
    DELETE 
    FROM LoaiVatTu 
    WHERE MaLoaiVT = @MaLoaiVT
END

EXEC XoaLoaiVatTu 'ngoaithatcc'

-- Lấy thông tin 
CREATE PROCEDURE LayThongTinLoaiVatTu 
    @MaLoaiVT CHAR(10) 
AS 
BEGIN 
    SELECT * 
    FROM [dbo].[LoaiVatTu]
    WHERE [MaLoaiVT] = @MaLoaiVT 
END 

EXEC LayThongTinLoaiVatTu 'ngoaithat'

-- Bảng VatTu 
--Thêm VatTu
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

EXEC ThemVatTu 'VT006' , 'Ống nhựa' , 'm' ,

--Sửa VatTu
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


--Xóa VatTu
CREATE PROCEDURE XoaVatTu
    @MaVT CHAR(10)
AS
BEGIN
    DELETE 
    FROM VatTu
    WHERE MaVT = @MaVT;
END

-- Lấy thông tin
CREATE PROCEDURE sp_GetVatTu
    @MaVT CHAR(10)
AS
BEGIN
    SELECT * FROM VatTu
    WHERE MaVT = @MaVT;
END


-- Bảng lương 
--Thêm 
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

--Sửa 
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

--Xóa
CREATE PROCEDURE XoaLuong
    @MaCV CHAR(10)
AS
BEGIN 
    DELETE 
    FROM [dbo].[Luong]
    WHERE [MaCV] = @MaCV 
END

--Lấy thông tin
CREATE PROCEDURE LayThongTinLuong
    @MaCV CHAR(10)
AS
BEGIN
    SELECT *
    FROM [dbo].[Luong]
    WHERE MaCV = @MaCV 
END


--Bảng NhanVien 
--Thêm 
CREATE PROCEDURE ThemNhanVien
    @MaNV CHAR(10),
    @TenNV NVARCHAR(50),
    @GioiTinh CHAR(3),
    @DiaChi NVARCHAR(70),
    @NgayVaoLam DATE,
    @MaCV CHAR(10),
    @MaKho CHAR(10)
AS
BEGIN
    INSERT INTO NhanVien (MaNV, TenNV, GioiTinh, DiaChi, NgayVaoLam, MaCV ,MaKho)
    VALUES (@MaNV, @TenNV, @GioiTinh, @DiaChi, @NgayVaoLam, @MaCV,@MaKho)
END

--Sửa
CREATE PROCEDURE SuaNhanVien
    @MaNV CHAR(10),
    @TenNV NVARCHAR(50),
    @GioiTinh CHAR(3),
    @DiaChi NVARCHAR(70),
    @NgayVaoLam DATE,
    @MaCV CHAR(10),
    @MaKho CHAR(10)
AS
BEGIN 
    UPDATE [dbo].[NhanVien]
    SET [TenNV] =  @TenNV , [GioiTinh] = @GioiTinh , [DiaChi] = @DiaChi , [Ngayvaolam] = @NgayVaoLam , [MaCV] = @MaCV , [MaKho] = @MaKho 
    WHERE [MaNV] =  @MaNV 
END

--Xóa
CREATE PROCEDURE XoaNhanVien
    @MaNV CHAR(10)
AS
BEGIN
    DELETE FROM NhanVien
    WHERE MaNV = @MaNV
END
