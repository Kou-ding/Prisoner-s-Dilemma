classdef grim < player
    % Class's Properties
    properties
        opponentHasDefected; % Flag that indicates if the opponent has defected
    end
    % Grim's methods
    methods
        function obj = grim()
            obj@player(); % Call the constructor of the parent class
            obj.move = 1;
            obj.opponentHasDefected = 0;
        end
        
        % Cooperate until the opponent defects. Then, always defect
        function obj = setMove(obj, opponentLastMove) % the second argument is not used
            if(currentRound==1)
                obj.move = 1;
            else
                if(opponentLastMove == 0)
                    obj.opponentHasDefected = 1;
                end
                
                if(obj.opponentHasDefected == 1)
                    obj.move = 0;
                else
                    obj.move = 1;
                end
            end
        end
    end
end