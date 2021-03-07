% function to plot total squared prediction error vs p 
% for p = 1:10
function part1d(djiaw)
    
    % define range of p 
    p = 1:10;
    
    % number of weeks worth of data
    N = 520;
    
    % empty error for total squared prediction error values
    E = zeros(1,length(p));
    
    % loop computs total squared prediction error for each value of p
    for k = 1:length(p)
        
        % empty matrix X
        X = zeros(N-p(k),p(k));
        
        % initialize matrix X
        for n = 1:N-p(k)
            for m = 0:p(k)-1
                X(n,m+1) = djiaw(n+m);
            end
        end
        
        % compute resulting vector x
        x = djiaw(p(k)+1:N);
        
        % compute linear predictor coefficients
        a = -X\x;
        
        % determine predicted value
        xhat = -X*a;
        
        % determine total squared prediction error
        e = x-xhat;
        E(k) = e'*e;
    end
    
    % plot results
    figure(4)
    plot(p,E)
    xlabel('p');
    ylabel('Total Squared Prediction Error');
    title('Plot of Total Squared Prediction Error vs p');
    
end