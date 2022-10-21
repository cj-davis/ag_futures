setwd("~/Desktop/FA_22/Research/data")
library("readxl")

# List of all data file names
states <- c("AK.xlsx",
"AL.xlsx",
"AR.xlsx",
"AZ.xlsx",
"CA.xlsx",
"CO.xlsx",
"CT.xlsx",
"DE.xlsx",
"FL.xlsx",
"GA.xlsx",
"GU.xlsx",
"HI.xlsx",
"IA.xlsx",
"ID.xlsx",
"IL.xlsx",
"IN.xlsx",
"KS.xlsx",
"KY.xlsx",
"LA.xlsx",
"MA.xlsx",
"MD.xlsx",
"ME.xlsx",
"MI.xlsx",
"MN.xlsx",
"MO.xlsx",
"MS.xlsx",
"MT.xlsx",
"NC.xlsx",
"ND.xlsx",
"NE.xlsx",
"NH.xlsx",
"NJ.xlsx",
"NM.xlsx",
"NV.xlsx",
"NY.xlsx",
"OH.xlsx",
"OK.xlsx",
"OR.xlsx",
"PA.xlsx",
"SC.xlsx",
"SD.xlsx",
"TN.xlsx",
"TX.xlsx",
"UT.xlsx",
"VA.xlsx",
"VI.xlsx",
"VT.xlsx",
"WA.xlsx",
"WI.xlsx",
"WV.xlsx",
"WY.xlsx")

# Column D is the daily average temperature
ex_data <- read_excel(states[1], range = cell_cols("C:D"))
plot(ex_data$YEARMODA, ex_data$TEMP, type='p')

acf(ex_data$TEMP)
t = (0:527464)
trig.reg <- lm(ex_data$TEMP ~ cos(2*pi*t / 365)+ sin(2*pi*t / 365))
plot(trig.reg$residuals)
acf(trig.reg$residuals)