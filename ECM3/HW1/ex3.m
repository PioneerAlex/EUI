%% clean up
clear 
close all
clc

%% path
cd '/Users/alex/Dropbox/EUI/ECM/ECM_3/PS1'

%% FRED
url = 'https://fred.stlouisfed.org/';
c = fred(url);
series = 'UNRATE';
d = fetch(c,series);

%% plot
y = d.Data(:,2);
T = length(y);

% acf
[acf,lags,bounds] = autocorr(y);
figure
autocorr(y,'NumLags',30)
    FigName = 'UNRATE_ACF';         % figure name for saving      
    print('-depsc','-r100',FigName); % saving
    
% pacf
[pacf,lags_pacf,bounds_pacf] = parcorr(y);
figure
parcorr(y,'NumLags',30)
    FigName = 'UNRATE_PACF';         % figure name for saving      
    print('-depsc','-r100',FigName); % saving
    
%% lags selection using BIC
% AR
p_max = 4;

LOGL = zeros(p_max,1);
P = zeros(p_max,1);
P_lag = zeros(p_max,1);
i = 0;
for p = 1:p_max
    mod = arima(p,0,0);
    [fit,~,logL] = estimate(mod,y,'Display','off');
    LOGL(p) = logL;
    P(p) = p;
    i = i + 1;
    P_lag(i) = p;
end

[aic,bic] = aicbic(LOGL,P+1,100);
[~, lag_pos] = min(bic);
P_lag(lag_pos)

% MA
q_max = 4;

LOGL = zeros(q_max,1);
Q = zeros(q_max,1);
Q_lag = zeros(q_max,1);
i = 0;
for q = 1:q_max
    mod = arima(0,0,q);
    [fit,~,logL] = estimate(mod,y,'Display','off');
    LOGL(p) = logL;
    Q(q) = q;
    i = i + 1;
    Q_lag(i) = q;
end

[aic,bic] = aicbic(LOGL,Q+1,100);
[~, lag_pos] = min(bic);
Q_lag(lag_pos)

%% bonus - ARIMA p and q
p_max = 4;
q_max = 4;


LOGL = zeros(p_max,q_max); % Initialize
PQ = zeros(p_max,q_max);
PQ_lag = zeros(p_max*q_max,2);
i = 0;
for p = 1:p_max
    for q = 1:q_max
        mod = arima(p,0,q);
        [fit,~,logL] = estimate(mod,y,'Display','off');
        LOGL(p,q) = logL;
        PQ(p,q) = p+q;
        i = i + 1;
        PQ_lag(i,:) = [p q];
     end
end

LOGL = reshape(LOGL,16,1);
PQ = reshape(PQ,16,1);
[aic,bic] = aicbic(LOGL,PQ+1,100);
reshape(aic,p_max,q_max);
reshape(bic,p_max,q_max);
[~, lag_pos] = min(bic);
PQ_lag(lag_pos,:)