USE NHOM29_QLTV;

-- Thủ tục thêm sách trong bảng SACH
CREATE OR ALTER PROC SP_THEM_SACH @ma_sach CHAR(10), @ma_the_loai CHAR(10), @ma_nxb CHAR(10), 
    @ten_sach NVARCHAR(200), @nam_xuat_ban INT, @so_luong_cuon INT
AS
    IF EXISTS (SELECT * FROM SACH WHERE ma_sach = @ma_sach)
        PRINT N'Thông báo: Mã sách này đã tồn tại'
    IF NOT EXISTS (SELECT * FROM THELOAI WHERE ma_the_loai = @ma_the_loai)
        PRINT N'Thông báo: Mã thể loại chưa có trong danh mục'
    IF NOT EXISTS (SELECT * FROM NHAXUATBAN WHERE ma_nxb = @ma_nxb)
        PRINT N'Thông báo: Mã nhà xuất bản chưa có trong danh mục'
    ELSE
        INSERT INTO SACH (ma_sach, ma_the_loai, ma_nxb, ten_sach, nam_xuat_ban, so_luong_cuon)
        VALUES (@ma_sach, @ma_the_loai, @ma_nxb, @ten_sach, @nam_xuat_ban, @so_luong_cuon)

EXEC SP_THEM_SACH 'S09', 'TL03', 'NXB01', N'Lập Trình Python', 2023, 2;
SELECT * FROM SACH;

-- Thủ tục sửa sách trong bảng SACH
CREATE OR ALTER PROC SP_SUA_SACH @ma_sach CHAR(10), @ten_sach NVARCHAR(200), 
	@nam_xuat_ban INT, @so_luong_cuon INT
AS
    IF NOT EXISTS (SELECT * FROM SACH WHERE ma_sach = @ma_sach)
        PRINT N'Thông báo: Mã sách này không tồn tại'
    ELSE
        UPDATE SACH
        SET ten_sach = @ten_sach,
            nam_xuat_ban = @nam_xuat_ban,
            so_luong_cuon = @so_luong_cuon
        WHERE ma_sach = @ma_sach

EXEC SP_SUA_SACH 'S09', N'Lập Trình Python Nâng Cao', 2024, 3;
SELECT * FROM SACH;

-- Thủ tục xoá sách trong bảng SACH
CREATE OR ALTER PROC SP_XOA_SACH @ma_sach CHAR(10)
AS
    IF NOT EXISTS (SELECT * FROM SACH WHERE ma_sach = @ma_sach)
        PRINT N'Thông báo: Không tìm thấy mã sách này'
    IF EXISTS (SELECT * FROM CUONSACH WHERE ma_sach = @ma_sach)
        PRINT N'Thông báo: Sách này đang có cuốn tồn tại, không thể xóa'
    ELSE
        DELETE FROM SACH
        WHERE ma_sach = @ma_sach

EXEC SP_XOA_SACH 'S09';
SELECT * FROM SACH;

-- Thủ tục thêm cuốn sách trong bảng CUONSACH
CREATE OR ALTER PROC SP_THEM_CUONSACH @ma_cuon_sach CHAR(10), @ma_sach CHAR(10), 
	@ma_vi_tri CHAR(10), @trang_thai NVARCHAR(50)
AS
    IF EXISTS (SELECT * FROM CUONSACH WHERE ma_cuon_sach = @ma_cuon_sach)
        PRINT N'Thông báo: Mã cuốn sách này đã tồn tại'
    IF NOT EXISTS (SELECT * FROM SACH WHERE ma_sach = @ma_sach)
        PRINT N'Thông báo: Mã sách chưa có trong danh mục'
    IF NOT EXISTS (SELECT * FROM VITRI WHERE ma_vi_tri = @ma_vi_tri)
        PRINT N'Thông báo: Mã vị trí chưa có trong danh mục'
    ELSE
        INSERT INTO CUONSACH (ma_cuon_sach, ma_sach, ma_vi_tri, trang_thai)
        VALUES (@ma_cuon_sach, @ma_sach, @ma_vi_tri, @trang_thai)

EXEC SP_THEM_CUONSACH 'CS0404', 'S04', 'VT03', N'Có sẵn';
SELECT * FROM CUONSACH;

-- Thủ tục sửa cuốn sách trong bảng CUONSACH
CREATE OR ALTER PROC SP_SUA_CUONSACH @ma_cuon_sach CHAR(10), @ma_vi_tri CHAR(10), @trang_thai NVARCHAR(50)
AS
    IF NOT EXISTS (SELECT * FROM CUONSACH WHERE ma_cuon_sach = @ma_cuon_sach)
        PRINT N'Thông báo: Mã cuốn sách này không tồn tại'
    IF NOT EXISTS (SELECT * FROM VITRI WHERE ma_vi_tri = @ma_vi_tri)
		PRINT N'Thông báo: Mã vị trí chưa có trong danh mục'
    ELSE
		UPDATE CUONSACH
        SET ma_vi_tri = @ma_vi_tri,
			trang_thai = @trang_thai
        WHERE ma_cuon_sach = @ma_cuon_sach

EXEC SP_SUA_CUONSACH 'CS0404', 'VT02', N'Đang mượn';
SELECT * FROM CUONSACH;

-- Thủ tục xoá cuốn sách trong bảng CUONSACH
CREATE OR ALTER PROC SP_XOA_CUONSACH @ma_cuon_sach CHAR(10)
AS
    IF NOT EXISTS (SELECT * FROM CUONSACH WHERE ma_cuon_sach = @ma_cuon_sach)
        PRINT N'Thông báo: Không tìm thấy mã cuốn sách này'
    ELSE
        DELETE FROM CUONSACH
        WHERE ma_cuon_sach = @ma_cuon_sach

EXEC SP_XOA_CUONSACH 'CS0404';
SELECT * FROM CUONSACH;

-- Thủ tục xem lịch sử mượn của độc giả bất kỳ
CREATE OR ALTER PROC SP_LICHSUMUON_DOCGIA @ma_doc_gia CHAR(10)
AS
BEGIN
    SELECT DOCGIA.ma_doc_gia, DOCGIA.ho_ten AS ten_doc_gia, PHIEUMUON.ma_phieu_muon, PHIEUMUON.ngay_muon,
        PHIEUMUON.han_tra, SACH.ten_sach, CHITIETPHIEUMUON.tinh_trang AS tinh_trang_khi_muon
    FROM DOCGIA, PHIEUMUON, CHITIETPHIEUMUON, CUONSACH, SACH
    WHERE DOCGIA.ma_doc_gia = @ma_doc_gia
        AND DOCGIA.ma_doc_gia = PHIEUMUON.ma_doc_gia
        AND PHIEUMUON.ma_phieu_muon = CHITIETPHIEUMUON.ma_phieu_muon
        AND CHITIETPHIEUMUON.ma_cuon_sach = CUONSACH.ma_cuon_sach
        AND CUONSACH.ma_sach = SACH.ma_sach
    ORDER BY PHIEUMUON.ngay_muon;
END

EXEC SP_LICHSUMUON_DOCGIA 'DG01';

-- Thủ tục xem lịch sử trả của độc giả bất kỳ
CREATE OR ALTER PROC SP_LICHSUTRA_DOCGIA @ma_doc_gia CHAR(10)
AS
BEGIN
    SELECT DOCGIA.ma_doc_gia, DOCGIA.ho_ten AS ten_doc_gia, PHIEUTRA.ma_phieu_tra, PHIEUTRA.ngay_tra,
        SACH.ten_sach, CHITIETPHIEUTRA.tinh_trang_khi_tra AS tinh_trang
    FROM DOCGIA, PHIEUTRA, CHITIETPHIEUTRA, CUONSACH, SACH
    WHERE DOCGIA.ma_doc_gia = @ma_doc_gia
        AND DOCGIA.ma_doc_gia = PHIEUTRA.ma_doc_gia
        AND PHIEUTRA.ma_phieu_tra = CHITIETPHIEUTRA.ma_phieu_tra
        AND CHITIETPHIEUTRA.ma_cuon_sach = CUONSACH.ma_cuon_sach
        AND CUONSACH.ma_sach = SACH.ma_sach
    ORDER BY PHIEUTRA.ngay_tra;
END

EXEC SP_LICHSUTRA_DOCGIA 'DG01';

-- Thủ tục xem phiếu mượn bất kỳ
CREATE OR ALTER PROC SP_XEMPHIEUMUON @ma_phieu_muon CHAR(10)
AS
BEGIN
    SELECT CUONSACH.ma_cuon_sach,SACH.ten_sach, CHITIETPHIEUMUON.tinh_trang AS tinh_trang_khi_muon
    FROM PHIEUMUON, CHITIETPHIEUMUON, CUONSACH, SACH
    WHERE PHIEUMUON.ma_phieu_muon = @ma_phieu_muon
        AND PHIEUMUON.ma_phieu_muon = CHITIETPHIEUMUON.ma_phieu_muon
        AND CHITIETPHIEUMUON.ma_cuon_sach = CUONSACH.ma_cuon_sach
        AND CUONSACH.ma_sach = SACH.ma_sach;
END

EXEC SP_XEMPHIEUMUON 'PM02';

-- Thủ tục xem phiếu trả bất kỳ
CREATE OR ALTER PROC SP_XEMPHIEUTRA @ma_phieu_tra CHAR(10)
AS
BEGIN
    SELECT CUONSACH.ma_cuon_sach, SACH.ten_sach, CHITIETPHIEUTRA.tinh_trang_khi_tra AS tinh_trang_khi_tra
    FROM PHIEUTRA, CHITIETPHIEUTRA, CUONSACH, SACH
    WHERE PHIEUTRA.ma_phieu_tra = @ma_phieu_tra
        AND PHIEUTRA.ma_phieu_tra = CHITIETPHIEUTRA.ma_phieu_tra
        AND CHITIETPHIEUTRA.ma_cuon_sach = CUONSACH.ma_cuon_sach
        AND CUONSACH.ma_sach = SACH.ma_sach;
END

EXEC SP_XEMPHIEUTRA 'PT03';

-- Thủ tục thống kê top những cuốn sách được mượn nhiều nhất
CREATE OR ALTER PROC SP_THONGKE_SACHMUONNHIEUNHAT @OPTION INT
AS
BEGIN
	IF @OPTION <= 0
		PRINT N'Lựa chọn không hợp lệ! Vui lòng nhập số lượng lớn hơn 0.'
	ELSE
	BEGIN
		SELECT TOP (@OPTION) SACH.ma_sach, SACH.ten_sach, THELOAI.ten_the_loai, 
			COUNT(CHITIETPHIEUMUON.ma_cuon_sach) AS so_lan_muon
		FROM CHITIETPHIEUMUON, CUONSACH, SACH, THELOAI
		WHERE CHITIETPHIEUMUON.ma_cuon_sach = CUONSACH.ma_cuon_sach
			AND CUONSACH.ma_sach = SACH.ma_sach
			AND SACH.ma_the_loai = THELOAI.ma_the_loai
		GROUP BY SACH.ma_sach, SACH.ten_sach, THELOAI.ten_the_loai
		ORDER BY so_lan_muon DESC, SACH.ten_sach ASC
	END
END;

EXEC SP_THONGKE_SACHMUONNHIEUNHAT 4; 