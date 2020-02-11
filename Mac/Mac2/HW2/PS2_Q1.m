clc; clear all; close all;

%% a - parameters
alpha = 0.36; beta = 0.9; delta = 0.025;

%% b - steady state
k_star = (alpha/(1/beta - 1 + delta))^(1/(1-alpha));

%% c - grid
nkk = 500;
grid_k = linspace(0.9*k_star, 1.1*k_star, nkk);

%% d - initial guess for V
V0 = zeros(1,nkk);

%% e
% i
V = V0;
V1 = zeros(1,nkk);
opt_k_ind = zeros(1,nkk);
check = 0;

its = 0;
tic
while check == 0
    for i=1:nkk
        values = zeros(1,nkk);
        for j=1:nkk
            % ii
            values(j) = log(grid_k(i)^alpha + (1 - delta)*grid_k(i) - grid_k(j)) + beta * V(j);
        end
        [V1(i), opt_k_ind(i)] = max(values);
        % iii
    end
% f - distance
    dist = norm(V1 - V)/norm(V);
    % i
    if dist > .001
        V = V1;
    else
        check = 1;
    end
    its = its + 1;
end
toc
its
%% g - policy function
k_opt = grid_k(opt_k_ind);

%% h
k1 = grid_k(1);
path_k = zeros(1,50);
path_k(1) = k1;
for i=2:50
    [~, idx] = min(abs(grid_k - path_k(i-1)));
    path_k(i) = k_opt(idx);
end

%%
% policy function
figure; plot(grid_k, k_opt); hold on; plot(4:.1:5,4:.1:5)
% policy - 45
diff = k_opt-grid_k;
figure; plot(grid_k, diff); hold on; plot(grid_k, zeros(1,500))
% convergence
figure; plot(path_k); hold on; plot(k_star*ones(1,50))
% value function
figure; plot(V1, grid_k)
