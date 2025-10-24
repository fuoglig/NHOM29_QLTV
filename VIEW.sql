USE NHOM29_QLTV;

-- View hiển thị thông tin chi tiết sách
CREATE OR ALTER VIEW V_CHITIETCUONSACH
AS
SELECT CUONSACH.ma_cuon_sach,SACH.ten_sach, THELOAI.ten_the_loai, NHAXUATBAN.ten_nxb, SACH.nam_xuat_ban,
	VITRI.tang, VITRI.khu_vuc, VITRI.ke_sach, CUONSACH.trang_thai
FROM CUONSACH, SACH, THELOAI, NHAXUATBAN, VITRI
WHERE CUONSACH.ma_sach = SACH.ma_sach
    AND SACH.ma_the_loai = THELOAI.ma_the_loai
    AND SACH.ma_nxb = NHAXUATBAN.ma_nxb
    AND CUONSACH.ma_vi_tri = VITRI.ma_vi_tri;

SELECT * FROM V_CHITIETCUONSACH;

-- View hiển thị danh sách cuốn sách có sẵn để mượn
CREATE OR ALTER VIEW V_CUONSACHCOSAN
AS
SELECT CUONSACH.ma_cuon_sach, SACH.ten_sach, VITRI.tang, VITRI.khu_vuc, VITRI.ke_sach, CUONSACH.trang_thai
FROM CUONSACH, SACH, VITRI
WHERE CUONSACH.ma_sach = SACH.ma_sach
    AND CUONSACH.ma_vi_tri = VITRI.ma_vi_tri
    AND CUONSACH.trang_thai = N'Có sẵn';

SELECT * FROM V_CUONSACHCOSAN;

-- View hiển thị độc giả trả sách quá hạn
CREATE OR ALTER VIEW V_DOCGIA_TRASACHQUAHAN
AS
SELECT DOCGIA.ma_doc_gia, DOCGIA.ho_ten AS ten_doc_gia, PHIEUTRA.ma_phieu_tra,
    PHIEUMUON.ngay_muon, PHIEUMUON.han_tra, PHIEUTRA.ngay_tra,
    DATEDIFF(DAY, PHIEUMUON.han_tra, PHIEUTRA.ngay_tra) AS so_ngay_qua_han
FROM PHIEUTRA, PHIEUMUON, DOCGIA
WHERE PHIEUTRA.ma_phieu_muon = PHIEUMUON.ma_phieu_muon
  AND PHIEUTRA.ma_doc_gia = DOCGIA.ma_doc_gia
  AND PHIEUTRA.ngay_tra > PHIEUMUON.han_tra;

SELECT * FROM V_DOCGIA_TRASACHQUAHAN;