%% clean up
clear 
close all
clc
%% path
cd '/Users/alex/Dropbox/EUI/ECM/ECM_3/PS1'
%% specification
modelAR = arima('Constant',1,'AR',{1.3,-0.4},'Variance',1);
impulse(modelAR, 30);
%% simulation
y = simulate(modelAR,500);
%% acf
[acf,lags,bounds] = autocorr(y);
figure
autocorr(y,'NumLags',30)
    FigName = 'AR_ACF';         % figure name for saving      
    print('-depsc','-r100',FigName); % saving
%% pacf
[pacf,lags_pacf,bounds_pacf] = parcorr(y);
figure
parcorr(y,'NumLags',30)
    FigName = 'AR_PACF';         % figure name for saving      
    print('-depsc','-r100',FigName); % saving