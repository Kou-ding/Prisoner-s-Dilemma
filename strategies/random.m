classdef random < player
    % Random's methods
    methods
        % Constructor
        function obj = random()
            obj@player();
            obj.move = 0;
        end

        % Make a random move
        function obj = setMove(obj, ~) % the second argument is not used
            obj.move = randi([1, 0]);
        end
    end
end