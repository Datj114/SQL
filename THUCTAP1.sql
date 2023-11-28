create DATABASE THUCTAP1
GO
USE THUCTAP1
CREATE TABLE KHOA(
MAKHOA CHAR(10) PRIMARY KEY NOT NULL,
TENKHOA CHAR(30),
DIENTHOAI CHAR(10)
)
CREATE TABLE GIANGVIEN(
MAGV INT NOT NULL PRIMARY KEY,
HOTENGV CHAR(30),
LUONG DECIMAL(5,2),
MAKHOA CHAR(10) NOT NULL FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA) ON UPDATE CASCADE ON DELETE CASCADE)

CREATE TABLE SINHVIEN(
MASV INT NOT NULL PRIMARY KEY,
HOTENSV CHAR(30) ,
MAKHOA CHAR(10),
NAMSINH INT,
QUEQUAN CHAR(30)
)

CREATE TABLE DETAI(
MADT CHAR(10) NOT NULL PRIMARY KEY,
TENDT CHAR(30),
KINHPHI INT,
NOITHUCTAP CHAR(30)
)

CREATE TABLE HUONGDAN(
MASV INT PRIMARY KEY NOT NULL,
MADT CHAR(10) NOT NULL FOREIGN KEY (MADT) REFERENCES DETAI(MADT) ON UPDATE CASCADE ON DELETE CASCADE,
MAGV INT NOT NULL FOREIGN KEY (MAGV) REFERENCES GIANGVIEN(MAGV) ON UPDATE CASCADE ON DELETE CASCADE,
KETQUA DECIMAL(5,2)
)
INSERT INTO Khoa VALUES ('K1', 'Khoa CNTT', '1234567890');
INSERT INTO Khoa VALUES ('K2', 'Khoa KT', '0987654321');
INSERT INTO Khoa VALUES ('K3', 'Khoa OTO', '1234567899');
INSERT INTO Khoa VALUES ('K4', 'Khoa NN', '0987654391');
-- Thêm dữ liệu cho các Khoa khác...
SELECT * FROM HUONGDAN
INSERT INTO GiangVien VALUES (111, 'Nguyen Van A', 500.00, 'K1');
INSERT INTO GiangVien VALUES (222, 'Tran Thi B', 550.00, 'K2');
-- Thêm dữ liệu cho các GiangVien khác...
INSERT INTO SinhVien VALUES (101, 'Le Van C', 'K1', 1998, 'Hanoi');
INSERT INTO SinhVien VALUES (102, 'Pham Thi D', 'K2', 1999, 'HCMC');
-- Thêm dữ liệu cho các SinhVien khác...
INSERT INTO DeTai VALUES ('DT1', 'Đề tài 1', 1000, 'Cong ty ABC');
INSERT INTO DeTai VALUES ('DT2', 'Đề tài 2', 1200, 'Cong ty XYZ');

-- Thêm dữ liệu cho các DeTai khác...
INSERT INTO HuongDan VALUES (101, 'DT1', 111, 900.5);
INSERT INTO HuongDan VALUES (102, 'DT2', 222, 880.0);
-- Thêm dữ liệu cho các HuongDan khác...

--ho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
SELECT DETAI.MADT,TENDT
FROM DETAI
JOIN HUONGDAN ON DETAI.MADT=HUONGDAN.MADT
JOIN GIANGVIEN ON GIANGVIEN.MAGV=HUONGDAN.MAGV
WHERE HOTENGV='Tran son'
--Cho biết tên đề tài không có sinh viên nào thực tập
SELECT TENDT
FROM DETAI
JOIN HUONGDAN ON DETAI.MADT=HUONGDAN.MADT
WHERE MASV IS NULL

--Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên
--trở lên
SELECT GIANGVIEN.MAGV, HOTENGV, TENKHOA
FROM GIANGVIEN
JOIN HUONGDAN ON GIANGVIEN.MAGV=HUONGDAN.MAGV
JOIN KHOA ON GIANGVIEN.MAKHOA=KHOA.MAKHOA
JOIN SinhVien ON HuongDan.MaSV = SinhVien.MaSV
GROUP BY GiangVien.MaGV, GiangVien.HoTenGV, Khoa.TenKhoa
HAVING COUNT(DISTINCT SinhVien.MaSV) >= 3;

----Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhấtSELECT MADT,TENDT FROM DETAIWHERE KINHPHI =(SELECT MAX(KINHPHI) FROM DETAI)--Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tậpSELECT DETAI.MADT,TENDTFROM DETAIJOIN HUONGDAN ON DETAI.MADT=HUONGDAN.MADTGROUP BY DETAI.MADT,TENDTHAVING (COUNT(MASV)=1)--SELECT Khoa.TenKhoa, COUNT(SinhVien.MaSV) AS SoLuongSinhVien
FROM Khoa
JOIN Lop ON Khoa.MaKhoa = Lop.MaKhoa
JOIN SinhVien ON Lop.MaLop = SinhVien.MaLop
GROUP BY Khoa.TenKhoa;
--
SELECT SinhVien.MaSV, SinhVien.HoTen, SinhVien.NgaySinh, SinhVien.GioiTinh, Lop.TenLop, Khoa.TenKhoa
FROM SinhVien
JOIN Lop ON SinhVien.MaLop = Lop.MaLop
JOIN HuongDan ON SinhVien.MaSV = HuongDan.MaSV
JOIN DeTai ON HuongDan.MaDT = DeTai.MaDT
JOIN Khoa ON Lop.MaKhoa = Khoa.MaKhoa
WHERE SinhVien.QueQuan = Khoa.TenKhoa;
--
SELECT SinhVien.MaSV, SinhVien.HoTen, SinhVien.NgaySinh, SinhVien.GioiTinh, Lop.TenLop, Khoa.TenKhoa
FROM SinhVien
JOIN Lop ON SinhVien.MaLop = Lop.MaLop
LEFT JOIN HuongDan ON SinhVien.MaSV = HuongDan.MaSV
WHERE HuongDan.MaSV IS NULL;
--
SELECT SinhVien.MaSV, SinhVien.HoTen
FROM SinhVien
JOIN HuongDan ON SinhVien.MaSV = HuongDan.MaSV
WHERE HuongDan.Diem IS NULL OR HuongDan.Diem = 0;

