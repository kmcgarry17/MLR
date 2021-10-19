clear all
close all

% calculate DIC, TA, pH, and aragonite saturation state
% from temperature, salinity, oxygen, nitrate of ECOA 2 data

% load the normalized predictors
% you created this file using the script process_data.m
load predictors.mat

% the empirical model equations are also in .mat files
% load the empirical models
load MLRs/DICmdl.mat
load MLRs/TAmdl.mat

% create the matrix of predictors
X = [Tn Sn On Nn];

% estimate DIC using the empirical model
DICest = predict(DICmdl, X);
TAest = predict(TAmdl, X);

save('MLR_estimates.mat', 'DICest', 'TAest');

