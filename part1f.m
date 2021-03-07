function part1f(djiaw)
    
    % output time range
    fprintf('\nResults for Last Decade of Data:\n');
    
    % number of weeks in investment interval
    N = 520;
    
    % calculate bank gain
    bank_gain = (1+0.03/52);
    
    % calculate upper bound
    
    % initial investment
    investment = 1000;
    
    % make 520 omniscient decisions
    for n=1:N
        
        % gain from the stock market
        DJIA_gain = djiaw(n+end-N)/djiaw(n+end-N-1);
        
        % determine investment value
        investment = max([DJIA_gain bank_gain])*investment;
    end
    
    % output upper bounds
    fprintf('\n\tUpper bound on how much you could make if you made\n');
    fprintf('\tomniscient trading decisions: $%.2f\n', investment);
    
    % dermine lower bound (all in the bank account)
    investment = 1000*bank_gain^N;
    
    % output lower bound
    fprintf('\n\tLower bound on how much you could make if you only\n');
    fprintf('\tinvested your money in the bank: $%.2f\n', investment);
    
    % determine lower bound (all money placed in stock market)
    investment = 1000*djiaw(end)/djiaw(end-N);
    
    % output lower bound
    fprintf('\n\tLower bound on how much you could make if you only\n');
    fprintf('\tinvested your money in the stock market: $%.2f\n', investment);
end