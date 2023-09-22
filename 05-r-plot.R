# File     : 05-r-plot.R
# Author   : Ming-Chang Lee
# Email    : alan9956@gmail.com
# RWEPA    : http://rwepa.blogspot.tw/
# GitHub   : https://github.com/rwepa
# Encoding : UTF-8

# 基礎繪圖環境graphics套件 -----
# (1).高階繪圖(high-level plotting) 
# (2).低階繪圖(low-level plotting)

# 繪圖 plot 參數 -----

# type     繪圖元素 type = {"p", "l", "b"}, 預設為"p", type = "n" 表示不繪製資料點
# xlim     x軸範圍 xlim = c(1, 100)
# ylim     y軸範圍 ylim = c(1, 100)
# log      log = "x", log = "y", log ="xy"
# main     主標題
# sub      置於x軸下方之次標題
# xlab     x軸標題
# ylab     y軸標題
# axes     關閉座標軸 axes = FALSE
# col      顏色, 整數1~8, 預設是1(黑色)
# colors() 全部657種顏色, col = "yellowgreen"
# pch      點符號{1~25}, pch = 1 預設空心圓, pch = 16 實心圓形
# lty      線符號{1~6}, lty = 1 預設實線
# lwd      線寬度, 預設值 lwd = 1 
# cex      文字與點符號之大小, 預設值 cex = 1
# legend   圖例

# 散佈圖 plot -----

# 技巧: 資料物件$欄位名稱

data(Cars93, package = "MASS")

plot(Cars93$Horsepower, Cars93$Price)
abline(lm(Price ~ Horsepower, data = Cars93, col = "red"))

# 盒鬚圖 boxplot
boxplot(Cars93$Price)

# 盒鬚圖詳解
Cars93_Price <- boxplot(Cars93$Price)

Cars93_Price

# 群組盒鬚圖
# OrchardSprays 果園噴霧劑
boxplot(decrease ~ treatment, 
        data = OrchardSprays, 
        col = "bisque")

# 水平群組盒鬚圖
boxplot(decrease ~ treatment, 
        data = OrchardSprays, 
        col = "bisque",
        horizontal=TRUE)

# 群組盒鬚圖-Y軸取log值
boxplot(decrease ~ treatment, 
        data = OrchardSprays, 
        col = "bisque", 
        log = "y")

# 長條圖 barplot -----
# mtcar範例
counts <- table(mtcars$gear)

barplot(counts, 
        main="Car Distribution",
        xlab="Number of Gears")

# 長條圖 - Cars93範例
data(Cars93, package = "MASS")
TypeCount <- table(Cars93$Type)
TypeCount

# 有改進的空間
barplot(TypeCount)

# Cars93-Type 水平長條圖 -----

# 設定外邊界區域(Outer Margin Areas)
# c(下, 左, 上, 右)
# 目的是增加Y軸標題的空間
op <- par(oma = c(0,3,0,0))

barplot(sort(table(Cars93$Type)),
        horiz = TRUE,
        col = "dodgerblue4",
        main = "Cars93-Type 水平長條圖",
        xlab = "次數",
        xlim = c(0, 25),
        cex.main = 2,
        las = 1)
mtext("型式", side=2, line=0, adj=1.5, outer=TRUE, las = 2)
box()

# reset to the default oma value c(0,0,0,0)
# or Ctrl + Shift + F10
par(op)

# Cars93(AirBags+Type)堆疊長條圖 -----

mytable2 <- table(Cars93$AirBags, Cars93$Type)
mycolor <- 2:(nrow(mytable2)+1)
barplot(mytable2,
        col = mycolor,
        main = "Cars93(AirBags+Type)堆疊長條圖",
        xlab = "Type",
        ylab = "AirBags",
        ylim = c(0, 25),
        cex.main = 2)
legend("topright",
       fill = mycolor,
       legend = rownames(mytable2),
       inset = c(0.01, 0.01))
box()

# Cars93(AirBags+Type)群組長條圖 -----

barplot(mytable2,
        beside = TRUE,
        col = mycolor,
        main = "Cars93(AirBags+Type)群組長條圖",
        xlab = "Type",
        ylab = "AirBags",
        ylim = c(0, 25),
        cex.main = 2)
legend("topright",
       fill = mycolor,
       legend = rownames(mytable2),
       inset = c(0.01, 0.01))
box()

# 直方圖 hist
hist(iris$Petal.Length,
     xlab = "Petal Length",
     col = "orange",
     border = "blue",
     main = "iris-Petal.Length 直方圖")

# 直方圖優化
hist(iris$Petal.Length,
     xlab = "Petal Length",
     col = "orange",
     border = "blue",
     main = "iris-Petal.Length 直方圖",
     ylim = c(0,40))

# 實作練習: 散佈圖矩陣 pairs -----
pairs(iris[-5], col = iris$Species, pch = 16, main = "iris-散佈圖矩陣")

# 繪圖結果輸出 -----
# http://rwepa.blogspot.com/2013/05/r.html

data(Cars93, package = "MASS")

pdf("Cars93_xyplot.pdf")

plot(Cars93$Horsepower, Cars93$Price,
     main = "Cars93 Scatter Plot",
     xlab = "Horsepower",
     ylab = "Price",
     pch = 16,
     col = Cars93$Type)

legend("topleft", 
       legend = levels(Cars93$Type), 
       col = 1:length(levels(Cars93$Type)),
       pch = 16)

dev.off()
# end
