% Always cooperates
classdef cooperate < player
    % Cooperate's methods
    methods
        % Constructor
        function obj = cooperate(~)
            obj@player(); % Call the constructor of the parent class
        end
        
        function obj = setMove(obj, ~, ~, ~) % the second argument is not used
            obj.move = 0;
        end
    end
end