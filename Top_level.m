load('djiaw_2019.mat')
djiaw = djiaw_total(:,2);

% plot of Dow Jones Industrial Average on 
% Linear and Semi-Logarithmetic Scale
part1a(djiaw);

% determine linear predictor coefficients for p=3 and N=520
[a,X] = part1b(djiaw);

% using spects from part b, plot predicted values on same set of axis
% as actual weekly average
part1c(a,X,djiaw)

% plot total squared prediction error vs p
part1d(djiaw)

% for first decade of data, determine bounds on how much you could make 
% using your predictor
part1e(djiaw)

% for last decade of data, determine bounds on how much you could make 
% using your predictor
part1f(djiaw)

load('eth_2019.mat');
block_difficulty = block_difficulty(:,2);

% uses July 30, 2015 to Dec. 31, 2015 as training data
% to predict difficulty on Jan. 1, 2016 to June 30, 2016. 
part2a(block_difficulty);
