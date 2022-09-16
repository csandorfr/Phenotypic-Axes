# Load data and library
rm(list = ls())
load("data_Tracking3.Rdata")
load("Tracking_Phen.Rdata")
library("phenix")

# Parameters
nb_sim<-100

# Phenotypic matrix longitudinal
Y_long<-Phen_long_red
n_phen_long<-dim(Y_long)[2]

# Trim baseline phenotypic/K matrix
ID1<-row.names(Y_temp_red)
ID2<-row.names(Y_long)
index<-which(ID1 %in% ID2)
Y_new<-Y_temp_red[index,]
K_new<-K_temp_red[index,index]


# Index 
run_phenix_imputation<-function(index_phen,nb_sim,Y_new,K_new,Y_long) {
  Y_new2<-cbind(Y_new,Y_long[,index_phen])
  col_test<-dim(Y_new2)[2]
  cor_test<-c()
  for (sim in c(1:nb_sim)) {
    print(sim)
    out_base_long <- phenix(Y_new2,K_new,test=TRUE,test.cols=c(col_test),seed=sim)
    cor_test<-c(cor_test,out_base_long$test$cor_glob)
  }
  return (cor_test)
}

# test all phenotype
list_cor<-sapply(c(1:n_phen_long),run_phenix_imputation,nb_sim=nb_sim,Y_new=Y_new,K_new=K_new,Y_long=Y_long)



