read.dist <- function(file, input='lt', make.square=T, diag=0){
	if(input=='lt'){
		stuff <- scan(file, what='character') #gets all of the elements of the file
		n <- as.numeric(stuff[1]) # n = number of groups/samples in file
		stuff <- stuff[-1] # removes number of groups from list of stuff
		m <- data.frame(matrix(NA, nrow=n, ncol=n) ) #makes empty matrix based on number of groups
		diag(m) <- diag #fills in diagnol with specified value
		
		c <- 1 # c keeps track of postion in stuff vector
		for(i in 1:n){
			group <- stuff[c] #get group name
			colnames(m)[i] <- group
			rownames(m)[i] <- group
			
			if(i > 1){
				m[i,1:(i-1)] <- stuff[(c+1):(c+i-1)] #fills in matrix with values from stuff
			}
			c<-c+i #this because math
		}
		if(make.square){
			m[upper.tri(m)] <- m[lower.tri(m)] #fills in upper triangle
		}
	}
	
	if(input=='square'){ #reads in square matrix
		m<-read.table(file, skip=1, row.names=1)
		colnames(m) <- rownames(m)
	}
	return(m)
}
	
#screening all nao
dist<-as.matrix(read.dist('data/mothur/Jan400.screening.all.na.omit.cmd.thetayc.0.03.lt.ave.dist'))
write.table(dist, file='data/mothur/Jan400.screening.all.na.omit.cmd.thetayc.0.03.square.ave.dist', quote=F, sep="\t")

#screening ust nao
dist<-as.matrix(read.dist('data/mothur/Jan400.screening.ust.na.omit.cmd.thetayc.0.03.lt.ave.dist'))
write.table(dist, file='data/mothur/Jan400.screening.ust.na.omit.cmd.thetayc.0.03.square.ave.dist', quote=F, sep="\t")

#screening placebo nao
dist<-as.matrix(read.dist('data/mothur/Jan400.screening.plac.na.omit.cmd.thetayc.0.03.lt.ave.dist'))
write.table(dist, file='data/mothur/Jan400.screening.plac.na.omit.cmd.thetayc.0.03.square.ave.dist', quote=F, sep="\t")

