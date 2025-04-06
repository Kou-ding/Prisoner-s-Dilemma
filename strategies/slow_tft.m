classdef slow_tft < player

    methods
        % Constructor
        function obj = slow_tft()
            obj@player();
        end
         % Cooperates on the first two moves, defects after two consecutive defections,
         % and returns to cooperation after two consecutive cooperations by the opponent.
        function obj = setMove(obj, ~, currentRound)
            
            if (currentRound <= 2)
                obj.move = 0;
            else

                lasttwo = [obj.history(currentRound-2,1), obj.history(currentRound-1,1)];

                if (lasttwo == [1,1]) % Oppionent defected twice
                    
                    obj.move = 1;
                elseif (lasttwo == [0,0]) % Opponent cooperated twice
                    obj.move = 0;
                else 
                    %??????????????????????????????????????????????
                end

            end

        end
    end
end