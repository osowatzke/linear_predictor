% function plots predicted values vs actual values
% and determine total square error
function part1c(a, X, djiaw)
    
    % specifications for part 1b
    p = 3;
    N = 520;
    
    % predicted values
    xhat1 = -X*a;
    
    % plot actual values vs predicted values
    figure(3)
    plot(p+1:N, xhat1, p+1:N, djiaw(p+1:N));
    legend('Predicted Values', 'Actual Weekly Average');
    xlabel('Week')
    title('Plot of Predicted Values and Actual Weekly Averages');
    
    % determine total squared error with xhat1
    x = djiaw(p+1:N);
    e1 = x-xhat1;
    E1 = e1'*e1;
    
    % output total squared error using xhat1
    fprintf('Total Squared Error using xhat1: %.2f\n', E1)
    
    % determine xhat2
    xhat2 = filter(-flip(a),1,djiaw(1:N-1));
    
    % filter returns initial part of convolution
    % we must get rid of p-1 samples
    xhat2 = xhat2(p:end);
    
    % determine total squared error with xhat2
    e2 = x-xhat2;
    E2 = e2'*e2;
    
    % output total squared error using xhat2
    fprintf('\nTotal Squared Error using xhat2: %.2f\n', E2)
    
end