classdef Behaviour
    enumeration
        Cooperate (0)
        Defect (1)
    end
end

classdef player 
    % Class's Properties
    properties
        score = 0;
    end

    % Class's Methods
    methods
        % Constructor
        function obj = Player()
            obj.score = 0;
        end
        % Method to add score
        function obj = addScore(obj, score)
            obj.score = obj.score + score;
        end
    end
end