classdef tournament
    % Class's Properties
    properties
        players;
        rounds; 
        opponent_history; % 0: defect, 1: cooperate
    end
    
    % Class's Methods
    methods
        % Constructor
        function obj = tournament(players)
            obj.players = players;
            obj.rounds = 0;
        end
        % Method to add round
        function obj = addRound(obj)
            obj.rounds = obj.rounds + 1;
        end
        % Method to play a round
        
    end
end