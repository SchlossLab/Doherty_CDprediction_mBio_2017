mdshared<-read.table(file="../data/Jan400.mdshared.wmg.txt", sep="\t", header=T) #wmg=with merged groups
APV_3_2016<-subset(mdshared, select=c(group, Site, visit, TRTGR, TRTGRINDMAN:COUNTRY, BAMINO, BANTIBIO, BCORT, BIMM, DDUR, tissinvol, BL_FLACT:BL_CRP, BOWSTRICT, RESPONSEwk4:REMISSwk22, RSP_SRwk8, RSP_SRwk22, cdai_wk0))
APV_3_2016screen<-APV_3_2016[APV_3_2016$visit=='Screening',]
APV_3_2016screenresp<-APV_3_2016screen[APV_3_2016screen$RESPONSEwk22!="NA",]

adiv<-read.table(file="../data/Jan400.ScreenRespwk22.0.03.subsample.groups.summary", sep="\t", header=T)
colnames(screen_data)
colnames(adiv)
screen_adiv<-merge(screen_data, adiv, by.x="group", by.y="group")
head(screen_adiv)
head(adiv)