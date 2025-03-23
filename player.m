classdef player 
    % Class's Properties
    properties
        score; % Player's score
        history; % Empty array StrategiesxRounds
        population; % Number of players
        strategy; % Player's strategy
        move; % Player's move
    end

    % Class's Methods
    methods
        % Constructor
        function obj = player()
            obj.score = 0;
            obj.history = zeros(100,5); %tournament.Rounds
            obj.population = 0;
            obj.strategy = 0;
            obj.move = 0;
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
        % Method to get the history
        function history = getHistory(obj, strategy, round)
            history = obj.history(strategy,round);
        end
        % Method to set the population
        function obj = setPopulation(obj, population)
            obj.population = population;
        end
        % Method to get the population
        function population = getPopulation(obj)
            population = obj.population;
        end
    end
end