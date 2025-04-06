classdef gradual < player

    properties
        punishQueue = 0;
        calmSteps =0;
    end

    methods
        function obj = gradual()
          obj@player();
        end

        function obj = setMove(obj, opponentLastMove, currentround)
            
            if (currentround == 1)
                obj.move = 0; % Always cooperate on the first move
                return; % Skip the rest of the logic
            end

            if (opponentLastMove == 1)
                obj.punishQueue = obj.punishQueue + 1; % Add one punishment to the queue
            end

            if (obj.punishQueue > 0) % Punishments are queued. Defect, decrease the queue by one
                obj.move = 1;
                obj.punishQueue = obj.punishQueue - 1;
               
                if (obj.punishQueue == 0) 
                  obj.calmSteps = 2; % Enter calming phase
                end
            elseif (obj.calmSteps > 0)
                obj.move = 0; % Cooperate
                obj.calmSteps = obj.calmSteps - 1;
            else
                obj.move = 0; % If calm,default to cooperation ???
            end
        end
    end
end

               




