--***************************************************************************************
--                              A. TRUY VẤN ĐƠN GIẢN (+ Pivot)                         --
--***************************************************************************************
     
-----------------------------------------------------------------------------------------
-- A.1/ Tổng doanh số của tất cả các loại hàng hóa
-----------------------------------------------------------------------------------------
   SELECT [MEASURES].[thanhtien] ON COLUMNS, 
          [HANG HOA].[loaihh] ON ROWS
   FROM [KDHH_CUBE];
   
   SELECT [MEASURES].[thanhtien] ON AXIS(0), 
          [HANG HOA].[loaihh] ON AXIS(1)
   FROM [KDHH_CUBE];
   
   SELECT [MEASURES].[thanhtien] ON 0, 
          [HANG HOA].[loaihh] ON 1
   FROM [KDHH_CUBE];

-----------------------------------------------------------------------------------------
-- A.2/ Doanh số của từng loại hàng hóa 
-----------------------------------------------------------------------------------------
   SELECT [MEASURES].[thanhtien] ON COLUMNS, 
          [HANG HOA].[loaihh].MEMBERS ON ROWS
   FROM [KDHH_CUBE];
   
   SELECT [MEASURES].[thanhtien] ON COLUMNS, 
          NON EMPTY [HANG HOA].[loaihh].MEMBERS ON ROWS
   FROM [KDHH_CUBE];

-----------------------------------------------------------------------------------------
-- A.3/ Doanh số của loại hàng hóa là bánh kẹo
-----------------------------------------------------------------------------------------
   SELECT [MEASURES].[thanhtien] ON COLUMNS, 
          [HANG HOA].[loaihh].[Bánh kẹo] ON ROWS
   FROM [KDHH_CUBE];
  
-----------------------------------------------------------------------------------------
-- A.4/ Doanh số của khu vực miền Trung
-----------------------------------------------------------------------------------------
   SELECT [MEASURES].[thanhtien] ON COLUMNS,
          [CUA HANG].[tenmien].[Miền Trung] ON ROWS
   FROM [KDHH_CUBE];

-----------------------------------------------------------------------------------------
-- A.5/ Doanh số của các loại hàng hóa: bánh kẹo và nước giải khát
-----------------------------------------------------------------------------------------
   -- Nếu là tập hợp có nhiều thành phần thì sử dụng { }
   ----------------------------------
   SELECT [MEASURES].[thanhtien] ON COLUMNS, 
          {[HANG HOA].[loaihh].[Bánh kẹo], [HANG HOA].[loaihh].[Nước giải khát]} ON ROWS
   FROM [KDHH_CUBE];

-----------------------------------------------------------------------------------------
-- A.6/ Số lần bán hàng và doanh số của các khu vực: miền Bắc và miền Nam
-----------------------------------------------------------------------------------------
   SELECT {[MEASURES].[HOA DON Count], [MEASURES].[thanhtien]} ON COLUMNS, 
          {[CUA HANG].[tenmien].[Miền Bắc], [CUA HANG].[tenmien].[Miền Nam]} ON ROWS
   FROM [KDHH_CUBE];

   -- Thay đổi thứ tự các dòng
   SELECT {[MEASURES].[HOA DON Count], [MEASURES].[thanhtien]} ON COLUMNS, 
          {[CUA HANG].[tenmien].[Miền Nam], [CUA HANG].[tenmien].[Miền Bắc]} ON ROWS
   FROM [KDHH_CUBE];

-----------------------------------------------------------------------------------------
-- A.7/ Số lần bán hàng và doanh số của tất cả các loại hàng hóa
-----------------------------------------------------------------------------------------
   SELECT {[MEASURES].[HOA DON Count], [MEASURES].[thanhtien]} ON COLUMNS,
          NON EMPTY [HANG HOA].[loaihh].MEMBERS ON ROWS
   FROM [KDHH_CUBE];
   
-----------------------------------------------------------------------------------------
-- A.8/ Tất cả measures của các hàng hóa thuộc 2 loại: bánh kẹo và dầu ăn
-----------------------------------------------------------------------------------------
   SELECT [MEASURES].MEMBERS ON COLUMNS,
          NON EMPTY {[HANG HOA].[loaihh].[Bánh kẹo], [HANG HOA].[loaihh].[Dầu ăn]} ON ROWS
   FROM [KDHH_CUBE];
  
-----------------------------------------------------------------------------------------
-- A.9/ Tất cả measures của tất cả các loại hàng hóa
-----------------------------------------------------------------------------------------
   SELECT [MEASURES].MEMBERS ON COLUMNS,
          NON EMPTY [HANG HOA].[loaihh].MEMBERS ON ROWS
   FROM [KDHH_CUBE];
   
-----------------------------------------------------------------------------------------
-- A.10/ Xoay chiều (PIVOT) của ví dụ trên 
-----------------------------------------------------------------------------------------
   SELECT [MEASURES].MEMBERS ON ROWS,
          NON EMPTY [HANG HOA].[loaihh].MEMBERS ON COLUMNS
   FROM [KDHH_CUBE];
   
   
--***************************************************************************************
--                                B. TRUY VẤN PHÂN CẤP                                 --
--***************************************************************************************
   
-----------------------------------------------------------------------------------------
-- B.1/ Doanh số của các cửa hàng theo khu vực của Việt Nam
-----------------------------------------------------------------------------------------
   -- Phân tích theo cửa hàng với CH_KV là tên của hierarchy trong dim [CUA HANG]
   -- Nếu không đặt tên CH_KV thì sử dụng từ khóa [Hierarchy] thay vì [CH_KV]
   SELECT [MEASURES].[thanhtien] ON COLUMNS, 
          [CUA HANG].[CH_KV].[tenqgia].[Việt Nam].CHILDREN ON ROWS
   FROM [KDHH_CUBE];
   
-----------------------------------------------------------------------------------------
-- B.2/ Doanh số của các khách hàng theo khu vực của Việt Nam
-----------------------------------------------------------------------------------------
   -- Phân tích theo khách hàng với KH_KV là tên của hierarchy trong dim [KHACH HANG]
   SELECT [MEASURES].[thanhtien] ON COLUMNS, 
          [KHACH HANG].[KH_KV].[tenqgia].[Việt Nam].CHILDREN ON ROWS
   FROM [KDHH_CUBE];

-----------------------------------------------------------------------------------------
-- B.3/ Doanh số của mỗi quý trong năm 2014
-----------------------------------------------------------------------------------------
   -- Dù khi thiết kế có dim [THOI GIAN] nhưng cube KDHH_DW sẽ không display dim này
   -- Lưu ý: [ngayhd] thay thế cho dim [THOI GIAN] và [TG] vẫn đóng vai trò Hierarchy
   SELECT [MEASURES].[thanhtien] ON COLUMNS, 
          [ngayhd].[TG].[Nam].[2014].CHILDREN ON ROWS
   FROM [KDHH_CUBE];
   
-----------------------------------------------------------------------------------------
-- B.4/ Doanh số và số lần bán hàng của từng hàng hóa thuộc loại dầu ăn
-----------------------------------------------------------------------------------------
   -- HH là tên của hierarchy trong dim [HANG HOA]
   SELECT {[MEASURES].[thanhtien], [MEASURES].[HOA DON Count]} ON COLUMNS, 
          [HANG HOA].[HH].[loaihh].[Dầu ăn].CHILDREN ON ROWS
   FROM [KDHH_CUBE];
   
-----------------------------------------------------------------------------------------
-- B.5/ Doanh số của từng hàng hóa thuộc loại dầu ăn và bánh kẹo
-----------------------------------------------------------------------------------------
   SELECT [MEASURES].[thanhtien] ON COLUMNS, 
          {[HANG HOA].[HH].[loaihh].[Bánh kẹo].CHILDREN, 
           [HANG HOA].[HH].[loaihh].[Dầu ăn].CHILDREN} ON ROWS
   FROM [KDHH_CUBE];
   
-----------------------------------------------------------------------------------------
-- B.6/ Doanh số của các cửa hàng theo từng miền ở Việt nam
-----------------------------------------------------------------------------------------
   -- Cách 1: Sử dụng CHILDREN
   SELECT [CUA HANG].[CH_KV].[tenqgia].[Việt Nam].CHILDREN ON ROWS, 
          [MEASURES].[thanhtien] ON COLUMNS
   FROM [KDHH_CUBE];
   
   -- Cách 2: Sử dụng DESCENDANTS(<Member_exp> [, <Level_exp> [, <Flag>]])
   -- Member_exp: [CUA HANG].[CH_KV].[tenqgia].[Việt Nam]
   -- Level_exp, Flag:  [CUA HANG].[CH_KV].[tenqgia], SELF
   SELECT DESCENDANTS ([CUA HANG].[CH_KV].[tenqgia].[Việt Nam], 
                       [CUA HANG].[CH_KV].[tenmien], SELF) ON ROWS, 
          [MEASURES].[thanhtien] ON COLUMNS
   FROM [KDHH_CUBE];
   
-----------------------------------------------------------------------------------------
-- B.7/ Doanh số của các cửa hàng theo từng thành phố và từng miền ở Việt nam
-----------------------------------------------------------------------------------------
   -- Cách 1: Sử dụng SELF AND BEFORE
   SELECT DESCENDANTS ([CUA HANG].[CH_KV].[tenqgia].[Việt Nam], 
                       [CUA HANG].[CH_KV].[tentpho], SELF_AND_BEFORE) ON ROWS, 
          [MEASURES].[thanhtien] ON COLUMNS
   FROM [KDHH_CUBE];
   
   -- Cách 2: Sử dụng BEFORE
   -- [Khoa CH]: tên đại điện của khoach trong hierarchy CH_KV, và thấp hơn tentpho 1 bậc
   SELECT DESCENDANTS ([CUA HANG].[CH_KV].[tenqgia].[Việt Nam], 
                       [CUA HANG].[CH_KV].[Khoa CH], BEFORE) ON ROWS, 
          [MEASURES].[thanhtien] ON COLUMNS
   FROM [KDHH_CUBE];
   
-----------------------------------------------------------------------------------------
-- B.8/ Doanh số của từng thành phố và từng cửa hàng thuộc Việt nam
-----------------------------------------------------------------------------------------
   -- Cách 1: Sử dụng SELF_AND_AFTER
   SELECT DESCENDANTS([CUA HANG].[CH_KV].[tenqgia].[Việt Nam], 
                      [CUA HANG].[CH_KV].[tentpho], SELF_AND_AFTER) ON ROWS, 
          [MEASURES].[thanhtien] ON COLUMNS
   FROM [KDHH_CUBE];
   
   -- Cách 2: Sử dụng AFTER
   SELECT DESCENDANTS([CUA HANG].[CH_KV].[tenqgia].[Việt Nam],
                      [CUA HANG].[CH_KV].[tenmien], AFTER) ON ROWS, 
          [MEASURES].[thanhtien] ON COLUMNS
   FROM [KDHH_CUBE];
   
-----------------------------------------------------------------------------------------
-- B.9/ Doanh số của từng loại hàng hóa theo từng miền
-----------------------------------------------------------------------------------------
   -- Phân tích 2 chiều: đặt measures vào thành phần WHERE   
   SELECT NON EMPTY [HANG HOA].[loaihh].MEMBERS ON COLUMNS, 
   	  NON EMPTY [CUA HANG].[tenmien].MEMBERS ON ROWS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[thanhtien]);

-----------------------------------------------------------------------------------------
-- B.10/ Doanh số của các loại hàng hóa theo từng năm
-----------------------------------------------------------------------------------------
   -- [TG] là tên của hierarchy trong dim [THOI GIAN]
   SELECT NON EMPTY [HANG HOA].[loaihh].MEMBERS ON ROWS, 
   	  NON EMPTY [ngayhd].[TG].[nam].MEMBERS ON COLUMNS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[thanhtien]);

--***************************************************************************************
--                                  C. SLICING, DICING                                 --
--***************************************************************************************
-----------------------------------------------------------------------------------------
-- C.1/ Doanh số theo từng khách hàng tại từng cửa hàng ở Việt Nam
-----------------------------------------------------------------------------------------
   -- tenkh phải là level thấp nhất trong hierarchy
   SELECT NON EMPTY [KHACH HANG].[tenkh].MEMBERS ON COLUMNS, 
          DESCENDANTS([CUA HANG].[CH_KV].[tenqgia].[Việt Nam], 
                      [CUA HANG].[CH_KV].[tench], SELF_AND_AFTER) ON ROWS
   FROM [KDHH_CUBE]
   WHERE [MEASURES].[thanhtien];

-----------------------------------------------------------------------------------------
-- C.2/ Doanh số từng loại hàng của từng cửa hàng ở TPHCM
-----------------------------------------------------------------------------------------
   -- Cách 1: 
   -- tench phải là level thấp nhất trong hierarchy
   SELECT NON EMPTY [HANG HOA].[loaihh].MEMBERS ON ROWS, 
   	  [CUA HANG].[tench].MEMBERS ON COLUMNS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[thanhtien], [CUA HANG].[tentpho].[TPHCM]);

   -- Cách 2: (không dùng MEMBERS --> không có All members trên dòng và cột)
   SELECT NON EMPTY [HANG HOA].[loaihh].MEMBERS ON ROWS, 
   	  [CUA HANG].[CH_KV].[tenqgia].[Việt Nam].[Miền Nam].[TPHCM].CHILDREN ON COLUMNS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[thanhtien]);

-----------------------------------------------------------------------------------------
-- C.3/ Doanh số của từng khách hàng tại từng cửa hàng đối với loại hàng hóa bánh kẹo
-----------------------------------------------------------------------------------------
   -- tenkh và tench phải lần lượt là các levels thấp nhất trong hierarchies
   SELECT NON EMPTY[KHACH HANG].[tenkh].MEMBERS ON ROWS, 
          NON EMPTY[CUA HANG].[tench].MEMBERS ON COLUMNS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[thanhtien], [HANG HOA].[loaihh].[Bánh kẹo]);
 
-----------------------------------------------------------------------------------------
-- C.4/ Doanh số của từng loại hàng hóa theo từng miền trong năm 2014
-----------------------------------------------------------------------------------------
   SELECT NON EMPTY [HANG HOA].[loaihh].MEMBERS ON ROWS, 
          NON EMPTY [CUA HANG].[tenmien].MEMBERS ON COLUMNS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[thanhtien], [ngayhd].[nam].[2014]);

-----------------------------------------------------------------------------------------
-- C.5/ Doanh số của từng loại hàng hóa theo từng quốc gia trong quý 1 năm 2014
-----------------------------------------------------------------------------------------
   -- Complex key  phải sử dụng &
   SELECT NON EMPTY [HANG HOA].[loaihh].MEMBERS ON ROWS, 
          NON EMPTY [CUA HANG].[tenqgia].MEMBERS ON COLUMNS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[thanhtien], [ngayhd].[TG].[quy].&[2014]&[1]);
   
  
--***************************************************************************************
--                                D. CALCULATED MEASURES                               --
--***************************************************************************************

-----------------------------------------------------------------------------------------
-- D.1/ Doanh số trung bình (tổng doanh số / số lần giao dịch) của mỗi cửa hàng ở TPHCM
-----------------------------------------------------------------------------------------
   -- tench phải là level thấp nhất trong hierarchy
   WITH MEMBER [MEASURES].[dsoTB] AS [MEASURES].[thanhtien]/[MEASURES].[HOA DON Count]
   SELECT [MEASURES].[dsoTB] ON COLUMNS, 
          NON EMPTY [CUA HANG].[tench].MEMBERS ON ROWS
   FROM [KDHH_CUBE]
   WHERE [CUA HANG].[tentpho].[TPHCM];

-----------------------------------------------------------------------------------------
-- D.2/ Doanh số trung bình của mỗi loại hàng hóa tại từng cửa hàng ở TPHCM
-----------------------------------------------------------------------------------------
   -- tench phải là level thấp nhất trong hierarchy
   WITH MEMBER [MEASURES].[dsoTB] AS [MEASURES].[thanhtien]/[MEASURES].[HOA DON Count]
   SELECT NON EMPTY [CUA HANG].[tench].MEMBERS ON ROWS, 
          NON EMPTY [HANG HOA].[loaihh].MEMBERS ON COLUMNS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[dsoTB], [CUA HANG].[tentpho].[TPHCM]);

-----------------------------------------------------------------------------------------
-- D.3/ Tiền thuế (10% doanh số) của từng cửa hàng ở VN trong từng năm 
-----------------------------------------------------------------------------------------
   -- Cách 1:
   -- tench phải là level thấp nhất trong hierarchy
   WITH MEMBER [MEASURES].[thue] AS [MEASURES].[thanhtien] * 0.1
   SELECT NON EMPTY [CUA HANG].[tench].MEMBERS ON ROWS, 
          NON EMPTY [ngayhd].[nam].MEMBERS ON COLUMNS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[thue], [CUA HANG].[tenqgia].[Việt Nam]);

   -- Cách 2:
   WITH MEMBER [MEASURES].[thue] AS [MEASURES].[thanhtien] * 0.1
   SELECT NON EMPTY DESCENDANTS([CUA HANG].[CH_KV].[tenqgia].[Việt Nam], 
                                [CUA HANG].[CH_KV].[tench], SELF_AND_AFTER) ON ROWS, 
   	  NON EMPTY [ngayhd].[nam].MEMBERS ON COLUMNS
   FROM [KDHH_CUBE]
   WHERE ([MEASURES].[thue]);
   
