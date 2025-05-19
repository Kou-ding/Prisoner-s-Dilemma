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
            obj.history = [];
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
        function obj = setHistory(obj, round, opponentIndex, move)
            obj.history(round,opponentIndex) = move;
        end
        % Method to get the entire history
        function history = getHistory(obj)
            history = obj.history;
        end
        % Method to get the history
        function historyElement = getHistoryElement(obj, round, opponentIndex)
            historyElement = obj.history(round, opponentIndex);
        end
        % Method to set the index
        function obj = setIndex(obj, index)
            obj.index = index;
        end
        % Method to get the index
        function index = getIndex(obj)
            index = obj.index;
        end
        % Method to get the move
        function move = getMove(obj)
            move = obj.move;
        end        
    end
end