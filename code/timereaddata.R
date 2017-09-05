source('../code/APmd.setup.R')

screen_RESPwk22<-APmd_RSPwk22 #[APmd_RSPwk22$visit=="Screening",] #removes any group with NA in RESPONSEwk22

screen_data<-screen_RESPwk22				#na.omit(screen_RESPwk22)

#screen_data$CDSTOOLM_Screening[screen_data$CDSTOOLM_Screening=="."]<-"NA"
#screen_data$CDSTOOLM_Screening <-as.integer(screen_data$CDSTOOLM_Screening)
#screen_data$CDPAINM_Screening[screen_data$CDPAINM_Screening=="."]<-"NA"
#screen_data$CDPAINM_Screening <-as.integer(screen_data$CDPAINM_Screening)
#screen_data$CDWELBEM_Screening[screen_data$CDWELBEM_Screening=="."]<-"NA"
#screen_data$CDWELBEM_Screening <-as.integer(screen_data$CDWELBEM_Screening)
#screen_data$CDHCTM_Screening[screen_data$CDHCTM_Screening=="."]<-"NA"
#screen_data$CDHCTM_Screening <-as.integer(screen_data$CDHCTM_Screening)
#screen_data$CDAMASSM_Screening<-as.factor(screen_data$CDAMASSM_Screening)

#axes <- read.table('data/Jan400.screen_ust.3107.subsample.thetayc.0.03.lt.ave.nmds.by3.axes', header=T)
tax<- read.table('../data/Jan400.simple.taxonomy.txt', header=T, sep="\t")
#summary(APmd_RSPwk22[,c("TRTGR", "visit")])
#summary(screen_RESPwk22[,1:49])
summary(subset(screen_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))

levs<-screen_data %>% group_by(USUBJID) %>% summarise(no_rows = length(USUBJID))
levs
subidsover4<-levs[levs$no_rows>=4,]
summary(subidsover4)
fourtimesubs<-as.character(subidsover4$USUBJID)

fourtime_data <- screen_data[screen_data$USUBJID %in% fourtimesubs,]
#summary(subset(fourtime_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))

#x5tp<-fourtime_data[fourtime_data$USUBJID=="C0743T26045400006",]
#subset(x5tp, select = c(group, USUBJID, visit, nseqs, coverage, sobs, invsimpson))

#Remove "duplicate" sample with worse coverage and nseqs
alltime_data<-fourtime_data
alltime_data<-alltime_data[alltime_data$TRTGRINDMAN!="Placebo_Treated", ]
alltime_data<-alltime_data[alltime_data$TRTGRINDMAN!="Treated_Placebo", ] #remove TRTGRINDMAN=Placebo_Treated for easier analysisof all time point data placebo vs treated

summary(subset(alltime_data, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, RESPONSEwk8)))
alltp.ust<-alltime_data[alltime_data$TRTGRINDMAN=="Treated_Treated",]
#alltp.ust<-alltp.ust[alltp.ust$TRTGRINDMAN!="Placebo_Treated",]
summary(alltp.ust[,1:6])
alltp.placplac<-alltime_data[alltime_data$TRTGRINDMAN=="Placebo_Placebo",]
#alltp.placplac<-alltp.plac[alltp.plac$TRTGRINDMAN="Treated_Treated",]
summary(alltp.placplac[,1:6])

alltp.ust.RESPyes<-alltp.ust[alltp.ust$RESPONSEwk22=="Yes",]
summary(alltp.ust.RESPyes[,1:6])
alltp.ust.RESPno<-alltp.ust[alltp.ust$RESPONSEwk22=="No",]
summary(alltp.ust.RESPno[,1:6])

alltp.placplac.RESPyes<-alltp.placplac[alltp.placplac$RESPONSEwk22=="Yes",]
summary(alltp.placplac.RESPyes[,1:6])
alltp.placplac.RESPno<-alltp.placplac[alltp.placplac$RESPONSEwk22=="No",]
summary(alltp.placplac.RESPno[,1:6])

alltp.all.respY<-alltime_data[alltime_data$RESPONSEwk22=="Yes",]
alltp.all.respN<-alltime_data[alltime_data$RESPONSEwk22=="No",]
summary(alltp.all.respY[,1:6])



wk22remitters<-alltime_data[alltime_data$REMISSwk22=="Yes",]
summary(subset(wk22remitters, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, REMISSwk22)))

trtd.wk22remitters<-wk22remitters[wk22remitters$TRTGRINDMAN!="Placebo_Placebo",]
trtd.wk22remitters<-trtd.wk22remitters[trtd.wk22remitters$TRTGRINDMAN!="Placebo_Treated",]
summary(subset(trtd.wk22remitters, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, REMISSwk22)))

plac.wk22remitters<-wk22remitters[wk22remitters$TRTGRINDMAN!="Treated_Placebo",]
plac.wk22remitters<-plac.wk22remitters[plac.wk22remitters$TRTGRINDMAN!="Treated_Treated",]
summary(subset(plac.wk22remitters, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, REMISSwk22)))
