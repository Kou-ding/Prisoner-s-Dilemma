addpath('strategies');

% Tweak the program's basic parameters via the script.m file
script;

function Axel(strategiesArray, populationsArray, matrix, rounds)

    function players = InitPlayers(strategiesArray, populationsArray, rounds)
        % Define function handles for each player type
        playerConstructors = containers.Map(...
            {1, 2, 3, 4, 5}, ... % Strategy numbers
            {@random, @cooperate, @defect, @tit_for_tat, @grim} ... % Corresponding constructors
        );
    
        % Calculate the total number of players
        totalPlayers = sum(populationsArray, "all");
    
        % Preallocate the players array as a cell array
        players = cell(1, totalPlayers);
    
        % Create players based on strategiesArray and populationsArray
        playerIndex = 1; % Track the current position in the players array
        for strategy = 1:length(strategiesArray)
            % Get the current strategy number
            strategyNumber = strategiesArray(strategy);
            
            % Get the population for the current strategy
            population = populationsArray(strategy);
            
            % Check if the strategy is valid
            if playerConstructors.isKey(strategyNumber)
                % Create 'population' number of players for the current strategy
                for i = 1:population
                    % Dynamically call the constructor for the current strategy
                    constructorHandle = playerConstructors(strategyNumber); % Get the function handle
                    players{playerIndex} = constructorHandle(); % Call the constructor to create a player object
                    playerIndex = playerIndex + 1; % Move to the next position in the players array
                end
            else
                error('Invalid strategy number: %d', strategyNumber);
            end
        end
        
        % Set the index and history matrix for each player
        for i = 1:length(players)
            players{i}.index = i;
            players{i} = players{i}.initHistory(rounds, length(players));
        end
    end

    % Initialize the players
    players = InitPlayers(strategiesArray, populationsArray, rounds);

    % Initialize the axelrod tournament
    tournament = axelrod();

    tournament = tournament.initAxel(players, matrix, rounds);
    disp('Tournament initialized:');
    disp(tournament);
    
    % Run the tournament
    tournament = tournament.begin();

    % Calculate the total score for each player class
    playerStrategies = containers.Map(...
        {1, 2, 3, 4, 5}, ... % Strategy numbers
        {'Random', 'Cooperate', 'Defect', 'Tit for Tat', 'Grim'}... % Strategy names
    );
    totalScore = zeros(1, length(strategiesArray));
    counter = 1;
    for m = 1:length(strategiesArray)
        for j = 1:populationsArray(m)
            totalScore(m) = totalScore(m) + tournament.players{counter}.getScore();
            counter = counter + 1;
        end
        fprintf('%s : %d points\n', playerStrategies(strategiesArray(m)), totalScore(m));
    end
end

Axel(strategiesArray, populationsArray, matrix, rounds);