classdef defect < player
    % Class's Properties
    properties
        strategy;
        move;
    end
    methods
        function obj = defect()
            obj@player();
            obj.strategy = 3;
        end
        
        function obj = setMove(obj)
            obj.move = 0;
        end
    end
end