﻿create database QUANLYTHUVIEN
use QUANLYTHUVIEN


create table NHANVIEN
(
	MANV nvarchar(10),
	TENNV nvarchar(20),
	SODT nvarchar(20),
	GIOITINH nvarchar(10),
	CHUCVU nvarchar(15),
	MACN nvarchar(10),
	constraint PK_MANV primary key(MANV)
)

create table SACH
(
	MASACH nvarchar(10),
	TENSACH nvarchar(50),
	NXB nvarchar(20),
	TACGIA nvarchar(30),
	THELOAI nvarchar(50),
	SOTRANG int,
	MATT bit,
	constraint PK_MASACH primary key (MASACH)
)

create table CHINHANH
(
	MACN nvarchar(10),
	SODT nvarchar(15),
	THANHPHO nvarchar(15),
	SONV int,
	constraint PK_MACN primary key (MACN)
)


create table KHACHHANG (
	MAKH nvarchar(10),
	TENKH nvarchar(10),
	DIACHI nvarchar(20),
	SODT nvarchar(10),
	CMND nvarchar(10),
	MASACH nvarchar (10),
	NGAYMUON smalldatetime,
	constraint PK_MAKH primary key (MAKH)
)

Create table TINHTRANG
(
	MATT bit,
	TENTINHTRANG nvarchar(30),
	constraint PK_MATT primary key (MATT)

)

alter table NHANVIEN
add constraint FK_MACN foreign key (MACN) references CHINHANH(MACN);

alter table SACH
add constraint FK_MATT foreign key (MATT) references TINHTRANG(MATT);

alter table KHACHHANG
add constraint FK_MASACH foreign key (MASACH) references SACH(MASACH);


create table SOLUONGSACH(
	MASACH nvarchar(10),
	SOLUONG int
)

CREATE TABLE THEMNHANVIEN(
	MANV nvarchar(10),
	TENNV nvarchar(20),
	SODT nvarchar(20),
	GIOITINH nvarchar(10),
	CHUCVU nvarchar(15),
	MACN nvarchar(10)

)
GO
---TRIGGER----
--TAO TRIGGER THEM NHAN VIEN MOI THI SO LUONG NV THAY DOI DUA TREN MACN
CREATE TRIGGER TRG_THEMNV_1 ON NHANVIEN AFTER INSERT AS 
BEGIN
	UPDATE CHINHANH
	SET SONV=SONV +1
	FROM CHINHANH JOIN inserted ON CHINHANH.MACN=inserted.MACN
END

--TAO TRIGGER XOA NHAN VIEN THI SO LUONG NV THAY DOI DUA TREN MACN
CREATE TRIGGER TRG_XOANV_1 ON NHANVIEN AFTER DELETE AS 
BEGIN
	UPDATE CHINHANH
	SET SONV=SONV-1
	FROM CHINHANH JOIN deleted ON CHINHANH.MACN=deleted.MACN
END



INSERT INTO NHANVIEN VALUES('NV007',N'NGUYỄN DD','90909',N'NAM',N'TÂN BINH','CN001')

DELETE NHANVIEN WHERE MANV='NV007'


UPDATE KHACHHANG
SET MASACH='S004' WHERE MAKH='GUEST103'

UPDATE KHACHHANG
SET MASACH='S002' WHERE MAKH='GUEST104'

UPDATE SACH
SET MATT=0
WHERE MASACH NOT IN (SELECT MASACH FROM KHACHHANG)

UPDATE SACH
SET MATT=1
WHERE MASACH  IN (SELECT MASACH FROM KHACHHANG)

--PROCEDURE--
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME LIKE
'Proc_insert_KH_1')
DROP PROC Proc_insert_KH_1
GO
	CREATE PROCEDURE Proc_insert_KH_1 (@MAKH NVARCHAR(10),@TENKH
	nvarchar(10),@DIACHI nvarchar(20),@SODT Nvarchar(10),@CMND NVARCHAR(10),@MASACH NVARCHAR(10),@NGAYMUON
	smalldatetime)
	as
	if NOT exists (select * from KHACHHANG where MASACH=@MASACH)
		begin 

			insert into KHACHHANG
			VALUES(@MAKH,@TENKH,@DIACHI,@SODT,@CMND,@MASACH,@NGAYMUON)
			print N'da chen thanh cong ! '
		end
		else
		begin
			print N'da chen that bai ! '
			
		end


go

CREATE TRIGGER TRG_THEMKH_1 ON KHACHHANG AFTER INSERT AS 
BEGIN
	UPDATE SACH
	SET MATT=1
	FROM SACH JOIN inserted ON SACH.MASACH=inserted.MASACH
END

INSERT INTO KHACHHANG VALUES ('GUEST106',N'NGỌC',N'QUẬN 6','11166','100050','S005','2021/1/1')

DELETE FROM KHACHHANG WHERE MAKH='GUEST106'


go 

CREATE TRIGGER TRG_XOAKH_1 ON KHACHHANG AFTER DELETE AS
BEGIN
	UPDATE SACH
	SET MATT=0
	FROM SACH JOIN deleted ON SACH.MASACH=deleted.MASACH
END

EXEC Proc_insert_KH_1 @MAKH='GUEST106',@TENKH=N'NGỌC',@DIACHI=N'QUẬN 4',
		@SODT='98867',@CMND='88899',@MASACH='S007',@NGAYMUON='6/2/2021';
--KHACH HANG KHONG DUOC TRUNG,KHONG DUOC MUON TRUNG SACH
DELETE KHACHHANG WHERE MAKH='GUEST107'


INSERT INTO NHANVIEN VALUES ('NV006',N'NGUYỄN F','232323',N'NAM',N'NHÂN VIÊN','CN003')


--FUNCTION--
--TINH RA NGAY TRA SACH DUA VAO NGAY MUON--
GO
CREATE FUNCTION NGAYTRASACH
(@NGAYMUON SMALLDATETIME)
RETURNS SMALLDATETIME
AS
		BEGIN
		RETURN  DATEADD(DAY,14,@NGAYMUON) 
		END


SELECT TENKH,DBO.NGAYTRASACH(NGAYMUON) AS NGAYTRASACH 
FROM KHACHHANG

CREATE FUNCTION SOSACHDUOCMUON
RETURNS INT
AS
	BEGIN

--DEM SO LUONG SACH DA DUOC MUON/CHUA DUOC MUON
GO

CREATE FUNCTION COUNT_BOOKS()
RETURNS TABLE
AS
	RETURN (
	SELECT TENTINHTRANG,COUNT(*) AS SO_LUONG_SACH
	FROM SACH JOIN TINHTRANG ON SACH.MATT=TINHTRANG.MATT
	GROUP BY TENTINHTRANG)


SELECT * FROM DBO.COUNT_BOOKS()

--THANH CONG ROIII---


--USERS--
CREATE LOGIN LO1 WITH PASSWORD='123'
CREATE LOGIN LO2 WITH PASSWORD='123'
CREATE LOGIN LO3 WITH PASSWORD='123'
CREATE USER US1 FOR LOGIN LO1
CREATE USER US2 FOR LOGIN LO2
CREATE USER US3 FOR LOGIN LO3


CREATE ROLE ROLE_1
CREATE ROLE ROLE_2
CREATE ROLE ROLE_3

exec sp_addrolemember ROLE_1,US1
exec sp_addrolemember ROLE_2,US2
exec sp_addrolemember ROLE_3,US3

GRANT SELECT ON KHACHHANG TO US1
GRANT SELECT,DELETE ON KHACHHANG TO US2
GRANT INSERT,DELETE ON KHACHHANG TO US3

--cau hoi tu chon--

--hay liet ke cac dau sach chu co khach hang nao muon?--
SELECT KHACHHANG.*
FROM SACH join KHACHHANG on SACH.MASACH=KHACHHANG.MASACH
WHERE TENSACH=N'Khuyến học'

select NHANVIEN.*
from NHANVIEN join CHINHANH on NHANVIEN.MACN=CHINHANH.MACN
where THANHPHO=N'ĐÀ NẴNG'


select KHACHHANG.*
from SACH join KHACHHANG on SACH.MASACH=KHACHHANG.MASACH
where THELOAI=N'Tiểu thuyết'

