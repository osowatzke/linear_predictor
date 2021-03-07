% function to plot DJIA and compare investing $1000 in the stock market to
% investing $1000 in the bank with %3 APR
function part1a(djiaw)

    % determine number of weeks
    num_weeks = length(djiaw);
    
    % plot Dow Jones Industrial Average on a Linear Scale
    figure(1)
    plot(1:num_weeks,djiaw);
    xlabel('Week');
    ylabel('Dow Jones Industrial Average');
    title('Plot of the Dow Jones Average on a Linear Scale');
    
    % plot Dow Jones Industrial Average on a Semi-Logarithmic Scale
    figure(2)
    semilogy(1:num_weeks,djiaw);
    xlabel('Week');
    ylabel('Dow Jones Industrial Average');
    title('Plot of the Dow Jones Average on a Semi-Logarithmic Scale');
    
    % if you had put all your money in the stock market, determine how 
    % much you would have at the end of the investment interval
    value = djiaw(end)/djiaw(1)*1000;
    fprintf('If you invested $1000 in the stock market, you would have\n');
    fprintf('$%.2f at the end of investment interval (%d weeks)\n', ...
        value, num_weeks-1);
    
    % if you had put all your money in the bank, determine how many weeks
    % it would take to earn as much as the DJIA?
    r = 0.03;
    N = log(value/1000)/log(1+r/52);
    fprintf('\nIf you invested $1000 in the bank at %%3 APR, it would take\n');
    fprintf('%d weeks to earn as much as the DJIA\n', round(N))
    
    % if you had put all your money in the bank, determine what APR would 
    % you need to make the same amount
    r = 52*((value/1000)^(1/(num_weeks-1))-1);
    fprintf('\nIf you invested $1000 in the bank for %d weeks,\n', num_weeks-1);
    fprintf('you would need an APR of %.2f%% to earn as much as the DJIA\n', 100*r);
end