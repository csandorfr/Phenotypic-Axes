rm(list = ls())

# Directory
setwd("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/gemma_R/src/module_disease")
library(ggplot2)

# load data
load("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/src/new_Figures/Fig5/Magma.Rdata")

# Make Plot
df<-df_magma_go[df_magma_go$Annotated<2000 & -log(as.numeric(df_magma_go$q)) > 20,]
df$VARIABLE_ID<-as.numeric(as.factor(df$VARIABLE))
df<-df[!duplicated(df$parentTerm),]
df$parentTerm <- factor(df$parentTerm, levels = df$parentTerm[order(df$VARIABLE)])

df$VARIABLE<-gsub("Microglia_","",df$VARIABLE)
My_Theme = theme(
axis.title.x = element_blank(),
axis.text.x = element_text(size = 30,angle = 90, vjust = 1.1, hjust=1),

axis.text.y = element_text(size = 30),
axis.title.y = element_blank(),
legend.text = element_text(size=30))




p<-ggplot(df,aes(VARIABLE_ID,parentTerm)) +  
  geom_point(aes(size=(-log(as.numeric(q))),color=factor(VARIABLE))) +
  theme(text = element_text(size=12))+
  scale_x_continuous(breaks = df$VARIABLE_ID, labels = df$DISEASE_SGN)
p<-p+My_Theme

