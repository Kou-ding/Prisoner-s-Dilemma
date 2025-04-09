classdef per_kind < player
  
    properties
      state = []; % 0: fresh start, 1: first C, 2: second C, 3: First D
    end 
  
  methods 
      % Constructor
      function obj = per_kind(numberOfPlayers)
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
                    obj.move = 1; % Now defect
                    obj.state(opponentIndex, 1) = 0;
          end
      end
  end
  
end 