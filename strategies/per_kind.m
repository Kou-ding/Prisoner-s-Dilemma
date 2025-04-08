classdef per_kind < player
  
    properties
      state = 0; % 0: fresh start, 1: first C, 2: second C, 3: First D
    end 
  
  methods 
      % Constructor
      function obj = per_kind()
          obj@player();
      end
  
      function obj = setMove(obj,~,~)
          switch obj.state
              case 0
                  obj.move = 0; % Begin by cooperating 
                  obj.state = 1;
              case 1
                  obj.move = 0; % Second cooperation
                  obj.state = 2;
              case 2
                  obj.move = 1; % Now defect
                  obj.state = 0;
          end
      end
  end
  
end 