classdef defect < player
    % Defect's methods
    methods
        function obj = defect()
            obj@player();
            obj.move = 0;
        end
        
        % Always defect
        function obj = setMove(obj, ~, ~) % the second argument is not used
            obj.move = 1;
        end
    end
end