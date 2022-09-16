require(dplyr)
library(reshape2)

# correlation proband

setwd("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/src/new_Figures/Revisions/fig1/correlation_axis")

# read clinical measure
f_phen_proband<-"/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/data/Proband_Leon/TrackingPD_dataset_2016_October.csv"
phen_proband<-read.table(f_phen_proband,h=T,sep=",")

# read axis
list_axis<-c("S1","S2","S3","S4","S6")
phen_f<-data.frame()
for (a in list_axis) {
 file<-paste("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/data/Proband_Leon/Phenix.Comps/Phenix.",a,".pheno",sep="")

  phen_axis1<-read.table(file,sep=" ",h=T)
  phen_axis1_s<-melt(phen_axis1[,-c(1)],id=c("IID"))
  phen_f<-rbind(phen_f,phen_axis1_s)
}

# ide map
id_map<-read.table("/Users/dpag0499/Dropbox (UK Dementia Research Institute)/Sandor Lab/Backup/PROJECTS/PPMI/data/Proband_Leon/Proband.Geno_Pheno_id.include.no.relative.map",h=F)
colnames(id_map)[5]<-"IID"
colnames(id_map)[1]<-"ID"

##write.table(colnames(phen_proband),file="phen_proband.txt",quote=FALSE,row.names=TRUE,col.names=FALSE,sep="\t")

#  category phenotype
phen_name_cat<-read.table("phenotye_cat_name_proband.csv",sep=",",h=T)

phen_proband_s<-melt(phen_proband,id=c("ID"))
colnames(phen_proband_s)[2]<-"Name1"
phen_proband_s_info<-merge(phen_proband_s,phen_name_cat,by=c("Name1"))

list_phen<-as.character(unique(phen_proband_s_info$Name1))

phen_axis<-merge(phen_f,id_map,by=c("IID"))
phen_proband_s_info_axis<-merge(phen_proband_s_info,phen_axis,by=c("ID"))
gp = group_by(phen_proband_s_info_axis, Name1,variable)
df<-as.data.frame(summarize(gp, cor(as.numeric(value.x), as.numeric(value.y),use="complete.obs")))
colnames(df)<-c("Name1","Axis","Cor")
save(df,phen_name_cat,file="corr_discovery.Rdata")

