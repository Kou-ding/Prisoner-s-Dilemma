classdef tit_for_tat < player
    % Class's Properties
    properties
        strategy = 2;
    end
    methods
        % Constructor
        function obj = tit_for_tat()
            obj@player();
            tit_for_tat.strategy = 2;
        end
        
        function move(obj)
            if(round==1)
                move = behaviour.cooperate;
            else 
                move = player.opponent_history(round-1);
            end
        end
    end
end