function PrisonersDilemma()
    % Fill in the payoffs
    payoffMatrix{1, 1} = [3, 2]; % Player 1 chooses X, Player 2 chooses A
    payoffMatrix{1, 2} = [0, 1]; % Player 1 chooses X, Player 2 chooses B
    payoffMatrix{2, 1} = [1, 4]; % Player 1 chooses Y, Player 2 chooses A
    payoffMatrix{2, 2} = [2, 3]; % Player 1 chooses Y, Player 2 chooses B
    
end

PrisonersDilemma();