classdef mistrust < player
    % Mistrust's methods
    methods
        % Constructor
        function obj = mistrust(~)
            obj@player();
        end

        % Mistrust: Defect on first move, then play what the opponent played on the previous move.
        function obj = setMove(obj, opponentsLastMove, ~, currentRound)

            if(currentRound == 1)
                obj.move = 1;
            else
                obj.move = opponentsLastMove;
            end
        end
    end
end
