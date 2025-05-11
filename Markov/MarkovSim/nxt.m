% S: vector of strategy total pay-offs
% n: vector of strategy populations (current state)
% nextstate: vector of next generation strategy populations
function nextstate = nxt(S, n, alluniquestates)

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
        %fprintf('Rule 00: Two strategies having no players\n');
        %fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        nextstate = remaintosamestate(n, alluniquestates);
        % Here, there are two strategies left, with their populations being non zero
    else
        % If the first of the two above strategies has a larger pay-off than the second one,
        if sortedS(1) > sortedS(2)
            %fprintf('Rule 01: Two strategies with non zero populations and different pay-offs\n');
            %fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
            probability1 = n(idx(1))/(n(idx(1))+n(idx(2)));
            probability2 = n(idx(2))/(n(idx(1))+n(idx(2)));
            rnd = randsrc(1, 1, [-1 1; probability1 probability2]);
            if rnd == -1
                nextstate = remaintosamestate(n, alluniquestates);
            else
                nextstate = transferfromXtoY(2, 1, n, idx, alluniquestates);
            end

            % Here, the two above strategies left have the same pay-off. 
        else
            %fprintf('Rule 02: Two strategies with non zero populations and same pay-offs\n');
            %fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
            probability1 = 0.5;
            probability2 = 0.5*n(idx(2))/(n(idx(1))+n(idx(2)));
            probability3 = 0.5*n(idx(1))/(n(idx(1))+n(idx(2)));
            rnd = randsrc(1, 1, [-1 0 1; probability1 probability2 probability3]);
            if rnd == -1
                nextstate = remaintosamestate(n, alluniquestates);
            elseif rnd == 0
                nextstate = transferfromXtoY(2, 1, n, idx, alluniquestates);
            else
                nextstate = transferfromXtoY(1, 2, n, idx, alluniquestates);
            end
        end
    end
else
    % Here we are left with three strategies with non-zero populations each.
    % They can all have different pay-offs
    if sortedS(1) > sortedS(2) && sortedS(2) > sortedS(3)
        %fprintf('Rule 03: Three strategies with non zero populations and different pay-offs\n');
        %fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        probability1 = n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3)));
        probability2 = n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3)));
        probability3 = n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3)));
        rnd = randsrc(1, 1, [-1 0 1; probability1 probability2 probability3]);
        if rnd == -1
            nextstate = remaintosamestate(n, alluniquestates);
        elseif rnd == 0
            nextstate = transferfromXtoY(2, 1, n, idx, alluniquestates);
        else
            nextstate = transferfromXtoY(3, 1, n, idx, alluniquestates);
        end

        % or the first two strategies can have the same pay-off
    elseif sortedS(1) == sortedS(2) && sortedS(2) > sortedS(3)
        %fprintf(['Rule 04: Three strategies with non zero populations, ' ...
        %    'the two higher pay-offs being the same\n']);
        %fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        probability1 = 0.5*((n(idx(1))+n(idx(2)))/(n(idx(1))+n(idx(2))+n(idx(3))));
        probability2 = 0.5*(n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3))));
        probability3 = 0.5*(n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3))));
        probability4 = 0.5*(n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3))));
        probability5 = 0.5*(n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3))));
        rnd = randsrc(1, 1, [1 2 3 4 5; probability1 probability2 probability3 probability4 probability5]);
        if rnd == 1
            nextstate = remaintosamestate(n, alluniquestates);
        elseif rnd == 2
            nextstate = transferfromXtoY(2, 1, n, idx, alluniquestates);
        elseif rnd == 3
            nextstate = transferfromXtoY(1, 2, n, idx, alluniquestates);
        elseif rnd == 4
            nextstate = transferfromXtoY(3, 1, n, idx, alluniquestates);
        else
            nextstate = transferfromXtoY(3, 2, n, idx, alluniquestates);
        end

        % or the two least pay-off strategies can have the same pay-off
    elseif sortedS(1) > sortedS(2) && sortedS(2) == sortedS(3)
        %fprintf('Rule 05: Three strategies with non zero populations, the two lower pay-offs being the same\n');
        %fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        probability1 = n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3)));
        probability2 = n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3)));
        probability3 = n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3)));
        rnd = randsrc(1, 1, [-1 0 1; probability1 probability2 probability3]);
        if rnd == -1
            nextstate = remaintosamestate(n, alluniquestates);
        elseif rnd == 0
            nextstate = transferfromXtoY(2, 1, n, idx, alluniquestates);
        else
            nextstate = transferfromXtoY(3, 1, n, idx, alluniquestates);
        end

        % or all three strategies can have the same pay-off
    elseif sortedS(1) == sortedS(2) && sortedS(2) == sortedS(3)
        %fprintf('Rule 06: Three strategies with non zero populations, all having the same pay-off\n');
        %fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
        probability1 = 1/3;
        probability2 = (1/3)*(n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3))));
        probability3 = (1/3)*(n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3))));
        probability4 = (1/3)*(n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3))));
        probability5 = (1/3)*(n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3))));
        probability6 = (1/3)*(n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3))));
        probability7 = (1/3)*(n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3))));
        rnd = randsrc(1, 1, [1 2 3 4 5 6 7; probability1 probability2 probability3 probability4 probability5 probability6 probability7]);
        if rnd == 1
            nextstate = remaintosamestate(n, alluniquestates);
        elseif rnd == 2
            nextstate = transferfromXtoY(2, 1, n, idx, alluniquestates);
        elseif rnd == 3
            nextstate = transferfromXtoY(3, 1, n, idx, alluniquestates);
        elseif rnd == 4
            nextstate = transferfromXtoY(1, 2, n, idx, alluniquestates);
        elseif rnd == 5
            nextstate = transferfromXtoY(3, 2, n, idx, alluniquestates);
        elseif rnd == 6
            nextstate = transferfromXtoY(1, 3, n, idx, alluniquestates);
        else
            nextstate = transferfromXtoY(2, 3, n, idx, alluniquestates);
        end
  
    end
end

% Transfer a player between two strategies
    function nextstate = transferfromXtoY(strategyX, strategyY, n, idx, alluniquestates)
        global Msim;
        currentstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
        [~, row] = ismember(n, alluniquestates,"rows");
        n(idx(strategyX)) = n(idx(strategyX)) - 1;
        n(idx(strategyY)) = n(idx(strategyY)) + 1;
        nextstate = n;
        [~, column] = ismember(nextstate, alluniquestates,"rows");
        Msim(row, column) = Msim(row, column) + 1;
        
        

        %fprintf('%s->%d %d %d', currentstate, nextstate);
        %fprintf('\n');
    end

% Remain to the same state
    function nextstate = remaintosamestate(n, alluniquestates)
        global Msim;
        currentstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
        [~, row] = ismember(n, alluniquestates,"rows");
        nextstate = n;
        [~, column] = ismember(nextstate, alluniquestates,"rows");
        Msim(row, column) = Msim(row, column) + 1;
        %fprintf('%s->%d %d %d', currentstate, nextstate);
        %fprintf('\n');
    end

end