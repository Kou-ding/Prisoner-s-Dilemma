classdef pavlov < player
    % Mistrust's methods
    methods
         % Constructor
        function obj = pavlov()
            obj@player();
        end
         % Pavlov:  Cooperates on the first move, then cooperates only if the two players made the same move.
        function obj = setMove(obj, opponentsLastMove, currentRound)

            if(currentRound == 1)
                obj.move = 0;
            else
                if (obj.move == opponentsLastMove)
                    obj.move = 0;
                else 
                    obj.move = 1;
                end
            end
        end
    end
end