USE QLBANHANG
--SanPham(MaSP, MaHangSX, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa)
--HangSX(MaHangSX, TenHang, DiaChi, SoDT, Email)
--NhanVien(MaNV, TenNV, GioiTinh, DiaChi, SoDT, Email, TenPhong)
--Nhap(SoHDN, MaSP, SoLuongN, DonGiaN)
--PNhap(SoHDN,NgayNhap,MaNV)
--Xuat(SoHDX, MaSP, SoLuongX)
--PXuat(SoHDX,NgayXuat,MaNV)
--
-------------------------------------------------------
--. Hãy Đưa ra tổng tiền nhập của mỗi nhân viên trong tháng 8 – năm 2018 có tổng giá
--trị lớn hơn 100.000
SELECT PNH.MaNV, NV.TenNV, SUM(NH.DonGiaN * NH.SoLuongN) AS TongTienNhap
FROM PNhap PNH
JOIN Nhap NH ON PNH.SoHDN = NH.SoHDN
JOIN NhanVien NV ON PNH.MaNV = NV.MaNV
WHERE MONTH(PNH.NgayNhap) = 8 AND YEAR(PNH.NgayNhap) = 2018
GROUP BY PNH.MaNV, NV.TenNV
HAVING SUM(NH.DonGiaN * NH.SoLuongN) > 100000;
--Hãy Đưa ra danh sách các sản phẩm đã nhập nhưng chưa xuất bao giờ.
Select SanPham.MaSP,TenSP
From SanPham 
Inner join nhap on SanPham.MaSP = nhap.MaSP
Where SanPham.MaSP Not In (Select MaSP From Xuat)
--Hãy Đưa ra danh sách các sản phẩm đã nhập năm 2020 và đã xuất năm 2020
SELECT DISTINCT SP.MaSP, SP.TenSP
FROM SanPham SP
JOIN Nhap N ON SP.MaSP = N.MaSP
JOIN PNhap P ON N.SoHDN = P.SoHDN
JOIN Xuat X ON SP.MaSP = X.MaSP
JOIN PXuat PX ON X.SoHDX = PX.SoHDX
WHERE YEAR(P.NgayNhap) = 2020 AND YEAR(PX.NgayXuat) = 2020;
--ĐƯA RA NHÂN VIÊN VỪA NHẬP VỪA XUẤT
SELECT DISTINCT NV.MaNV, NV.TenNV
FROM NhanVien NV
JOIN PNhap P ON NV.MaNV = P.MaNV
JOIN PXuat PX ON NV.MaNV = PX.MaNV;
--Hãy Đưa ra danh sách các nhân viên không tham gia việc nhập và xuất.
SELECT NV.MaNV, NV.TenNV
FROM NhanVien NV
WHERE NV.MaNV NOT IN ( SELECT DISTINCT MaNV FROM PNhap) 
and  NV.MaNV NOT IN (SELECT DISTINCT MaNV FROM PXuat)


