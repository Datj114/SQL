﻿CREATE DATABASE THUCTAP
GO 
USE THUCTAP
CREATE TABLE KHOA(
MAKHOA NCHAR(20) NOT NULL PRIMARY KEY,
TENKHOA NCHAR(20) 
)
CREATE TABLE LOP(
MALOP NCHAR(20) NOT NULL PRIMARY KEY,
TENLOP NCHAR(20),
SISO INT,
MAKHOA NCHAR(20) NOT NULL FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA) ON UPDATE CASCADE ON DELETE CASCADE)

CREATE TABLE SINHVIEN(
MASV NCHAR(20) NOT NULL PRIMARY KEY,
HOTEN NCHAR(20),
NGAYSINH DATE,
GIOITINH BIT,
MALOP NCHAR(20) NOT NULL FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
)
-- Nhập dữ liệu cho bảng Khoa
INSERT INTO Khoa (MaKhoa, TenKhoa) VALUES
    ('K1', 'Khoa CNTT'),
    ('K2', 'Khoa Kinh Te')

-- Nhập dữ liệu cho bảng Lop
INSERT INTO Lop (MaLop, TenLop, SiSo, MaKhoa) VALUES
    ('L1', 'Lop 1', 30, 'K1'),
    ('L2', 'Lop 2', 25, 'K2'),
	('L3', 'Lop 3', 11, 'K2');


-- Nhập dữ liệu cho bảng SinhVien
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, GioiTinh, MaLop) VALUES
    ('SV1', 'Nguyen Van A', '2000-01-01', 1, 'L1'),
    ('SV2', 'Tran Thi B', '2000-02-15', 0, 'L1'),
    ('SV3', 'Le Van C', '2000-03-20', 1, 'L1'),
    ('SV4', 'Pham Thi D', '2001-04-05', 0, 'L2'),
    ('SV5', 'Ho Van E', '2001-05-10', 1, 'L2'),
    ('SV6', 'Nguyen Thi F', '2001-06-15', 0, 'L2'),
    ('SV7', 'Tran Van G', '2002-07-20', 1, 'L2');

--. Đưa ra thống kê số lớp của từng khoa gồm các thông tin: TenKhoa, Số lớp

SELECT TENKHOA, COUNT(TENLOP) AS SOLOP
FROM KHOA
JOIN LOP ON KHOA.MAKHOA=LOP.MAKHOA
GROUP BY TENKHOA
--Đưa ra những sinh viên ít tuổi nhất (của một khoa nào đó) gồm: MaSV, HoTen, Tuổi.
SELECT MASV,HOTEN,YEAR(GETDATE())-YEAR(NGAYSINH ) AS TUOI
FROM SINHVIEN
JOIN LOP ON SINHVIEN.MALOP=LOP.MALOP
WHERE  LOP.MAKHOA='K1'AND YEAR(GETDATE())-YEAR(NGAYSINH )= (SELECT MIN(YEAR(GETDATE())-YEAR(NGAYSINH )) FROM SINHVIEN JOIN LOP ON SINHVIEN.MALOP=LOP.MALOP
WHERE LOP.MAKHOA='K1') 

--. Đưa ra một danh sách gồm: MaSV, HoTen, NgaySinh, TenLop, TenKhoa, Tuoi trong khoảng 18-25  

SELECT MASV, HOTEN, NGAYSINH, TENLOP, TENKHOA, YEAR(GETDATE())-YEAR(NGAYSINH) AS TUOI
FROM SINHVIEN
JOIN LOP ON SINHVIEN.MALOP=LOP.MALOP
JOIN KHOA ON LOP.MAKHOA = KHOA.MAKHOA
WHERE  YEAR(GETDATE())-YEAR(NGAYSINH) >=18 AND  YEAR(GETDATE())-YEAR(NGAYSINH) <=25

--5. Đưa ra sinh viên có tuổi lớn nhất gồm các thông tin: MaSV, HoTen, NgaySinh, GioiTinh , TenLop, Tenkhoa.
SELECT MASV, HOTEN, NGAYSINH, GIOITINH,TENLOP,TENKHOA
FROM SINHVIEN
JOIN LOP ON SINHVIEN.MALOP=LOP.MALOP
JOIN KHOA ON LOP.MAKHOA=KHOA.MAKHOA
WHERE YEAR(GETDATE())-YEAR(NGAYSINH) = (SELECT MAX(YEAR(GETDATE())-YEAR(NGAYSINH)) FROM SINHVIEN)

--Hãy tạo View đưa ra thống kê số lớp của từng khoa gồm các thông tin: TenKhoa, Số lớp
SELECT TENKHOA, COUNT(MALOP) AS SOLOP
FROM KHOA
JOIN LOP ON LOP.MAKHOA=KHOA.MAKHOA
GROUP BY TENKHOA