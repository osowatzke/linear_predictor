function part1a(djiaw)
    % determine number of weeks
    num_weeks = length(djiaw);
    
    % plot Dow Jones Industrial Average on a Linear Scale
    figure(1)
    plot(1:num_weeks,djiaw);
    xlabel('Week');
    ylabel('Dow Jones Industrial Average');
    title('Plot of the Dow Jones Average on a Linear Scale');
    
    % plot Dow Jones Industrial Average on a Semi-Logarithmic Scale
    figure(2)
    semilogy(1:num_weeks,djiaw);
    xlabel('Week');
    ylabel('Dow Jones Industrial Average');
    title('Plot of the Dow Jones Average on a Semi-Logarithmic Scale');
end