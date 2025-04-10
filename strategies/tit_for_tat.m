% At first cooperate, afterwards copy your opponent's last move
classdef tit_for_tat < player
    % Tit for Tat's methods
    methods
        % Constructor
        function obj = tit_for_tat(~)
            obj@player();
        end
        
        function obj = setMove(obj, opponentLastMove, ~, currentRound)
            if(currentRound==1)
                obj.move = 0;
            else 
                obj.move = opponentLastMove;
            end
        end
    end
end