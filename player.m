classdef player 
    % Class's Properties
    properties
        index; % Player's index
        score; % Player's score
        history; % Empty array StrategiesxRounds
        move; % Player's move
    end

    % Class's Methods
    methods
        % Constructor
        function obj = player()
            obj.score = 0;
            obj.history = []; %tournament.Rounds
            obj.index = 0;
            obj.move = 0;
        end
        % Method to set the score
        function obj = setScore(obj, roundScore)
            obj.score = obj.score + roundScore;
        end
        % Method to get the score
        function score = getScore(obj)
            score = obj.score;
        end
        % Method to initialize the history array
        function obj = initHistory(obj, rounds, numberPlayers)
            obj.history = zeros(rounds,numberPlayers);
        end
        % Method to set the history
        function obj = setHistory(obj, round, index, move)
            obj.history(round,index) = move;
        end
        % Method to get the history
        function history = getHistory(obj, round, opponentIndex)
            history = obj.history(round, opponentIndex);
        end
        % Method to set the index
        function obj = setIndex(obj, index)
            obj.index = index;
        end
        % Method to get the index
        function index = getIndex(obj)
            index = obj.index;
        end        
    end
end