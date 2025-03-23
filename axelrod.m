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
            obj.players = player.empty;
            obj.rounds = 0;
            obj.currentRound = 0;
            obj.payoffMatrix = {0, 0, 0, 0}; 
        end
        
        % Initializer
        function obj = initAxel(obj, playersArray, matrix, rounds)
            % Initialize the players
            obj.setPlayers(playersArray);

            % Initialize the rounds
            obj.setRounds(rounds);

            % Initialize the payoff matrix
            obj.setPayoffMatrix(matrix);
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
            obj.currentRound = currentRound + 1;
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
        function obj = encounter(obj, player1, player2, currentRound)
            % Set the moves utilizing the opponent's history
            player1.setMove(player2.getHistory(currentRound-1,player1.getIndex())); % Previous round row 
            player2.setMove(player1.getHistory(currentRound-1,player2.getIndex())); % Opponent's index column

            % Update the scores
            player1.setScore(player1, obj.payoffMatrix{player1.move+1, player2.move+1});
            player2.setScore(player2, obj.payoffMatrix{player2.move+1, player1.move+1});
            % Update the history
            player1.setHistory(player1, currentRound, player1.getIndex(), player1.getMove());
            player2.setHistory(player2, currentRound, player2.getIndex(), player2.getMove());
        end

        % Round
        % Method to play a round
        function obj = playRound(obj)
            setCurrentRound(1);
            for i = 1:length(obj.players)-1
                for j = i+1:length(obj.players)
                    % Encounter the players
                    encounter(obj.players(i), obj.players(j), getCurrentRound(obj));
                end
            end
            % Update the current round
            setCurrentRound(obj, getCurrentRound(obj)+1);
        end

        % Method to play the tournament
        function obj = begin(obj)
            for i = 1:obj.rounds
                % Set the current round
                obj.setCurrentRound(i);

                % Play the round
                obj.playRound();
            end
            disp('Tournament finished');
            disp('Scores:');
            for i = 1:length(obj.players)
                fprintf('Player %d score: %d\n', i, obj.players(i).getScore());
            end
        end
    end
end