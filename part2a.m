% function uses July 30, 2015 to Dec. 31, 2015 as training data
% to predict difficulty on Jan. 1, 2016 to June 30, 2016. 
function part2a(block_difficulty)
    
    % part (a)
    
    % problem specs
    L = 155;
    p = 10;
    
    % empty array rx
    rx = zeros(1,p+1);
    
    % loop initializes rx
    for m = 0:p
        for n = 1:L-m
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
  
    % real difficulty
    real_difficulty = block_difficulty(L+1:L+182);
    
    %predicted difficulty
    predicted_difficulty = filter(-[0;a],1,block_difficulty);
    predicted_difficulty = predicted_difficulty(L+1:L+182);
    
    % plot predicted difficulty and real difficulty
    figure(5)
    plot(1:182,real_difficulty, 1:182,predicted_difficulty);
    xlabel('Days Since December 31st');
    title('Plot of Real Difficulty and Predicted Difficulty');
    legend('Real Difficulty', 'Predicted Difficulty');
    
    % part (b)
    
    % define range of p
    p = 2:4:50;
    
    % define empty array for Least Squares Error
    E = zeros(1,length(p));
    
    % loop through each value of p
    for k = 1:length(p)
        % empty array rx
        rx = zeros(1,p(k)+1);

        % loop initializes rx
        for m = 0:p(k)
            for n = 1:L-m
                rx(m+1)= rx(m+1)+block_difficulty(n)*block_difficulty(n+m);
            end
        end

        % empty matrix R
        R = zeros(p(k)-1,p(k)-1);

        % loop initializes lower triangle of R
        for n=1:p(k)
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
        
        % real difficulty
        x = block_difficulty(L+1:L+182);
    
        %predicted difficulty
        xhat = filter(-[0;a],1,block_difficulty);
        xhat = xhat(L+1:L+182);
        
        % determine least squares error
        e = x-xhat;
        E(k) = e'*e;
    end  
    
    % plot least squares error vs p
    figure(6)
    plot(p,E)
    xlabel('p');
    ylabel('E');
    title('Plot of Least Squares Error vs p');
end

