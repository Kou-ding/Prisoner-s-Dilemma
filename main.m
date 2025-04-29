addpath('strategies');

% Tweak the program's basic parameters via the script.m file
script;

function TourTheFit(matrix,strategiesArray, populationsArray, rounds, generations)
    tournament = genaxel(); 
    tournament.callTourTheFit(matrix, strategiesArray, populationsArray, rounds, generations);
end


TourTheFit(matrix, strategiesArray, populationsArray, rounds, generations);


function TourSimFit(matrix, strategiesArray, populationsArray, rounds, generations)
    
    tournament = genaxel();
    tournament.callTourSimFit(matrix, strategiesArray, populationsArray, rounds, generations);
end

%TourSimFit(matrix, strategiesArray, populationsArray, rounds, generations);

function TourSimImit(matrix, strategiesArray, populationsArray, K , rounds, generations)
    
    tournament = genaxel();
    tournament.callTourSimImi(matrix, strategiesArray, populationsArray, K , rounds, generations);
end

%TourSimImit(matrix, strategiesArray, populationsArray,K, rounds, generations);


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

