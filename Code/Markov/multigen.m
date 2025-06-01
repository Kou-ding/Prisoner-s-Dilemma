% Performs all meetings (many generations) until the final state
function [finalstate, genNumOfPlayersHistory] = multigen(p1, p2, p3, initialstate, rounds, payoff, initprobs, alluniquestates, ngens)

    % fprintf('(%d, %d, %d)\n',initialstate);
    
    % History of population evolution for the meeting (tournament)
    genNumOfPlayersHistory = zeros(3, ngens+1);
    genNumOfPlayersHistory(:,1) = initialstate';

    % Repeat for every generation and call gentournament() to play a
    % meeting
    for i=1:ngens
          [nextstate, tournamentscores] = gentournament(p1, p2, p3, initialstate, rounds, payoff, initprobs, alluniquestates);
          % fprintf('(%d, %d, %d)\n',nextstate);
          % fprintf('(%.4f, %.4f, %.4f)\n\n',tournamentscores);
          % 'nextstate' is becoming the next 'initialstate' for the next round
          initialstate = nextstate;
          genNumOfPlayersHistory(:,i+1) = nextstate';
    end
    
    % Hopefully, after ngens generations we have reached the final state
    finalstate = nextstate;
end