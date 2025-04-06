classdef random < player
    % Random's methods
    methods
        % Constructor
        function obj = random()
            obj@player();
        end

        % Make a random move
        function obj = setMove(obj, ~, ~) % the second and third arguments are not used
            obj.move = randi([0, 1]);
        end
    end
end