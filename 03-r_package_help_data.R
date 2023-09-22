# File     : 03-r_package_help_data.R
# Author   : Ming-Chang Lee
# Email    : alan9956@gmail.com
# RWEPA    : http://rwepa.blogspot.tw/
# GitHub   : https://github.com/rwepa

# 大綱 -----

# 3.1 R使用環境
# 3.2 套件 package
# 3.3 輔助說明 help
# 3.4 數學運算
# 3.5 資料物件

##############################
# 3.1 R使用環境 -----
##############################

# 控制台的特定符號
iris$Sepal.Length

# Google’s R Style Guide -----
# https://google.github.io/styleguide/Rguide.html

##############################
# 3.2 套件 package -----
##############################

# e1071 package
install.packages("e1071")

library(e1071)

example(svm, package="e1071")

# 已載入的套件
search()

# R套件-44類別
# https://cran.csie.ntu.edu.tw/web/packages/index.html

# 44類別-中文說明
# http://rwepa.blogspot.tw/2013/10/packages-list-32.html

# R對話資訊
sessionInfo()

# 套件安裝目錄

# 預設套件安裝目錄
.Library

# 套件安裝目錄
.libPaths()

# 已安裝套件
x <- installed.packages()
class(x)  # "matrix" "array"
dim(x)
mypackage = x[, 1] # matrix[列, 行]
mypackage[1:5]

library() # same as installed.packages()

##############################
# 3.3 輔助說明 help -----
##############################

help.start()

?plot

help(plot)

help.search("regression")

??regression

##############################
# 3.4 數學運算 -----
##############################

# R即是計算機
# log, exp

# e，作為數學常數，是自然對數函數的底數，亦稱自然常數、自然底數，或是尤拉數（Euler's number），以瑞士數學家尤拉命名。它是一個無限不循環小數
exp(1) # 2.718282
log(exp(1))
log(exp(2))
log10(1000)

# 算術操作 (arithmetic operator)

# +, -, *, /, ^, %%, %/%, %*%(2個矩陣相乘)
1+2
1/3
2^3 # 次方
7 %% 2  # 餘數
7 %/% 2 # 商數

# 關係比較操作 (relation/comparison operator) 
# ==, !=, <, <=, >, >=

# 邏輯操作(logical operator)
# ! NOT
# & AND
# | OR

# 特殊數值
x <- 5/0

x # Inf

exp(x)

exp(-x)

x - x

0/0 # NaN

# NA
x.NA <- c(1, 2, 3)

x.NA

length(x.NA) <- 4

x.NA

pi

letters

LETTERS

month.abb

month.name

##############################
# 3.5 資料物件 -----
##############################

# 資料型別
# 整數
# 數值
# 字串: 須使用 ‘台北市‘ 或 “台北市“ 符號
# 邏輯值: 包括 TRUE, FALSE

# 資料物件
# 1.向量   vector
# 2.矩陣   matrix
# 3.陣列   array
# 4.資料框 data.frame
# 5.串列   list

# 建立向量函數 c (concatenate) -----
x <- c(1, 3, 5, 7, 9)
x

# 因子 factor - levels, labels -----
f1 <- factor(1:3)
f2 <- factor(1:3, levels=1:5)

f1
f2

f2[4] <- 5
f2[5] <- 10
f2

# factor 範例1
eye.colors <- factor(c("brown", "blue", "blue", "green", "brown", "brown", "brown"))
eye.colors
levels(eye.colors)

# factor 範例2
gender <- factor(c("男", "女", "男", "男", "女"))

gender

levels(gender)

str(gender)

# 有序因子 (ordered factor)

ClothSize <- ordered(c("L", "H", "L", "M", "H"), 
                     levels = c("L", "M", "H"))

ClothSize

levels(ClothSize)

str(ClothSize)

# 因子轉換
# as.factor 		    轉換為因子
# as.numeric()     	轉換為數值
# as.character()   	轉換為字串

# cut 函數示範
?cut

# 向量 vector

# 整數
v0 <- c(1:10)
v0
class(v0)
typeof(v0)

# 實數
v1 <- c(.29, .30, .15, .89, .12)
v1
class(v1)
typeof(v1)

v1[1]
v1[2:4]
v1[1,3,5] # error
v1[c(1,3,5)]

# 字元
x2 <- c("Taiwan", "China", "USA")
x2
is.vector(x2)

# Expand the length of a vector
length(x2) <- 5
x2

# 數值+字元
# 強制(coercion)轉換成單一相同型態
v2 <- c(.29, .30, .15, .89, .12, "wepa")
v2
class(v2)
typeof(v2)
mean(v2)

# 如何取得數值資料之平均值
as.numeric(v2)
mean(as.numeric(v2))
mean(as.numeric(v2), na.rm=TRUE)

# 向量具有 mode, length 屬性 
x1 <- vector(mode="numeric", length=1000000)

# 檢視前6筆資料
head(x1)

# 是否為向量
is.vector(x1)

taiwan1 <- c("正月初一", "正月初二", "正月初四", "正月初五", "正月初九", "正月十五")
names(taiwan1) <- c("春節", "回娘家", "接神日", "迎財神", "天公生", "元宵節")
taiwan1

# 矩陣 matrix

# 預設採用直行填入資料
x <- matrix(c(1:4), ncol = 2)
x
# [,1] [,2]
# [1,]    1    3
# [2,]    2    4

# 使用 byrow = TRUE 改為橫列填入
x <- matrix(c(1:4), ncol = 2, byrow = TRUE)
x
# [,1] [,2]
# [1,]    1    2
# [2,]    3    4
t(x)
diag(x)

# 矩陣運算
y <- matrix(c(4:1), ncol = 2)
y

x %*% y

?solve # 解a*x=b

# 資料框 data.frame

# cars資料集線上說明
?cars
help(cars)

# 載入資料集
data(cars) # 好像不輸入data(cars),亦可以直接輸入cars???

# 顯示資料集
cars

# 資料類別
class(cars) # data.frame 資料框

# 前6筆資料
head(cars)

# 前3筆資料
head(cars, n=3)

# 第2行資料, 結果是直行, 表示資料框
cars[2]

# 第2行資料, 結果是直行, 表示資料框
cars["dist"]

# 第2行資料, 結果是橫放, 表示向量
cars[,2]

# 認識 iris, 150*5, 150列,5行資料
iris

# 前6筆資料
head(iris)

# 後6筆資料
tail(iris)

# 資料結構 str
str(iris)

# 資料摘要 summary
summary(iris)

# Sepal.Length  欄位名稱
# Min.   :4.300 最小值 Minimum
# 1st Qu.:5.100 25百分位數 First Quantile  第一四分位數 Q1
# Median :5.800 50百分位數 Second Quantile 第二四分位數 Q2
# Mean   :5.843 平均值
# 3rd Qu.:6.400 75百分位數 Third Quantile  第三四分位數 Q3
# Max.   :7.900 最大值 Maximum

# https://en.wikipedia.org/wiki/Quartile

# 實作練習 -----

# 練習a.iris {datasets} 操作
# 找出 Sepal.Length變數大於中位數的資料集

# analysis:
iris$Sepal.Length[iris$Sepal.Length > median(iris$Sepal.Length)]

# 練習b.Cars93 {MASS}操作,資料篩選
# 練習列,行,條件式資料篩選
data(Cars93, package = "MASS")
Cars93
str(Cars93)
summary(Cars93)

# analysis:
# 列資料篩選
Cars93[1:3,]
Cars93[c(2,4,6,90),]

# 行資料篩選
Cars93[1]
Cars93[,1]
Cars93["Manufacturer"]

Cars93[2:4]
Cars93[,2:4]

head(Cars93[c(1,3,5,7)])
head(Cars93[c("Manufacturer", "Type", "Price", "MPG.city")])

# 條件式資料篩選
Cars93[Cars93$Price > 30,]
Cars93[Cars93$Type == "Large",]
Cars93[Cars93$Price > 30 & Cars93$Type == "Large",] # & AND
Cars93[Cars93$Price > 30 | Cars93$Type == "Large",] # | OR

# 練習c.計算 Luggage.room 的平均值為何?
# 將 Luggage.room 的遺漏值以平均值填補
mean(Cars93$Luggage.room) # NA ???

mean(Cars93$Luggage.room, na.rm = TRUE)

sum(is.na(Cars93$Luggage.room)) # 11

Cars93$Luggage.room[is.na(Cars93$Luggage.room)] <- mean(Cars93$Luggage.room, na.rm = TRUE)

sum(is.na(Cars93$Luggage.room)) # 0

# 參考資料 -----

# RWEPA
# http://rwepa.blogspot.com/

# Python 程式設計-李明昌 <免費電子書>
# http://rwepa.blogspot.com/2020/02/pythonprogramminglee.html

# R入門資料分析與視覺化應用教學(付費)
# https://mastertalks.tw/products/r?ref=MCLEE

# R商業預測與應用(付費)
# https://mastertalks.tw/products/r-2?ref=MCLEE 
# end
# 謝謝您的聆聽 , Q & A
# 完成R之旅 ^_^
