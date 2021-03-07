load('djiaw_2019.mat')
djiaw = djiaw_total(:,2);

% plot of Dow Jones Industrial Average on 
% Linear and Semi-Logarithmetic Scale
part1a(djiaw);

% determine linear predictor coefficients for p=3 and N=520
a = part1b(djiaw);

