% Executes numofreps meetings starting from the same 'initialstate'
function [row, m, repgenNumOfPlayersHistory] = multimultigen(p1, p2, p3, initialstate, rounds, payoff, initprobs, numofreps, alluniquestates, ngens)
    
    % Initialization of the appropriate row of the k-step (k big) transition
    % matrix
    m = zeros(1, size(alluniquestates,1));

    % Find the index of the initial state (row of the k-step (k big)
    % transition matrix)
    [~, row] = ismember(initialstate, alluniquestates,"rows");
    
    % All state evolutions starting from the same state
    repgenNumOfPlayersHistory = zeros(3 * numofreps, ngens + 1);

    % For each repetition starting from 'initialstate' find the finalstate 
    for repetition=1:numofreps

        [finalstate, genNumOfPlayersHistory] = multigen(p1, p2, p3, initialstate, rounds, payoff, initprobs, alluniquestates, ngens);
        
        % Find the index of the final state (column of the k-step (k big)
        % transition matrix)
        [~, column] = ismember(finalstate, alluniquestates,"rows");

        % Prepare row m of M^k. Add 1 for each occurence of the final state
        m(1, column) = m(1, column) + 1;

        % Add population evolution for this repetition
        repgenNumOfPlayersHistory((repetition-1)*3+1:repetition*3,:) = genNumOfPlayersHistory;

    end

    % Now that all repetitions from initialstate are performed, normalize
    % to probabilities row m
    m = m/sum(m(1,:));
