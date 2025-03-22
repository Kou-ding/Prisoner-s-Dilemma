classdef tit_for_tat < player
    % Class's Properties
    properties
        strategy;
        move;
    end
    methods
        % Constructor
        function obj = tit_for_tat()
            obj@player();
            obj.strategy = 4;
        end
        
        function obj = setMove(strategy,round,player2)
            if(round==1)
                obj.move = 1;
            else 
                obj.move = player2.history(tournament.currentRound,strategy);
            end
        end
    end
end