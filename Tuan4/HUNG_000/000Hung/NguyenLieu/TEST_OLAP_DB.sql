IF EXISTS (SELECT * FROM sys.databases WHERE name='TEST_OLAP')
BEGIN
	USE MASTER
	DROP DATABASE TEST_OLAP
END
GO
CREATE DATABASE TEST_OLAP
GO
USE TEST_OLAP
GO
IF EXISTS (SELECT * FROM sys.tables WHERE name='FactBanHang')
	DROP TABLE FactBanHang
GO
CREATE TABLE FactBanHang
(
	matg	INT,
	mahh	VARCHAR(10),
	mach	VARCHAR(4),
	makh	VARCHAR(6),
	sluong	INT,
	dgia	FLOAT,
	thanhtien AS sluong*dgia
)
GO
IF EXISTS (SELECT * FROM sys.tables WHERE name='DimThoiGian')
	DROP TABLE DimThoiGian
GO
CREATE TABLE DimThoiGian
(
	matg	INT IDENTITY PRIMARY KEY,
	thang	TINYINT,
	quy		TINYINT,
	nam		INT
)
GO
IF EXISTS (SELECT * FROM sys.tables WHERE name='DimCuaHang')
	DROP TABLE DimCuaHang
GO
CREATE TABLE DimCuaHang
(
	mach	VARCHAR(4) PRIMARY KEY,
	tench	NVARCHAR(100) not null,
	makv	VARCHAR(15)
)
GO
IF EXISTS (SELECT * FROM sys.tables WHERE name='DimHangHoa')
	DROP TABLE DimHangHoa
GO
CREATE TABLE DimHangHoa
(
	mahh	VARCHAR(10) PRIMARY KEY,
	tenhh	NVARCHAR(50), 
	cloai	NVARCHAR(50)
)
GO
IF EXISTS (SELECT * FROM sys.tables WHERE name='DimKhuVuc')
	DROP TABLE DimKhuVuc
GO
CREATE TABLE DimKhuVuc
(
	makv	VARCHAR(15) PRIMARY KEY,
	tpho NVARCHAR(50),
	mien NVARCHAR(50),
	qgia NVARCHAR(50)
)
GO
IF EXISTS (SELECT * FROM sys.tables WHERE name='DimKhachHang')
	DROP TABLE DimKhachHang
GO
CREATE TABLE DimKhachHang
(
	makh	VARCHAR(6) PRIMARY KEY,
	tenkh	NVARCHAR(100),
	makv	VARCHAR(15)
)
--ALTER TABLE FACTDDH DROP CONSTRAINT fk_makv
--DROP TABLE DimKhuVuc
ALTER TABLE FactBanHang ADD CONSTRAINT fk_FactBH_matg FOREIGN KEY (matg) REFERENCES DimThoiGian(matg)
ALTER TABLE FactBanHang ADD CONSTRAINT fk_FactBH_mach FOREIGN KEY (mach) REFERENCES DimCuaHang(mach)
ALTER TABLE FactBanHang ADD CONSTRAINT fk_FactBH_mahh FOREIGN KEY (mahh) REFERENCES DimHangHoa(mahh)
ALTER TABLE FactBanHang ADD CONSTRAINT fk_FactBH_makh FOREIGN KEY (makh) REFERENCES DimKhachHang(makh)
ALTER TABLE DimKhachHang ADD CONSTRAINT fk_DimKH_makv FOREIGN KEY (makv) REFERENCES DimKhuVuc(makv)
ALTER TABLE DimCuaHang ADD CONSTRAINT fk_DimCH_makv FOREIGN KEY (makv) REFERENCES DimKhuVuc(makv)

/*===================================================*/
--THEM DU LIEU
/*===================================================*/

-------------------DimThoiGian-------------------------
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (1,1,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (2,1,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (3,1,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (4,2,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (5,2,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (6,2,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (7,3,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (8,3,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (9,3,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (10,4,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (11,4,2013)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (12,4,2013)
--
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (1,1,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (2,1,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (3,1,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (4,2,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (5,2,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (6,2,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (7,3,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (8,3,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (9,3,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (10,4,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (11,4,2014)
INSERT INTO DimThoiGian(thang,quy,nam) VALUES (12,4,2014)
--
SELECT * FROM DimThoiGian
-------------------DimHangHoa-------------------------
INSERT INTO  DimHangHoa VALUES ('HH001', N'Trà xanh O2',N'Nước giải khát')
INSERT INTO  DimHangHoa VALUES ('HH002', N'Coca cola',N'Nước giải khát')
INSERT INTO  DimHangHoa VALUES ('HH003', N'Bánh ChocoPie',N'Bánh kẹo')
INSERT INTO  DimHangHoa VALUES ('HH004', N'Dầu ăn Tường An',N'Dầu ăn')
INSERT INTO  DimHangHoa VALUES ('HH005', N'Bánh AFC',N'Bánh kẹo')
INSERT INTO  DimHangHoa VALUES ('HH006', N'Dầu ăn Neptune',N'Dầu ăn')
INSERT INTO  DimHangHoa VALUES ('HH007', N'Bia Heineken',N'Nước giải khát')
INSERT INTO  DimHangHoa VALUES ('HH008', N'Pepsi',N'Nước giải khát')
INSERT INTO  DimHangHoa VALUES ('HH009', N'Cam ép Twister',N'Nước giải khát')
INSERT INTO  DimHangHoa VALUES ('HH010', N'Sữa đậu nành Soya',N'Nước giải khát')
INSERT INTO  DimHangHoa VALUES ('HH011', N'Bánh Hura',N'Bánh kẹo')
INSERT INTO  DimHangHoa VALUES ('HH012', N'Bánh Oreo',N'Bánh kẹo')
INSERT INTO  DimHangHoa VALUES ('HH013', N'Bánh Goute',N'Bánh kẹo')
INSERT INTO  DimHangHoa VALUES ('HH014', N'Kẹo Alpenliebe',N'Bánh kẹo')
INSERT INTO  DimHangHoa VALUES ('HH015', N'Kẹo Golia',N'Bánh kẹo')
--
SELECT * FROM DimHangHoa
-------------------DimKhuVuc-------------------------
INSERT INTO  DimKhuVuc VALUES('KV01', N'Tp. Hồ Chí Minh', N'Miền Nam', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV02', N'Tp. Cần Thơ', N'Miền Nam', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV03', N'Đồng Nai', N'Miền Nam', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV04', N'Bình Dương', N'Miền Nam', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV05', N'Tp. Hà Nội', N'Miền Bắc', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV06', N'Tp. Hải Phòng', N'Miền Bắc', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV07', N'Nam Định', N'Miền Bắc', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV08', N'Tp.Đà Nẵng', N'Miền Trung', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV09', N'Huế', N'Miền Trung', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV10', N'Quảng Ngãi', N'Miền Trung', N'Việt Nam')
INSERT INTO  DimKhuVuc VALUES('KV11', N'Austin', N'Texas', N'Hoa Kỳ')
INSERT INTO  DimKhuVuc VALUES('KV12', N'Orlando', N'Florida', N'Hoa Kỳ')
INSERT INTO  DimKhuVuc VALUES('KV13', N'Boston', N'New Jersey', N'Hoa Kỳ')
INSERT INTO  DimKhuVuc VALUES('KV14', N'San Francisco', N'California', N'Hoa Kỳ')

--
SELECT * FROM DimKhuVuc
-------------------DimCuaHang-------------------------
INSERT INTO DimCuaHang VALUES ('CH01', N'Cửa hàng Q.5','KV01')
INSERT INTO DimCuaHang VALUES ('CH02', N'Cửa hàng Q.10','KV01')
INSERT INTO DimCuaHang VALUES ('CH03', N'Cửa hàng Cần Thơ','KV02')
INSERT INTO DimCuaHang VALUES ('CH04', N'Cửa hàng Long Thành','KV03')
INSERT INTO DimCuaHang VALUES ('CH05', N'Cửa hàng Thủ Dầu Một','KV04')
INSERT INTO DimCuaHang VALUES ('CH06', N'Cửa hàng Q.Hoàn Kiếm','KV05')
INSERT INTO DimCuaHang VALUES ('CH07', N'Cửa hàng Hải phòng','KV06')
INSERT INTO DimCuaHang VALUES ('CH08', N'Cửa hàng Nam Định','KV07')
INSERT INTO DimCuaHang VALUES ('CH09', N'Cửa hàng Đà Nẵng','KV08')
INSERT INTO DimCuaHang VALUES ('CH10', N'Cửa hàng Huế','KV09')
INSERT INTO DimCuaHang VALUES ('CH11', N'Royal Blue Grocery','KV11')
INSERT INTO DimCuaHang VALUES ('CH12', N'Orlando Grocery','KV12')
INSERT INTO DimCuaHang VALUES ('CH13', N'Foodie Store','KV13')
INSERT INTO DimCuaHang VALUES ('CH14', N'Rainbow Grocery Store','KV14')
--
SELECT * FROM DimCuaHang
-------------------DimKhachHang-------------------------
INSERT INTO DimKhachHang VALUES ('KH001',N'Lê Thanh Bình','KV01')
INSERT INTO DimKhachHang VALUES ('KH002',N'Nguyễn Cao Cường','KV02')
INSERT INTO DimKhachHang VALUES ('KH003',N'Phạm Thanh Sơn','KV03')
INSERT INTO DimKhachHang VALUES ('KH004',N'Lê Thành Tài','KV04')
INSERT INTO DimKhachHang VALUES ('KH005',N'Lê Mỹ Dung','KV05')
INSERT INTO DimKhachHang VALUES ('KH006',N'Trần Thanh Tâm','KV06')
INSERT INTO DimKhachHang VALUES ('KH007',N'Lê Như Quỳnh','KV07')
INSERT INTO DimKhachHang VALUES ('KH008',N'Trần Bình Minh','KV08')
INSERT INTO DimKhachHang VALUES ('KH009',N'Phan Ngọc Đức','KV09')
INSERT INTO DimKhachHang VALUES ('KH010',N'Nguyễn Cẩm Tú','KV10')
INSERT INTO DimKhachHang VALUES ('KH011',N'John.F','KV11')
INSERT INTO DimKhachHang VALUES ('KH012',N'Katerine.L','KV12')
INSERT INTO DimKhachHang VALUES ('KH013',N'Richard.S','KV13')
INSERT INTO DimKhachHang VALUES ('KH014',N'Mick.D','KV14')
INSERT INTO DimKhachHang VALUES ('KH015',N'Nguyễn Thanh Hằng','KV01')
--
SELECT * FROM DimKhachHang
-------------------FactBanHang-------------------------
SELECT * FROM FactBanHang
INSERT INTO FactBanHang VALUES (1,'HH001','CH02','KH001',15,8500)
INSERT INTO FactBanHang VALUES (1,'HH001','CH01','KH001',3,8500)
INSERT INTO FactBanHang VALUES (2,'HH006','CH03','KH005',15,18500)
INSERT INTO FactBanHang VALUES (3,'HH007', 'CH03','KH002',12,12500)
INSERT INTO FactBanHang VALUES (3,'HH009', 'CH11','KH011',20,23000)
INSERT INTO FactBanHang VALUES (3,'HH001', 'CH02','KH001',12,8500)
INSERT INTO FactBanHang VALUES (4,'HH015','CH01','KH001',5,14500)
INSERT INTO FactBanHang VALUES (4,'HH003','CH14','KH014',15,34500)
INSERT INTO FactBanHang VALUES (5,'HH004','CH06','KH005',2,19700)
INSERT INTO FactBanHang VALUES (5,'HH002','CH04','KH003',8,10000)
INSERT INTO FactBanHang VALUES (6,'HH008','CH05','KH004',3,17000)
INSERT INTO FactBanHang VALUES (6,'HH014','CH12','KH012',15,6500)
INSERT INTO FactBanHang VALUES (7,'HH012','CH04','KH003',11,9000)
INSERT INTO FactBanHang VALUES (7,'HH009','CH09','KH010',5,23000)
INSERT INTO FactBanHang VALUES (8,'HH013','CH14','KH014',5,25000)
INSERT INTO FactBanHang VALUES (8,'HH011','CH02','KH015',9,15000)
INSERT INTO FactBanHang VALUES (9,'HH010','CH13','KH013',5,21000)
INSERT INTO FactBanHang VALUES (10,'HH009', 'CH05','KH004',2,23000)
INSERT INTO FactBanHang VALUES (11,'HH005', 'CH07','KH006',3,16700)
INSERT INTO FactBanHang VALUES (11,'HH013', 'CH08','KH007',2,25000)
INSERT INTO FactBanHang VALUES (12,'HH015', 'CH09','KH008',1,14500)
INSERT INTO FactBanHang VALUES (12,'HH004','CH10','KH009',7,19700)
INSERT INTO FactBanHang VALUES (12,'HH001','CH02','KH015',5,8500)
INSERT INTO FactBanHang VALUES (12,'HH002','CH08','KH006',68,9000)
INSERT INTO FactBanHang VALUES (12,'HH003','CH13','KH013',50,34500)
--
INSERT INTO FactBanHang VALUES (13,'HH001','CH02','KH001',15,8500)
INSERT INTO FactBanHang VALUES (14,'HH006','CH03','KH005',15,18500)
INSERT INTO FactBanHang VALUES (15,'HH007', 'CH03','KH002',12,12500)
INSERT INTO FactBanHang VALUES (15,'HH009', 'CH11','KH011',20,23000)
INSERT INTO FactBanHang VALUES (15,'HH001', 'CH02','KH001',12,8500)
INSERT INTO FactBanHang VALUES (15,'HH015','CH03','KH002',5,14500)
INSERT INTO FactBanHang VALUES (15,'HH003','CH11','KH014',1,34500)
INSERT INTO FactBanHang VALUES (16,'HH015','CH01','KH001',5,14500)
INSERT INTO FactBanHang VALUES (16,'HH003','CH14','KH014',15,34500)
INSERT INTO FactBanHang VALUES (17,'HH004','CH06','KH005',2,19700)
INSERT INTO FactBanHang VALUES (17,'HH002','CH04','KH003',8,10000)
INSERT INTO FactBanHang VALUES (17,'HH008','CH05','KH004',3,17000)
INSERT INTO FactBanHang VALUES (17,'HH014','CH12','KH012',15,6500)
INSERT INTO FactBanHang VALUES (17,'HH002','CH07','KH006',18,9000)
INSERT INTO FactBanHang VALUES (17,'HH008','CH05','KH004',250,17000)
INSERT INTO FactBanHang VALUES (18,'HH012','CH04','KH003',11,9000)
INSERT INTO FactBanHang VALUES (18,'HH009','CH09','KH010',5,23000)
INSERT INTO FactBanHang VALUES (18,'HH002','CH06','KH005',12,9000)
INSERT INTO FactBanHang VALUES (19,'HH013','CH14','KH014',5,25000)
INSERT INTO FactBanHang VALUES (19,'HH011','CH02','KH015',9,15000)
INSERT INTO FactBanHang VALUES (19,'HH013','CH14','KH014',7,25000)
INSERT INTO FactBanHang VALUES (20,'HH010','CH13','KH013',5,21000)
INSERT INTO FactBanHang VALUES (21,'HH009', 'CH05','KH004',2,23000)
INSERT INTO FactBanHang VALUES (22,'HH005', 'CH07','KH006',3,16700)
INSERT INTO FactBanHang VALUES (23,'HH013', 'CH08','KH007',2,25000)
INSERT INTO FactBanHang VALUES (24,'HH015', 'CH09','KH008',1,14500)
INSERT INTO FactBanHang VALUES (24,'HH004','CH10','KH009',7,19700)
INSERT INTO FactBanHang VALUES (24,'HH001','CH02','KH015',5,8500)
INSERT INTO FactBanHang VALUES (24,'HH002','CH08','KH006',68,9000)
INSERT INTO FactBanHang VALUES (24,'HH003','CH13','KH013',50,34500)

--
SELECT * FROM FactBanHang
