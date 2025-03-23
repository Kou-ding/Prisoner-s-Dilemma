classdef cooperate < player
    % Cooperate's methods
    methods
        % Constructor
        function obj = cooperate()
            obj@player();
            obj.move = 1;
        end
        
        % Always cooperate
        function obj = setMove(obj, opponentLastMove)
            obj.move = 1;
        end
    end
end