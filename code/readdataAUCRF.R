source('../code/APmd.setup.R')

APmd_adiv<-merge(APmd, adiv, by.x="group", by.y="group")#nonmatch removed
APmd_shared<-merge(APmd_adiv, ss3k_shared_U2s, by.x="group", by.y="Group")

APmd_shared$TRTGR_REMISSwk6 <- as.factor(paste(APmd_shared$TRTGR, APmd_shared$REMISSwk6))
APmd_shared$TRTGR_REMISSwk22 <- as.factor(paste(APmd_shared$TRTGR, APmd_shared$REMISSwk22))

APmd_shared$TRTGR_RESPONSEwk6 <- as.factor(paste(APmd_shared$TRTGR, APmd_shared$RESPONSEwk6))
APmd_shared$TRTGR_RESPONSEwk22 <- as.factor(paste(APmd_shared$TRTGR, APmd_shared$RESPONSEwk22))
APmd_RSPwk22<-APmd_shared

screen_RESPwk22<-APmd_RSPwk22[APmd_RSPwk22$visit=="Screening",] #removes any group with NA in RESPONSEwk22

screen_data<-screen_RESPwk22			

screen.trtd<-screen_data[screen_data$TRTGRINDMAN!="Placebo_Placebo",]
screen.trtd<-screen.trtd[screen.trtd$TRTGRINDMAN!="Placebo_Treated",]
summary(screen.trtd[,1:6])
screen.plac<-screen_data[screen_data$TRTGRINDMAN!="Treated_Placebo",]
screen.plac<-screen.plac[screen.plac$TRTGRINDMAN!="Treated_Treated",]
summary(screen.plac[,1:6])

nao.screen_data<-na.omit(screen_data)

nao.screen.trtd<-nao.screen_data[nao.screen_data$TRTGRINDMAN!="Placebo_Placebo",]
nao.screen.trtd<-nao.screen.trtd[nao.screen.trtd$TRTGRINDMAN!="Placebo_Treated",]
summary(nao.screen.trtd[,1:6])
nao.screen.plac<-nao.screen_data[nao.screen_data$TRTGRINDMAN!="Treated_Placebo",]
nao.screen.plac<-nao.screen.plac[nao.screen.plac$TRTGRINDMAN!="Treated_Treated",]
summary(nao.screen.plac[,1:6])

tax<- read.table('../data/Jan400.simple.taxonomy.txt', header=T, sep="\t")
