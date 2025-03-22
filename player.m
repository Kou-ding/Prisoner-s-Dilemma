classdef player 
    % Class's Properties
    properties
        score; % Player's score
        history; % Empty array StrategiesxRounds
        population; % Number of players
        % strategy; % 
    end

    % Class's Methods
    methods
        % Constructor
        function obj = player()
            obj.score = 0;
            obj.history = zeros(tournamnt.Rounds,5);
            obj.population = 0;
            % obj.strategy = 0;
        end
        % Method to set the score
        function obj = setScore(obj, score)
            obj.score = obj.score + score;
        end
        % Method to get the score
        function score = getScore(obj)
            score = obj.score;
        end
        % Method to set the history
        function obj = setHistory(obj, round, player, move)
            obj.history(round,player.strategy) = move;
        end
    end
end