
#r knitr_settings, eval=TRUE, echo=FALSE, cache=FALSE}

knitr::opts_chunk$set("echo" = FALSE)
knitr::opts_chunk$set("tidy" = TRUE)
knitr::opts_chunk$set("eval" = TRUE)
knitr::opts_chunk$set("warning" = FALSE)
knitr::opts_chunk$set("message" = FALSE)
knitr::opts_chunk$set("cache" = T)

inline_hook <- function(x){
	print(x)
	
	if(is.list(x)){
		x <- unlist(x)
	}
	
	if(is.numeric(x)){
		if(abs(x - round(x)) < .Machine$double.eps^0.5){
			paste(format(x,big.mark=',', digits=3, scientific=FALSE))
		} else {
			paste(format(x,big.mark=',', digits=3, nsmall=1, scientific=FALSE))
		}
	} else {
		paste(x)      
	}
}
knitr::knit_hooks$set(inline=inline_hook)