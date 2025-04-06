classdef soft_majo < player
    
    methods
        % Constructor
        function obj = soft_majo()
            obj@player;
        end

        function obj = setMove(obj, ~, currentRound)

            if (currentsround == 1)
                obj.move = 0; % Cooperate on the first move
                return;
            end

            % Get all past opponent moves
            pastMoves = obj.history(1:currentRound-1, 1);
            coopCount = sum(pastMoves == 0) % Cooperations
            defectCount = sum(pastMoves == 1) % Defections


            if (defectCount > coopCount)
                obj.move = 1; % If opponent mostly defected, defect
            else
                obj.move = 0; % Otherwise cooperate (including tie)
            end
        end
    end
end


    
    
    
    
    
    



