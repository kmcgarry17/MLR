clear all
close all

% plot the estimates you calculated with the MLR
% plot them against observations to evaluate how well the model did

% load your estimates
load MLR_estimates.mat

% load the carbon observations
load carbon_obs.mat


%% Dissolved Inorganic Carbon

% calculate R squared for estimate and observations
r_dic = corr(DICest, dic_obs);
R2_dic = r_dic^2;

% set the min and max of the plot
min = 1850;
max = 2200;

% create data to draw the 1:1 line
xDIC=linspace(min, max);


% create DIC figure 
figure(1)

% plot the 1:1 line
plot(xDIC, xDIC, 'k', 'handlevisibility', 'off')
hold on

% plot the DIC data
scatter(dic_obs, DICest, 40, [0, 0, 196/255], 'filled')

set(gca, 'fontsize', 20, 'xtick', [1900:100:2200], 'ytick', [1800:100:2200])
ylabel('\fontsize{26}Model Estimate (\mumol/kg)')
xlabel('\fontsize{26}ECOA 2 Observation (\mumol/kg)')
title('\fontsize{28}DIC Evaluation')
axis([min max min max])
set(gcf, 'position', [100, 100, 700, 600])
text(2060,1930,sprintf('R^2 = %0.3g' ,R2_dic), 'fontsize', 24);
hold off

% save the figure to a .png file
saveas(figure(1), 'dic_eval.png')


%% Total Alkalinity

r_alk = corr(TAest, alk_obs);
R2_alk = r_alk^2

rmse = sqrt(mean((TAest - alk_obs).^2))

TAx = linspace(1930, 2400);

% create TA figure
figure(2)

% plot 1:1 line
plot(TAx, TAx, 'r')
hold on

% plot data
scatter(alk_obs, TAest, 40, 'b', 'filled')
ylabel('\fontsize{26}Model Estimate (\mumol/kg)') %should this be mueq?
xlabel('\fontsize{26}Observation (\mumol/kg)')
title('\fontsize{28}TA - T, S, O_2, NO_3')
axis([1930 2410 1930 2410])
set(gcf, 'position', [100, 100, 700, 600])
text(2180,2040,sprintf('R^2 = %0.3g',R2_alk), 'fontsize', 24);
hold off

saveas(figure(2), 'ta_eval.png')

