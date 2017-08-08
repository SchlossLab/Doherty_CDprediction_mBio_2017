md<-read.table(file="../data/Jan400.mdshared.wmg.txt", sep="\t", header=T) #wmg=with merged groups
APmd.wk6<-subset(md, select=c(group, USUBJID, Site, visit, TRTGR, TRTGRINDMAN:COUNTRY, BAMINO, BANTIBIO, BCORT, BIMM, BL_BMI:tissinvol, BRSP_TNF, BL_FLACT:BL_FLACTLEV, BOWSTRICT, RESPONSEwk4:REMISSwk22, RSP_Rwk8n22:RSP_SRwk8N22, REMISSwk6, RESPONSEwk6, cdail_wk0, cdail_wk4, cdail_wk6, cdail_wk8, cdail_wk22, CDSTOOLM_Week.6, CDPAINM_Week.6, CDWELBEM_Week.6, CDARTRTM_Week.6, CDARALGM_Week.6, CDIRITM_Week.6, CDUVEITM_Week.6, CDERYTHM_Week.6, CDPYODEM_Week.6, CDSTOMAM_Week.6, CDFISURM_Week.6, CDFISTUM_Week.6, CDABSCEM_Week.6, CDOTFISM_Week.6, CDFEVERM_Week.6, CDDRGM_Week.6, CDAMASSM_Week.6, CDHCTM_Week.6, CDWEIGHM_Week.6))

levels(APmd.wk6$TRTGR)<-c("Placebo", "Treated")
levels(APmd.wk6$TRTGRINDMAN)<-c("Placebo_Not", "Placebo_Placebo", "Placebo_Treated", "Treated_Not", "Treated_Placebo", "Treated_Treated")

APmd.wk6$TRTGR_REMISSwk6 <- as.factor(paste(APmd.wk6$TRTGR, APmd.wk6$REMISSwk6))
APmd.wk6$TRTGR_REMISSwk22 <- as.factor(paste(APmd.wk6$TRTGR, APmd.wk6$REMISSwk22))

APmd.wk6$TRTGR_RelRSPwk6 <- as.factor(paste(APmd.wk6$TRTGR, APmd.wk6$RelRSPwk6))
APmd.wk6$TRTGR_RelRSPwk22 <- as.factor(paste(APmd.wk6$TRTGR, APmd.wk6$RelRSPwk22))

APmd.wk6$CDSTOOLM_Week.6[APmd.wk6$CDSTOOLM_Week.6=="."]<-"NA"
APmd.wk6$CDSTOOLM_Week.6 <-as.integer(APmd.wk6$CDSTOOLM_Week.6)
APmd.wk6$CDHCTM_Week.6[APmd.wk6$CDHCTM_Week.6=="."]<-"NA"
APmd.wk6$CDHCTM_Week.6 <-as.integer(APmd.wk6$CDHCTM_Week.6)
summary(subset(APmd.wk6, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))

deltaCDAIwk0_22<-APmd.wk6$cdail_wk22-APmd.wk6$cdail_wk0
deltaCDAIwk0_8<-APmd.wk6$cdail_wk8-APmd.wk6$cdail_wk0
deltaCDAIwk0_4<-APmd.wk6$cdail_wk4-APmd.wk6$cdail_wk0
deltaCDAIwk0_6<-APmd.wk6$cdail_wk6-APmd.wk6$cdail_wk0
percentdelta0_4<-deltaCDAIwk0_4/APmd.wk6$cdail_wk0*100
percentdelta0_6<-deltaCDAIwk0_6/APmd.wk6$cdail_wk0*100
percentdelta0_8<-deltaCDAIwk0_8/APmd.wk6$cdail_wk0*100
percentdelta0_22<-deltaCDAIwk0_22/APmd.wk6$cdail_wk0*100
deltaCDAIwk8_22<-APmd.wk6$cdail_wk22-APmd.wk6$cdail_wk8
percentdelta8_22<-deltaCDAIwk8_22/APmd.wk6$cdail_wk8*100
APmd.wk6$percentdelta0_4<-percentdelta0_4
APmd.wk6$percentdelta0_6<-percentdelta0_6
APmd.wk6$percentdelta0_8<-percentdelta0_8
APmd.wk6$percentdelta0_22<-percentdelta0_22
APmd.wk6$percentdelta8_22<-percentdelta8_22
APmd.wk6$RelRSPwk4<-as.factor(ifelse(APmd.wk6$percentdelta0_4>=-29.5, print("No"), print("Yes")))
APmd.wk6$RelRSPwk6<-as.factor(ifelse(APmd.wk6$percentdelta0_6>=-29.5, print("No"), print("Yes")))
APmd.wk6$RelRSPwk8<-as.factor(ifelse(APmd.wk6$percentdelta0_8>=-29.5, print("No"), print("Yes")))
APmd.wk6$RelRSPwk22<-as.factor(ifelse(APmd.wk6$percentdelta0_22>=-29.5, print("No"), print("Yes")))
APmd.wk6$RelRSPwk8_22<-as.factor(ifelse(APmd.wk6$percentdelta8_22>=-29.5, print("No"), print("Yes")))
APmd.wk6$visit<-factor(APmd.wk6$visit, levels = c("Screening", "Week 4", "Week 6", "Week 22"))
adiv<-read.table(file="../data/Jan400.all.na.omit.cmd.groups.summary", sep="\t", header=T)
ss3k_shared<-read.table(file="../data/Jan400.all.na.omit.cmd.0.03.subsample.shared", sep="\t", header=T)#Jan400 subsampled to 3K visit=Week.6
APmd.wk6_adiv<-merge(APmd.wk6, adiv, by.x="group", by.y="group")#nonmatch removed
APmd.wk6_shared<-merge(APmd.wk6_adiv, ss3k_shared_U2s, by.x="group", by.y="Group")
summary(APmd.wk6_shared[,1:20])
APmd.wk6_shared<-APmd.wk6_shared[APmd.wk6_shared$USUBJID!='C0743T26030100002',]
APmd.wk6_shared<-APmd.wk6_shared[APmd.wk6_shared$group!='E4859941-5',]
levs<-APmd.wk6_shared %>% group_by(USUBJID) %>% summarise(no_rows = length(USUBJID))
levs

APmd.wk6_shared<-APmd.wk6_shared[APmd.wk6_shared$TRTGRINDMAN!="Placebo_Not",]
APmd.wk6_shared<-APmd.wk6_shared[APmd.wk6_shared$TRTGRINDMAN!="Treated_Not",]

allwk6_data<-APmd.wk6_shared[APmd.wk6_shared$visit=="Week 6",]
summary(allwk6_data[,1:20])

trtd.wk6_data<-allwk6_data[allwk6_data$TRTGR=="Treated",]
summary(trtd.wk6_data[,1:20])
nrow(trtd.wk6_data[trtd.wk6_data$visit=="Week 6",])
plac.wk6_data<-allwk6_data[allwk6_data$TRTGR!="Treated",]
summary(plac.wk6_data[,1:20])

wk0_6_data<-APmd.wk6_shared[APmd.wk6_shared$visit!="Week 4",]
wk0_6_data<-wk0_6_data[wk0_6_data$visit!="Week 22",]

summary(subset(wk0_6_data, select = c(group, USUBJID, visit, nseqs, coverage, sobs, invsimpson)))

levs<-wk0_6_data %>% group_by(USUBJID) %>% summarise(no_rows = length(USUBJID))
summary(levs)
subidsover2<-levs[levs$no_rows>=2,]
summary(subidsover2)
subidsover2
zero6subs<-as.character(subidsover2$USUBJID)
zero6subs_data <- wk0_6_data[wk0_6_data$USUBJID %in% zero6subs,]


zero6subs_data<-zero6subs_data[zero6subs_data$TRTGRINDMAN!="Placebo_Not",]
zero6subs_data<-zero6subs_data[zero6subs_data$TRTGRINDMAN!="Treated_Not",]
summary(subset(zero6subs_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))

trtd.zero6subs_data<-zero6subs_data[zero6subs_data$TRTGRINDMAN!="Placebo_Placebo",]
trtd.zero6subs_data<-trtd.zero6subs_data[trtd.zero6subs_data$TRTGRINDMAN!="Placebo_Treated",]
plac.zero6subs_data<-zero6subs_data[zero6subs_data$TRTGRINDMAN!="Treated_Treated",]
plac.zero6subs_data<-plac.zero6subs_data[plac.zero6subs_data$TRTGRINDMAN!="Treated_Placebo",]
summary(subset(trtd.zero6subs_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))
summary(subset(plac.zero6subs_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))

week6.N.all <- nrow(zero6subs_data[zero6subs_data$visit=='Week 6',])
week6.trtd <- trtd.zero6subs_data[trtd.zero6subs_data$visit=='Week 6',]
week6.N.trtd <- nrow(trtd.zero6subs_data[trtd.zero6subs_data$visit=='Week 6',])
week6.N.trtd.respY <- nrow(week6.trtd[week6.trtd$RelRSPwk6=='Yes',])
week6.N.trtd.respN <- nrow(week6.trtd[week6.trtd$RelRSPwk6=='No',])
week6.plac <- plac.zero6subs_data[plac.zero6subs_data$visit=='Week 6',]
week6.N.plac <- nrow(plac.zero6subs_data[plac.zero6subs_data$visit=='Week 6',])
week6.N.plac.respY <- nrow(week6.plac[week6.plac$RelRSPwk6=='Yes',])
week6.N.plac.respN <- nrow(week6.plac[week6.plac$RelRSPwk6=='No',])
week6.N.trtd.REMY <- nrow(week6.trtd[week6.trtd$REMISSwk6=='Yes',])
week6.N.trtd.REMN <- nrow(week6.trtd[week6.trtd$REMISSwk6=='No',])
week6.N.plac.REMY <- nrow(week6.plac[week6.plac$REMISSwk6=='Yes',])
week6.N.plac.REMN <- nrow(week6.plac[week6.plac$REMISSwk6=='No',])

all.RelRSPwk6<-matrix(c('Week 6 Response (No, Yes)', trtd.RelRSPwk6_sum, plac.RelRSPwk6_sum, all.RelRSPwk6.kw.test.pval, all.RelRSPwk6_AMOVA), ncol = 5)

week6.N.resp.trtd_sum<-toString(c(week6.N.trtd.respN, week6.N.trtd.respY))
week6.N.resp.plac_sum<-toString(c(week6.N.plac.respN, week6.N.plac.respY))

week6.N.REM.trtd_sum<-toString(c(week6.N.trtd.REMN, week6.N.trtd.REMY))
week6.N.REM.plac_sum<-toString(c(week6.N.plac.REMN, week6.N.plac.REMY))

wk6.RelRSPwk6 <- matrix(c("Week 6", "Response Week 6 (No, Yes)", week6.N.resp.trtd_sum, week6.N.resp.plac_sum, week6.N.all), ncol=5)
colnames(wk6.RelRSPwk6) <- c("Stool Week", 'Status Week', 'Treated (n)', "Placebo (n)", "Total (n)")
wk6.REMISSwk6 <- matrix(c("Week 6", "Remission Week 6 (No, Yes)", week6.N.REM.trtd_sum, week6.N.REM.plac_sum, week6.N.all), ncol=5)
colnames(wk6.REMISSwk6) <- c("Stool Week", 'Status Week', 'Treated (n)', "Placebo (n)", "Total (n)")

wk6_wk6 <- rbind(wk6.RelRSPwk6, wk6.REMISSwk6)
wk6_wk6 <- wk6_wk6[,-5]