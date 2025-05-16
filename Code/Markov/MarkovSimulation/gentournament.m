% Perform a tournament (meeting)
% Returns the total scores of the strategies and the nextstate 
function [nextstate, tournamentscores] = gentournament(p1, p2, p3, currentstate, rounds, payoff, initprobs, alluniquestates)
    
    % Players of each strategy for the current state (generation-tournament-meeting)
    n1 = currentstate(1); n2 = currentstate(2); n3 = currentstate(3);

    % Initialization of the total strategy scores
    tournamentscores = zeros(1,3);

    % Play all matches between strategy 1 vs strategy 1 players
    for i = 1:n1*(n1-1)/2
        firstX = randsrc(1,1, [0 1; initprobs(1) 1-initprobs(1)]);
        firstY = randsrc(1,1, [0 1; initprobs(1) 1-initprobs(1)]);
        CprobsX = randomplay(rounds, p1);
        CprobsY = randomplay(rounds, p1);
        [XYchoices, matchscores] = playmatch(rounds, firstX, CprobsX, firstY, CprobsY, payoff);
        tournamentscores(1) = tournamentscores(1) + matchscores(1) + matchscores(2);
    end

        % Play all matches between strategy 1 vs strategy 2 players
    for i = 1:n1*n2
        firstX = randsrc(1,1, [0 1; initprobs(1) 1-initprobs(1)]);
        firstY = randsrc(1,1, [0 1; initprobs(2) 1-initprobs(2)]);
        CprobsX = randomplay(rounds, p1);
        CprobsY = randomplay(rounds, p2);
        [XYchoices, matchscores] = playmatch(rounds, firstX, CprobsX, firstY, CprobsY, payoff);
        tournamentscores(1) = tournamentscores(1) + matchscores(1);
        tournamentscores(2) = tournamentscores(2) + matchscores(2);
    end

    % Play all matches between strategy 1 vs strategy 3 players
    for i = 1:n1*n3
        firstX = randsrc(1,1, [0 1; initprobs(1) 1-initprobs(1)]);
        firstY = randsrc(1,1, [0 1; initprobs(3) 1-initprobs(3)]);
        CprobsX = randomplay(rounds, p1);
        CprobsY = randomplay(rounds, p3);
        [XYchoices, matchscores] = playmatch(rounds, firstX, CprobsX, firstY, CprobsY, payoff);
        tournamentscores(1) = tournamentscores(1) + matchscores(1);
        tournamentscores(3) = tournamentscores(3) + matchscores(2);
    end

        % Play all matches between strategy 2 vs strategy 2 players
    for i = 1:n2*(n2-1)/2
        firstX = randsrc(1,1, [0 1; initprobs(2) 1-initprobs(2)]);
        firstY = randsrc(1,1, [0 1; initprobs(2) 1-initprobs(2)]);
        CprobsX = randomplay(rounds, p2);
        CprobsY = randomplay(rounds, p2);
        [XYchoices, matchscores] = playmatch(rounds, firstX, CprobsX, firstY, CprobsY, payoff);
        tournamentscores(2) = tournamentscores(2) + matchscores(1) + matchscores(2);
    end

        % Play all matches between strategy 2 vs strategy 3 players
    for i = 1:n2*n3
        firstX = randsrc(1,1, [0 1; initprobs(2) 1-initprobs(2)]);
        firstY = randsrc(1,1, [0 1; initprobs(3) 1-initprobs(3)]);
        CprobsX = randomplay(rounds, p2);
        CprobsY = randomplay(rounds, p3);
        [XYchoices, matchscores] = playmatch(rounds, firstX, CprobsX, firstY, CprobsY, payoff);
        tournamentscores(2) = tournamentscores(2) + matchscores(1);
        tournamentscores(3) = tournamentscores(3) + matchscores(2);
    end

    % Play all matches between strategy 3 vs strategy 3 players
    for i = 1:1:n3*(n3-1)/2
        firstX = randsrc(1,1, [0 1; initprobs(3) 1-initprobs(3)]);
        firstY = randsrc(1,1, [0 1; initprobs(3) 1-initprobs(3)]);
        CprobsX = randomplay(rounds, p3);
        CprobsY = randomplay(rounds, p3);
        [XYchoices, matchscores] = playmatch(rounds, firstX, CprobsX, firstY, CprobsY, payoff);
        tournamentscores(3) = tournamentscores(3) + matchscores(1) + matchscores(2);
    end

    % Now that we now the total scores of all the strategies, we find the next state by calling nxt() 
    nextstate = nxt(tournamentscores, currentstate, alluniquestates);
end