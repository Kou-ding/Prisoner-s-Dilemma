classdef grim < player
    % Class's Properties
    properties
        strategy;
        move;
        opponentHasDefected;
    end
    methods
        function obj = grim()
            obj@player(); % Call the constructor of the parent class
            obj.strategy = 5;
            obj.opponentHasDefected = 0;
            obj.move = 1;
        end
        
        % Set the move
        function obj = setMove(obj,player2,currentRound)
            if(currentRound==1)
                obj.move = 1;
            else
                if(player2.history(tournament.currentRound,player2) == 0)
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