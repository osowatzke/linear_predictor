function part1e(djiaw)

    % chosen value of p from part 1d
    p = 10;
    
    % number of weeks used to find linear predictor coefficients 
    N = 520;
    
    % find linear prediction coefficients using method of part 1d
    X = zeros(N-p,p);
    for n = 1:N-p
        for k = 0:p-1
            X(n,k+1) = djiaw(n+k);
        end
    end
    x = djiaw(p+1:N);
    a = -X\x;
    
    % determine upper bound of how much you could make
    
    % initial investment
    investment = 1000;
    
    % gain from bank investment
    bank_gain = (1+0.03/52);
    
    % loop makes 520 trading decisions starting at p
    for n = 1:N
        
        % gain from stock market investment
        DJIA_gain = djiaw(n+p)/djiaw(n+p-1);
        
        % calculate next value of investment
        investment = investment*max([bank_gain DJIA_gain]);
    end
    
    % output upper bounds
    fprintf('\nUpper bound on how much you could make if you made\n');
    fprintf('omniscient trading decisions: $%.2f\n', investment);
    
    % determine lower bound (all money left in bank)
    % bank_gain was calculated previously
    investment = 1000*bank_gain^N;
    
    % output lower bound
    fprintf('\nLower bound on how much you could make if you only\n');
    fprintf('invested your money in the bank: $%.2f\n', investment);
    
    % determine lower bound (all money placed in stock market)
    investment = 1000*djiaw(N+p)/djiaw(p);
    
    % output lower bound
    fprintf('\nLower bound on how much you could make if you only\n');
    fprintf('invested your money in the stock market: $%.2f\n', investment);
    
    % make trading decision using the predictor results
    
    % predicted value of x (note we have to discard p-1 samples at
    % beginning
    xhat = filter(-flip(a),1,djiaw(1:N+p-1));
    xhat = xhat(p:end);
    
    % initial investment
    investment = 1000;
    
    % loop makes 520 trading decisions
    for n=1:N
        
        % predicted gain using linear predictor
        predicted_gain = xhat(n)/djiaw(n+p-1);
        
        % stock market gain (bank gain was already calculated)
        DJIA_gain = djiaw(n+p)/djiaw(n+p-1);
        
        % determine whether to invest in bank or stock market
        if (predicted_gain > bank_gain)
            investment = DJIA_gain * investment;
        else
            investment = bank_gain * investment;
        end
    end
    
    % output results of linear predictor
    fprintf('\nHow much you if you based your decisions on\n');
    fprintf('the linear predictor: $%.2f\n', investment);
end