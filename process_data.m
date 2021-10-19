clear all 
close all

% read the excel file into matlab
E2datafile = 'ECOA2_master_sheet_discrete.xlsx';
E2data = xlsread(E2datafile);

% -999 is used when there is no data
% change these values to NaN
E2data(E2data == -999) = NaN;

% set geographic limits
lat = E2data(:, 9);
lon = E2data(:, 8);

% set lat and lon limits for northeast US shelf
icoord = lat >= 34.4 & lat <= 45.3 & lon >= -78 & lon <= 64.7;

% set pressure limits 15-500 dbar
pres = E2data(:, 6);
ipres = pres>15 & pres<500;

data_limit = E2data((icoord&ipres), :);

% pull out predictor variables
temp = data_limit(:, 10);
psal = data_limit(:, 14);
doxy = data_limit(:, 22);
no3 = data_limit(:, 32);

% pull out carbon observations
alk = data_limit(:, 26);
dic = data_limit(:, 24);

% remove the points where there is no data for any of the predictors
% or the carbon variables, which we will compare estimates to later

index = ~isnan(temp) & ~isnan(psal) & ~isnan(doxy) & ~isnan(no3) &...
    ~isnan(alk) & ~isnan(dic);

% new matrix only including points where there is data for all the variables
E2complete = data_limit(index, :);

% read Quality Control flags
% only 2 is a good data point
oxyflag = E2complete(:, 23);
dicflag = E2complete(:, 25);
alkflag = E2complete(:, 27);
nitflag = E2complete(:, 33);

iQC = oxyflag == 2 & dicflag == 2 & alkflag == 2 & nitflag == 2;
E2_QC = E2complete(iQC, :);

% get new variables from the complete, QCed matrix
temp = E2_QC(:, 10);
psal = E2_QC(:, 14);
doxy = E2_QC(:, 22);
no3 = E2_QC(:, 32);
alk_obs = E2_QC(:, 26);
dic_obs = E2_QC(:, 24);

% normalize predictors
% subtract the mean and divide by the standard deviation of the calibration data

% load the means and standard deviations calculated from the calibration data
load normalizers.mat

Tn = (temp-Tm)/Tstd;
Sn = (psal - Sm)/Sstd;
On = (doxy - O2m)/O2std;
Nn = (no3 - NO3m)/NO3std;

save('predictors.mat', 'Tn', 'Sn', 'On', 'Nn');

save('carbon_obs.mat', 'alk_obs', 'dic_obs');
