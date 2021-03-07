% determine linear predictor coefficients
% for p=3 and N=520
function [a,X] = part1b(djiaw)

    % problem specs
    p = 3;
    N = 520;
    
    % define empty matrix X
    X = zeros(N-p,p);
    
    % initialize matrix X
    for n = 1:N-p
        for k=0:p-1
            X(n,k+1) = djiaw(n+k);
        end
    end
    
    % calculate vector x
    x = djiaw(p+1:N);
    
    % determine linear predictor coefficients
    % emitting semicolon, outputs results to command window
    a = -X\x
end