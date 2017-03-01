#r setup, include=F, echo=FALSE, cache=FALSE}
deps = c("AUCRF","pROC", "vegan", "dplyr", 'knitr', "gridExtra", "grid", "devtools", "pgirmess", "knitcitations", "scales", "tidyr", "ggplot2", "Hmisc");
for (dep in deps){
	if (dep %in% installed.packages()[,"Package"] == FALSE){
		install.packages(as.character(dep), quiet=TRUE);
	}
	library(dep, verbose=FALSE, character.only=TRUE)
}
