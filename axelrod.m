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
            obj.payoffMatrix = {3, 1; 4, 2}; 
        end

        % Initializer
        function obj = initAxel(obj, playersArray, populationsArray, matrix, rounds)
            % Initialize the players
            for i = 1:length(obj.players)
                obj.players(i).initialize();
            end
            % Initialize the populations
            for i = 1:length(obj.players)
                obj.players(i).setPopulation(populationsArray(i));
            end
            % Initialize the rounds
            obj.setRounds(rounds);

            % Initialize the payoff matrix
            obj.payoffMatrix = matrix;
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
        % Method to get the payoff matrix
        function payoffMatrix = getPayoffMatrix(obj)
            payoffMatrix = obj.payoffMatrix;
        end
        
        % Encounters
        % Method to encounter two players
        function obj = encounter(obj, player1, player2, previousRound)
            % Set the moves
            player1.setMove(player2,history(previousRound,player1.strategy));
            player2.setMove(player1,history(previousRound,player2.strategy));

            % Update the scores
            player1.setScore(player1,obj.payoffMatrix(player1.getMove(),player2.getMove()));
            player2.setScore(player2,obj.payoffMatrix(player2.getMove(),player1.getMove()));

            % Update the history
            player1.setHistory(previousRound+1,player1.strategy,player1.getMove());
            player2.setHistory(previousRound+1,player2.strategy,player2.getMove());
        end

        % Round
        % Method to play a round
        function obj = playRound(obj)
            for i = 1:length(obj.players)
                for j = 1:length(population(i))
                    % Simulate the encounter as many times as the population of the player
                    if(i==j)
                        % (N-1)N/2 encounters
                        for k = 1:((obj.players(i).population-1)*obj.players(i).population/2)
                            encounter(obj.players(i), obj.players(j));
                        end
                    end    
                    for k = 1:(obj.players(i).population)
                        encounter(obj.players(i), obj.players(j));
                    end
                    
                end
            end
        end

        % Method to play the tournament
        function obj = begin(obj)
            for i = 1:obj.rounds
                obj.playRound();
            end
        end
    end
end