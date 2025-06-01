function TourTheFit(b , strategies , pop0 , T , J, rounding )
    % TourTheFit simulates the evolution of strategies in a population using a tournament-based evolutionary game.
    %
    % Inputs:
    %     b           - Payoff parameter(s) for the game
    %     strategies  - Cell array or matrix of strategy definitions
    %     pop0        - Initial population vector for each strategy
    %     T           - Number of rounds per tournament
    %     J           - Number of generations to simulate
    %     rounding    - Rounding parameter for fitness calculation

    tournament = genaxel(); % Create a new genaxel object to manage the tournament

    popHistory = zeros(J,length(strategies)); % Preallocate matrix to store population history

    Wn = pop0; % Initialize population for generation 1
    
    tournament.static_totalplayers = sum(Wn); % Set total number of players in the tournament
    tournament = tournament.oneVone(b,strategies,T);
    % Simulate J generations
    for i = 1:J
        popHistory(i,:) = Wn ; % Record current population
        
        % Compute next generation's population using theoretical fitness
        [tournament, Wn] = tournament.TheoreticalFitness(b , strategies , Wn , T , rounding);
    end

    % Plot the evolution of strategy populations over generations
    tournament.plotgen(J , popHistory , strategies);   
                                                                    
end