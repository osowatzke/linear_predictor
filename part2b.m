function part2b(block_difficulty)
    
    % problem specs 
    p = 2;
    L = 366; % leap year
    N = 155; % number of days until January 1st, 2016
    
    % empty array rx
    rx = zeros(1,p+1);
    
    % loop initializes rx
    for m = 0:p
        for n = N+1:N+L-m
            rx(m+1)= rx(m+1)+block_difficulty(n)*block_difficulty(n+m);
        end
    end
    
     % empty matrix R
    R = zeros(p-1,p-1);
    
    % loop initializes lower triangle of R
    for n=1:p
       for m=1:n
           R(n,m)=rx(n-m+1);
       end
    end
    
    % finish initializing R
    R = R + R'-diag(diag(R));
    
    % find vector r
    r = rx(2:end)';
    
    % solve for predictor coefficients
    a = -R\r;
    
    % predicted data
    predicted_difficulty = filter(-[0;a],1,block_difficulty);
    
    % actual difficulty from Jan. 1,2017 to Dec 31, 2017.
    x1 = block_difficulty(L+N+1:L+N+365);
    
    % predicted difficulty from Jan. 1,2017 to Dec 31, 2017.
    xhat1 = predicted_difficulty(L+N+1:L+N+365);
    
    figure(8)
    plot(1:365,x1,1:365,xhat1);
    xlabel('Days since December 31, 2016');
    title('Plot of Predicted and Actual Block Difficulty');
    legend('Actual Difficulty','Predicted Difficulty');
    
    % average predicted error for Jan. 1,2017 to Dec 31, 2017.
    %E = 
   
end