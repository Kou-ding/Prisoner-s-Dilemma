% Implement two vars, previous round, previous-previous round, utilize opponentslastmove

classdef hard_tft < player

    methods
        % Constructor
        function obj = hard_tft()
            obj@player();
        end
         % Cooperates on the first two moves, defects after at least one defection in the last two rounds,
         % cooperates otherwise.
        function obj = setMove(obj, ~, currentRound)
            
            if (currentRound <= 2)
                obj.move = 0; % Start by cooperating two times
            else

                % rename...
                lasttwo = obj.history(currentRound-2,1) + obj.history(currentRound-1,1);

                if (lasttwo > 0 ) 
                    
                    obj.move = 1;% Opponent defected at least once during last two rounds, so defect
                else 
                    obj.move = 0; % In any other case, cooperate
                end

            end

        end
    end
end