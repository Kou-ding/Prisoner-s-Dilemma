classdef tit_for_tat < player
    % Tit for Tat's methods
    methods
        % Constructor
        function obj = tit_for_tat()
            obj@player();
            obj.move = 1;
        end
        
        % At first cooperate. Afterwards copy your opponent's last move
        function obj = setMove(obj, opponentLastMove)
            if(round==1)
                obj.move = 1;
            else 
                obj.move = opponentLastMove;
            end
        end
    end
end