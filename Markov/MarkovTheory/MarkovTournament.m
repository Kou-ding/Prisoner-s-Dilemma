clear;
clc;

% Choose opponents, strategy vectors, pay-off matrix and population
[p1, p2, p3, R, S, T, P, n, rounds] = initializeT();

% Symbolic variables for each strategy's population (n1, n2, n3)
% Symbolic variables for each strategy's total pay-off at each generation (SCA, SCB, SCC) 
% Useless to multiply by the number of rounds per play (T)
syms n1 n2 n3 SCA SCB SCC

% Return the payoffs in a play between two oppenents
% PXYX is the pay-off in a game between X vs Y, for X
% PXYY is the pay-off in a game between X vs Y, for Y
P = tournamentpayoffs(p1, p2, p3, R, T, S, P);
PAAA = P(1);
PBBB = P(2);
PCCC = P(3);
PABA = P(4); PABB = P(5);
PACA = P(6); PACC = P(7);
PBCB = P(8); PBCC = P(9);

% Strategy total pay-offs per generation
SCA = (n1*(n1-1)*PAAA + n1*n2*PABA + n1*n3*PACA)* rounds;
SCB = (n1*n2*PABB + n2*(n2-1)*PBBB + n2*n3*PBCB)* rounds;
SCC = (n1*n3*PACC + n2*n3*PBCC +n3*(n3-1)*PCCC)* rounds;

% Minimum and maximum number of a strategy's population in a generation
nmin = 0;
nmax = n;

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

        % Vector of strategy pay-offs
        SA = subs(SCA);
        SB = subs(SCB);
        SC = subs(SCC);  
        S = [SA, SB, SC];

        % Vector of strategy populations
        n = [n1, n2, n3];

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

% Find unique current states (unique system states)
allcurrentuniquestates=unique(allcurrentstates);

% Initialize transition matrix
M=zeros(size(allcurrentuniquestates,1),size(allcurrentuniquestates,1));

% Add transitions found
% allcurentstates(i)   allnextstates(i) allprobs(i)
for i=1:size(allcurrentstates,1)
    M(find(ismember(allcurrentuniquestates,allcurrentstates(i))),...
      find(ismember(allcurrentuniquestates,allnextstates(i)))) =...
      allprobs(i);
end

% Create the Markov chain model. Specify the state names. 
mc = dtmc(M, StateNames=allcurrentuniquestates);

% One step transition matrix M heatmap
figure
imagesc(M)
colorbar
axis square
h = gca;
h.XTick = 1:size(allcurrentuniquestates);
h.YTick = 1:size(allcurrentuniquestates);
title("One-step transition matrix M heatmap")

% 8-step transition matrix M^8 heatmap
figure
imagesc(M^8)
colorbar
axis square
h = gca;
h.XTick = 1:size(allcurrentuniquestates);
h.YTick = 1:size(allcurrentuniquestates);
title("8-step transition matrix M^8 heatmap")

% k-step transition matrix M^k heatmap (k big)
figure
imagesc(M^100)
colorbar
axis square
h = gca;
h.XTick = 1:size(allcurrentuniquestates,1);
h.YTick = 1:size(allcurrentuniquestates,1);
title("k-step (k big) transition matrix M^k heatmap")

% Digraph of the Markov chain
figure
% h1 = graphplot(mc, ColorEdges=true);
h2 = graphplot(mc, ColorEdges=true, ColorNodes=true);
colormap('jet');

% M^k evolution
figure
axis square
h = gca;
h.XTick = 1:size(allcurrentuniquestates,1);
h.YTick = 1:size(allcurrentuniquestates,1);
title("k-step transition matrix evolution")

for i=1:100
    colorbar
    imagesc(M^i)
    pause(0.5)
end


MTheory = M;
save("TheoryOutput.mat","MTheory");

function [allcurrentstates,allnextstates,allprobs] = transferfromXtoY(strategyX, strategyY, probability,n,idx,allcurrentstates,allnextstates,allprobs)
    currentstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
    n(idx(strategyX)) = n(idx(strategyX)) - 1;
    n(idx(strategyY)) = n(idx(strategyY)) + 1;
    nextstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
    allcurrentstates=[allcurrentstates;currentstate];
    allnextstates=[allnextstates;nextstate];
    allprobs=[allprobs;probability];
    fprintf('%s->%s %.3f\n',currentstate,nextstate,probability);
    fprintf('\n');
end

function [allcurrentstates,allnextstates,allprobs] = remaintosamestate(probability,n,allcurrentstates,allnextstates,allprobs)
    currentstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
    nextstate = "("+num2str(n(1))+","+num2str(n(2))+","+num2str(n(3))+")";
    allcurrentstates=[allcurrentstates;currentstate];
    allnextstates=[allnextstates;nextstate];
    allprobs=[allprobs;probability];
    fprintf('%s->%s %.3f\n',currentstate,nextstate,probability);
    fprintf('\n');
end