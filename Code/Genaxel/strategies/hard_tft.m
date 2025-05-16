% Cooperates on the first two moves, defects after at least one defection in the last two rounds,
% cooperates otherwise
classdef hard_tft < player

    properties
        opponentlasttwo = [];
    end

    methods
        % Constructor
        function obj = hard_tft(numberOfPlayers)
            obj@player();
            obj.opponentlasttwo = zeros(numberOfPlayers, 2);
        end
         
        function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
            
            obj.opponentlasttwo(opponentIndex, 1) = obj.opponentlasttwo(opponentIndex, 2);
            obj.opponentlasttwo(opponentIndex, 2) = opponentLastMove;
            if (currentRound <= 2)
                obj.move = 0; % Start by cooperating two times
            else

                recent = obj.opponentlasttwo(opponentIndex, :);
                if any(recent == 1)
                    obj.move = 1; % Defect if opponent defected at least one time
                else 
                    obj.move = 0; % Otherwise, cooperate
                end    

            end

        end
    end
end