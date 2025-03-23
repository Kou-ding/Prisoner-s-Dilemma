classdef cooperate < player
    % Cooperate's methods
    methods
        % Constructor
        function obj = cooperate()
            obj@player();
            obj.strategy = 2;
            obj.move = 1;
        end
        
        % Always cooperate
        function obj = setMove(obj)
            obj.move = 1;
        end
    end
end