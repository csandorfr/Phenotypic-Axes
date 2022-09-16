library(phenix)
setwd("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/src/new_Figures/Revisions/FigS10")


load(out_without_genetics,file="/Users/dpag0499/Documents/PROJECTS/PPMI/src/comparison_ppmi_odpc_phenix/OPDC_Without_Genetics.Rdata")


Phen<-read.table('/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/data/phenix_input/Caseonly_gemma2_pheno.txt',header=TRUE,sep='\t',row.names = 1)
Kinship<-read.table('/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/data/phenix_input/Caseonly_gemma2_kinship.txt',header=TRUE,sep='\t',row.names = 1)
Y_temp<-as.matrix(Phen[,5:44])
K_temp<-as.matrix(Kinship)
K_temp2<-diag(842)
col_test<-dim(Y_temp)[2]
out_without_genetics <- phenix(Y_temp,K_temp2,test=TRUE)
out_with_genetics <- phenix(Y_temp,K_temp,test=TRUE)


df<-data.frame(Phen=colnames(Y_temp),Cor1=out_with_genetics$test$cors,Cor2=out_without_genetics$test$cors)
df$diff=df$Cor1-df$Cor2

df$diff2<-df$diff+runif(40, 0, 0.1)
info_phen<-read.table('/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/src/new_Figures/Revisions/FigS10/discovery_phen.txt',h=T,sep='\t')
colnames(df)[1]<-"Name1"
df_name<-merge(df,info_phen,by=c("Name1"))
df_name$Name2 <- factor(df_name$Name2, levels=unique(df_name$Name2 [order(df_name$Category)]))

p<-ggplot(df_name, aes(x = Name2, y =diff2,fill=Category)) + 
  geom_bar(position=position_dodge(), stat = "identity",colour="black") + 
  coord_flip()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  scale_y_continuous(limits=c(-0.1,0.1))+
  theme(axis.text=element_text(size=10))+
  theme(strip.text.x = element_text(size = 10))+
  theme(legend.key.size = unit(1, "cm"),legend.text=element_text(size=10),legend.title=element_text(size=10))
