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

alltp.ust.RESPyes<-alltp.ust[alltp.ust$RelRSPwk22=="Yes",]
summary(alltp.ust.RESPyes[,1:6])
alltp.ust.RESPno<-alltp.ust[alltp.ust$RelRSPwk22=="No",]
summary(alltp.ust.RESPno[,1:6])

alltp.placplac.RESPyes<-alltp.placplac[alltp.placplac$RelRSPwk22=="Yes",]
summary(alltp.placplac.RESPyes[,1:6])
alltp.placplac.RESPno<-alltp.placplac[alltp.placplac$RelRSPwk22=="No",]
summary(alltp.placplac.RESPno[,1:6])

alltp.all.respY<-alltime_data[alltime_data$RelRSPwk22=="Yes",]
alltp.all.respN<-alltime_data[alltime_data$RelRSPwk22=="No",]
summary(alltp.all.respY[,1:6])

all.distmat<-read.table("../data/Jan400.all.na.omit.cmd.thetayc.0.03.square.ave.dist")
all.dist<-as.dist(all.distmat)
ustdistmat<-read.table("../data/Jan400.ust.na.omit.cmd.thetayc.0.03.square.ave.dist")
ustdist<-as.dist(ustdistmat)
pladistmat<-read.table("../data/Jan400.plac.na.omit.cmd.thetayc.0.03.square.ave.dist")
pladist<-as.dist(pladistmat)
alltp_distmat<-read.table("../data/Jan400.alltp.noPU.na.omit.cmd.thetayc.0.03.sq.ave.dist")
alltp_dist<-as.dist(alltp_distmat)
alltp_ustdistmat<-read.table("../data/Jan400.all.na.omit.cmd.ust.alltp.thetayc.square.ave.dist")
alltp_ustdist<-as.dist(alltp_ustdistmat)
alltp_placplacdistmat<-read.table("../data/Jan400.alltp.plac.noPU.na.omit.cmd.thetayc.0.03.sq.ave.dist")
alltp_placplacdist<-as.dist(alltp_placplacdistmat)

wk046_distmat<-read.table("../data/Jan400.wk046.all.na.omit.cmd.thetayc.0.03.square.ave.dist")
wk046_dist<-as.dist(wk046_distmat)
wk046_ustdistmat<-read.table("../data/Jan400.wk046.ust.na.omit.cmd.thetayc.0.03.square.ave.dist")
wk046_ustdist<-as.dist(wk046_ustdistmat)
wk046_placdistmat<-read.table("../data/Jan400.wk046.plac.na.omit.cmd.thetayc.0.03.square.ave.dist")
wk046_placdist<-as.dist(wk046_placdistmat)

wk0.ustdistmat<-read.table("../data/Jan400.alltp.ust.wk0.na.omit.cmd.thetayc.0.03.square.ave.dist")
wk0.ustdist<-as.dist(wk0.ustdistmat)
wk4.ustdistmat<-read.table("../data/Jan400.alltp.ust.wk4.na.omit.cmd.thetayc.0.03.square.ave.dist")
wk4.ustdist<-as.dist(wk4.ustdistmat)
wk6.ustdistmat<-read.table("../data/Jan400.alltp.ust.wk6.na.omit.cmd.thetayc.0.03.square.ave.dist")
wk6.ustdist<-as.dist(wk6.ustdistmat)

wk0.placdistmat<-read.table("../data/Jan400.alltp.plac.wk0.na.omit.cmd.thetayc.0.03.square.ave.dist")
wk0.placdist<-as.dist(wk0.placdistmat)
wk4.placdistmat<-read.table("../data/Jan400.alltp.plac.wk4.na.omit.cmd.thetayc.0.03.square.ave.dist")
wk4.placdist<-as.dist(wk4.placdistmat)
wk6.placdistmat<-read.table("../data/Jan400.alltp.plac.wk6.na.omit.cmd.thetayc.0.03.square.ave.dist")
wk6.placdist<-as.dist(wk6.placdistmat)


alltp_ustdistmat.respY<-read.table("../data/Jan400.alltp.noPU.trtd.relRSP.Y.na.omit.cmd.thetayc.0.03.sq.ave.dist")
alltp_ustdist.respY<-as.dist(alltp_ustdistmat.respY)
alltp_placdistmat.respY<-read.table("../data/Jan400.alltp.noPU.plac.relRSP.Y.na.omit.cmd.thetayc.0.03.sq.ave.dist")
alltp_placdist.respY<-as.dist(alltp_placdistmat.respY)
alltp_distmat.respY<-read.table("../data/Jan400.alltp.noPU.relRSP.Y.na.omit.cmd.thetayc.0.03.sq.ave.dist")
alltp_dist.respY<-as.dist(alltp_distmat.respY)
alltp_distmat.respN<-read.table("../data/Jan400.alltp.noPU.relRSP.N.na.omit.cmd.thetayc.0.03.sq.ave.dist")
alltp_dist.respN<-as.dist(alltp_distmat.respN)

wk22remitters<-alltime_data[alltime_data$REMISSwk22=="Yes",]
summary(subset(wk22remitters, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, REMISSwk22)))

trtd.wk22remitters<-wk22remitters[wk22remitters$TRTGRINDMAN!="Placebo_Placebo",]
trtd.wk22remitters<-trtd.wk22remitters[trtd.wk22remitters$TRTGRINDMAN!="Placebo_Treated",]
summary(subset(trtd.wk22remitters, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, REMISSwk22)))

plac.wk22remitters<-wk22remitters[wk22remitters$TRTGRINDMAN!="Treated_Placebo",]
plac.wk22remitters<-plac.wk22remitters[plac.wk22remitters$TRTGRINDMAN!="Treated_Treated",]
summary(subset(plac.wk22remitters, select=c(group, USUBJID, visit, TRTGR, TRTGRINDMAN, REMISSwk22)))

wk22remitters.distmat<-read.table("../data/Jan400.alltp.wk22remitters.na.omit.cmd.thetayc.0.03.sq.ave.dist")
wk22remitters.dist<-as.dist(wk22remitters.distmat)
trtd.wk22remitters.distmat<-read.table("../data/Jan400.alltp.trtd.wk22remitters.na.omit.cmd.thetayc.0.03.sq.ave.dist")
trtd.wk22remitters.dist<-as.dist(trtd.wk22remitters.distmat)
plac.wk22remitters.distmat<-read.table("../data/Jan400.alltp.plac.wk22remitters.na.omit.cmd.thetayc.0.03.sq.ave.dist")
plac.wk22remitters.dist<-as.dist(plac.wk22remitters.distmat)