% Cooperates on the first move, defects after two consecutive opponent defections,
% cooperates otherwises
classdef tf2t < player

    properties
        opponentlasttwo = [];
    end

    methods
        % Constructor
        function obj = tf2t(numberOfPlayers)
            obj@player();
            obj.opponentlasttwo = zeros(numberOfPlayers, 2);
        end
         
        function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
            obj.opponentlasttwo(opponentIndex, 1) = obj.opponentlasttwo(opponentIndex, 2);
            obj.opponentlasttwo(opponentIndex, 2) = opponentLastMove;
            if (currentRound == 1)
                obj.move = 0; % Start by cooperating 
            else
                lastTwo = obj.opponentlasttwo(opponentIndex,:);
                if (isequal(lastTwo, [1,1]))
                    obj.move = 1;
                else
                    obj.move = 0;
                end
            end
        end
    end
end

            