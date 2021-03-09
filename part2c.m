function part2c(block_difficulty)
    
    % problem specs
    p = 2;
    start_index = datenum('1/1/2018') - datenum('7/30/2015')+1;
    end_index = datenum('6/30/2018') - datenum('7/30/2015')+1;
    
    % predictor coefficient using 365 days of data
    a = lpc(block_difficulty(start_index-365:start_index-1),p);
    
    % determine predicted difficulty
    xhat = filter(-[0 a(2:end)],1,block_difficulty);
    xhat = xhat(start_index:end_index);
    
    % actual difficulty
    x = block_difficulty(start_index:end_index);
    
    % plot predicted and actual difficulty
    figure(10)
    plot(1:(end_index-start_index)+1,x,1:(end_index-start_index)+1,xhat);
    legend('Predicted Difficulty','Actual Difficulty');
    xlabel('Days Since December 31, 2017');
    title('Plot of Difficulty when 365 Days of Data is Used to Train Predictor');
    
    % average error for predictor trained with 365 days of data
    e_avg = mean((x-xhat).^2);
    
    % output results
    fprintf('\nAverage predicted error when predictor is trained\n');
    fprintf('using 365 days of data: %.2f\n', e_avg);
    
    % predictor coefficient using 180 days of data
    a = lpc(block_difficulty(start_index-180:start_index-1),p);
    
    % determine predicted difficulty
    xhat = filter(-[0 a(2:end)],1,block_difficulty);
    xhat = xhat(start_index:end_index);
    
    % actual difficulty
    x = block_difficulty(start_index:end_index);
    
    % plot predicted and actual difficulty
    figure(11)
    plot(1:(end_index-start_index)+1,x,1:(end_index-start_index)+1,xhat);
    legend('Predicted Difficulty','Actual Difficulty');
    xlabel('Days Since December 31, 2017');
    title('Plot of Difficulty when 180 Days of Data is Used to Train Predictor');
    
    % average error for predictor trained with 180 days of data
    e_avg = mean((x-xhat).^2);
    
    % output results
    fprintf('\nAverage predicted error when predictor is trained\n');
    fprintf('using 180 days of data: %.2f\n', e_avg);
    
    % predictor coefficient using 30 days of data
    a = lpc(block_difficulty(start_index-30:start_index-1),p);
    
    % determine predicted difficulty
    xhat = filter(-[0 a(2:end)],1,block_difficulty);
    xhat = xhat(start_index:end_index);
    
    % actual difficulty
    x = block_difficulty(start_index:end_index);
    
    % plot predicted and actual difficulty
    figure(12)
    plot(1:(end_index-start_index)+1,x,1:(end_index-start_index)+1,xhat);
    legend('Predicted Difficulty','Actual Difficulty');
    xlabel('Days Since December 31, 2017');
    title('Plot of Difficulty when 30 Days of Data is Used to Train Predictor');
    
    % average error for predictor trained with 30 days of data
    e_avg = mean((x-xhat).^2);
    
    % output results
    fprintf('\nAverage predicted error when predictor is trained\n');
    fprintf('using 30 days of data: %.2f\n\n', e_avg);
end