classdef defect < player
    % Class's Properties
    properties
        strategy = 1;
    end
    methods
        function obj = defect(name)
            obj@player(name); % Call the constructor of the parent class
        end
        
        function move(obj)
            move =  behaviour.defect;
        end
    end
end