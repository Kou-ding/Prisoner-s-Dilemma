% Periodically plays defect, defect, cooperate
classdef per_nasty < player
  
    properties
        state = []; % 0: Start by defecting, 1: Second defection, 2: Finally, cooperate
    end 
  
    methods 
        % Constructor
        function obj = per_nasty(numberOfPlayers)
            obj@player();
            obj.state = zeros(numberOfPlayers, 1); % Initialize state for one opponent
        end

        function obj = setMove(obj, ~, opponentIndex, ~)
            switch obj.state(opponentIndex, 1)
                case 0
                    obj.move = 1; % Begin by defecting 
                    obj.state(opponentIndex, 1) = 1;
                case 1
                    obj.move = 1; % Second defection
                    obj.state(opponentIndex, 1) = 2;
                case 2
                    obj.move = 0; % Finally, cooperate
                    obj.state(opponentIndex, 1) = 0;
            end
        end
    end
end 
  