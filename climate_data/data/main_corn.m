% In this script, we will derive parameter estimates for a GARCH(1,1) model
% for raw temperature data, log-differenced temperatur data, and the
% residuals of a fixed-effects model with day and state fixed effects

% We will only need temperature volatility estimates for a handful of
% states at a time
states=['IA', 'IL', 'NE', 'MN', 'IN', 'KS', 'SD', 'OH', 'MO', 'WI', 'MI', 'KY', 'ND'];
% States are included in states array by greatest to least share of corn
% produced in 2020

%% Raw Data
%avg_tmp = getAvgTemp(states(1:4));
data = readtable('CO.xlsx');

%% Log-Differenced Data

%% Residual Data