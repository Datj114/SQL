﻿CREATE DATABASE QLSP
IF(EXISTS(SELECT *FROM SYSDATABASES WHERE NAME='QLSP'))
DROP DATABASE QLSP
GO 
CREATE DATABASE QLSP
USE QLSP
GO
CREATE TABLE NSX(
MANSX CHAR(20) NOT NULL PRIMARY KEY,
TENNSX CHAR(20),
DIACHI CHAR(20),
)

CREATE TABLE SANPHAM(
MASP CHAR(20) NOT NULL PRIMARY KEY,
TENSP CHAR(20),
MAU CHAR(20),
SOLUONG INT,
GIABAN DECIMAL(10,2),
)

CREATE TABLE CUNGCAP(
MANSX CHAR(20) NOT NULL,
MASP CHAR(20) NOT NULL,
SLCC int,
NGAYCC CHAR(20),
CONSTRAINT PK_SX_SP PRIMARY KEY (MANSX,MASP),
CONSTRAINT FK_SX FOREIGN KEY (MANSX) REFERENCES NSX(MANSX) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK_SP FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP) ON UPDATE CASCADE ON DELETE CASCADE
)
INSERT INTO NSX VALUES
(N'5',N'SS',N'VINHPHUC'),
(N'6',N'LG',N'HANOI'),
(N'17',N'TCL',N'HANAM')

INSERT INTO SANPHAM VALUES
(N'1',N'MAYCHIEU',N'TRANG',50,80000),
(N'2',N'TULANH',N'XANH',100,80000),
(N'3',N'DIEUHOA',N'TRANG',50,50000)

INSERT INTO CUNGCAP VALUES
(N'5',N'2',5,'2021-2-12'),
(N'6',N'2',5,'2022-2-12'),
(N'5',N'3',15,'2021-2-12'),
(N'6',N'1',20,'2022-6-2'),
(N'17',N'3',10,'2021-9-2'),
(N'17',N'1',20,'2021-9-2')
SELECT * FROM NSX
SELECT * FROM SANPHAM
SELECT * FROM CUNGCAP

SELECT * FROM NSX
SELECT TENNSX FROM NSX 
WHERE DIACHI =N'HANOI'

--
SELECT * FROM SANPHAM
SELECT TENSP,MAU FROM SANPHAM
WHERE GIABAN>8000000

--
SELECT TENSP FROM SANPHAM
WHERE SOLUONG >50
--
SELECT TENSP FROM SANPHAM
JOIN CUNGCAP ON CUNGCAP.MASP=SANPHAM.MASP
WHERE YEAR(NGAYCC)='2021'


--
SELECT TENSP FROM SANPHAM
JOIN CUNGCAP ON CUNGCAP.MASP=SANPHAM.MASP
JOIN NSX ON CUNGCAP.MANSX=NSX.MANSX
WHERE TENNSX='LG'
--
SELECT * FROM NSX
SELECT*FROM SANPHAM
SELECT TENSP, GIABAN
FROM SANPHAM
JOIN CUNGCAP ON CUNGCAP.MASP=SANPHAM.MASP
JOIN NSX ON CUNGCAP.MANSX=NSX.MANSX
WHERE TENNSX LIKE 'H%'
--
SELECT * FROM CUNGCAP
SELECT * FROM NSX
SELECT*FROM SANPHAM
SELECT DISTINCT TENNSX FROM NSX
JOIN CUNGCAP ON CUNGCAP.MANSX=NSX.MANSX
JOIN SANPHAM ON CUNGCAP.MASP=SANPHAM.MASP
WHERE MAU='TRANG'
--đếm số lượng sản phẩm đã bán năm 2022
SELECT  SUM(SLCC) from cungcap
WHERE YEAR(NGAYCC) = 2022


