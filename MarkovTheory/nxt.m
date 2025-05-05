% S: vector of strategy total pay-offs
% n: vector of strategy populations (current state)
% nextstate: vector of next generation strategy populations
function nextstate = nxt(S, n)

% Unpack the vector S of strategy total pay-offs
SA=S(1); SB=S(2); SC=S(3);

% Sort vector S of strategy total pay-offs in descending order
[sortedS, idx] = sort(S,'descend');

% If the least pay-off strategy has no players
if n(idx(3)) == 0
    % Substract it from the sorted list
    sortedS = sortedS(1:2);
    % If also the second least pay-off strategy has no players, no state transition is
    % possible, remain in the current state
    if n(idx(2))==0
        fprintf('Rule 00: Two strategies having no players\n');
        fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        nextstate = remaintosamestate(n);
        % Here, there are two strategies left, with their populations being non zero
    else
        % If the first of the two above strategies has a larger pay-off than the second one,
        % transfer a player from the second strategy to the first one
        if sortedS(1) > sortedS(2)
            fprintf('Rule 01: Two strategies with non zero populations and different pay-offs\n');
            fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
            nextstate = transferfromXtoY(2, 1, n, idx);
            % Here, the two above strategies left have the same pay-off. Transfer from either strategy
            % to the other one with possibility 0.5
        else
            fprintf('Rule 03: Two strategies with non zero populations and same pay-offs\n');
            fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
            % Choose randomly between -1 and 1 with respective
            % probabilities 0.5
            rnd = randsrc(1, 1, [-1 1; 0.5 0.5]);
            if rnd == 1
                % Transfer a player fro the first to the second
                % strategy
                nextstate = transferfromXtoY(1, 2, n, idx);
            else
                % Transfer a player from the second to the first
                % strategy
                nextstate = transferfromXtoY(2, 1, n, idx);
            end
        end
    end
else
    % Here we are left with three strategies with non-zero populations each.
    % They can all have different pay-offs
    if sortedS(1) > sortedS(2) && sortedS(2) > sortedS(3)
        fprintf('Rule 04: Three strategies with non zero populations and different pay-offs\n');
        fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        % Transfer one player from the third to the first strategy
        nextstate = transferfromXtoY(3, 1, n, idx);

        % or the first two strategies can have the same pay-off
    elseif sortedS(1) == sortedS(2) && sortedS(2) > sortedS(3)
        fprintf(['Rule 05: Three strategies with non zero populations, ' ...
            'the two higher pay-offs being the same\n']);
        fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        % Choose randomly between -1 and 1 with respective
        % probabilities 0.5
        rnd = randsrc(1,1,[-1 1; 0.5 0.5]);
        if rnd == 1
            % Transfer a player from the third to the first
            % strategy
            nextstate = transferfromXtoY(3, 1, n,idx);
        else
            % Transfer a player from the third to the second
            % strategy
            nextstate = transferfromXtoY(3, 2, n,idx);
        end

        % or the two least pay-off strategies can have the same pay-off
    elseif sortedS(1) > sortedS(2) && sortedS(2) == sortedS(3)
        fprintf('Rule 06: Three strategies with non zero populations, the two lower pay-offs being the same\n');
        fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        % Choose randomly between -1 and 1 with respective
        % probabilities 0.5
        rnd = randsrc(1,1,[-1 1; 0.5 0.5]);
        if rnd == 1
            % Transfer a player from the second to the first
            % strategy
            nextstate = transferfromXtoY(2, 1, n, idx);
        else
            % Transfer a player from the third to the first
            % strategy
            nextstate = transferfromXtoY(3, 1, n, idx);
        end

        % or all three strategies can have the same pay-off
    elseif sortedS(1) == sortedS(2) && sortedS(2) == sortedS(3)
        fprintf('Rule 07: Three strategies with non zero populations, all having the same pay-off\n');
        fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        % Choose randomly between 1, 2, 3, 4, 5, 6, with respective
        % probabilities 1/6
        rnd = randsrc(1,1,[ 1 2 3 4 5 6; 1/6 1/6 1/6 1/6 1/6 1/6]);
        % All combinations from/to are possible with probability
        % 1/6 each
        switch(rnd)
            case 1
                nextstate = transferfromXtoY(1, 2, n,idx);
            case 2
                nextstate = transferfromXtoY(1, 3, n,idx);
            case 3
                nextstate = transferfromXtoY(2, 1, n,idx);
            case 4
                nextstate = transferfromXtoY(2, 3, n,idx);
            case 5
                nextstate = transferfromXtoY(3, 1, n,idx);
            case 6
                nextstate = transferfromXtoY(3, 2, n,idx);
        end
    end
end

% Transfer a player between two strategies
    function nextstate = transferfromXtoY(strategyX, strategyY, n, idx)
        currentstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
        n(idx(strategyX)) = n(idx(strategyX)) - 1;
        n(idx(strategyY)) = n(idx(strategyY)) + 1;
        nextstate = n;
        fprintf('%s->%d %d %d', currentstate, nextstate);
        fprintf('\n');
    end

% Remain to the same state
    function nextstate = remaintosamestate(n)
        currentstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
        nextstate = n;
        fprintf('%s->%d %d %d', currentstate, nextstate);
        fprintf('\n');
    end

end