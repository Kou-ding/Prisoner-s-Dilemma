classdef player 
    % Class's Properties
    properties
        score = 0; % Player's score
        history = behaviour.empty; % Empty array of behaviours
    end

    % Class's Methods
    methods
        % Constructor
        function obj = player()
            obj.score = 0;
            obj.history = behaviour.empty;
        end
        % Method to add score
        function obj = addScore(obj, score)
            obj.score = obj.score + score;
        end
    end
end