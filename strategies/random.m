classdef random < player
    % Class's Properties
    properties
        strategy = 3;
    end
    methods
        % Constructor
        function obj = random()
            obj@player();
            random.strategy = 0;
        end

        % Make a random move
        function move(obj)
            move = randi([behaviour.cooperate, behaviour.defect]);
        end
    end
end