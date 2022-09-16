library(phenix)
library(ggplot2)

load("/Users/dpag0499/Documents/PROJECTS/PPMI/src/run_phenix/ODPC.Rdata")

Phen<-read.table('/Users/dpag0499/Documents/PROJECTS/PPMI/data/phenix_input/Caseonly_gemma2_pheno.txt',header=TRUE,sep='\t',row.names = 1)
Kinship<-read.table('/Users/dpag0499/Documents/PROJECTS/PPMI/data/phenix_input/Caseonly_gemma2_kinship.txt',header=TRUE,sep='\t',row.names = 1)
Y_temp<-as.matrix(Phen[,5:44])
K_temp<-as.matrix(Kinship)te<-apply(ou$imp,2,function(x) normalize(x))
out <- phenix(Y_temp,K_temp,test=TRUE)



Y_temp_norm2<-apply(out$imp,2,function(x) normalize(x))

Y_temp_norm1<-apply(out$imp,2,function(x) normalize(x,method="range"))

out_scale1 <- phenix(Y_temp_norm1,K_temp,test=TRUE)

out_scale2 <- phenix(Y_temp_norm2,K_temp,test=TRUE)

all_pves <- matrix( NA, M, P ) 
for( m in 1:M ) {
  for( p in 1:P) {
    var_exp <- var(out$S[,m]*out$beta[m,p])
    var_tot<-var(out$imp[,p])
    all_pves[m,p]  <- var_exp / var_tot
  }
}
pves <- rowSums( all_pves )
pves_norm<-pves/sum(pves)


te<-apply(out$imp,2,function(x) normalize(x,method="range"))

out_scale <- phenix(te,K_temp,test=TRUE)


sd_beta<-apply(out_scale1$beta, 1, sd)
var_expl<-cumsum((sd_beta)^2) / sum(sd_beta^2) 







barplot(var_expl[1:length(sd_beta)],names.arg=paste0("V",c(1:length(sd_beta))))