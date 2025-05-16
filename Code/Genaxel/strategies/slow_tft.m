% Cooperates on the first  move, defects after two consecutive defections,
% and returns to cooperation after two consecutive cooperations by the opponent
classdef slow_tft < player

    properties
        opponentsLasttwo = [];
    end

    methods
        % Constructor
        function obj = slow_tft(numberOfPlayers)
            
            obj@player();
            obj.opponentsLasttwo = zeros(numberOfPlayers, 2);
        end

        function obj = setMove(obj, opponentLastMove,opponenIndex, currentRound)
            
            if (currentRound == 1)
                obj.move = 0; % Start with a cooperation
            else
                obj.opponentsLasttwo(opponenIndex, 1) = obj.opponentsLasttwo(opponenIndex, 2);
                obj.opponentsLasttwo(opponenIndex, 2) = opponentLastMove;
                lastTwo = obj.opponentsLasttwo(opponenIndex, :);

                if (isequal(lastTwo, [1,1])) % Oppionent defected twice
                    obj.move = 1;
                elseif (isequal(lastTwo, [0,0])) % Opponent cooperated twice
                    obj.move = 0;
                end
            end
        end
    end
end