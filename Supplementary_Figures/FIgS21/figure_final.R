
# Load data and library
rm(list = ls())
setwd("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/Longitudinal_Data/src/phenix_beta_value/Prediction_Longitudinal/Tracking")
library(reshape2)
library(ggplot2)

p <- ggplot(df_list_cor3, aes(x=Name2, y=Correlation,col=Category)) +
  geom_boxplot()+ theme(axis.text.y = element_text(size=20))+coord_flip()+theme(legend.key.size = unit(1, "cm"),legend.text=element_text(size=10),legend.title=element_text(size=10))

 
p



