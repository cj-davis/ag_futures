# Climate data
All climate data is pulled from NOAA FTP. The MATLAB script used to pull the data is not included. Inside the 'data' directory, there are two MATLAB scrips which will be used for aggregating the temperature data and generating estimates for a GARCH(1,1) model of the data.

## Aggregating Temperature Data for Leading Corn Production States
The analysis right now is focused on corn futures contracts. Analysis of other grain commodity futures is a step that will occur in the near future.

We want to take the temperature data from the US states that were the leaders in corn production in 2020 (according to the USDA) and generate three different GARCH(1,1) models for each group of states being analyzed. The first GARCH(1,1) model will use raw data. The idea of this paper operates under the assumption that temperature data is not stationary, so this will likely not generate a very useful model. I will probably add stationary tests (ADF) for the raw data at some point. The second GARCH(1,1) model will be generated using log-differenced temperature data. More thought needs to be put into how to correctly interpret log-differenced temperature data, but this is a very standard pre-processing technique with financial time series. The third GARCH(1,1) model (and likely the most useful) will be generated from the residuals of US state and time fixed effects being regressed on temperature data. 

Data preprocessing is still a work in progress.
