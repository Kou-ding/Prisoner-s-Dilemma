function TourSimImit(b, strategies, pop0, K, T, J)
    % TourSimImit simulates evolutionary game dynamics using imitation in tournaments.
    %
    % Inputs:
    %   b          - Payoff parameter(s) for the game
    %   strategies - Array of available strategies
    %   pop0       - Initial population distribution (vector)
    %   K          - Tournament size or selection parameter
    %   T          - Number of rounds per tournament
    %   J          - Number of generations to simulate

    tournament = genaxel(); % Instantiate a genaxel object to manage the simulation

    popHistory = zeros(J, length(strategies)); % Preallocate matrix to store population history

    Wn = pop0; % Initialize population for the first generation
    
    for i = 1:J
        popHistory(i,:) = Wn; % Record the population distribution for generation i
        % Simulate one generation using imitation dynamics and update the population
        [tournament, Wn] = tournament.ImitationSim(b, strategies, Wn, K, T);
    end
    
    % Plot the evolution of strategy frequencies over generations
    tournament.plotgen(J, popHistory, strategies);
end