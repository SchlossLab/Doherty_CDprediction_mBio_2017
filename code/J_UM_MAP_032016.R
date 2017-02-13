library(AUCRF)
library(pROC)
#Read in all data
#metadata
mdshared<-read.table(file="Jan400.mdshared.wmg.txt", sep="\t", header=T) #wmg=with merged groups

#APV_3_2016 subsets metadata variable from March 2016 analysis Plan (AnalysisPlanVariables)
APV_3_2016<-subset(mdshared, select=c(group, Site, visit, TRTGR, TRTGRINDMAN:COUNTRY, BAMINO, BANTIBIO, BCORT, BIMM, BL_BMI:tissinvol, BRSP_TNF, BL_FLACT:BL_FLACTLEV, BOWSTRICT, RESPONSEwk4:REMISSwk22, RSP_Rwk8n22:RSP_SRwk8N22, cdai_wk0))
wk4":"REMISSwk22", "RSP_SRwk8", "RSP_SRwk22", "cdai_wk0", "shared_count"))
APmd<-read.table(file="Jan400.APmd.txt", sep="\t", header=T) #Analysis Plan 3_2016 metadata

#shared
#merge APmd and Jan400.an.0.03.subsampled.shared
ss3k_shared<-read.table(file="Jan400.an.0.03.subsample.shared", sep="\t", header=T)#Jan400 subsampled to 3K

APmd_shared<-merge(APmd, ss3k_shared, by.x="group", by.y="Group")#nonmatch removed
#write.table(APmd_shared, file="Jan400.APmd_shared.ss3k.txt", sep="\t", row.names=F, quote=F)

all_data<-read.table(file="Jan400.APmd_shared.ss3k.txt", sep="\t", header=T)

#Predict Wk 22 reponse based on visit 1
#ever_respond <- apply()
resp <- all_data[all_data$visit=='Screening', c('RESPONSEwk22', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
resp <- na.omit(resp)
levels(resp$RESPONSEwk22) <- c(0,1)

resp_rf <- AUCRF(RESPONSEwk22~., data=resp, ranking='MDA', ntree=500, pdel=0.2)
resp_rf # prints list of optimal OTUs
resp_r
plot(resp_rf) #AUC for each number of features
resp_probs <- predict(resp_rf$RFopt, type='prob')[,2]
resp_roc <- roc(resp$RESPONSEwk22~resp_probs)



# Compare Drug vs No Drug





# RF regression on CDAI
cdai <- all_data[, c('cdai_wk0', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
cdai <- na.omit(cdai)
cdai_reg <- randomForest(CDAI~., data=cdai, ntree=1000)
plot(cdai$CDAI, cdai_reg$predicted) #compare actual and predicted CDAI
cor.test(cdai$CDAI, cdai_reg$predicted, method='spearman')
varImpPlot(cdai_reg) #plot most important OTUs

#RF regression on Calprotectin
fcalp <- all_data[, c('BL_FCALP', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
fcalp <- na.omit(fcalp)
fcalp_reg <- randomForest(FCALP~., data=fcalp, ntree=1000)
plot(log(fcalp$FCALP), log(fcalp_reg$predicted)) #compare actual and predicted FCALP
cor.test(fcalp$FCALP, fcalp_reg$predicted, method='spearman')
varImpPlot(fcalp_reg, type=2) #plot most important OTUs

plot(log(fcalp$Otu00303+0.1), log(fcalp$FCALP+0.1))
