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
            % % Debugging
            % disp('Player 1 history:');
            % disp(player1.getHistory());
            % disp('Player 1 move:');
            % disp(player1.getMove());

            if(currentRound==1 || currentRound<1)
                % Set the player moves for the first round 
                player1 = player1.setMove(0); % First round
                player2 = player2.setMove(0); % First round
            else
                % Set the next player moves utilizing the opponent's history
                player1 = player1.setMove(player2.getHistoryElement(currentRound-1,player1.getIndex())); % Previous round row 
                player2 = player2.setMove(player1.getHistoryElement(currentRound-1,player2.getIndex())); % Opponent's index column
            end
            % Update the scores
            player1 = player1.setScore(obj.getPayoffMatrixElement(player1.move+1, player2.move+1));
            player2 = player2.setScore(obj.getPayoffMatrixElement(player2.move+1, player1.move+1));

            % Update the history
            player1 = player1.setHistory(currentRound, player2.getIndex(), player1.getMove());
            player2 = player2.setHistory(currentRound, player1.getIndex(), player2.getMove());
            
            % % Debugging
            % disp('Player 1:\n');
            % disp(player1)
            % disp('Player 1:\n');
            % disp(player2);
            % fprintf('Player %d score: %d\n', player1.getIndex(), player1.getScore());
            % fprintf('Player %d score: %d\n', player2.getIndex(), player2.getScore());
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

                % Play the round
                obj = obj.playRound();

                % % Debugging
                % disp('Round finished, tournament state');
                % disp(obj);
                %
                % for j = 1:length(obj.players)
                %     fprintf('Player %d history:',j);
                %     disp(obj.players{j}.getHistory());
                % end
            end
            disp('Tournament finished');
            disp('Scores:');
            for i = 1:length(obj.players)
                fprintf('Player %d score: %d\n', i, obj.players{i}.getScore());
            end  
        end
        
    end
end