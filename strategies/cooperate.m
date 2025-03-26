classdef cooperate < player
    % Cooperate's methods
    methods
        % Constructor
        function obj = cooperate()
            obj@player();
        end
        
        % Always cooperate
        function obj = setMove(obj, ~, ~) % the second argument is not used
            obj.move = 0;
        end
    end
end