### List of commands to render final pdf

# Load needed library
#This function loads and installs libraries if they are not already loaded by the user 
loadLibs <- function(deps){
  for (dep in deps){
    if (dep %in% installed.packages()[,"Package"] == FALSE){
      install.packages(as.character(dep), quiet=TRUE);
    }
    library(dep, verbose=FALSE, character.only=TRUE)
  }
}

loadLibs(c("knitr", "rmarkdown"))

# Render the final pdfs
<<<<<<< HEAD
render('submission/Doherty_CDprediciton_mBio_2017_finaldraft.Rmd', output_format = "pdf_document", clean = FALSE)
=======
render('submission/Doherty_CDprediciton_mBio_2017_finaldraft.Rmd', clean = FALSE)
>>>>>>> 10b96170ecb159b892699d21633615dedccbdd8f
