classdef defect < player
    % Defect's methods
    methods
        function obj = defect()
            obj@player();
            obj.strategy = 3;
            obj.move = 0;
        end
        
        % Always defect
        function obj = setMove(obj)
            obj.move = 0;
        end
    end
end