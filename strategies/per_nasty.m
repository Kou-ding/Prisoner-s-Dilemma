classdef per_nasty < player
  
    properties
      state = 0; % 0: Start by defecting, 1: Second defection, 2: Finally, cooperate
    end 
  
  methods 
      % Constructor
      function obj = per_nasty()
          obj@player();
      end
  
      function obj = setMove(obj,~,~)
          switch obj.state
              case 0
                  obj.move = 1; % Begin by defecting 
                  obj.state = 1;
              case 1
                  obj.move = 1; % Second defection
                  obj.state = 2;
              case 2
                  obj.move = 0; % Finally, cooperate
                  obj.state = 0;
          end
      end
  end
  
end 
  