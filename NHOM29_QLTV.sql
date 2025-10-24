CREATE DATABASE NHOM29_QLTV;
USE NHOM29_QLTV;

-- Tạo và nhập dữ liệu cho bảng THELOAI
CREATE TABLE THELOAI (
    ma_the_loai CHAR(10) PRIMARY KEY NOT NULL,
    ten_the_loai NCHAR(50) NOT NULL,
    mo_ta NCHAR(200)
);

INSERT INTO THELOAI VALUES ('TL01', N'Văn học', N'Các tác phẩm văn học trong nước và quốc tế');
INSERT INTO THELOAI VALUES ('TL02', N'Khoa học', N'Sách về khoa học tự nhiên và xã hội');
INSERT INTO THELOAI VALUES ('TL03', N'Công nghệ', N'Sách về công nghệ thông tin và lập trình');
INSERT INTO THELOAI VALUES ('TL04', N'Kinh tế', N'Sách về kinh tế, tài chính và quản trị');
INSERT INTO THELOAI VALUES ('TL05', N'Tâm lý', N'Sách tâm lý học và phân tích hành vi');

SELECT * FROM THELOAI;

-- Tạo và nhập dữ liệu cho bảng NHAXUATBAN
CREATE TABLE NHAXUATBAN (
    ma_nxb CHAR(10) PRIMARY KEY NOT NULL,
    ten_nxb NCHAR(100) NOT NULL,
    dia_chi NCHAR(150),
    sdt CHAR(15),
    email CHAR(50)
);

INSERT INTO NHAXUATBAN VALUES ('NXB01', N'Nhà Xuất Bản Trẻ', N'161B Lý Chính Thắng, P.7, Q.3, TP.HCM', '02839316289', 'nxbtre@nxbtre.com.vn');
INSERT INTO NHAXUATBAN VALUES ('NXB02', N'Nhà Xuất Bản Kim Đồng', N'55 Quang Trung, P. Nguyễn Du, Q. Hai Bà Trưng, Hà Nội', '02439434790', 'info@nxbkimdong.com.vn');
INSERT INTO NHAXUATBAN VALUES ('NXB03', N'Nhà Xuất Bản Giáo Dục Việt Nam', N'81 Trần Hưng Đạo, P. Hoàn Kiếm, Q. Hoàn Kiếm, Hà Nội', '02438220801', 'lienhe@nxbgd.vn');

SELECT * FROM NHAXUATBAN;

-- Tạo và nhập dữ liệu cho bảng SACH 
CREATE TABLE SACH (
    ma_sach CHAR(10) PRIMARY KEY NOT NULL,
    ma_the_loai CHAR(10) REFERENCES THELOAI(ma_the_loai) NOT NULL,
    ma_nxb CHAR(10) REFERENCES NHAXUATBAN(ma_nxb) NOT NULL,
    ten_sach NVARCHAR(200) NOT NULL,
    nam_xuat_ban INT,
    so_luong_cuon INT
);

INSERT INTO SACH VALUES ('S01', 'TL01', 'NXB01', N'Tắt Đèn', 1939, NULL);
INSERT INTO SACH VALUES ('S02', 'TL01', 'NXB02', N'Chí Phèo', 1941, NULL);
INSERT INTO SACH VALUES ('S03', 'TL02', 'NXB03', N'Vũ Trụ Trong Vỏ Hạt Dẻ', 2001, NULL);
INSERT INTO SACH VALUES ('S04', 'TL03', 'NXB01', N'Lập Trình Java Cơ Bản', 2020, NULL);
INSERT INTO SACH VALUES ('S05', 'TL03', 'NXB02', N'Trí Tuệ Nhân Tạo', 2022, NULL);
INSERT INTO SACH VALUES ('S06', 'TL04', 'NXB03', N'Kinh Tế Học Hài Hước', 2005, NULL);
INSERT INTO SACH VALUES ('S07', 'TL04', 'NXB01', N'Bí Mật Của Tư Duy Triệu Phú', 2005, NULL);
INSERT INTO SACH VALUES ('S08', 'TL05', 'NXB02', N'Đọc Vị Bất Kỳ Ai', 2007, NULL);

SELECT * FROM SACH;

-- Tạo và nhập dữ liệu cho bảng TACGIA 
CREATE TABLE TACGIA (
    ma_tac_gia CHAR(10) PRIMARY KEY NOT NULL,
    ten_tac_gia NCHAR(50) NOT NULL,
    nam_sinh INT,
    quoc_tich NCHAR(30)
);

INSERT INTO TACGIA VALUES ('TG01', N'Ngô Tất Tố', 1893, N'Việt Nam');
INSERT INTO TACGIA VALUES ('TG02', N'Nam Cao', 1917, N'Việt Nam');
INSERT INTO TACGIA VALUES ('TG03', N'Stephen Hawking', 1942, N'Anh');
INSERT INTO TACGIA VALUES ('TG04', N'Trần Thành', 1978, N'Việt Nam');
INSERT INTO TACGIA VALUES ('TG05', N'Phạm Văn Ất', 1940, N'Việt Nam');
INSERT INTO TACGIA VALUES ('TG06', N'T. Harv Eker', 1954, N'Canada');
INSERT INTO TACGIA VALUES ('TG07', N'David J. Lieberman', 1967, N'Mỹ');
INSERT INTO TACGIA VALUES ('TG08', N'Steven D. Levitt', 1967, N'Mỹ');
INSERT INTO TACGIA VALUES ('TG09', N'Stephen J. Dubner', 1963, N'Mỹ');

SELECT * FROM TACGIA; 

-- Tạo và nhập dữ liệu cho bảng VIET
CREATE TABLE VIET (
    ma_tac_gia CHAR(10) REFERENCES TACGIA(ma_tac_gia) NOT NULL,
    ma_sach CHAR(10) REFERENCES SACH(ma_sach) NOT NULL,
    vai_tro NVARCHAR(50),
    PRIMARY KEY (ma_tac_gia, ma_sach)
);

INSERT INTO VIET VALUES ('TG01', 'S01', N'Tác giả chính');        
INSERT INTO VIET VALUES ('TG02', 'S02', N'Tác giả chính');       
INSERT INTO VIET VALUES ('TG03', 'S03', N'Tác giả chính');        
INSERT INTO VIET VALUES ('TG04', 'S04', N'Tác giả chính');       
INSERT INTO VIET VALUES ('TG05', 'S05', N'Chủ biên');             
INSERT INTO VIET VALUES ('TG06', 'S07', N'Tác giả chính');      
INSERT INTO VIET VALUES ('TG07', 'S08', N'Tác giả chính');       
INSERT INTO VIET VALUES ('TG08', 'S06', N'Đồng tác giả');      
INSERT INTO VIET VALUES ('TG09', 'S06', N'Đồng tác giả');        

SELECT * FROM VIET;

-- Tạo và nhập dữ liệu cho bảng VITRI 
CREATE TABLE VITRI (
    ma_vi_tri CHAR(10) PRIMARY KEY NOT NULL,
    tang INT,
    khu_vuc NVARCHAR(50),
    ke_sach NVARCHAR(50)
);

INSERT INTO VITRI VALUES ('VT01', 1, N'Khu A', N'Kệ 01');
INSERT INTO VITRI VALUES ('VT02', 1, N'Khu A', N'Kệ 02');
INSERT INTO VITRI VALUES ('VT03', 1, N'Khu B', N'Kệ 01');
INSERT INTO VITRI VALUES ('VT04', 2, N'Khu B', N'Kệ 02');
INSERT INTO VITRI VALUES ('VT05', 2, N'Khu C', N'Kệ 01');
INSERT INTO VITRI VALUES ('VT06', 2, N'Khu C', N'Kệ 02');

SELECT * FROM VITRI;

-- Tạo và nhập dữ liệu cho bảng CUONSACH
CREATE TABLE CUONSACH (
    ma_cuon_sach CHAR(10) PRIMARY KEY NOT NULL,
    ma_sach CHAR(10) REFERENCES SACH(ma_sach) NOT NULL,
    ma_vi_tri CHAR(10) REFERENCES VITRI(ma_vi_tri) NOT NULL,
    trang_thai NVARCHAR(50)
);

INSERT INTO CUONSACH VALUES ('CS0101', 'S01', 'VT01', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0102', 'S01', 'VT01', N'Đang mượn');
INSERT INTO CUONSACH VALUES ('CS0103', 'S01', 'VT01', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0201', 'S02', 'VT01', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0301', 'S03', 'VT02', N'Đang mượn');
INSERT INTO CUONSACH VALUES ('CS0302', 'S03', 'VT02', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0401', 'S04', 'VT03', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0402', 'S04', 'VT03', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0403', 'S04', 'VT03', N'Đang mượn');
INSERT INTO CUONSACH VALUES ('CS0501', 'S05', 'VT04', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0502', 'S05', 'VT04', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0601', 'S06', 'VT05', N'Đang mượn');
INSERT INTO CUONSACH VALUES ('CS0602', 'S06', 'VT05', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0701', 'S07', 'VT06', N'Có sẵn');
INSERT INTO CUONSACH VALUES ('CS0801', 'S08', 'VT06', N'Đang mượn');

SELECT * FROM CUONSACH;

-- Tạo và nhập dữ liệu cho bảng NHANVIEN
CREATE TABLE NHANVIEN (
    ma_nv CHAR(10) PRIMARY KEY NOT NULL,
    ho_ten NVARCHAR(50) NOT NULL,
    sdt CHAR(15),
    email CHAR(50)
);

INSERT INTO NHANVIEN VALUES ('NV01', N'Nguyễn Minh Anh', '0912345678', 'nmanh@thuvien.edu.vn');
INSERT INTO NHANVIEN VALUES ('NV02', N'Trần Quang Huy', '0923456789', 'tqhuy@thuvien.edu.vn');
INSERT INTO NHANVIEN VALUES ('NV03', N'Lê Thảo Nguyên', '0934567890', 'ltnguyen@thuvien.edu.vn');
INSERT INTO NHANVIEN VALUES ('NV04', N'Phạm Đức Anh', '0945678901', 'pdanh@thuvien.edu.vn');
INSERT INTO NHANVIEN VALUES ('NV05', N'Hoàng Bảo Châu', '0956789012', 'hbchau@thuvien.edu.vn');

SELECT * FROM NHANVIEN; 

-- Tạo và nhập dữ liệu cho bảng DOCGIA 
CREATE TABLE DOCGIA (
    ma_doc_gia CHAR(10) PRIMARY KEY NOT NULL,
    ho_ten NVARCHAR(50) NOT NULL,
    ngay_sinh DATE,
    gioi_tinh NCHAR(3),
    dia_chi NVARCHAR(150),
    sdt CHAR(15),
    email CHAR(50)
);

INSERT INTO DOCGIA VALUES ('DG01', N'Trần Văn Nam', '2000-05-15', N'Nam', N'25 Trần Hưng Đạo, Q.Hoàn Kiếm, Hà Nội', '0987654321', 'tvnam@gmail.com');
INSERT INTO DOCGIA VALUES ('DG02', N'Nguyễn Thị Hằng', '1999-08-22', N'Nữ', N'18 Láng Hạ, Q.Đống Đa, Hà Nội', '0974123658', 'nthang@gmail.com');
INSERT INTO DOCGIA VALUES ('DG03', N'Phạm Quốc Anh', '2001-03-10', N'Nam', N'32 Kim Mã, Q.Ba Đình, Hà Nội', '0963258741', 'pqanh@gmail.com');
INSERT INTO DOCGIA VALUES ('DG04', N'Đỗ Mạnh Hùng', '1997-09-14', N'Nam', N'12 Phạm Văn Đồng, Q.Cầu Giấy, Hà Nội', '0923658741', 'dmhung@gmail.com');
INSERT INTO DOCGIA VALUES ('DG05', N'Bùi Thu Hà', '2001-04-25', N'Nữ', N'56 Nguyễn Trãi, Q.Thanh Xuân, Hà Nội', '0958741236', 'btha@gmail.com');

SELECT * FROM DOCGIA; 

-- Tạo và nhập dữ liệu cho bảng PHIEUMUON 
CREATE TABLE PHIEUMUON (
    ma_phieu_muon CHAR(10) PRIMARY KEY NOT NULL,
    ma_nv CHAR(10) REFERENCES NHANVIEN(ma_nv) NOT NULL,
    ma_doc_gia CHAR(10) REFERENCES DOCGIA(ma_doc_gia) NOT NULL,
    ngay_muon DATE NOT NULL,
    han_tra DATE
);

INSERT INTO PHIEUMUON VALUES ('PM01', 'NV01', 'DG01', '2025-04-05', NULL);  
INSERT INTO PHIEUMUON VALUES ('PM02', 'NV01', 'DG03', '2025-04-25', NULL);  
INSERT INTO PHIEUMUON VALUES ('PM03', 'NV02', 'DG02', '2025-05-20', NULL);  
INSERT INTO PHIEUMUON VALUES ('PM04', 'NV02', 'DG01', '2025-06-10', NULL);  
INSERT INTO PHIEUMUON VALUES ('PM05', 'NV03', 'DG04', '2025-07-05', NULL);  
INSERT INTO PHIEUMUON VALUES ('PM06', 'NV04', 'DG05', '2025-08-01', NULL);  
INSERT INTO PHIEUMUON VALUES ('PM07', 'NV04', 'DG03', '2025-09-24', NULL);  
INSERT INTO PHIEUMUON VALUES ('PM08', 'NV03', 'DG01', '2025-09-28', NULL); 

SELECT * FROM PHIEUMUON; 

-- Tạo và nhập dữ liệu cho bảng CHITIETPHIEUMUON
CREATE TABLE CHITIETPHIEUMUON (
    ma_phieu_muon CHAR(10) REFERENCES PHIEUMUON(ma_phieu_muon) NOT NULL,
    ma_cuon_sach CHAR(10) REFERENCES CUONSACH(ma_cuon_sach) NOT NULL,
    tinh_trang NVARCHAR(50),
    PRIMARY KEY (ma_phieu_muon, ma_cuon_sach)
);

INSERT INTO CHITIETPHIEUMUON VALUES ('PM01', 'CS0101', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM01', 'CS0103', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM01', 'CS0201', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM02', 'CS0302', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM03', 'CS0401', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM03', 'CS0501', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM04', 'CS0402', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM04', 'CS0502', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM05', 'CS0602', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM05', 'CS0701', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM05', 'CS0302', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM06', 'CS0701', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM07', 'CS0102', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM07', 'CS0301', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM07', 'CS0403', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM08', 'CS0601', N'Bình thường');
INSERT INTO CHITIETPHIEUMUON VALUES ('PM08', 'CS0801', N'Bình thường');

SELECT * FROM CHITIETPHIEUMUON; 

-- Tạo và nhập dữ liệu cho bảng PHIEUTRA
CREATE TABLE PHIEUTRA (
    ma_phieu_tra CHAR(10) PRIMARY KEY NOT NULL,
    ma_phieu_muon CHAR(10) REFERENCES PHIEUMUON(ma_phieu_muon) NOT NULL,
    ma_nv CHAR(10) REFERENCES NHANVIEN(ma_nv) NOT NULL,
    ma_doc_gia CHAR(10) REFERENCES DOCGIA(ma_doc_gia) NOT NULL,
    ngay_tra DATE NOT NULL
);

INSERT INTO PHIEUTRA VALUES ('PT01', 'PM01', 'NV02', 'DG01', '2025-04-18'); 
INSERT INTO PHIEUTRA VALUES ('PT02', 'PM02', 'NV03', 'DG03', '2025-05-10');  
INSERT INTO PHIEUTRA VALUES ('PT03', 'PM03', 'NV04', 'DG02', '2025-06-02');  
INSERT INTO PHIEUTRA VALUES ('PT04', 'PM04', 'NV02', 'DG01', '2025-06-23');  
INSERT INTO PHIEUTRA VALUES ('PT05', 'PM05', 'NV05', 'DG04', '2025-07-21');  
INSERT INTO PHIEUTRA VALUES ('PT06', 'PM06', 'NV01', 'DG05', '2025-08-14');  

SELECT * FROM PHIEUTRA;

-- Tạo và nhập dữ liệu cho bảng CHITIETPHIEUTRA
CREATE TABLE CHITIETPHIEUTRA (
    ma_phieu_tra CHAR(10) REFERENCES PHIEUTRA(ma_phieu_tra) NOT NULL,
    ma_cuon_sach CHAR(10) REFERENCES CUONSACH(ma_cuon_sach) NOT NULL,
    tinh_trang_khi_tra NVARCHAR(50),
    PRIMARY KEY (ma_phieu_tra, ma_cuon_sach)
);

INSERT INTO CHITIETPHIEUTRA VALUES ('PT01', 'CS0101', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT01', 'CS0103', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT01', 'CS0201', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT02', 'CS0302', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT03', 'CS0401', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT03', 'CS0501', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT04', 'CS0402', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT04', 'CS0502', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT05', 'CS0602', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT05', 'CS0701', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT05', 'CS0302', N'Bình thường');
INSERT INTO CHITIETPHIEUTRA VALUES ('PT06', 'CS0701', N'Bình thường');

SELECT * FROM CHITIETPHIEUTRA;

-- Cập nhật số lượng cuốn cho sách
UPDATE SACH 
SET so_luong_cuon = (
    SELECT COUNT(*) 
    FROM CUONSACH 
    WHERE CUONSACH.ma_sach = SACH.ma_sach
);

SELECT * FROM SACH;

-- Cập nhật hạn trả cho phiếu mượn
UPDATE PHIEUMUON 
SET han_tra = DATEADD(day, 14, ngay_muon)
WHERE han_tra IS NULL;

SELECT * FROM PHIEUMUON;
