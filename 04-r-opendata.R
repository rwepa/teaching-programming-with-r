# File     : 04-r-opendata.R
# Author   : Ming-Chang Lee
# Email    : alan9956@gmail.com
# RWEPA    : http://rwepa.blogspot.tw/
# GitHub   : https://github.com/rwepa
# Encoding : UTF-8

# 開放資料的匯入與繪圖 -----

# read.table  輸入文字檔
# read.csv    輸入CSV檔
# write.table 輸出文字檔
# write.csv   輸出CSV檔

# 步驟 1. 設定工作目錄
# 步驟 2. 建立資料檔
# 步驟 3. 匯入資料  read.table
# 步驟 4. 資料處理
# 步驟 5. 匯出資料

#********************
# 步驟 1. 設定工作目錄 -----
#********************

# 預設工作目錄(我的文件)
getwd()

# 設定工作目錄為 "C:/rdata"
workpath <- "C:/rdata"
setwd(workpath)

# 已經更改為 C:/rdata 工作目錄
getwd()

dir()

#********************
# 步驟 2. 準備資料檔 -----
#********************

# 日空氣品質指標(AQI)
# https://data.gov.tw/dataset/40507

#********************
# 步驟 3. 匯入資料  read.table -----
#********************

# ?read.table
# header: 標題名稱, sep: 區隔符號

myfile <- "aqx_p_434.csv"

aq <- read.table(myfile, header=TRUE, sep=",")

head(aq) # 欄位名稱與資料皆正確顯示

# 資料檢視
head(aq, n=5)

names(aq) # 欄位名稱

#********************
# 步驟 4. 資料處理 -----
#********************

# 日期: 字串(chr)修正為日期(Date)
str(aq)

aq$monitordate <- as.Date(aq$monitordate)

str(aq)

# 維度 dim
head(aq)
dim(aq) # 1000列11L行

# 篩選資資料
aq.Banqiao<- aq[aq$sitename == "板橋", ]
aq.Banqiao <- aq.Banqiao[order(aq.Banqiao$monitordate), ]

aq.Xizhi <- aq[aq$sitename == "汐止", ]
aq.Xizhi <- aq.Xizhi[order(aq.Xizhi$monitordate), ]

# 繪製直線圖
plot(aq.Banqiao$aqi, type="b")
lines(aq.Xizhi$aqi, col="red")
points(aq.Xizhi$aqi, col="red")

ymin <- min(aq.Banqiao$aqi, aq.Xizhi$aqi) - 1
ymax <- max(aq.Banqiao$aqi, aq.Xizhi$aqi) + 3

# ylim       : Y軸範圍
# xaxt = "n" : 取消預設刻度
# axis       : 人工設定刻度
# legend     : 圖例

plot(aq.Banqiao$aqi, 
     type = "b", 
     ylim = c(ymin, ymax), 
     main = "2022年7月AQI-板橋vs.汐止",
     xaxt = "n",
     xlab = "日期",
     ylab = "AQI")

axis(side = 1,
     at = 1:length(aq.Banqiao$aqi),
     labels = aq.Banqiao$monitordate,
     cex.axis = 0.8)

lines(aq.Xizhi$aqi, col="red")
points(aq.Xizhi$aqi, col="red")
legend("topleft", legend=c("板橋", "汐止"), col=c(1,2), lty=1)

#********************
# 步驟 5. 匯出資料 -----
#********************

aq.Banqiao.Xizhi <- rbind(aq.Banqiao, aq.Xizhi)

write.table(x = aq.Banqiao.Xizhi, 
            file = "aq.Banqiao.Xizhi.csv", 
            sep = ",", 
            row.names = FALSE,
            fileEncoding = "CP950") # ONLY FOR WINDOWS, 使用"BIG-5"亦可.

# RData 資料物件儲存/匯入 -----
# save(資料物件1, 資料物件2, file = "myData.RData")
# load("myData.RData")

# 實作練習 -----
# 將 aq, aq.Banqiao.Xizhi 儲存為 aq.Banqiao.Xizhi.RData
# 練習載入 aq.Banqiao.Xizhi.RData

save(aq, aq.Banqiao.Xizhi, file = "aqBanqiaoXizhi.RData")

# 按 Session \ Restart R

load(file = "aqBanqiaoXizhi.RData")

# 讀取 SAS 檔案 -----

# h_nhi_ipdte103.sas7bdat 103年模擬全民健保處方及治療明細檔_西醫住院檔
# 下載 https://github.com/rwepa/DataDemo/blob/master/h_nhi_ipdte103.sas7bdat

# 方法1. 使用 sas7bdat 套件
# https://cran.r-project.org/web/packages/sas7bdat/index.html

library(sas7bdat)
dd2014 <- read.sas7bdat("h_nhi_ipdte103.sas7bdat") # Error

# 方法2. 使用 haven 套件讀取結果為正確顯示
# https://cran.r-project.org/web/packages/haven/index.html

library(haven)
dd2014 <- read_sas("h_nhi_ipdte103.sas7bdat")

# 執行系統時間, 每次執行時間可能不相同.
system.time(dd2014 <- read_sas("h_nhi_ipdte103.sas7bdat")) # 0.42秒
# 使用者   系統   流逝 
# 0.33     0.00   0.42

# 方法3. RStudio: 右側 [Environment]視窗 \ [Import] \ [From SAS...]

# 顯示資料
dd2014 # 14,297 × 80

# 類別
class(dd2014) # "tbl_df" "tbl" "data.frame"

# 匯入 SPSS -----

# foreign 套件
# https://cran.r-project.org/web/packages/foreign/index.html

# foreign 套件可讀取以下檔案格式:
# Minitab, S, SAS, SPSS, Stata, Systat, Weka, dBase

library(foreign)

# 下載 https://github.com/rwepa/DataDemo/blob/master/school.sav

db <- read.spss("school.sav", to.data.frame = TRUE)
head(db)
str(db)

# RMySQL套件編譯與建立 -----
# http://rwepa.blogspot.tw/2013/01/windows-rmysql.html

# RODBC 與 SQL Server 資料匯入與寫入 -----
# http://rwepa.blogspot.tw/2013/08/rodbc-sql-server.html
# end
