% Periodically plays cooperate,defect
classdef per_ccccd < player

    properties
        state = []; % per-opponent array of the player's current state number
    end

    methods
        % Constructor
        function obj = per_ccccd(numberOfPlayers)
            obj@player();
            obj.state(numberOfPlayers, 1) = 0;
        end

        function obj = setMove(obj, ~, opponentIndex, ~)
            switch obj.state(opponentIndex, 1)
                case 0
                      obj.move = 0; % Begin by cooperating 
                      obj.state(opponentIndex, 1) = 1;
                case 1
                      obj.move = 0; % Second cooperation
                      obj.state(opponentIndex, 1) = 2;
                case 2
                      obj.move = 0; % Third cooperation
                      obj.state(opponentIndex, 1) = 3;
                case 3
                      obj.move = 0; % Fourth cooperation
                      obj.state(opponentIndex, 1) = 4;
                case 4
                      obj.move = 1; % Now defect
                      obj.state(opponentIndex, 1) = 0;
            end
        end
    end
end