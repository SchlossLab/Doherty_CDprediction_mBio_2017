library(AUCRF)
library(pROC)
library(vegan)
#Read in all data
#metadata
mdshared<-read.table(file="Jan400.mdshared.wmg.txt", sep="\t", header=T) #wmg=with merged groups

#APV_3_2016 subsets metadata variable from March 2016 analysis Plan (AnalysisPlanVariables)
APV_3_2016<-subset(mdshared, select=c(group, Site, visit, TRTGR, TRTGRINDMAN:COUNTRY, BAMINO, BANTIBIO, BCORT, BIMM, DDUR, tissinvol, BL_FLACT:BL_CRP, BOWSTRICT, RESPONSEwk4:REMISSwk22, RSP_SRwk8, RSP_SRwk22, cdai_wk0))
#APmd<-read.table(file="Jan400.APmd.txt", sep="\t", header=T) #Analysis Plan 3_2016 metadata

#shared
#merge APmd and Jan400.an.0.03.subsampled.shared
ss3k_shared<-read.table(file="Jan400.an.0.03.subsample.shared", sep="\t", header=T)#Jan400 subsampled to 3K

APmd_shared<-merge(APmd, ss3k_shared, by.x="group", by.y="Group")#nonmatch removed
write.table(APmd_shared, file="Jan400.APmd_shared.ss3k.txt", sep="\t", row.names=F, quote=F)

all_data<-read.table(file="Jan400.APmd_shared.ss3k.txt", sep="\t", header=T)

#Predict Wk 4 reponse based on visit 1=screening
#ever_respond <- apply()
resp <- all_data[all_data$visit=='Screening', c('RESPONSEwk4', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
levels(resp$RESPONSEwk4) <- c(0,1)

resp_rf <- AUCRF(RESPONSEwk4~., data=resp, ranking='MDA', ntree=500, pdel=0.2)
resp_rf # prints list of optimal OTUs
plot(resp_rf) #AUC for each number of features
resp_probs <- predict(resp_rf$RFopt, type='prob')[,2]
resp_roc <- roc(resp$RESPONSEwk4~resp_probs)
plot(resp_roc)

#Predict Wk 8 reponse based on visit 1=screening
#ever_respond <- apply()
resp <- all_data[all_data$visit=='Screening', c('RESPONSEwk8', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
levels(resp$RESPONSEwk8) <- c(0,1)

resp_rf <- AUCRF(RESPONSEwk8~., data=resp, ranking='MDA', ntree=500, pdel=0.2)
resp_rf # prints list of optimal OTUs
plot(resp_rf) #AUC for each number of features
resp_probs <- predict(resp_rf$RFopt, type='prob')[,2]
resp_roc <- roc(resp$RESPONSEwk8~resp_probs)
plot(resp_roc)

#Predict Wk 22 reponse based on visit 1=screening
#ever_respond <- apply()
resp <- all_data[all_data$visit=='Screening', c('RESPONSEwk22', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
levels(resp$RESPONSEwk22) <- c(0,1)

resp_rf <- AUCRF(RESPONSEwk22~., data=resp, ranking='MDA', ntree=500, pdel=0.2)
resp_rf # prints list of optimal OTUs
plot(resp_rf) #AUC for each number of features
resp_probs <- predict(resp_rf$RFopt, type='prob')[,2]
resp_roc <- roc(resp$RESPONSEwk22~resp_probs)
plot(resp_roc)
# Compare Drug vs No Drug

#Predict REMISSwk4 reponse based on visit 1=screening
resp <- all_data[all_data$visit=='Screening', c('REMISSwk4', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
levels(resp$REMISSwk4) <- c(0,1)

resp_rf <- AUCRF(REMISSwk4~., data=resp, ranking='MDA', ntree=500, pdel=0.2)
resp_rf # prints list of optimal OTUs
plot(resp_rf) #AUC for each number of features
resp_probs <- predict(resp_rf$RFopt, type='prob')[,2]
resp_roc <- roc(resp$REMISSwk4~resp_probs)
plot(resp_roc)

#Predict REMISSwk8 reponse based on visit 1=screening

#Predict REMISSwk22 reponse based on visit 1=screening
resp <- all_data[all_data$visit=='Screening', c('REMISSwk22', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
levels(resp$REMISSwk22) <- c(0,1)

resp_rf <- AUCRF(REMISSwk22~., data=resp, ranking='MDA', ntree=500, pdel=0.2)
resp_rf # prints list of optimal OTUs
plot(resp_rf) #AUC for each number of features
resp_probs <- predict(resp_rf$RFopt, type='prob')[,2]
resp_roc <- roc(resp$REMISSwk22~resp_probs)
plot(resp_roc)

#Predict RSP_SRwk8 reponse based on visit 1=screening
resp <- all_data[all_data$visit=='Screening', c('RSP_SRwk8', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
levels(resp$RSP_SRwk8) <- c(0,1)

resp_rf <- AUCRF(RSP_SRwk8~., data=resp, ranking='MDA', ntree=500, pdel=0.2)
resp_rf # prints list of optimal OTUs
plot(resp_rf) #AUC for each number of features
resp_probs <- predict(resp_rf$RFopt, type='prob')[,2]
resp_roc <- roc(resp$RSP_SRwk8~resp_probs)
plot(resp_roc)

#Predict RSP_SRwk22 reponse based on visit 1=screening
resp <- all_data[all_data$visit=='Screening', c('RSP_SRwk22', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
resp <- na.omit(resp)
levels(resp$RSP_SRwk22) <- c(0,1)

resp_rf <- AUCRF(RSP_SRwk22~., data=resp, ranking='MDA', ntree=500, pdel=0.2)
resp_rf # prints list of optimal OTUs
plot(resp_rf) #AUC for each number of features
resp_probs <- predict(resp_rf$RFopt, type='prob')[,2]
resp_roc <- roc(resp$RSP_SRwk22~resp_probs)
plot(resp_roc)



# RF regression on CDAI
cdai <- all_data[, c('cdai_wk0', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
cdai_reg <- randomForest(cdai_wk0~., data=cdai, ntree=1000)
plot(cdai$cdai_wk0, cdai_reg$predicted) #compare actual and predicted CDAI
cor.test(cdai$cdai_wk0, cdai_reg$predicted, method='spearman')
varImpPlot(cdai_reg) #plot most important OTUs

#RF regression on Calprotectin
fcalp <- all_data[, c('BL_FCALP', colnames(all_data)[grep('Otu[0123456789]', colnames(all_data))])]
fcalp_reg <- randomForest(BL_FCALP~., data=fcalp, ntree=1000)
plot(log(fcalp$BL_FCALP), log(fcalp_reg$predicted)) #compare actual and predicted FCALP
cor.test(fcalp$BL_FCALP, fcalp_reg$predicted, method='spearman')
varImpPlot(fcalp_reg, type=2) #plot most important OTUs

plot(log(fcalp$Otu00303+0.1), log(fcalp$BL_FCALP+0.1))
