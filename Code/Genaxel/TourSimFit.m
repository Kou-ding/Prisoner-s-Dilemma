function TourSimFit(b , strategies , pop0 , T , J)
    % TourSimFit simulates an evolutionary tournament using the Axelrod model.
    % 
    % Inputs:
    %   b          - Benefit parameter for the game
    %   strategies - Cell array of strategy objects or function handles
    %   pop0       - Initial population vector for each strategy
    %   T          - Number of rounds per tournament
    %   J          - Number of generations to simulate

    tournament = genaxel(); % Instantiate a genaxel tournament object

    popHistory = zeros(J, length(strategies)); % Preallocate population history matrix

    Wn = pop0; % Initialize population vector for the first generation

    % Run the tournament simulation for J generations
    for i = 1:J 
        popHistory(i,:) = Wn; % Record current generation's population
        [tournament, Wn] = tournament.SimFitness(b, strategies, Wn, T); % Simulate one generation and update population
    end

    % Plot the population dynamics over generations
    tournament.plotgen(J, popHistory, strategies); 
end    