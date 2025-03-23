classdef random < player
    % Random's methods
    methods
        % Constructor
        function obj = random()
            obj@player();
            obj.move = 0;
        end

        % Make a random move
        function obj = setMove(obj, opponentLastMove)
            obj.move = randi([1, 0]);
        end
    end
end