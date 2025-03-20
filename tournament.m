classdef tournament
    % Class's Properties
    properties
        players = player.empty; % Empty array of players
        rounds; % Number of rounds
        payoffMatrix = cell(2, 2); % Payoff matrix
    end
    
    % Class's Methods
    methods
        % Constructor
        function obj = tournament()
            obj.players = players.empty;
            obj.rounds = 0;
        end
        % Method to add round
        function obj = addRound(obj)
            obj.rounds = obj.rounds + 1;
        end
        % Method to play a round
        function obj = playRound(obj)
            for i = 1:length(obj.players)
                obj.players(i).move();
            end
            for i = 1:length(obj.players)
                for j = 1:length(obj.players)
                    payoff = obj.payoffMatrix{obj.players(i).history(obj.rounds), obj.players(j).history(obj.rounds)};
                    obj.players(i).addScore(payoff(1));
                    obj.players(j).addScore(payoff(2));
                end
            end
        end
        % Method to play the tournament
        function obj = playTournament(obj)
            for i = 1:obj.rounds
                obj.playRound();
            end
        end
    end
end