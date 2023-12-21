﻿-- Bảng Nhân viên: NhanVien(MaNV TenNV, TrinhDo, ChucVu)
--Bảng Khóa học: KhoaHoc(MaKH, TenKH, DiaDiem)
--Bàng Tham gia: Tham Gia MANY, MaKH, SoBuoiNghi, KetQua)
CREATE DATABASE QLNHANVIEN1
USE QLNHANVIEN1
CREATE TABLE NHANVIEN(
MANV NCHAR(20) NOT NULL PRIMARY KEY,
TENNV NCHAR(20),
TRINHDO NCHAR(20),
CHUCVU NCHAR(20))

CREATE TABLE KHOAHOC(
MAKH NCHAR(20) NOT NULL PRIMARY KEY,
TENKH NCHAR(20),
DIADIEM NCHAR(20))

CREATE TABLE THAMGIA (
MANV NCHAR(20) NOT NULL,
MAKH NCHAR(20) NOT NULL,
SOBUOINGHI INT,
KETQUA NCHAR(20)
CONSTRAINT PR PRIMARY KEY (MANV,MAKH),
CONSTRAINT PRNV FOREIGN KEY (MANV) REFERENCES  NHANVIEN(MANV) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT PRKH FOREIGN KEY (MAKH) REFERENCES  KHOAHOC(MAKH) ON UPDATE CASCADE ON DELETE CASCADE
)
INSERT INTO NHANVIEN VALUES
(N'NV01',N'Trần Văn Ước ',N'Đại học',N'Nhân viên '),
(N'NV02',N'Hoàng Văn Huy',N'Đại học',N'Trưởng phòng'),
(N'NV03',N'Nguyễn Thị Chính',N'Cao ',N'Nhân viên')
INSERT INTO KHOAHOC VALUES
(N'KH01',N'Giao tiếp cơ bản',N'Hà Nội'),
(N'KH02',N'Giao tiếp nâng cao',N'Hà Nội'),
(N'KH03',N'Phân tích số liệu',N'Hồ Chí Minh')
INSERT INTO THAMGIA VALUES
(N'NV01',N'KH01',1,N'Khá'),
(N'NV01',N'KH02',2,N'Khá'),
(N'NV02',N'KH01',0,N'Giỏi'),
(N'NV02',N'KH02',1,N'Khá'),
(N'NV02',N'KH03',1,N'Trung bình'),
(N'NV03',N'KH01',4,N'Trung bình')
SELECT * FROM NHANVIEN
SELECT * FROM KHOAHOC
SELECT * FROM THAMGIA
--a. Lấy ra từ cơ sở dữ liệu tên các nhân viên có trình độ đại học.
SELECT TENNV FROM NHANVIEN WHERE TRINHDO =N'Đại học'
--b. Lấy ra tên các nhân viên tham gia khóa học Giao nếp nâng cao có kết quả Khá
SELECT TENNV FROM NHANVIEN
JOIN THAMGIA ON THAMGIA.MANV=NHANVIEN.MANV
WHERE MAKH=N'KH02' AND KETQUA=N'Khá'

--Lấy ra mà nhân viên, tên nhân viên, số buổi nghĩ và kết quả của các nhân viên tham gia các khóa học về
--giao tiếp.
SELECT NHANVIEN.MANV,TENNV,SOBUOINGHI,KETQUA FROM NHANVIEN
JOIN THAMGIA ON THAMGIA.MANV=NHANVIEN.MANV
JOIN KHOAHOC ON THAMGIA.MAKH=KHOAHOC.MAKH
WHERE TENKH LIKE N'Giao tiếp%'

--d. Lấy ra tên nhân viên và đếm số khóa học nhân viên đó đã tham gia.
SELECT TENNV , COUNT(MAKH) FROM NHANVIEN 
JOIN THAMGIA ON THAMGIA.MANV=NHANVIEN.MANV
GROUP BY TENNV
--e. Lấy ra mã và tên các khóa học có từ 2 nhân viên trở lên tham gia học và đạt kết quả Khá 
SELECT KHOAHOC.MAKH,TENKH FROM KHOAHOC
JOIN THAMGIA ON THAMGIA.MAKH=KHOAHOC.MAKH
WHERE KETQUA=N'Khá'
GROUP BY KHOAHOC.MAKH,TENKH
HAVING COUNT(MANV) >=2
--1. Lấy ra mà và tên nhân viên đã tham gia tất cả các khóa học đã được tổ chức.
SELECT NHANVIEN.MANV, TENNV FROM NHANVIEN
JOIN THAMGIA ON NHANVIEN.MANV=THAMGIA.MANV
GROUP BY NHANVIEN.MANV, TENNV 
HAVING COUNT(MAKH) = (SELECT COUNT(MAKH) FROM KHOAHOC)