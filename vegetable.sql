GO
--drop database OrderManagement

GO
CREATE DATABASE VegetableShop

GO
USE VegetableShop

--GO
--drop table tblUsers

GO
CREATE TABLE [dbo].[tblRoles](
	[roleID] [char](2) NOT NULL,
	[roleName] [nvarchar](50) NULL,
CONSTRAINT [PK_tblRoles] PRIMARY KEY (roleID)
)

GO
CREATE TABLE [dbo].[tblUsers](
	[userID] [nvarchar](50) NOT NULL,
	[fullName] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,	
	[roleID] [char](2) NOT NULL,
	[address] [nvarchar](50) NULL,
	[birthday] [date] NULL,
	[phone] [char](10) NULL,
	[email] [nvarchar](50) NULL,
	[status] [bit] NULL,
CONSTRAINT [FK_tblUsers] FOREIGN KEY (roleID) REFERENCES [tblRoles] (roleID),
CONSTRAINT [PK_tblUsers] PRIMARY KEY (userID)
)

GO
CREATE TABLE [dbo].[tblOrders](
	[orderID] [int] IDENTITY(1, 1) NOT NULL,
	[orderDate] [date] NULL,
	[total] [real] NULL,	
	[userID] [nvarchar](50) NOT NULL,
	[status] [int] NULL,
CONSTRAINT [FK_tblOrders] FOREIGN KEY (userID) REFERENCES [tblUsers] (userID),
CONSTRAINT [PK_tblOrders] PRIMARY KEY (orderID)
)


GO
CREATE TABLE [dbo].[tblCategory](
	[categoryID] [nvarchar](50) NOT NULL,
	[categoryName] [nvarchar](50) NULL,	
CONSTRAINT [PK_tblCategory] PRIMARY KEY (categoryID)
)

GO
CREATE TABLE [dbo].[tblProduct](
	[productID] [nvarchar](50) NOT NULL,
	[productName] [nvarchar](50) NULL,
	[image] [nvarchar](50) NULL,	
	[price] real NULL,
	[quantity] int NULL,
	[categoryID] [nvarchar](50) NOT NULL,
	[importDate] [date] NULL,
	[usingDate] [date] NULL,
CONSTRAINT [FK_tblProduct] FOREIGN KEY (categoryID) REFERENCES [tblCategory] (categoryID),
CONSTRAINT [PK_tblProduct] PRIMARY KEY (productID)
)

GO
CREATE TABLE [dbo].[tblOrderDetail](
	[detailID] [int] IDENTITY(1, 1) NOT NULL,	
	[orderID] [int] NOT NULL,
	[productID] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
	[price] [real] NULL,
		
CONSTRAINT [FK_orderID_tblOrderDetail] FOREIGN KEY (orderID) REFERENCES [tblOrders] (orderID),
CONSTRAINT [FK_productID_tblOrderDetail] FOREIGN KEY (productID) REFERENCES [tblProduct] (productID),
CONSTRAINT [PK_tblOrderDetail] PRIMARY KEY (detailID)
)


--INSERT DATA
GO
INSERT [dbo].[tblRoles] ([roleID], [roleName]) VALUES ('AD', N'Administrator')
INSERT [dbo].[tblRoles] ([roleID], [roleName]) VALUES ('US', N'User')

GO
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'admin', N'Toi la admin', N'1', N'AD', N'TPHCM', '2000-12-1', '0909090909', 'admin@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'Hoadnt', N'Hoa Doan', N'1', N'US', N'Long An', '1999-8-3', '0911111111', 'hoadnt@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE130363', N'Ngo Ha Tri Bao', N'1', N'AD', N'Binh Duong', '2001-12-24', '0922222222', 'baongo@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE140103', N'Phuoc Ha', N'1', N'US', N'Vung Tau', '2003-5-1', '0933333339', 'haphuoc@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE140119', N'Trai Nguyen', N'1', N'AD', N'Nam Dinh', '1997-4-30', '0944444444', 'nguyentrai@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE140130', N'Tam Tran', N'1', N'AD', N'Ha Noi', '1998-10-20', '0955555555', 'tramtam@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE140201', N'PHAM HOANG TU', N'1', N'AD', N'Ha Noi', '1998-6-1', '0966666666', 'tupham@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE140969', N'Nguyen Gia Tin', N'123', N'US', N'TPHCM', '2000-3-10', '0977777777', 'tinnguyen@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE150443', N'LE MINH KHOA', N'1', N'US', N'Can Tho', '2001-1-1', '0988888888', 'khoale@gmail.com', 1)

GO
INSERT [dbo].[tblOrders] ([orderDate], [total], [userID], [status]) VALUES ('2022-3-4', 24400, 'Hoadnt', '1')
INSERT [dbo].[tblOrders] ([orderDate], [total], [userID], [status]) VALUES ('2022-3-5', 15400, 'SE140969', '1')
INSERT [dbo].[tblOrders] ([orderDate], [total], [userID], [status]) VALUES ('2022-3-2', 7800, 'SE150443', '1')
INSERT [dbo].[tblOrders] ([orderDate], [total], [userID], [status]) VALUES ('2022-3-7', 42900, 'SE140103', '1')

GO
INSERT [dbo].[tblCategory] ([categoryID], [categoryName]) VALUES ('C001', N'Củ')
INSERT [dbo].[tblCategory] ([categoryID], [categoryName]) VALUES ('C002', N'Rau')
INSERT [dbo].[tblCategory] ([categoryID], [categoryName]) VALUES ('C003', N'Trái cây')
INSERT [dbo].[tblCategory] ([categoryID], [categoryName]) VALUES ('C004', N'Quả')
INSERT [dbo].[tblCategory] ([categoryID], [categoryName]) VALUES ('C005', N'Đậu')

GO
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P001', N'Củ cải đỏ', 'image/cuCaiDo.jpg', '6300', 50, 'C001', '2022-2-28', '2022-3-20')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P002', N'Rau diếp cá', 'image/rauDiepCa.jpg', '30000', 50, 'C002', '2022-2-27', '2022-3-5')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P003', N'Khổ qua', 'image/khoQua.jpg', '32000', 50, 'C004', '2022-2-28', '2022-3-20')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P004', N'Giá đỗ', 'image/giaDo.jpg', '25000', 50, 'C002', '2022-2-28', '2022-3-4')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P005', N'Cà chua', 'image/caChua.jpg', '47000', 50, 'C004', '2022-2-28', '2022-3-7')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P006', N'Cam', 'image/cam.jpg', '40000', 50, 'C004', '2022-1-3', '2022-3-20')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P007', N'Bưởi', 'image/buoi.jpg', '44000', 50, 'C004', '2022-3-4', '2022-3-25')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P008', N'Xà lách', 'image/xaLach.jpg', '18000', 50, 'C002', '2022-2-28', '2022-3-4')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P009', N'Bắp cải', 'image/bapCai.jpg', '22000', 50, 'C002', '2022-3-10', '2022-3-20')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P010', N'Củ cải trắng', 'image/cuCaiTrang.jpg', '12000', 50, 'C001', '2022-2-28', '2022-3-20')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P011', N'Hành tây', 'image/hanhTay.jpg', '15000', 50, 'C001', '2022-2-27', '2022-3-30')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P012', N'Hành lá', 'image/hanhLa.jpg', '27000', 50, 'C002', '2022-2-28', '2022-3-8')

INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate]) 
VALUES (N'P013', N'Tỏi', 'image/toi.jpg', '26000', 50, 'C001', '2022-2-28', '2022-4-20')


GO
INSERT [dbo].[tblOrderDetail] ([orderID], [productID], [quantity], [price]) VALUES (1, 'P001', 3, 10000)
INSERT [dbo].[tblOrderDetail] ([orderID], [productID], [quantity], [price]) VALUES (1, 'P010', 2, 14400)
INSERT [dbo].[tblOrderDetail] ([orderID], [productID], [quantity], [price]) VALUES (2, 'P008', 2, 15400)
INSERT [dbo].[tblOrderDetail] ([orderID], [productID], [quantity], [price]) VALUES (3, 'P013', 5, 7800)
INSERT [dbo].[tblOrderDetail] ([orderID], [productID], [quantity], [price]) VALUES (4, 'P001', 3, 18900)
INSERT [dbo].[tblOrderDetail] ([orderID], [productID], [quantity], [price]) VALUES (4, 'P005', 1, 4000)
INSERT [dbo].[tblOrderDetail] ([orderID], [productID], [quantity], [price]) VALUES (4, 'P002', 5, 20000)

