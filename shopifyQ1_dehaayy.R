install.packages("readxl") #Commented after first use
library("readxl")

##  I N T R O ##
#One reason in this unexpectedly high number of AOV is the presence of outliers
  #within the given data set.


#Reading the data
data <- read_excel("/Users/dehaay/Desktop/Shopify_challange_2022/2019 Winter Data Science Intern Challenge Data Set.xlsx")

hist(data$order_amount)

#Looking at the histogram, it is clearly visible that there are significant outliers that are present in the
  #data that increases the "naively" calculated average order value.

#In order to proceed, one of the outlier removal method of the interquartile range
  #method can be utilized


#Using IQR Method to Detect Outliers
quant75 <- quantile(data$order_amount, 0.75) #75 quantile of the order_amount
quant25 <- quantile(data$order_amount, 0.25) #25 quantile of the order_amount
iqr = IQR(data$order_amount) #same as quant75 - quant25


allowed_coeff <- 1.5
#1.5 as it is a traditionally used value in IQR Method that allows -2.7σ to 2.7σ
  #data range to be considered, and classifies outside this range as outlier. To Demonstrate the upper bound calculation => quant75 + 1.5 * (quant75 - quant25)
  # = 0.675σ + 1.5 * 1.35σ -> = 2.7σ

#The allowed additional range to 25%,75% quantiles that would not be considered outlier
allowed_additional_range <- allowed_coeff * iqr

#Using the rows of order_amount value that are lying between the allowed lower and upper ranges from the original data set
data_wout_outliers <- subset(data, my_data$order_amount > (quant25 - allowed_additional_range) & my_data$order_amount < (quant75 + allowed_additional_range))
boxplot(data_wout_outliers$order_amount ) #Outliers are still visible in the boxplot but greatly reduced.
AOV_sneaker <- mean(data_wout_outliers$order_amount)
AOV_sneaker

##Finalized AOV value is $293.72 calculated in dollors 
hist(data_wout_outliers$order_amount)
##The data is observed to be positively skewed 



## A D D I T I O N A L##

#Although the coefficient 1.5 is traditionally accepted
#the data without any outliers is found using 1.38 
allowed_coeff <- 1.38
allowed_additional_range <- allowed_coeff * iqr

data_wout_outliers <- subset(data, my_data$order_amount > (quant25 - allowed_additional_range) & my_data$order_amount < (quant75 + allowed_additional_range))
boxplot(data_wout_outliers$order_amount )
AOV_sneaker_1.38 <- mean(data_wout_outliers$order_amount)
AOV_sneaker_1.38

#Author 
#Deha Ay
#Shopify

