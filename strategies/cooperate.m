classdef cooperate < player
    % Class's Properties
    properties
        strategy = 0;
    end
    methods
        % Constructor
        function obj = cooperate()
            obj@player();
            cooperate.strategy = 0;
        end
        
        function move(obj)
            move = behaviour.cooperate;
        end
    end
end