%% clean up
clear 
close all
clc
%% path
cd '/Users/alex/Dropbox/EUI/ECM/ECM_3/PS1'
%% specification
modelMA = arima('Constant',1,'MA',{-1.3,0.4},'Variance',1);
impulse(modelMA, 30);
    FigName = 'IRF_MA';         % figure name for saving      
    print('-depsc','-r100',FigName); % saving
%% simulation
y = simulate(modelMA,500);
%% acf
[acf,lags,bounds] = autocorr(y);
figure
autocorr(y,'NumLags',30)
    FigName = 'MA_ACF';         % figure name for saving      
    print('-depsc','-r100',FigName); % saving
%% pacf
[pacf,lags_pacf,bounds_pacf] = parcorr(y);
figure
parcorr(y,'NumLags',30)
    FigName = 'MA_PACF';         % figure name for saving      
    print('-depsc','-r100',FigName); % saving