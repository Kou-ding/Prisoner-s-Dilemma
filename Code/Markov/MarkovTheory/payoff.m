% Return transition matrix M, stationary distribution π, opponent pay-offs
function [M, pi, payoff1, payoff2] = payoff(p, q, R, S, T, P)
    
    % Calculate transition matrix 
    M = transitionMatrix(p, q);

    % Solve symbolically the equations πM=π, Σπi=1, when π=[x y z t]
    % Symbolic variables
    syms x y z t;
    % Solution
    [solx, soly, solz, solt] = solve([x y z t]*M(:,1) == x, [x y z t]*M(:,2) == y,...
                                     [x y z t]*M(:,3) == z, [x y z t]*M(:,4) == t,...
                                      x + y + z + t == 1, [x y z t]);
    
    % Stationary distribution π
    pi = [solx, soly, solz, solt];

    % Long-run average expected pay-offs of the two players
    payoff1 = double(pi*[R;S;T;P]);
    payoff2 = double(pi*[R;T;S;P]);


end