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
    
    % number of linear predictor coefficients
    p = 10;
    
    % determine matrix X
    X = zeros(N-p,p);
    for n = 1:N-p
        for k = 0:p-1
            X(n,k+1) = djiaw(n+k);
        end
    end
    
    % determine vector x
    x = djiaw(p+1:N);
    
    % determine linear predictor coefficients
    % identical to coefficients in part 1e
    a = -X\x;
    
    % determine predicted values
    % note the omission of p-1 coefficients
    xhat = filter(-flip(a),1,djiaw(end-N-p+1:end-1));
    xhat = xhat(p:end);
    
    plot(1:N,xhat,1:N,djiaw(end-N+1:end))
    
    % initial investment
    investment = 1000;
    
    % loop makes 520 trading decisions
    for n=1:N
        
        % predicted gain using linear predictor
        predicted_gain = xhat(n)/djiaw(n+end-N-1);
        
        % stock market gain (bank gain was already calculated)
        DJIA_gain = djiaw(n+end-N)/djiaw(n+end-N-1);
        
        % determine whether to invest in bank or stock market
        if (predicted_gain > bank_gain)
            investment = DJIA_gain * investment;
        else
            investment = bank_gain * investment;
        end
    end
    
    % output results of linear predictor
    fprintf('\n\tHow much you would make if you based your\n');
    fprintf('\tdecisions on the linear predictor: $%.2f\n', investment);
    
end