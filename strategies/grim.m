classdef grim < player
    % Grim's Properties
    properties
        opponentHasDefected = []; % Flag that indicates if the opponent has defected
    end
    % Grim's methods
    methods
        function obj = grim(numberOfPlayers)
            obj@player(); % Call the constructor of the parent class
            obj.opponentHasDefected = zeros(1, numberOfPlayers); % Initialize the opponentHasDefected array
        end
        
        % Cooperate until the opponent defects. Then, always defect.
        function obj = setMove(obj, opponentLastMove, opponentIndex, currentRound)
            if(currentRound==1)
                obj.move = 0;
            else
                if(opponentLastMove == 1)
                    obj.opponentHasDefected(opponentIndex) = 1;
                end
                
                if(obj.opponentHasDefected(opponentIndex) == 1)
                    obj.move = 1;
                else
                    obj.move = 0;
                end
            end
        end
    end
end