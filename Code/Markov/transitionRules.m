function [allcurrentstates, allnextstates, allprobs] = transitionRules(Ps, N, roundsth)

    % Minimum and maximum number of a strategy's population in a generation
    nmin = 0;
    nmax = N;

    % Vectors to store all current states with the respective next states 
    % and the respective probabilities for the state transitions
    allcurrentstates=[];
    allnextstates=[];
    allprobs=[];
    
    % Find all triplets (n1, n2, n3) that satisfy a rule between the strategy
    % pay-offs (i.e. SCA > SCB > SCC) This will determene the permissible state
    % transitions
    % For each n1 from nmin to nmax
    for n1 = nmin:nmax
        % For each n2 from nmin to nmax-n1
        for n2 = nmin:nmax-n1
            % n3 is the rest from nmax
            n3 = nmax - n2 - n1;
            
            % Vector of strategy populations
            n = [n1, n2, n3];
    
            % Strategy pay-offs
            [SA, SB, SC] = strategyPayoffs(Ps, n, roundsth);
    
            S = [SA, SB, SC];
    
            % Sort vector S of strategy pay-offs
            [sortedS, idx] = sort(S,'descend');
            
            % If the least pay-off strategy has 0 players 
            if n(idx(3)) == 0
                % Take it out of the sorted list
                sortedS = sortedS(1:2);
                % If the second least pay-off strategy also has 0 players, no move is
                % possible, stay in the same state
                if n(idx(2))==0
                   fprintf('Rule 00: Two strategies with zero players\n');
                   fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
                   probability = 1;
                   [allcurrentstates,allnextstates,allprobs] = remaintosamestate(probability,n,allcurrentstates,allnextstates,allprobs);
                % Here, there are two strategies left with non 0 players
                else
                   % If the first one has a larger pay-off than the second one 
                   if sortedS(1) > sortedS(2)
                       fprintf('Rule 01: Two strategies with non zero players and different pay-offs\n');
                       fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
                       probability = n(idx(1))/(n(idx(1))+n(idx(2)));
                       [allcurrentstates,allnextstates,allprobs] = remaintosamestate(probability,n,allcurrentstates,allnextstates,allprobs);
                       probability = n(idx(2))/(n(idx(1))+n(idx(2)));
                       [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(2, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                   % Here, the two strategies left have the same pay-off 
                   else
                       fprintf('Rule 02: Two strategies with non zero players and same pay-offs\n');
                       fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
                       probability = 0.5;
                       [allcurrentstates,allnextstates,allprobs] = remaintosamestate(probability,n,allcurrentstates,allnextstates,allprobs);
                       probability = 0.5*n(idx(2))/(n(idx(1))+n(idx(2)));
                       [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(2, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                       probability = 0.5*n(idx(1))/(n(idx(1))+n(idx(2)));
                       [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(1, 2, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                   end    
                end
            else
                % Here we have three strategies with non-zero players each.
                % They can all have different pay-offs
                if sortedS(1) > sortedS(2) && sortedS(2) > sortedS(3)
                    fprintf('Rule 03: Three strategies with non zero players and different pay-offs\n');
                    fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
                    probability = n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3)));
                    [allcurrentstates,allnextstates,allprobs] = remaintosamestate(probability,n,allcurrentstates,allnextstates,allprobs);
                    probability = n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3)));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(2, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3)));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(3, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                
                % or the first two have the same pay-off
                elseif sortedS(1) == sortedS(2) && sortedS(2) > sortedS(3)
                    fprintf('Rule 04: Three strategies with non zero players, the two higher pay-offs are the same\n');
                    fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
                    probability = 0.5*((n(idx(1))+n(idx(2)))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = remaintosamestate(probability,n,allcurrentstates,allnextstates,allprobs);
                    probability = 0.5*(n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(2, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = 0.5*(n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(1, 2, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = 0.5*(n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(3, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = 0.5*(n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(3, 2, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                % or the last two have the same pay-off
                elseif sortedS(1) > sortedS(2) && sortedS(2) == sortedS(3)
                    fprintf('Rule 05: Three strategies with non zero players, the two lower pay-offs are the same\n');
                    fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
                    probability = n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3)));
                    [allcurrentstates,allnextstates,allprobs] = remaintosamestate(probability,n,allcurrentstates,allnextstates,allprobs);
                    probability = n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3)));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(2, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3)));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(3, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                
                % or all have the same pay-off
                elseif sortedS(1) == sortedS(2) && sortedS(2) == sortedS(3)
                    fprintf('Rule 06: Three strategies with non zero players all having the same pay-off\n');
                    fprintf('SA=%.2f, SB=%.2f, SC=%.2f \n',SA, SB, SC);
                    probability = 1/3;
                    [allcurrentstates,allnextstates,allprobs] = remaintosamestate(probability,n,allcurrentstates,allnextstates,allprobs);
                    probability = (1/3)*(n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(2, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = (1/3)*(n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(3, 1, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = (1/3)*(n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(1, 2, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = (1/3)*(n(idx(3))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(3, 2, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = (1/3)*(n(idx(1))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(1, 3, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                    probability = (1/3)*(n(idx(2))/(n(idx(1))+n(idx(2))+n(idx(3))));
                    [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(2, 3, probability,n,idx,allcurrentstates,allnextstates,allprobs);
                end
            end
        end
    end
end