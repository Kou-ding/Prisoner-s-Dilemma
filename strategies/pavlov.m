classdef pavlov < player
    % Pavlov's properties
    properties
        previousMove = []; % Store the previous move of the player  
    end
    % Pavlov's methods
    methods
         % Constructor
        function obj = pavlov(numberOfPlayers)
            obj@player();
            obj.previousMove = zeros(numberOfPlayers, 1);
        end
         % Pavlov: Cooperates on the first move, then cooperates only if the two players made the same move.
        function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)

            if(currentRound == 1)
                obj.move = 0;
                obj.previousMove(opponentIndex, 1) = obj.move; % Store the first move
            else
                if (obj.previousMove(opponentIndex, 1) == opponentLastMove)
                    obj.move = 0;
                    obj.previousMove(opponentIndex, 1) = obj.move; % Store the last move
                else 
                    obj.move = 1;
                    obj.previousMove(opponentIndex, 1) = obj.move; % Store the last move
                end
            end
        end
    end
end