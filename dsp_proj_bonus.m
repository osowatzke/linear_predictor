%% Load required file for bonus part of project
clear;
% load required file
load('djiaw_2019.mat');

price = djiaw_total(:,2);
dateML = djiaw_total(:,1);

%% (i) Use first ten years (520 wks) to predict 2018 values. Finding the best p value.
start = 0;
fin = 0;

for ii=1:length(dateML)
    if datestr(dateML(ii),2) == '01/02/18'
        start = ii;
    end
    if datestr(dateML(ii),2) == '12/31/18'
        fin = ii;
    end
end

% set N and max p values
N = 520;
p_max = 20;

% create empty cells to store computed values for p = 1,2,...
a_vects = cell(1,p_max); % store linear predictor coefficient vectors
err_vects = cell(1,p_max); % store prediction error vectors
tse_vects = zeros(1,p_max); % store total squared prediction errors 
Xmat_vects = cell(1,p_max); % store generated X matrices
xvect_vects = cell(1,p_max); % store generated x vectors


for p=1:p_max
    % X matrix
    X = zeros(N-p,p);
    for row = 1:N-p
        X(row,1:p) = price(row:row+p-1);
    end
    Xmat_vects{p} = X;

    % x vector
    x = zeros(N-p,1);
    for row = 1:N-p
        x(row,:) = price(row+p);
    end
    xvect_vects{p} = x;
    
    % generate linear predictor coefficient vector
    a = -X \ x;
    
    % store coefficients vector
    a_vects{p} = a;
    
    xhat_p = filter(-[0; flip(a)],1,price);
    
    % generate prediction error
%     error = x + X * a;
    error = xhat_p(start:fin) - price(start:fin);
    
    % store error values generated
    err_vects{p} = error;
    
    % generate total squared error
    tse = error.' * error;
    
    % store total squared error values
    tse_vects(p) = tse;

end

figure;
plot(1:p_max,tse_vects);
grid(gca,'minor');
grid on;
title('Total squared prediction error vs p');
xlabel('p'); ylabel('Total Squared Prediction Error');