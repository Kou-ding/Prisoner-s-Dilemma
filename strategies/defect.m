classdef defect < player
    % Defect's methods
    methods
        function obj = defect()
            obj@player();
        end
        
        % Always defect
        function obj = setMove(obj, ~, ~) % the second argument is not used
            obj.move = 1;
        end
    end
end