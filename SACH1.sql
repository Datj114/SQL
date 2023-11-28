--Bảng Sách: SACH(MaSach, TenSach, TheLoai, Slco)
--Bảng Phiếu nhập: PHIEUNHAP(SoPN, NgayLap, MaCuaHang)
--Bảng Chi tiết phiếu nhập: CTPN(SoPN,MaSach, SLNhap, DonGia
CREATE DATABASE SACH_V1
GO
USE SACH_V1
CREATE TABLE SACH (
    MASACH NCHAR(10) PRIMARY KEY,
    TENSACH NVARCHAR(255),
    THELOAI NVARCHAR(50),
    SLCO INT
);
CREATE TABLE PHIEUNHAP (
    SOPN NCHAR(10) PRIMARY KEY,
    NGAYLAP DATE,
    MACUAHANG NCHAR(10)
);
CREATE TABLE CTPN (
    SOPN NCHAR(10),
    MASACH NCHAR(10),
    SLNHAP INT,
    GIABAN DECIMAL(18, 2),
    PRIMARY KEY (SOPN, MASACH),
    FOREIGN KEY (SOPN) REFERENCES PHIEUNHAP(SOPN) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MaSach) REFERENCES SACH(MaSach) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO SACH (MaSach, TenSach, TheLoai, Slco)
VALUES
    ('S001', 'Harry Potter and the Sorcerer''s Stone', 'Fantasy', 100),
    ('S002', 'To Kill a Mockingbird', 'Fiction', 80),
    ('S003', '1984', 'Dystopian', 120),
    ('S004', 'The Great Gatsby', 'Classic', 90),
    ('S005', 'The Catcher in the Rye', 'Coming-of-age', 110);
INSERT INTO PHIEUNHAP (SoPN, NgayLap, MaCuaHang)
VALUES
    ('PN001', '2023-01-10', 'CH001'),
    ('PN002', '2023-02-15', 'CH002'),
    ('PN003', '2023-03-20', 'CH003');
INSERT INTO CTPN (SoPN, MaSach, SLNhap, GIABAN)
VALUES
    ('PN001', 'S001', 20, 100.5),
    ('PN001', 'S002', 15, 80.5),
    ('PN002', 'S003', 25, 12.0),
    ('PN003', 'S004', 18, 15.0),
    ('PN003', 'S005', 22, 18.5);

--Lấy ra tên sách thuộc thể loại sách giáo khoa.
SELECT TENSACH 
FROM SACH
WHERE THELOAI=N'sách giáo khoa';
--Lấy ra số phiếu nhập và tên sách được nhập trước ngày 10/12/2021'.
SELECT PHIEUNHAP.SOPN,TENSACH
FROM PHIEUNHAP
JOIN CTPN ON PHIEUNHAP.SOPN=CTPN.SOPN
JOIN SACH ON CTPN.MASACH=SACH.MASACH
WHERE NGAYLAP< '10/12/2021'

--Lấy ra số phiếu nhập các sách có mã ‘SGK01' sau ngày 25/02/2021'
SELECT PHIEUNHAP.SOPN
FROM PHIEUNHAP
JOIN CTPN ON PHIEUNHAP.SOPN=CTPN.SOPN
WHERE MASACH='SGK01' AND NGAYLAP >'2021-02-25';
--Lấy ra tên sách được nhập bởi cửa hàng có mã là 'CH2' với số lượng nhập ít hơn 1000
SELECT TENSACH
FROM SACH
JOIN CTPN ON CTPN.MASACH=SACH.MASACH
JOIN PHIEUNHAP ON PHIEUNHAP.SOPN=CTPN.SOPN

WHERE MACUAHANG='CH2' AND SLNHAP <1000;
--Lấy ra số phiếu nhập nhập cả 2 quyển sách có tên là “sách toán 6' và 'sách toán 7'
SELECT SOPN
FROM CTPN
JOIN SACH ON CTPN.MASACH=SACH.MASACH
WHERE TENSACH IN ('Sách toán 6', 'Sách toán 7') ;
--Lấy ra mã sách đã xuất hiện trong tất cả các phiếu nhập
SELECT MaSach
FROM CTPN
GROUP BY MaSach
HAVING COUNT(DISTINCT SoPN) = (SELECT COUNT(DISTINCT SoPN) FROM PHIEUNHAP);
--User
--Lấy ra tên sách, số lượng có của các sách thuộc thể loại 'sách giáo khoa'.
SELECT SACH.TenSach, COUNT(CTPN.MaSach) AS SoLuong
FROM SACH
JOIN CTPN ON SACH.MaSach = CTPN.MaSach
JOIN PHIEUNHAP ON CTPN.SoPN = PHIEUNHAP.SoPN
WHERE SACH.TheLoai = 'sách giáo khoa'
GROUP BY SACH.TenSach;
--Lấy ra số phiếu nhập và tên sách có đơn giá nhập không nhỏ hơn 2000.
SELECT PHIEUNHAP.SoPN, SACH.TenSach
FROM CTPN
JOIN PHIEUNHAP ON CTPN.SoPN = PHIEUNHAP.SoPN
JOIN SACH ON CTPN.MaSach = SACH.MaSach
WHERE CTPN.GIABAN >= 2000;
--Lấy ra tên các quyển sách có tên chứa cụm từ “giáo khoa được nhập bởi cửa hàng có mã là 'CHI'.
SELECT DISTINCT SACH.TenSach
FROM SACH
JOIN CTPN ON SACH.MaSach = CTPN.MaSach
JOIN PHIEUNHAP ON CTPN.SoPN = PHIEUNHAP.SoPN
WHERE SACH.TenSach LIKE '%giáo khoa%' AND PHIEUNHAP.MaCuaHang = 'CHI';
--
SELECT TOP 1 CTPN.MaSach, TenSach
FROM CTPN
JOIN SACH ON CTPN.MaSach = SACH.MaSach
ORDER BY CTPN.GIABAN ASC;
-- DEM TONG SO LUONG NHAP THEO MA SACH
SELECT MaSach, SUM(SLNhap) AS TongSoLuongNhap
FROM CTPN
GROUP BY MaSach;

--
--Lấy ra số phiếu nhập đã nhập ít nhất 2 đầu sách thuộc thể loại sách giáo khoa'.
SELECT SoPN
FROM CTPN
JOIN SACH ON CTPN.MaSach = SACH.MaSach
WHERE SACH.TheLoai = 'sách giáo khoa'
GROUP BY SoPN
HAVING COUNT(DISTINCT CTPN.MaSach) >= 2;

