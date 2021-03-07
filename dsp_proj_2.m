%% Load required file for part one of project

% load required file
load('djiaw_2019.mat');

price = djiaw_total(:,2);
dateML = djiaw_total(:,1);
date = datestr(dateML(:),2);

%% (a) Plot DJIA data on linear and semilog scale.

% plot DJIA data vs dates on linear scale
figure;
plot(dateML,price);
datetick('x','yyyy');
grid on;
ax = gca;
ax.YAxis.Exponent = 0; 
grid(gca,'minor');
ylabel('Dow Jones Industrial Average');
xlabel('Year');
title('(a) Dow Jones Industrial Average Oct 1,1928-Feb 11,2019')

% plot DJIA data vs dates on semi-log scale
figure;
semilogy(dateML,price);
datetick('x','yyyy');
grid on;
ax = gca;
ax.YAxis.Exponent = 0;
ylabel('log_{10} of Dow Jones Industrial Average');
xlabel('Year');
title('(a) Semilog plot of DJIA Oct 1,1928-Feb 11,2019');

%% (a) Investment through DJIA

% money gain per week
week_val = 1;

% total money gained at the end of investment interval, initial: $ 1000
total = 1000;

% calculate the money gained per week and sum to total balance
for ii=1:length(price)-1
    % obtain amount of money at week ii+1 depending on DJIA data
    week_val = total * price(ii+1)/price(ii);
    % update current investment money 
    total = week_val;
end

% % total money gained at the end of investment interval = $ 104196.93

fprintf('\n(a) Total money gained at the end of the investment ');
fprintf('interval = $%.2f\n',total);

%% (a) Money through savings account

% best APR to achieve same balance as DJIA investment within same
% investment interval
rate = ((total/1000)^(1/length(price))-1)*52;
% % 5.128% APR to achieve same level of performance.
fprintf('(a) %.3f%% APR to achieve same level of performance.\n',rate*100);

% number of weeks needed to reach same amount at DJIA investment if APR
% remains 3%
no_weeks = log(total/1000) / log(1+0.03/52);
no_weeks = round(no_weeks);
% % 8055.88 rounded to 8056 weeks to achieve same level of performance.
fprintf('(a) It will take %d weeks to achieve the same ',no_weeks);
fprintf('level of performance at 3%% APR.\n');

%% (b) Solve for vector of linear predictor coefficients, a

% X matrix
X = zeros(517,3);
for row = 1:517
    X(row,1:3) = price(row:row+2);
end

% x vector
x = zeros(517,1);
for row = 1:517
    x(row,:) = price(row+3);
end

% solve for linear predictor coefficients
a = -X \ x;

fprintf('\n(b) Linear predictor coefficients for p = 3, N = 520:\n');
disp(a);
% % a1 = 0.0268
% % a2 = 0.0938
% % a3 = -1.118

%% (c) Generate predicted values and error compared to actual values.

% predict future prices from week 4 to 520 using data from week 1 to 517
xhat1 = -X * a;

% predict future prices using linear predictor coefficients from part b
xhat2 = filter(-[0 a(3) a(2) a(1)],1,price);
% subset of predicted xhat2 values from week 4 to week 520
xhat2_sub = xhat2(4:520);

% plot predicted values vs actual weekly average from week 4 to week 520
figure;
plot(dateML(4:520),xhat1);
hold on
plot(dateML(4:520),xhat2_sub,'-.');
hold on
plot(dateML(4:520),price(4:520),'--g');
datetick('x','yyyy');
legend('xhat1','xhat2','Actual Weekly Average');
title('(c) Predicted and Actual Values from Week 4 to Week 520');

% determine error between actual and xhat1 from week 4 - 520
e1 = x + X * a;
e1 = round(e1,3);

% total squared error for xhat1
tse_e1 = e1.' * e1;
% % 23638.108116

% determine error between actual and xhat2 from week 4 - 520
e2 = price(4:520) - xhat2_sub;
e2 = round(e2,3);

% check if both errors are equal, meaning both predicted values are same
isequal(e1,e2);
% % answer is 1, both error values are the same

% total squared error for xhat2
tse_e2 = 0;
for ii=4:520
    diff = xhat2(ii) - price(ii);
    diff_sq = diff^2;
    tse_e2 = tse_e2 + diff_sq;
end
% % 23638.0642056466

% both total squared error = 23638
fprintf('\n(c) Total squared error for xhat1 =  %g \n',tse_e1);
fprintf('(c) Total squared error for xhat2 =  %g \n',tse_e2);

%% (d) Finding linear predictor coefficients for different orders of p

% set N and max p values
N = 520;
p_max = 10;

% create empty cells to store computed values for p = 1,2,...,10
a_vects = cell(1,p_max); % store linear predictor coefficient vectors
err_vects = cell(1,p_max); % store prediction error vectors
tse_vects = zeros(1,10); % store total squared prediction errors 
Xmat_vects = cell(1,10); % store generated X matrices
xvect_vects = cell(1,10); % store generated x vectors

% generate linear predictor coefficients for p = 1,2,...,10

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
    
    % store vector
    a_vects{p} = a;
    
    % generate prediction error
    error = x + X * a;
    
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
title('(d) Total squared prediction error vs p');
xlabel('p'); ylabel('Total Squared Prediction Error');

% It is observed that higher values of p produces lower prediction errors. 
% Given choices of p from only 1 to 10, we choose the p value with the 
% lowest total squared prediction error. Therefore, p = 10.

fprintf('\n(d) Observe a linear relationship between p and total\n');
fprintf('squared errors. There is no observable "knee". \n');
fprintf('Given range of p from 1 to 10, p value is chosen\n');
fprintf('such that it has the overall lowest total squared\n');
fprintf('prediction error. Therefore, p = 10. \n');


%% (e) Apply various strategies to predict 520 week values from p-th week

N = 520;
p_chosen = 10;

% Setting the upper bound, initial investment of 1000 at week p
upper_value = 1000;

% Iterate from week p+1 onwards for 520 weeks 
for ii = p_chosen:p_chosen+N-1
    
    % compute returns from savings account
    by_bank = upper_value * (1+0.03/52);
    
    % compute returns from DJIA
    by_djia = upper_value * price(ii+1)/price(ii);
    
    % if DJIA has higher returns than the bank, then invest into DJIA 
    if by_djia > by_bank
        upper_value = by_djia;

    % if bank has higher or same return, then invest into bank
    else
        upper_value = by_bank;
    end
        
end
        
% % upper bound $ 4703277.85
fprintf('\n(e) Upper bound: $ %.2f\n',upper_value);

lower_djia = 1000;

% lower bound by investing into DJIA
for ii = p_chosen:p_chosen+N-1
    lower_djia = lower_djia * price(ii+1)/price(ii);
end

% % lower bound DJIA = $ 543.77
fprintf('(e) Lower bound with DJIA investment: $ %.2f\n',lower_djia);

lower_bank = 1000;
% lower bound by investing into bank
for ii = 1:N
    lower_bank = lower_bank * (1+0.03/52);
end

% % lower bound bank = $ 1349.74
fprintf('(e) Lower bound with bank: $ %.2f\n',lower_bank);

pred_val = 1000;

a_10 = a_vects{1,10};

% compute predicted values using coefficients when p = 10
xhat_p = filter(-[0 a_10(10) a_10(9) a_10(8) a_10(7) a_10(6) ...
    a_10(5) a_10(4) a_10(3) a_10(2) a_10(1)],1,price);

% compute predicted values from week 11 to week 530 using linear predictor
for ii = p_chosen:p_chosen+N-1
    
    % compute returns from savings account
    by_bank = pred_val * (1+0.03/52);
    
    % compute predicted returns from DJIA
    by_djia = pred_val * xhat_p(ii+1)/price(ii);
    
    % if DJIA has higher prediction return than bank, invest into DJIA 
    if by_djia > by_bank
        % calculate actual gain using real stock price data
        pred_val = pred_val * price(ii+1)/price(ii);

    % if bank has higher or same return, then invest into bank
    else
        pred_val = by_bank;
    end
        
end

fprintf('(e) Predicted value: $ %.2f\n',pred_val);

%% (f) Predicting values in the most recent decade 



upper_value = 1000;

% for ii = p_chosen:p_chosen+N-1
for ii = length(price)-520:length(price)-1
    
    % compute returns from savings account
    by_bank = upper_value * (1+0.03/52);
    
    % compute returns from DJIA
    by_djia = upper_value * price(ii+1)/price(ii);
    
    % if DJIA has higher returns than the bank, then invest into DJIA 
    if by_djia > by_bank
        upper_value = by_djia;

    % if bank has higher or same return, then invest into bank
    else
        upper_value = by_bank;
    end
    
end

fprintf('\n(f) Upper bound: $ %.2f\n',upper_value);


lower_bank = 1000;
% lower bound by investing into bank
for ii = 1:N
    lower_bank = lower_bank * (1+0.03/52);
end

fprintf('(f) Lower bound with bank: $ %.2f\n',lower_bank);

lower_djia = 1000;

% lower bound by investing into DJIA
for ii = length(price)-520:length(price)-1
    lower_djia = lower_djia * price(ii+1)/price(ii);
end

fprintf('(f) Lower bound with DJIA investment: $ %.2f\n',lower_djia);

pred_val = 1000;

for ii = length(price)-520:length(price)-1
    
    % compute returns from savings account
    by_bank = pred_val * (1+0.03/52);
    
    % compute predicted returns from DJIA
    by_djia = pred_val * xhat_p(ii+1)/price(ii);
    
    % if DJIA has higher prediction return than bank, invest into DJIA 
    if by_djia > by_bank
        % calculate actual gain using real stock price data
        pred_val = pred_val * price(ii+1)/price(ii);

    % if bank has higher or same return, then invest into bank
    else
        pred_val = by_bank;
    end
        
end

fprintf('(f) Predicted value: $ %.2f\n',pred_val);

% best APR to achieve same balance as linear predictor in 520 weeks
rate = ((pred_val/1000)^(1/N)-1)*52;

fprintf('(f) %.3f%% APR to achieve same level of performance.\n', rate*100);

