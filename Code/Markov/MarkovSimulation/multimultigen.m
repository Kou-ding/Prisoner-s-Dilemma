% Executes numofreps meetings starting from the same 'initialstate'
function [row, m] = multimultigen(p1, p2, p3, initialstate, rounds, payoff, initprobs, numofreps, alluniquestates, ngens)
    
    % Initialization of the appropriate row of the k-step (k big) transition
    % matrix
    m = zeros(1, size(alluniquestates,1));

    % Find the index of the initial state (row of the k-step (k big)
    % transition matrix)
    [~, row] = ismember(initialstate, alluniquestates,"rows");

    % For each repetition starting from 'initialstate' find the finalstate 
    for i=1:numofreps

        finalstate = multigen(p1, p2, p3, initialstate, rounds, payoff, initprobs, alluniquestates, ngens);
        
        % Find the index of the final state (column of the k-step (k big)
        % transition matrix)
        [~, column] = ismember(finalstate, alluniquestates,"rows");

        % Prepare row m of M^k. Add 1 for each occurence of the final state
        m(1, column) = m(1, column) + 1;
    end

    % Now that all repetitions from initialstate are performed, normalize
    % to probabilities row m
    m = m/sum(m(1,:));
