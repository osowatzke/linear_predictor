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
    size(x)
    a = -X\x;
    
    % determine upper bound of how much you could make
    
    % initial investment
    investment = 1000;
    
    % loop makes 520 trading decisions starting at p
    for n = 1:520
        
        % gain from bank investment
        bank_gain = (1+0.03/52);
        
        % gain from stock market investment
        DJIA_gain = djiaw(n+p+1)/djiaw(n+p);
        
        % calculate next value of investment
        investment = investment*max([bank_gain DJIA_gain]);
    end
    
    % output upper bounds
    fprintf('\nUpper bound on how much you could make: $%.2f\n', investment);
end