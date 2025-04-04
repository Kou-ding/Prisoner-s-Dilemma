classdef per_nasty < player
  
    properties
      state = 0; % 0: Start by cooperating, 1: First defection, 2: Second defection
    end 
  
  methods 
      % Constructor
      function obj = per_nasty()
          obj@player();
      end
  
      function obj = setMove(obj,~,~)
          switch obj.stste
              case 0
                  obj.move = 0; % Begin by cooperating 
                  obj.state = 1;
              case 1
                  obj.move = 1; % First defection
                  obj.state = 2;
              case 2
                  obj.move = 1; % Second defection
                  obj.state = 0;
          end
      end
  end
  
end 
  