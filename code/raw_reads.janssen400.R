raw_reads <- read.table(file="./results/tables/All_Runs_rawcounts.txt", header=T)
summary(raw_reads)
under100<-raw_reads$count < 100
n.und100<-nrow(raw_reads [under100,])
n.und100
und3k <- raw_reads$count < 3000
n.und3k <-nrow(raw_reads [und3k,])
n.und3k
total <- nrow(raw_reads)
total
4335641/400
total.counts <- sum(raw_reads$count)
total.counts
total.counts/1600