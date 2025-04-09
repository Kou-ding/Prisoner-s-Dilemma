classdef gradual < player

    properties
        punishCount = 0;
        calmCount = 0;
        totalDefections = 0;
    end

    methods
        function obj = gradual(~)
            obj@player();
        end

        function obj = setMove(obj, opponentLastMove, ~, currentround)

            if (currentround == 1)
                obj.move = 0; % Cooperate initially
                return;
            end

            % If currently punishing
            if (obj.punishCount > 0)
                obj.punishCount = obj.punishCount - 1;
                obj.move = 1; % Defect
                return;
            end

            % If currently calming
            if (obj.calmCount > 0)
                obj.calmCount = obj.calmCount - 1;
                obj.move = 0; % Cooperate
                return;
            end

            % If opponent just defected
            if (opponentLastMove == 1)
                obj.totalDefections = obj.totalDefections + 1;
                obj.punishCount = obj.totalDefections - 1;
                obj.calmCount = 2;
                obj.move = 1; % Defect
                return;
            end

            % Default behavior
            obj.move = 0; % Cooperate
        end
    end
end