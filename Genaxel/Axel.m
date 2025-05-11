function Axel(strategiesArray, populationsArray, matrix, rounds)

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
    tournament.printResults(strategiesArray, populationsArray);
end

