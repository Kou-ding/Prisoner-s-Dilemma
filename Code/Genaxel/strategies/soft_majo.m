% Plays the opponent's most played move, cooperates in case of equality

classdef soft_majo < player

    properties
        opponentsMovecount = []; % Per opponent, number of coops and defects
    end

    methods
        % Constructor
        function obj = soft_majo(numberOfPlayers)
            obj@player;
            obj.opponentsMovecount = zeros(numberOfPlayers,2);
        end

        function obj = setMove(obj,opponentLastMove, opponentIndex, currentRound)

            if (currentRound == 1)
                obj.move = 0;
                return;
            end

            if (opponentLastMove == 0)
                obj.opponentsMovecount(opponentIndex,1) = obj.opponentsMovecount(opponentIndex,1) + 1;
            elseif (opponentLastMove == 1)
                obj.opponentsMovecount(opponentIndex,2) = obj.opponentsMovecount(opponentIndex,2) + 1;
            end

            coops = obj.opponentsMovecount(opponentIndex, 1);
            defects = obj.opponentsMovecount(opponentIndex, 2);

            if (defects > coops)
                obj.move = 1; % Defect if opponent mostly defected
            else 
                obj.move = 0; % Cooperate otherwise(including tie)
            end
        end
    end
end


    
    
    
    
    
    


