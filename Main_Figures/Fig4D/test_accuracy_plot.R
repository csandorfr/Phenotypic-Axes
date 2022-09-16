rm(list = ls())
setwd("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/src/new_Figures/Fig4D")
load("Long_AD.Rdata")


library(ggpubr)

my_comparisons <- list( c("Original", "Alzheimer's disease (0.05)"))
My_Theme = theme(
axis.title.x = element_blank(),
axis.text.x = element_blank(),
axis.text.y = element_text(size = 40),
axis.title.y = element_text(size = 40),
legend.text = element_text(size=30))

p<- ggboxplot( df_phen, x = "Disease", y ="Cor",col="Disease", palette = "jco",size=3) + 
  geom_jitter(aes(colour = Disease),size=5)+
  stat_compare_means(comparisons = my_comparisons,size=10)+ # Add pairwise comparisons p-value
  ylab("Global imputation accuracy")


p<-p+My_Theme

p



