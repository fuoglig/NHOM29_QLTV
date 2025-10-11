USE NHOM29_QLTV;

-- Hàm tính số sách đang được mượn
CREATE OR ALTER FUNCTION FN_SOSACHDANGMUON()
RETURNS INT
AS
BEGIN
    DECLARE @so_luong INT;
    SELECT @so_luong = COUNT(*)
    FROM CUONSACH
    WHERE trang_thai = N'Đang mượn';
    RETURN @so_luong;
END;
GO

SELECT dbo.FN_SOSACHDANGMUON() AS so_sach_dang_muon;

-- Hàm kiểm tra sách có sẵn để cho mượn
CREATE OR ALTER FUNCTION FN_KIEMTRASACHCOSAN(@ma_sach CHAR(10))
RETURNS BIT
AS
BEGIN
    DECLARE @ket_qua BIT;
    IF EXISTS (
        SELECT * FROM CUONSACH 
        WHERE ma_sach = @ma_sach AND trang_thai = N'Có sẵn'
    )
        SET @ket_qua = 1;
    ELSE
        SET @ket_qua = 0;
    RETURN @ket_qua;
END;
GO

SELECT dbo.FN_KIEMTRASACHCOSAN('S01') AS trang_thai; -- 1 = có, 0 = hết