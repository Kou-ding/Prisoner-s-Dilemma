classdef tit_for_tat < player
    % Class's Properties
    properties
        strategy = 2;
    end
    methods
        % Constructor
        function obj = tit_for_tat()
            obj@cooperate();
            cooperate.strategy = 0;
        end

        function obj = tit_for_tat()
            obj@player(); % Call the constructor of the parent class
        end
        
        function move(obj)
            if(round==1)
                return Behaviour.Cooperate;
            else 
                return % player.opponent_history(round-1);
        end
    end
end