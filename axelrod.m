classdef axelrod
    % Class's Properties
    properties
        players; % Empty array of players
        rounds; % Number of rounds
        currentRound; % Current round
        payoffMatrix; % Payoff matrix
    end
    
    % Class's Methods
    methods
        % Constructor
        function obj = axelrod()
            obj.players = {};
            obj.rounds = 0;
            obj.currentRound = 0;
            obj.payoffMatrix = {0, 0, 0, 0}; 
        end
        
        % Initializer
        function obj = initAxel(obj, playersArray, matrix, rounds)
            % Initialize the players
            obj = obj.setPlayers(playersArray);
            % Initialize the payoff matrix
            obj = obj.setPayoffMatrix(matrix);
            % Initialize the rounds
            obj = obj.setRounds(rounds);
        end

        % Players
        % Method to set all players
        function obj = setPlayers(obj, players)
            obj.players = players;
        end
        % Method to get the players
        function players = getPlayers(obj)
            players = obj.players;
        end
        % Method to initialize players
        function obj = InitPlayers(obj, strategiesArray, populationsArray, rounds)
            % Define function handles for each player type
            playerConstructors = containers.Map(...
                {1, 2, 3, 4, 5}, ... % Strategy numbers
                {@random, @cooperate, @defect, @tit_for_tat, @grim} ... % Corresponding constructors
            );
        
            % Calculate the total number of players
            totalPlayers = sum(populationsArray, "all");
        
            % Preallocate the players array as a cell array
            obj.players = cell(1, totalPlayers);
        
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
                        obj.players{playerIndex} = constructorHandle(totalPlayers); % Call the constructor to create a player object
                        playerIndex = playerIndex + 1; % Move to the next position in the players array
                    end
                else
                    error('Invalid strategy number: %d', strategyNumber);
                end
            end
            
            % Set the index and history matrix for each player
            for i = 1:length(obj.players)
                obj.players{i}.index = i;
                obj.players{i} = obj.players{i}.initHistory(rounds, length(obj.players));
            end
        end
        
        % Rounds
        % Method to set the number of rounds
        function obj = setRounds(obj, rounds)
            obj.rounds = rounds;
        end
        % Method to get the number of rounds
        function rounds = getRounds(obj)
            rounds = obj.rounds;
        end

        % Current Round
        % Method to set the current round
        function obj = setCurrentRound(obj, currentRound)
            obj.currentRound = currentRound;
        end
        % Method to get the current round
        function currentRound = getCurrentRound(obj)
            currentRound = obj.currentRound;
        end
        
        % Payoff Matrix
        % Method to set the payoff matrix
        function obj = setPayoffMatrix(obj, payoffMatrix)
            obj.payoffMatrix = payoffMatrix;
        end
        % Method to get the payoff matrix
        function payoffMatrix = getPayoffMatrixElement(obj, row, column)
            payoffMatrix = obj.payoffMatrix(row,column);
        end

        % Encounters
        % Method to encounter two players
        function [player1,player2] = encounter(obj, player1, player2, currentRound)
            % Avoid accessing non-existent history
            if(currentRound==1 || currentRound<1)
                % Set the player moves for the first round 
                player1 = player1.setMove(0, player2.getIndex(), currentRound); % First round
                player2 = player2.setMove(0, player2.getIndex(), currentRound); % First round
            else
                % Set the next player moves utilizing the opponent's history
                player1 = player1.setMove(player2.getHistoryElement(currentRound-1,player1.getIndex()), player2.getIndex(), currentRound); % Previous round row 
                player2 = player2.setMove(player1.getHistoryElement(currentRound-1,player2.getIndex()), player2.getIndex(), currentRound); % Opponent's index column
            end
            % Update the scores
            player1 = player1.setScore(obj.getPayoffMatrixElement(player1.move+1, player2.move+1));
            player2 = player2.setScore(obj.getPayoffMatrixElement(player2.move+1, player1.move+1));

            % Update the history
            player1 = player1.setHistory(currentRound, player2.getIndex(), player1.getMove());
            player2 = player2.setHistory(currentRound, player1.getIndex(), player2.getMove());
        end

        % Round
        % Method to play a round
        function obj = playRound(obj)
            % Simulate all the encounters
            for i = 1:length(obj.players)-1
                for j = i+1:length(obj.players)
                    % Encounter the players
                    [obj.players{i}, obj.players{j}] = obj.encounter(obj.players{i}, obj.players{j}, obj.getCurrentRound());
                end
            end
        end

        % Method to play the tournament
        function obj = begin(obj)
            for i = 1:obj.rounds
                % Set the current round
                obj = obj.setCurrentRound(i);

                % Debugging
                disp('Round finished, tournament state');
                disp(obj);
                
                for j = 1:length(obj.players)
                    fprintf('Player %d history:',j);
                    disp(obj.players{j}.getHistory());
                end

                % Play the round
                obj = obj.playRound();
            end
        end
        
        % Results
        % Method to print the results
        function printResults(obj, strategiesArray, populationsArray)
            % Calculate the total score for each player class
            playerStrategies = containers.Map(...
                {1, 2, 3, 4, 5}, ... % Strategy numbers
                {'Random', 'Cooperate', 'Defect', 'Tit for Tat', 'Grim'}... % Strategy names
            );
            totalScore = zeros(1, length(strategiesArray));
            counter = 1;
            for m = 1:length(strategiesArray)
                for j = 1:populationsArray(m)
                    totalScore(m) = totalScore(m) + obj.players{counter}.getScore();
                    counter = counter + 1;
                end
                fprintf('%s : %d points\n', playerStrategies(strategiesArray(m)), totalScore(m));
            end
        end
    end
end