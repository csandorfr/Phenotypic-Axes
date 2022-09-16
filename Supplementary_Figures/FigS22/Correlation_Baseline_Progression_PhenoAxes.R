# Set up
rm(list = ls())
setwd("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/Longitudinal_Data/src/phenix_beta_value/correlation_base_line")
library(ggplot2)
library(ggpubr)
range01 <- function(x){(x-min(x))/(max(x)-min(x))}


# Load Discovery
load("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/Longitudinal_Data/src/phenix_beta_value/OPDC/V2/data_OPDC_AK.Rdata")
S_base<-as.data.frame(out$S[,1])
S_base$ID<-row.names(Y_temp)
S_long<-as.data.frame(out_long$S[,1])
S_long$ID<-row.names(Phen_long_red)
S<-merge(S_base,S_long,by=c("ID"))
colnames(S)<-c("ID","Base","Long")
rm(list= ls()[!(ls() %in% c('S'))])
S1<-S

# Load PPMI
load("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/Longitudinal_Data/src/phenix_beta_value/PPMI/V3/data_AK.Rdata")
S_base<-as.data.frame(out3$S[,1])
S_base$ID<-row.names(Y_temp3)
S_long<-as.data.frame(list_out$OnOff_withSWEDD$out$S[,1])
S_long$ID<-row.names(list_out$OnOff_withSWEDD$Phen)
S<-merge(S_base,S_long,by=c("ID"))
colnames(S)<-c("ID","Base","Long")
S$Cohort<-"PPMI"
S1$Cohort<-"Discovery"
S_final<-rbind(S1,S)
rm(list= ls()[!(ls() %in% c('S_final'))])

# Load Tracking
load("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/Longitudinal_Data/src/phenix_beta_value/Tracking/data_Tracking3.Rdata")
load("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/Longitudinal_Data/data/Tracking_AK/Tracking_Phen.Rdata")
S_base<-as.data.frame(out$S[,1])
S_base$ID<-row.names(Y_temp_red)
S_long<-as.data.frame(out_long$S[,1])
S_long$ID<-row.names(Phen_long_red)
S<-merge(S_base,S_long,by=c("ID"))
colnames(S)<-c("ID","Base","Long")
S$Cohort<-"Tracking"

S_final<-rbind(S_final,S)
rm(list= ls()[!(ls() %in% c('S_final'))])

# Plot

ggplot(S_final,aes(Base, Long)) +
  facet_grid(~Cohort)+
  geom_point()+
  geom_smooth(method='lm', formula= y~x)+
stat_cor(aes(label =..p.label..), label.x = 0, label.y =4)
