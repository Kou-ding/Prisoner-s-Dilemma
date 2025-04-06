classdef tf2t < player

    methods
        % Constructor
        function obj = tf2t()
            obj@player();
        end
         % Cooperates on the first move, defects after two consecutive defections,
         % cooperates otherwise.
        function obj = setMove(obj, ~, currentRound)
            
            if (currentRound == 1)
                obj.move = 0; % Start by cooperating once
            else

                lasttwo = [obj.history(currentRound-2,1), obj.history(currentRound-1,1)];

                if (lasttwo == [1,1]) 
                    
                    obj.move = 1;% Opponent defected twice, so defect
                else 
                    obj.move = 0; % In any other case, cooperate
                end

            end

        end
    end
end