classdef cooperate < player
    % Class's Properties
    properties
        strategy = 0;
    end
    methods
        % Constructor
        function obj = cooperate()
            obj@cooperate();
            cooperate.strategy = 0;
        end

        function obj = cooperate()
            obj@player(); % Call the constructor of the parent class
        end
        
        function move(obj)
            return Behaviour.Cooperate;
        end
    end
end