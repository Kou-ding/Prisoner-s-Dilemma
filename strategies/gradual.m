    classdef gradual < player

        properties
            punishCount = [];
            calmCount = [];
            totalDefections = [];
        end

        methods
            function obj = gradual(numberOfPlayers)
                obj@player();
                obj.punishCount = zeros(numberOfPlayers, 1);
                obj.calmCount = zeros(numberOfPlayers, 1);
                obj.totalDefections = zeros(numberOfPlayers, 1);
            end

            function obj = setMove(obj, opponentLastMove, opponentIndex, currentround)
                % First round
                if (currentround == 1)
                    obj.move = 0; % Cooperate initially
                    return;
                end
                
                % Defection count
                if (opponentLastMove == 1)
                    obj.totalDefections(opponentIndex, 1) = obj.totalDefections(opponentIndex, 1) + 1;
                end

                % If currently punishing
                if (obj.punishCount(opponentIndex, 1) > 0)
                    obj.punishCount(opponentIndex, 1) = obj.punishCount(opponentIndex, 1) - 1;
                    obj.move = 1; % Defect
                    return;
                end

                % If currently calming
                if (obj.calmCount(opponentIndex, 1) > 0)
                    obj.calmCount(opponentIndex, 1) = obj.calmCount(opponentIndex, 1) - 1;
                    obj.move = 0; % Cooperate
                    return;
                end

                % If opponent defected while not punishing or calming
                if (opponentLastMove == 1 && obj.punishCount(opponentIndex, 1) == 0)
                    % Start punishing
                    obj.punishCount(opponentIndex, 1) = obj.totalDefections(opponentIndex, 1) - 1;
                    obj.calmCount(opponentIndex, 1) = 2;
                    obj.move = 1; % Defect
                    return;
                end

                % Default behavior
                obj.move = 0; % Cooperate
            end
        end
    end