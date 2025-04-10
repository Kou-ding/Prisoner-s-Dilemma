% Makes a random move
classdef random < player
    % Random's methods
    methods
        % Constructor
        function obj = random(~)
            obj@player(); % Call the constructor of the parent class
        end

        function obj = setMove(obj, ~, ~, ~) % both arguments are not used
            obj.move = randi([0, 1]);
        end
    end
end