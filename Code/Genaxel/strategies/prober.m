% Periodically plays cooperate,defect
classdef prober < player

    properties
        state = []; % per-opponent array of the player's current state number
        flag = []; % flag to indicate if the player is gullible
    end

    methods
        % Constructor
        function obj = prober(numberOfPlayers)
            obj@player();
            obj.state(numberOfPlayers, 1) = 0;
            obj.flag(numberOfPlayers, 1) = 0; % Initialize gullible flag for each opponent
        end

        function obj = setMove(obj, opponentLastMove, opponentIndex, ~)
            switch obj.state(opponentIndex, 1)
                case 0
                    obj.move = 1; % Begin by defecting 
                    obj.state(opponentIndex, 1) = 1;
                case 1
                    obj.move = 0; % Then cooperates
                    obj.state(opponentIndex, 1) = 2;
                case 2
                    obj.move = 0; % Cooperates and waits to see if the opponent has retaliated
                    obj.state(opponentIndex, 1) = 3;
                    % Set gullible flag if opponent defected
                    if opponentLastMove == 1
                        obj.flag(opponentIndex) = 1;
                    end
                case 3
                    % Set gullible flag if opponent defected
                    if opponentLastMove == 1
                        obj.flag(opponentIndex) = 1;
                    end
                    
                    % Determine behaviour based on the flag's value
                    if obj.flag(opponentIndex) == 1
                        obj.state(opponentIndex, 1) = 4; % Adopts tit-for-tat strategy
                        obj.move = opponentLastMove;
                    else
                        obj.state(opponentIndex, 1) = 5; % Adopts all-defect strategy
                        obj.move = 1;
                    end
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