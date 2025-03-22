classdef cooperate < player
    % Class's Properties
    properties
        strategy;
        move;
    end
    methods
        % Constructor
        function obj = cooperate()
            obj@player();
            obj.strategy = 2;
            obj.move = 1;
        end
        
        function obj = setMove(obj)
            obj.move = 1;
        end
    end
end