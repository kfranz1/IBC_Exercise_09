setwd("~/Desktop/IBC_Exercise_09")
library(ggplot2)
library(cowplot)
library(reshape2)

# Problem 1

# load data on the name "Clara since the year 2000!"
Clara <- read.delim("Clara.txt")

# create the scatterplot
a = ggplot(data=XY, mapping=aes(x=Year, y=Percentage))+
  geom_point(color = "blue", size=2)+
  xlab("Year")+ylab("% Female Babies in US named 'Clara'")+
  theme_classic()+
  
#add treadline
  stat_smooth(method="lm") 
a

# Problem 2 

# load data from file 
data <- read.delim("data.txt", sep =',', header= TRUE, stringsAsFactors = FALSE)

# Create barplot of means of four populations 
# I'm SURE there is a better and easier way to do this..

# establish unique regions
unique_regions = unique(data$region)
regions = length(unique_regions)

#create a vector for means 
means = c(1:regions)

for (i in 1:regions){
  regiondata= subset(data, data$region == unique_regions[i])
  regionmean = mean(regiondata$observations)
  means[i] =regionmean
}

# make df for region and mean 
meandata = data.frame("region"=unique_regions, "mean"=means)

b <- ggplot(data=meandata, aes(x=region,y=mean)) +
  xlab("Region")+ylab("Mean(Observations)")+
  geom_bar(stat = "identity") +
  theme_classic()
b

# Create scatterplot of all of the observations (jitter the points)
c <- ggplot(data=data, aes(x=region, y=observations)) +
  geom_point(color = "blue", size=2)+
  xlab("Region")+ylab("Observations")+
  geom_jitter()+
  theme_classic()
c

# display both figures that summarize the data 
plot_grid(b,c, ncol=2)

# do the bar and scatterplots tell different stories? Why?

# The bar plots show only the means, while the scatter plots show the spreads
# of the individual datapoints. The locations regions drastically in  
# their distributions. Some are spread close to the mean, while others have a high 
# variance around the mean, and one appears to be bimodal rather than unimodal (south).
# Populations that seem similar based on mean alone can in reality be quite different. 