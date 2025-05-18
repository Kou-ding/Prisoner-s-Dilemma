% Periodically plays cooperate,defect
classdef prober < player

    properties
        state = []; % per-opponent array of the player's current state number
    end

    methods
        % Constructor
        function obj = prober(numberOfPlayers)
            obj@player();
            obj.state(numberOfPlayers, 1) = 0;
        end

        function obj = setMove(obj, opponentLastMove, opponentIndex, ~)
            switch obj.state(opponentIndex, 1)
                case 0
                    obj.move = 0; % Begin by cooperating 
                    obj.state(opponentIndex, 1) = 1;
                case 1
                    obj.move = 1; % Then defects
                    obj.state(opponentIndex, 1) = 2;
                case 2
                    obj.move = 0; % Cooperates and waits to see if the opponent retaliates 
                    obj.state(opponentIndex, 1) = 3;
                case 3
                    obj.move = 1; % Defects
                    if opponentLastMove == 1
                        obj.state(opponentIndex, 1) = 4; % Adopts tit-for-tat
                    else
                        obj.state(opponentIndex, 1) = 5; % Adopts all-d
                    end
                    obj.state(opponentIndex, 1) = 3;
                % Opponent isn't exploitable -> Tit-for-tat
                case 4
                    obj.move = opponentLastMove;
                    obj.state(opponentIndex, 1) = 4;
                % Opponent is exploitable -> Defect
                case 5
                    obj.move = 1;
                    obj.state(opponentIndex, 1) = 5;
            end
        end
    end
end