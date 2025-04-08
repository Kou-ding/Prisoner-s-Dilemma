classdef per_cd < player

    properties
        internalState = 0; % 0: start or after D, 1: after C
    end

    methods
        % Constructor
        function obj = per_cd()
            obj@player();
        end

        function obj = setMove(obj, ~, ~)
            if (obj.internalState == 0)
                obj.move = 0; % Cooperate
                obj.internalState = 1;
            else
                obj.move = 1; % Defect
                obj.internalState = 0;
            end
        end
    end
end