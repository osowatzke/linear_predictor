%% Load required file for part two of project

% load required file
load('eth_2019.mat');

% isolate price and date values from data set
price = block_difficulty(:,2);
dateML = block_difficulty(:,1);

%% (a) (i) p = 2

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

rhat = filter(-[a(1) a(2)],1,real_price);

figure;
plot(1:length(real_date),real_price,'r');
hold on
plot(1:length(real_date),rhat,'-.k');
legend('Real','Predicted');
ylabel('Block Difficulty');
title('Predicted and Real Block Difficulty');
xlabel('Week');

%% (a) (ii) p = [2:4:50]
err = [];

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

    rhat = filter(-[a(1) a(2)],1,real_price);
    
    arx = a' * r_x(2:end)';
    
    error = r_x(1) + arx;
    
    err = [err error];
end

plot(2:4:50,err)



        
        
        
        
        
        