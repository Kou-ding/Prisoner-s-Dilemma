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
            % Set the moves
            player1.setMove(player1, player2.getHistory(currentRound-1,player1.getIndex())); % Previous round row 
            player2.setMove(player2, player1.getHistory(currentRound-1,player2.getIndex())); % Opponent's index column

            % Update the scores
            player1.setScore(player1,obj.getPayoffMatrixElement(obj,player1.getMove(),player2.getMove()));
            player2.setScore(player2,obj.getPayoffMatrixElement(obj,player2.getMove(),player1.getMove()));

            % Update the history
            player1.setHistory(currentRound,player1.strategy,player1.getMove());
            player2.setHistory(currentRound,player2.strategy,player2.getMove());
        end

        % Round
        % Method to play a round
        function obj = playRound(obj)
            for i = 1:length(obj.players)
                for j = i:length(obj.players)
                    % % Simulate the encounter as many times as the population of the player
                    % if(i==j)
                    %     % (N-1)N/2 encounters where N is the population
                    %     for k = 1:((obj.players(i).population-1)*obj.players(j).population/2)
                    %         encounter(obj.players(i), obj.players(j));
                    %     end
                    % else
                    %     % N1*N2 encounters where N1 and N2 are the populations of the players
                    %     for k = 1:(obj.players(i).population*obj.players(j).population)
                    %         encounter(obj.players(i), obj.players(j));
                    %     end
                    % end
                    encounter(obj.players(i), obj.players(j), getCurrentRound(obj));
                end
            end
            setCurrentRound(obj, getCurrentRound(obj));
        end

        % Method to play the tournament
        function obj = begin(obj)
            for i = 1:obj.rounds
                % Set the current round
                obj.setCurrentRound(obj, i);

                % Play the round
                obj.playRound();
            end
            disp('Tournament finished');
            disp('Scores:');
            for i = 1:length(obj.players)
                disp('Player ' + i + 'score:\n');
                disp(obj.players(i).getScore());
            end
        end
    end
end