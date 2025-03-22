classdef random < player
    % Class's Properties
    properties
        strategy;
        move;
    end
    methods
        % Constructor
        function obj = random()
            obj@player();
            obj.strategy = 1;
        end

        % Make a random move
        function obj = setMove(obj)
            obj.move = randi([1, 0]);
        end
    end
end