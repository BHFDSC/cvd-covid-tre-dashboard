#######################################
##### Shinyapp deployment script ######
#######################################
### SHOULD NOT BE ABLE TO SEE THIS
#BLAH
# Running a shinyapp creates a temporary version (appearing in your browser normally) that only you can view. If you want to share the
# app with others though you need to host a public version. You can do this by setting up an account on shinyapps.io

# Instructions can be found here
# https://shiny.rstudio.com/articles/shinyapps.html


##########################################################################
# Setting up a shinyapps.io account ---------------------------------------
###########################################################################

# https://www.shinyapps.io/


###########################################################################
# Giving Rstudio access to your online domain -----------------------------
###########################################################################

# After this you just need the shiny app in your rstudio to have credentials to access your public domain, in order to deploy it.

# Make sure you have this package installed.
install.packages('rsconnect')


rsconnect::setAccountInfo(name='hdruk-bhf-dsc',                                 # this is the domain name you chose when first setting your account
                          token='6018508B8DEBB0B1BD77B941566BA0C3',             # this is a token you will be offered during set up as well
                          secret='Sdxnky2HqiyECLrVBHP/YVvNBIM4M8E+vXemCisY')    # you will need to replace this with the 'secret' (click show secret to copy)


# Go to the 'Tokens' page on your account if you're not sure on this info

###########################################################################
# Deploying the shiny dashboard -------------------------------------------
###########################################################################

# Finally there's the 'deploying' part itself. Its maybe somewhere between 'running the app' locally, and 'pushing to github'.

# There are two ways to deploy a shiny app. One is through running the below code. 

library(rsconnect)

#app_location <- getwd()

rsconnect::deployApp()

# The other is to click the button next to the 'run app', called 'publish'... should be in the top right of your script or the dashboard you produce.


# There may be some additional package warnings..... in this case you might want to use pacman to quickly address this. See code below

#install.packages("pacman")
# 
# pacman::p_load(brew, devtools, downlit, gert, gh, gitcreds, ini, miniUI, pkgbuild, pkgdown, profvis, ragg, rcmdcheck, remotes,
#                roxygen2, rversions, sessioninfo, textshaping, urlchecker, usethis, whisker, xopen, zip, gh, jJava, shinyvalidate,
#                xlsx, xlsxjars)

# pacman::p_load(checkmate, crul, fontBitstreamVera , fontLiberation, fontquiver, fresh,
#                gdtools, gfonts, httpcode)



