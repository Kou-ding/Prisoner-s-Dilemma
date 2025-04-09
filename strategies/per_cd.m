classdef per_cd < player

    properties
        state = []; % 0: start or after D, 1: after C
    end

    methods
        % Constructor
        function obj = per_cd(numberOfPlayers)
            obj@player();
            obj.state = zeros(numberOfPlayers, 1);
        end

        function obj = setMove(obj, ~, opponentIndex, ~)
            if (obj.state(opponentIndex, 1) == 0)
                obj.move = 0; % Cooperate
                obj.state(opponentIndex, 1) = 1;
            else
                obj.move = 1; % Defect
                obj.state(opponentIndex, 1) = 0;
            end
        end
    end
end