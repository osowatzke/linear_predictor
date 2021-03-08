%% Load required file for part two of project

% load required file
load('eth_2019.mat');

% isolate price and date values from data set
price = block_difficulty(:,2);
dateML = block_difficulty(:,1);

%% 2(a)-(a) Designing predictor with p = 2

% get the index from dateML for July 30, 2015 and December 31, 2015
start = 0;
fin = 0;
for ii=1:length(dateML)
    if datestr(dateML(ii),2) == '07/30/15'
        start = ii;
    end
    if datestr(dateML(ii),2) == '12/31/15'
        fin = ii;
    end
end

% create subset of data for training from Jul 30, 2015 to Dec 31, 2015
train_price = price(start:fin);

% get the index from dateML for January 1, 2016 and June 30, 2016
start = 0;
fin = 0;
for ii=1:length(dateML)
    if datestr(dateML(ii),2) == '01/01/16'
        start = ii;
    end
    if datestr(dateML(ii),2) == '06/30/16'
        fin = ii;
    end
end

% create subset for actual data from Jan 1, 2016 to June 30, 2016
real_price = price(start:fin);
        
% create rx matrix
p = 2;
L = length(train_price);
r_x = zeros(1,p+1);

% aa = i - k
for aa = 0:p
    for nn =1:L-aa
        r_x(aa+1) = r_x(aa+1) + train_price(nn) * train_price(nn + aa);
    end
end

% create R matrix 
vv = r_x(1:p);
R = toeplitz(vv);

% create r vector of size p x 1 (in this case: 2 x 1)
r = r_x(2:end)';
    
% solve for predictor coefficients
a = -R\r;

rhat = filter(-[0 a'],1,price);
rhat = rhat(start:fin);

figure;
plot(1:length(real_price),real_price);
hold on
plot(1:length(real_price),rhat);
legend('Real','Predicted');
ylabel('Block Difficulty');
title('Predicted and Real Block Difficulty');
xlabel('Week');

%% 2(a)-(b) Plotting LSE vs p = [2:4:50]
err = [];
rhat_vects = cell(1,13);
count = 1;

for p = 2:4:50
    L = length(train_price);
    % create rx matrix
    r_x = zeros(1,p+1);

    % aa = i - k
    for aa = 0:p
        for nn =1:L-aa
            r_x(aa+1) = r_x(aa+1) + train_price(nn) * train_price(nn + aa);
        end
    end

    % create R matrix 
    vv = r_x(1:p);
    R = toeplitz(vv);

    % create r vector of size p x 1 
    r = r_x(2:end)';

    % solve for predictor coefficients
    a = -R\r;

    rhat = filter(-[0 a'],1,price);
    rhat = rhat(start:fin);
    
    rhat_vects{count} = rhat;
    count = count + 1;
    
    % total squared error for rhat
    tse = 0;
    for ii=1:length(real_price)
        diff = rhat(ii) - real_price(ii);
        diff_sq = diff^2;
        tse = tse + diff_sq;
    end
    
    err = [err tse];
end

figure;
plot(2:4:50,err)
title('Least Squares Error E vs P');
xlabel('P');
ylabel('Least Squared Error E');

%% 2(a)-(c) Plotting average predicted errors

avg_vects = zeros(1,13);
    
for ii = 1:13
    pred_price = rhat_vects{1,ii};
    diff_sum = pred_price - real_price;
    avg_err = diff_sum' * diff_sum / length(diff_sum);
    avg_vects(ii) = avg_err;
end
figure;        
plot(2:4:50,avg_vects);
title('Average Predicted Errors vs P');
xlabel('P');
ylabel('Average Predicted Errors');
     
%% 2(b)-(a) Prediction from Jan 1, 2017 to Dec 31, 2017 (p = 2)

% get the index from dateML for January 1, 2016 and December 31, 2016
jan_1_16 = 0;
dec_31_16 = 0;
for ii=1:length(dateML)
    if datestr(dateML(ii),2) == '01/01/16'
        jan_1_16 = ii;
    end
    if datestr(dateML(ii),2) == '12/31/16'
        dec_31_16 = ii;
    end
end

% create subset of data for training from Jan 1, 2016 to Dec 31, 2016
train_price = price(jan_1_16:dec_31_16);   

% get the index from dateML for Jan 1, 2017 to Dec 31, 2017
jan_1_17 = 0;
dec_31_17 = 0;
for ii=1:length(dateML)
    if datestr(dateML(ii),2) == '01/01/17'
        jan_1_17 = ii;
    end
    if datestr(dateML(ii),2) == '12/31/17'
        dec_31_17 = ii;
    end
end

% create subset for actual data from Jan 1, 2017 to Dec 31, 2017
real_17 = price(jan_1_17:dec_31_17);
        
% create rx matrix
p = 2;
L = length(train_price);
r_x = zeros(1,p+1);

% aa = i - k
for aa = 0:p
    for nn =1:L-aa
        r_x(aa+1) = r_x(aa+1) + train_price(nn) * train_price(nn + aa);
    end
end

% create R matrix 
vv = r_x(1:p);
R = toeplitz(vv);

% create r vector of size p x 1 
r = r_x(2:end)';
    
% solve for predictor coefficients
a = -R\r;

rhat = filter(-[0 a'],1,price);
rhat_17 = rhat(jan_1_17:dec_31_17);

figure;
plot(1:length(real_17),real_17);
hold on
plot(1:length(real_17),rhat_17);
legend('Real','Predicted');
ylabel('Block Difficulty');
title('Predicted and Real Block Difficulty from Jan 1, 2017 to Dec 31, 2017');
xlabel('Week of 2017');

%% 2(b)-(a) Prediction from Jan 1, 2018 to Dec 31, 2018 (p = 2)

% get the index from dateML for Jan 1, 2018 to Dec 31, 2018
jan_1_18 = 0;
dec_31_18 = 0;
for ii=1:length(dateML)
    if datestr(dateML(ii),2) == '01/01/18'
        jan_1_18 = ii;
    end
    if datestr(dateML(ii),2) == '12/31/18'
        dec_31_18 = ii;
    end
end

% create subset for actual data from Jan 1, 2018 to Dec 31, 2018
real_18 = price(jan_1_18:dec_31_18);
        
% create rx matrix
p = 2;
L = length(train_price);
r_x = zeros(1,p+1);

% aa = i - k
for aa = 0:p
    for nn =1:L-aa
        r_x(aa+1) = r_x(aa+1) + train_price(nn) * train_price(nn + aa);
    end
end

% create R matrix 
vv = r_x(1:p);
R = toeplitz(vv);

% create r vector of size p x 1 
r = r_x(2:end)';
    
% solve for predictor coefficients
a = -R\r;

rhat = filter(-[0 a'],1,price);
rhat_18 = rhat(jan_1_18:dec_31_18);

figure;
plot(1:length(real_18),real_18);
hold on
plot(1:length(real_18),rhat_18);
legend('Real','Predicted');
ylabel('Block Difficulty');
title('Predicted and Real Block Difficulty from Jan 1, 2018 to Dec 31, 2018');
xlabel('Week of 2018');

%% 2 (b)-(c) Average predicted errors

diff_17 = rhat_17 - real_17;
err_17 = diff_17' * diff_17 / length(diff_17);

diff_18 = rhat_18 - real_18;
err_18 = diff_18' * diff_18 / length(diff_18);

fprintf('\nAverage error generated for 2017 = %.2f\n',err_17);
fprintf('Average error generated for 2018 = %.2f\n',err_18);

%% 2 (c) Predict data from Jan 1, 2018 to June 30, 2018

% get the index from dateML for Jan 1, 2018 to Dec 31, 2018
jan_1_18 = 0;
jun_30_18 = 0;
for ii=1:length(dateML)
    if datestr(dateML(ii),2) == '01/01/18'
        jan_1_18 = ii;
    end
    if datestr(dateML(ii),2) == '06/30/18'
        jun_30_18 = ii;
    end
end

real_cc = price(jan_1_18:jun_30_18);


% (a) predicting using data from a year before

% create subset of data for training data -> one year before
train_price = price(jan_1_18-365:jan_1_18-1);   

% create rx matrix
p = 2;
L = length(train_price);
r_x = zeros(1,p+1);

% aa = i - k
for aa = 0:p
    for nn =1:L-aa
        r_x(aa+1) = r_x(aa+1) + train_price(nn) * train_price(nn + aa);
    end
end

% create R matrix 
vv = r_x(1:p);
R = toeplitz(vv);

% create r vector of size p x 1 
r = r_x(2:end)';
    
% solve for predictor coefficients
a = -R\r;

rhat = filter(-[0 a'],1,price);
rhat_1_yr = rhat(jan_1_18:jun_30_18);

diff_1_yr = rhat_1_yr - real_cc;
err_1_yr = diff_1_yr' * diff_1_yr / length(diff_1_yr);
fprintf('\nAverage predicted error for one year data: %.2f\n',err_1_yr);

% (b) predicting using data from 6 months before

% create subset of data for training data -> 6 months before
train_price = price(jan_1_18-180:jan_1_18-1);   

% create rx matrix
p = 2;
L = length(train_price);
r_x = zeros(1,p+1);

% aa = i - k
for aa = 0:p
    for nn =1:L-aa
        r_x(aa+1) = r_x(aa+1) + train_price(nn) * train_price(nn + aa);
    end
end

% create R matrix 
vv = r_x(1:p);
R = toeplitz(vv);

% create r vector of size p x 1 
r = r_x(2:end)';
    
% solve for predictor coefficients
a = -R\r;

rhat = filter(-[0 a'],1,price);
rhat_6_mths = rhat(jan_1_18:jun_30_18);

diff_6_mths = rhat_6_mths - real_cc;
err_6_mths = diff_6_mths' * diff_6_mths / length(diff_6_mths);
fprintf('\nAverage predicted error for 180 days data: %.2f\n',err_6_mths);

% (c) predicting using data from 1 month before

% create subset of data for training data -> 1 month before
train_price = price(jan_1_18-30:jan_1_18-1);   

% create rx matrix
p = 2;
L = length(train_price);
r_x = zeros(1,p+1);

% aa = i - k
for aa = 0:p
    for nn =1:L-aa
        r_x(aa+1) = r_x(aa+1) + train_price(nn) * train_price(nn + aa);
    end
end

% create R matrix 
vv = r_x(1:p);
R = toeplitz(vv);

% create r vector of size p x 1 
r = r_x(2:end)';
    
% solve for predictor coefficients
a = -R\r;

rhat = filter(-[0 a'],1,price);
rhat_1_mth = rhat(jan_1_18:jun_30_18);

diff_1_mth = rhat_1_mth - real_cc;
err_1_mth = diff_1_mth' * diff_1_mth / length(diff_1_mth);
fprintf('\nAverage predicted error for 30 days data: %.2f\n',err_1_mth);

figure;
plot(1:length(real_cc),real_cc); hold on;
plot(1:length(real_cc),rhat_1_yr); hold off;
legend('Real','One year data');
ylabel('Block Difficulty');
title('Predicted and Real Block Difficulty from Jan 1, 2018 to June 30, 2018');
xlabel('Week of 2018');

figure;
plot(1:length(real_cc),real_cc); hold on;
plot(1:length(real_cc),rhat_6_mths); hold off;
legend('Real','6 months data');
ylabel('Block Difficulty');
title('Predicted and Real Block Difficulty from Jan 1, 2018 to June 30, 2018');
xlabel('Week of 2018');

figure;
plot(1:length(real_cc),real_cc); hold on;
plot(1:length(real_cc),rhat_1_mth); hold off;
legend('Real','1 month data');
ylabel('Block Difficulty');
title('Predicted and Real Block Difficulty from Jan 1, 2018 to June 30, 2018');
xlabel('Week of 2018');

