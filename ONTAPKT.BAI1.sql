https://github.com/Datj114/SQL/blob/main/image.png
CREATE DATABASE QLDAOTAO
USE QLDAOTAO
CREATE TABLE SV(
MASV NCHAR(20) PRIMARY KEY NOT NULL,
HO NCHAR(20),
TEN NCHAR(20),
TENLOP NCHAR(20))

CREATE TABLE MON(
MAMH NCHAR(20) NOT NULL PRIMARY KEY,
TENMH NCHAR(20),
SOTC INT)

CREATE TABLE KQ(
MASV NCHAR(20) NOT NULL,
MAMH NCHAR(20) NOT NULL,
DIEM FLOAT,
XEPLOAI CHAR(20)
CONSTRAINT  PR PRIMARY KEY(MASV,MAMH),
CONSTRAINT FRSV FOREIGN KEY (MASV) REFERENCES SV(MASV) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FRMH FOREIGN KEY (MAMH) REFERENCES MON(MAMH) ON UPDATE CASCADE ON DELETE CASCADE)

INSERT INTO SV VALUES
(N'SV01',N'TRAN VAN',N'Ước',N'IT6123'),
(N'SV02',N'Hoàng Văn',N'Huy',N'IT6031'),
(N'SV03',N'Nguyễn ',N'Chính',N'IT6123')
INSERT INTO MON VALUES
(N'H04',N'OOP',2)
INSERT INTO MON VALUES
(N'H01',N'Cơ sở dữ liệu',2),
(N'H02',N'Lập trình C',3),
(N'H03',N'Cấu trúc dữ liệu',3)
INSERT INTO KQ VALUES
(N'SV01',N'H01',8,N'B'),
(N'SV01',N'H02',7.5,N'B'),
(N'SV02',N'H01',9.5,N'A'),
(N'SV02',N'H02',7,N'B'),
(N'SV02',N'H03',5,N'C'),
(N'SV03',N'H01',6,N'C')
SELECT * FROM SV
SELECT * FROM MON
SELECT *FROM KQ

--Lấy ra từ cơ sở dữ liệu họ và tên các sinh viên thuộc lớp IT6123.
SELECT HO, TEN, TENLOP FROM SV
WHERE TENLOP = N'IT6123'
--b. Lấy ra tên các sinh viên có kết quả môn Cơ sở dữ liệu xếp loại A
SELECT TEN FROM SV 
JOIN KQ ON SV.MASV=KQ.MASV
WHERE MAMH=N'H01' AND XEPLOAI =N'A'
--c. Lấy ra mã, họ và tên các sinh viên, điểm và xếp loại của các môn học về dữ liệu.
SELECT SV.MASV, HO, TEN, DIEM,XEPLOAI FROM SV
JOIN KQ ON KQ.MASV=SV.MASV
JOIN MON ON MON.MAMH=KQ.MAMH
WHERE TENMH LIKE N'%dữ liệu%'
--d. Lấy ra tên môn học và số sinh viên lớp ‘IT6123' đã học môn học đó.
SELECT TENMH,COUNT(KQ.MASV) FROM MON
JOIN KQ ON KQ.MAMH=MON.MAMH
JOIN SV ON SV.MASV=KQ.MASV
WHERE TENLOP =N'IT6123'
GROUP BY TENMH
--e. Lấy ra mã và tên các môn học có dưới 3 sinh viên đã có kết quả.
SELECT MON.MAMH, TENMH FROM MON
LEFT JOIN KQ ON KQ.MAMH=MON.MAMH
GROUP BY MON.MAMH, TENMH
HAVING COUNT(MASV) <3 OR COUNT(MASV) IS NULL
--f. Lấy ra mã và tên sinh viên đã học tất cả các môn học.
SELECT SV.MASV,HO,TEN FROM SV
JOIN KQ ON KQ.MASV=SV.MASV
GROUP BY SV.MASV,HO,TEN
HAVING COUNT(MAMH)=(SELECT COUNT(MAMH) FROM MON)
--g. Lấy ra mã và tên môn học có nhiều sinh viên học nhất
SELECT MON.MAMH,TENMH FROM MON
JOIN KQ ON KQ.MAMH=MON.MAMH
GROUP BY MON.MAMH,TENMH
HAVING COUNT(MASV) = (SELECT MAX(SL) FROM (SELECT MAMH,COUNT(MASV) AS SL FROM KQ GROUP BY MAMH) AS BANGSL)
