USE NHOM29_QLTV;

-- Trigger cập nhật tự động số lượng cuốn khi thêm cuốn mới
CREATE OR ALTER TRIGGER TRG_CUONSACH_INSERT ON CUONSACH
AFTER INSERT
AS
BEGIN
    DECLARE @ma_sach CHAR(10);
    SELECT @ma_sach = ma_sach FROM INSERTED;
    UPDATE SACH
    SET so_luong_cuon = (
        SELECT COUNT(*) FROM CUONSACH WHERE ma_sach = @ma_sach )
    WHERE SACH.ma_sach = @ma_sach;
END

EXEC SP_THEM_CUONSACH 'CS0404', 'S04', 'VT03', N'Có sẵn';
SELECT * FROM SACH;

-- Trigger cập nhật tự động số lượng cuốn khi xóa cuốn sách
CREATE OR ALTER TRIGGER TRG_CUONSACH_DELETE ON CUONSACH
AFTER DELETE
AS
BEGIN
    DECLARE @ma_sach CHAR(10);
    SELECT @ma_sach = ma_sach FROM DELETED;
    UPDATE SACH
    SET so_luong_cuon = (
        SELECT COUNT(*) FROM CUONSACH WHERE ma_sach = @ma_sach )
    WHERE SACH.ma_sach = @ma_sach;
END

EXEC SP_XOA_CUONSACH 'CS0404';
SELECT * FROM SACH

-- Trigger cập nhật tự động hạn trả khi thêm phiếu mượn
CREATE OR ALTER TRIGGER TRG_CAPNHAT_HANTRA ON PHIEUMUON
AFTER INSERT
AS
BEGIN
    UPDATE PHIEUMUON
    SET han_tra = DATEADD(DAY, 14, ngay_muon)
    WHERE ma_phieu_muon IN (SELECT ma_phieu_muon FROM INSERTED);
END;

INSERT INTO PHIEUMUON VALUES ('PM09', 'NV02', 'DG04', '2025-10-23', NULL);
SELECT * FROM PHIEUMUON;

-- Trigger cập nhật tự động trạng thái "Đang mượn" khi mượn sách (thêm chi tiết phiếu mượn)
CREATE OR ALTER TRIGGER TRG_CAPNHAT_DANGMUON ON CHITIETPHIEUMUON
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @ma_cuon_sach CHAR(10);
    SELECT @ma_cuon_sach = ma_cuon_sach FROM INSERTED;
    IF EXISTS (SELECT * FROM CUONSACH WHERE ma_cuon_sach = @ma_cuon_sach AND trang_thai = N'Đang mượn')
        PRINT N'Không thể mượn vì cuốn sách này đang được mượn';
    ELSE
    BEGIN
        INSERT INTO CHITIETPHIEUMUON
        SELECT * FROM INSERTED;
        UPDATE CUONSACH
        SET trang_thai = N'Đang mượn'
        WHERE ma_cuon_sach = @ma_cuon_sach;
    END
END;

INSERT INTO CHITIETPHIEUMUON VALUES ('PM09', 'CS0101', N'Bình thường');
SELECT * FROM CUONSACH;

-- Trigger cập nhật tự động trạng thái "Có sẵn" khi trả sách (thêm chi tiết phiếu trả)
CREATE OR ALTER TRIGGER TRG_CAPNHAT_COSAN ON CHITIETPHIEUTRA
AFTER INSERT
AS
BEGIN
    DECLARE @ma_cuon_sach CHAR(10);
    SELECT @ma_cuon_sach = ma_cuon_sach FROM INSERTED;
    UPDATE CUONSACH
    SET trang_thai = N'Có sẵn'
    WHERE ma_cuon_sach = @ma_cuon_sach;
END;

INSERT INTO PHIEUTRA VALUES ('PT09', 'PM09','NV02', 'DG04', '2025-10-24');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT09', 'CS0101', N'Bình thường');
SELECT * FROM CUONSACH;


