function Axel(strategiesArray, populationsArray, matrix, rounds)
    % Axel runs an Axelrod tournament simulation.
    %
    % Inputs:
    %   strategiesArray   - Cell array or vector specifying the strategy names or types for each player.
    %   populationsArray  - Array specifying the number of players for each corresponding strategy.
    %   matrix            - 2D array (payoff matrix) defining the rewards for each possible outcome.
    %   rounds            - Integer specifying how many rounds each match in the tournament should last.
    
    % Create an axelrod tournament
    tournament = axelrod();

    % Initialize the players from the strategies and populations arrays
    tournament = tournament.InitPlayers(strategiesArray, populationsArray, rounds);

    % Initialize the tournament from the players, payoff matrix, and rounds
    tournament = tournament.initAxel(tournament.players, matrix, rounds);
    
    % Run the tournament
    tournament = tournament.begin();

    % Display the results
    disp('Tournament results:');
    disp('-------------------');
    tournament.plotResults(strategiesArray, populationsArray);
end

