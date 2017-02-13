mdshared<-read.table(file="Jan400.mdshared.wmg.txt", sep="\t", header=T) #wmg=with merged groups
APV_3_2016<-subset(mdshared, select=c(group, Site, visit, TRTGR, TRTGRINDMAN:COUNTRY, BAMINO, BANTIBIO, BCORT, BIMM, DDUR, tissinvol, BL_FLACT:BL_CRP, BOWSTRICT, RESPONSEwk4:REMISSwk22, RSP_SRwk8, RSP_SRwk22, cdai_wk0))
var_list<-colnames(APV_3_2016)
APV_3_2016screen<-APV_3_2016[APV_3_2016$visit=='Screening',]
APV_3_2016screenresp<-APV_3_2016screen[APV_3_2016screen$RESPONSEwk22!="NA",]
APV_3_2016screenrespNAomit<-na.omit(APV_3_2016screenresp)
#for (i in var_list){
	#by.i<-subset(APV_3_2016screen, select=c(group, (i))
	#write.table(by.i, file=paste("screening.by", i, ".design", sep=""), row.names=F, quote=F)
	#}

bySite<-subset(APV_3_2016screenresp, select=c(group, Site))
bySite<-na.omit(bySite)
write.table(bySite, file="screening.bySite.design", row.names=F, quote=F)

byTRTGR<-subset(APV_3_2016screenresp, select=c(group, TRTGR))
byTRTGR<-na.omit(byTRTGR)
write.table(byTRTGR, file="screening.byTRTGR.design", row.names=F, quote=F)

byTRTGRINDMAN<-subset(APV_3_2016screenresp, select=c(group, TRTGRINDMAN))
byTRTGRINDMAN<-na.omit(byTRTGRINDMAN)
write.table(byTRTGRINDMAN, file="screening.byTRTGRINDMAN.design", row.names=F, quote=F)

byAGE<-subset(APV_3_2016screenresp, select=c(group, AGE))
byAGE<-na.omit(byAGE)
write.table(byAGE, file="screening.byAGE.design", row.names=F, quote=F)

bySEX<-subset(APV_3_2016screenresp, select=c(group, SEX))
bySEX<-na.omit(bySEX)
write.table(bySEX, file="screening.bySEX.design", row.names=F, quote=F)

byRACE<-subset(APV_3_2016screenresp, select=c(group, RACE))
byRACE<-na.omit(byRACE)
write.table(byRACE, file="screening.byRACE.design", row.names=F, quote=F)

byCOUNTRY<-subset(APV_3_2016screenresp, select=c(group, COUNTRY))
byCOUNTRY<-na.omit(byCOUNTRY)
write.table(byCOUNTRY, file="screening.byCOUNTRY.design", row.names=F, quote=F)

byBAMINO<-subset(APV_3_2016screenresp, select=c(group, BAMINO))
byBAMINO<-na.omit(byBAMINO)
write.table(byBAMINO, file="screening.byBAMINO.design", row.names=F, quote=F)

byBANTIBIO<-subset(APV_3_2016screenresp, select=c(group, BANTIBIO))
byBANTIBIO<-na.omit(byBANTIBIO)
write.table(byBANTIBIO, file="screening.byBANTIBIO.design", row.names=F, quote=F)

byBCORT<-subset(APV_3_2016screenresp, select=c(group, BCORT))
byBCORT<-na.omit(byBCORT)
write.table(byBCORT, file="screening.byBCORT.design", row.names=F, quote=F)

byBIMM<-subset(APV_3_2016screenresp, select=c(group, BIMM))
byBIMM<-na.omit(byBIMM)
write.table(byBIMM, file="screening.byBIMM.design", row.names=F, quote=F)

byDDUR<-subset(APV_3_2016screenresp, select=c(group, DDUR))
byDDUR<-na.omit(byDDUR)
write.table(byDDUR, file="screening.byDDUR.design", row.names=F, quote=F)

bytissinvol<-subset(APV_3_2016screenresp, select=c(group, tissinvol))
bytissinvol<-na.omit(bytissinvol)
write.table(bytissinvol, file="screening.bytissinvol.design", row.names=F, quote=F)

byBL_FLACT<-subset(APV_3_2016screenresp, select=c(group, BL_FLACT))
byBL_FLACT<-na.omit(byBL_FLACT)
write.table(byBL_FLACT, file="screening.byBL_FLACT.design", row.names=F, quote=F)

byBL_FCALP<-subset(APV_3_2016screenresp, select=c(group, BL_FCALP))
byBL_FCALP<-na.omit(byBL_FCALP)
write.table(byBL_FCALP, file="screening.byBL_FCALP.design", row.names=F, quote=F)

byBL_CRP<-subset(APV_3_2016screenresp, select=c(group, BL_CRP))
byBL_CRP<-na.omit(byBL_CRP)
write.table(byBL_CRP, file="screening.byBL_CRP.design", row.names=F, quote=F)

byBOWSTRICT<-subset(APV_3_2016screenresp, select=c(group, BOWSTRICT))
byBOWSTRICT<-na.omit(byBOWSTRICT)
write.table(byBOWSTRICT, file="screening.byBOWSTRICT.design", row.names=F, quote=F)

byRESPONSEwk22<-subset(APV_3_2016screenresp, select=c(group, RESPONSEwk22))
byRESPONSEwk22<-na.omit(byRESPONSEwk22)
write.table(byRESPONSEwk22, file="screening.byRESPONSEwk22.design", row.names=F, quote=F)

bycdai_wk0<-subset(APV_3_2016screenresp, select=c(group, cdai_wk0))
bycdai_wk0<-na.omit(bycdai_wk0)
write.table(bycdai_wk0, file="screening.bycdai_wk0.design", row.names=F, quote=F)

byDDUR10<-subset(APV_3_2016screen, select=c(group, DDUR10))
byDDUR10<-na.omit(byDDUR10)
write.table(byDDUR10, file="screening.byDDUR10.design", row.names=F, quote=F)

byDDUR15<-subset(APV_3_2016screen, select=c(group, DDUR15))
byDDUR15<-na.omit(byDDUR15)
write.table(byDDUR15, file="screening.byDDUR15.design", row.names=F, quote=F)

byBL_FCALPLEV<-subset(APV_3_2016screen, select=c(group, BL_FCALPLEV))
byBL_FCALPLEV<-na.omit(byBL_FCALPLEV)
write.table(byBL_FCALPLEV, file="screening.byBL_FCALPLEV.design", row.names=F, quote=F)

byBL_CRPLEV<-subset(APV_3_2016screen, select=c(group, BL_CRPLEV))
byBL_CRPLEV<-na.omit(byBL_CRPLEV)
write.table(byBL_CRPLEV, file="screening.byBL_CRPLEV.design", row.names=F, quote=F)

byBL_FLACTLEV<-subset(APV_3_2016screen, select=c(group, BL_FLACTLEV))
byBL_FLACTLEV<-na.omit(byBL_FLACTLEV)
write.table(byBL_FLACTLEV, file="screening.byBL_FLACTLEV.design", row.names=F, quote=F)

byRSP_Rwk8n22<-subset(APV_3_2016screen, select=c(group, RSP_Rwk8n22))
byRSP_Rwk8n22<-na.omit(byRSP_Rwk8n22)
write.table(byRSP_Rwk8n22, file="screening.byRSP_Rwk8n22.design", row.names=F, quote=F)

byRSP_SRwk8N22<-subset(APV_3_2016screen, select=c(group, RSP_SRwk8N22))
byRSP_SRwk8N22<-na.omit(byRSP_SRwk8N22)
write.table(byRSP_SRwk8N22, file="screening.byRSP_SRwk8N22.design", row.names=F, quote=F)

