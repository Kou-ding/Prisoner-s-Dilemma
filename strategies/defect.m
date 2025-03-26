classdef defect < player
    % Defect's methods
    methods
        % Constructor
        function obj = defect()
            obj@player(); % Call the constructor of the parent class
        end
        
        % Always defect
        function obj = setMove(obj, ~, ~) % the second argument is not used
            obj.move = 1;
        end
    end
end