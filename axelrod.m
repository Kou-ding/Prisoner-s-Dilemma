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
            obj.payoffMatrix = {1, 2; 3, 4}; 
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
        function obj = encounter(obj, player1, player2, currentRound)
            player1.setMove(player2,history(currentRound,player1.strategy));
            player2.setMove(player1,history(currentRound,player2.strategy));
            player1.setScore(player1,obj.payoffMatrix(player1.getMove(),player2.getMove()));
            player2.setScore(player2,obj.payoffMatrix(player2.getMove(),player1.getMove()));
        end
        % Method to play a round
        function obj = playRound(obj)
            for i = 1:length(obj.players)
                for j = i:length(obj.players)
                    encounter(obj.players(i), obj.players(j));
                end
            end
        end
        % function obj = playRound(obj)
        %     for i = 1:length(obj.players)
        %         obj.players(i).move();
        %     end
        %     for i = 1:length(obj.players)
        %         for j = 1:length(obj.players)
        %             payoff = obj.payoffMatrix{obj.players(i).history(obj.rounds), obj.players(j).history(obj.rounds)};
        %             obj.players(i).addScore(payoff(1));
        %             obj.players(j).addScore(payoff(2));
        %         end
        %     end
        % end
        % Method to play the tournament
        function obj = playTournament(obj)
            for i = 1:obj.rounds
                obj.playRound();
            end
        end
    end
end