```{r , echo=F}
axes <- read.table('../data/Jan400.ScreenRespwk22.0.03.subsample.thetayc.0.03.lt.ave.nmds.axes', header=T)
#des <- read.table('screening.bySRwk8other.design', header=T)
nmds <- merge(screen_data, axes, by.x='group', by.y='group')


SR<-nmds[(nmds$SRwk8other=="SR"), c("axis1", "axis2")]
non <- nmds[(nmds$SRwk8other=="Other"), c("axis1","axis2")]


#make plot, this is probably not the best way to do it
plot(nmds$axis1, nmds$axis2, pch=4)
title("SRwk8other")
#color points by response 
points(SR, col = "blue", pch=4)
points(non, col = "red", pch=4)


legend <- c("SR", "Other")
legend(x="topright", legend, col = c("blue", "red"), pch=4)

summary(nmds$SRwk8other)
```