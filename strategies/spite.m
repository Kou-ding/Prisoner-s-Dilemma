classdef spite < player
    % Mistrust's methods
    methods
         % Constructor
        function obj = spite()
            obj@player();
        end
         % Spite: Cooperates until the opponent defects, then defects all the time.
        function obj = setMove(obj, opponentsLastMove, currentRound)

            while (opponentsLastMove == 0)
                obj.move = 0;
            end

            obj.move = 1;
            
        end
    end
end