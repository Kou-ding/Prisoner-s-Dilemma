classdef player 
    % Class's Properties
    properties
        score = 0;
    end

    % Class's Methods
    methods
        % Constructor
        function obj = player()
            obj.score = 0;
        end
        % Method to add score
        function obj = addScore(obj, score)
            obj.score = obj.score + score;
        end
    end
end