#Read in all data
#metadata
md<-read.table(file="../data/Jan400.mdshared.wmg.txt", sep="\t", header=T) #wmg=with merged groups

#APmd subsets metadata variable from March 2016 analysis Plan (AnalysisPlanVariables)

APmd<-subset(md, select=c(group, USUBJID, Site, visit, TRTGR, TRTGRINDMAN:COUNTRY, BAMINO, BANTIBIO, BCORT, BIMM, BL_BMI:tissinvol, BRSP_TNF, BL_FLACT:BL_FLACTLEV, BOWSTRICT, RESPONSEwk4:REMISSwk22, RSP_Rwk8n22:RSP_SRwk8N22, REMISSwk6, RESPONSEwk6, cdail_wk0, cdail_wk4, cdail_wk6, cdail_wk8, cdail_wk22, CDSTOOLM_Screening, CDPAINM_Screening, CDWELBEM_Screening, CDARTRTM_Screening, CDARALGM_Screening, CDIRITM_Screening, CDUVEITM_Screening, CDERYTHM_Screening, CDPYODEM_Screening, CDSTOMAM_Screening, CDFISURM_Screening, CDFISTUM_Screening, CDABSCEM_Screening, CDOTFISM_Screening, CDFEVERM_Screening, CDDRGM_Screening, CDAMASSM_Screening, CDHCTM_Screening, CDWEIGHM_Screening))

levels(APmd$TRTGR)<-c("Placebo", "Treated")
levels(APmd$TRTGRINDMAN)<-c("Placebo_Not", "Placebo_Placebo", "Placebo_Treated", "Treated_Not", "Treated_Placebo", "Treated_Treated")
levels(APmd$visit) <- c("Screening", "Week 4", "Week 6", "Week 22")


delta<- function(finalcdai, initialcdai=APmd$cdail_wk0){
	deltacdai <- finalcdai-initialcdai
	return(deltacdai)
}

percentdelta <- function(finalcdai, initialcdai=APmd$cdail_wk0){
	pdeltcdai <- (finalcdai-initialcdai)/initialcdai*100
	return(pdeltcdai)
}

deltaCDAIwk8_22<-delta(APmd$cdail_wk22, APmd$cdail_wk8)
percentdelta8_22<-percentdelta(APmd$cdail_wk22, APmd$cdail_wk8)

APmd$deltaCDAIwk0_22<-delta(APmd$cdail_wk22)
APmd$deltaCDAIwk0_8<-delta(APmd$cdail_wk8)
APmd$deltaCDAIwk0_6<-delta(APmd$cdail_wk6)
APmd$deltaCDAIwk0_4<-delta(APmd$cdail_wk4)

APmd$deltaCDAIwk8_22<-deltaCDAIwk8_22

APmd$percentdelta0_4<-percentdelta(APmd$cdail_wk4)
APmd$percentdelta0_6<-percentdelta(APmd$cdail_wk6)
APmd$percentdelta0_8<-percentdelta(APmd$cdail_wk8)
APmd$percentdelta0_22<-percentdelta(APmd$cdail_wk22)

APmd$percentdelta8_22<-percentdelta8_22

RelRSP <- function(percentdelta){
	as.factor(ifelse(percentdelta>=-29.5, "No", "Yes"))
}

RelSR <- function(percentdelta){
	as.factor(ifelse(percentdelta>=-49.5, "No", "Yes"))
}

APmd$RelRSPwk4<-RelRSP(APmd$percentdelta0_4)
APmd$RelRSPwk6<-RelRSP(APmd$percentdelta0_6)
APmd$RelRSPwk8<-RelRSP(APmd$percentdelta0_8)
APmd$RelRSPwk22<-RelRSP(APmd$percentdelta0_22)
APmd$RelRSPwk8_22<-RelRSP(APmd$percentdelta8_22)
APmd$RelSRwk4<-RelSR(APmd$percentdelta0_4)
APmd$RelSRwk6<-RelSR(APmd$percentdelta0_6)
APmd$RelSRwk8<-RelSR(APmd$percentdelta0_8)
APmd$RelSRwk22<-RelSR(APmd$percentdelta0_22)
APmd$RelSRwk8_22<-RelSR(APmd$percentdelta8_22)

APmd$CDSTOOLM_Screening[APmd$CDSTOOLM_Screening=="."]<-"NA"
APmd$CDSTOOLM_Screening <-as.integer(APmd$CDSTOOLM_Screening)
APmd$CDPAINM_Screening[APmd$CDPAINM_Screening=="."]<-"NA"
APmd$CDPAINM_Screening <-as.integer(APmd$CDPAINM_Screening)
APmd$CDWELBEM_Screening[APmd$CDWELBEM_Screening=="."]<-"NA"
APmd$CDWELBEM_Screening <-as.integer(APmd$CDWELBEM_Screening)
APmd$CDHCTM_Screening[APmd$CDHCTM_Screening=="."]<-"NA"
APmd$CDHCTM_Screening <-as.integer(APmd$CDHCTM_Screening)
APmd$CDAMASSM_Screening<-as.factor(APmd$CDAMASSM_Screening)

APmd<-APmd[APmd$USUBJID!='C0743T26030100002',]
APmd<-APmd[APmd$group!='E4859941-5',]
APmd<-APmd[APmd$TRTGRINDMAN!="Placebo_Not",]
APmd<-APmd[APmd$TRTGRINDMAN!="Treated_Not",]



#shared
#merge APmd and Jan400.an.0.03.subsampled.shared
#adiv<-read.table(file='../data/Jan400.screen.all.groups.summary', sep="\t", header=T)
#ss3k_shared<-read.table(file="../data/Jan400.screen.all.subsample.shared", sep="\t", header=T)#Jan400 subsampled to 3K visit=Screening
adiv<-read.table(file="../data/Jan400.all.na.omit.cmd.groups.summary", sep="\t", header=T)
ss3k_shared<-read.table(file="../data/Jan400.all.na.omit.cmd.0.03.subsample.shared", sep="\t", header=T)#Jan400 subsampled to 3K visit=Screening
APmd_adiv<-merge(APmd, adiv, by.x="group", by.y="group")#nonmatch removed
APmd_shared<-merge(APmd_adiv, ss3k_shared, by.x="group", by.y="Group")

APmd_shared$TRTGR_REMISSwk6 <- as.factor(paste(APmd_shared$TRTGR, APmd_shared$REMISSwk6))
APmd_shared$TRTGR_REMISSwk22 <- as.factor(paste(APmd_shared$TRTGR, APmd_shared$REMISSwk22))

APmd_shared$TRTGR_RelRSPwk6 <- as.factor(paste(APmd_shared$TRTGR, APmd_shared$RelRSPwk6))
APmd_shared$TRTGR_RelRSPwk22 <- as.factor(paste(APmd_shared$TRTGR, APmd_shared$RelRSPwk22))
APmd_RSPwk22<-APmd_shared