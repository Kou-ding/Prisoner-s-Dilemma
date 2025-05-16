%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% README FIRST %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Be sure to have run MarkovTournament.m before, in MarkovTheory directory
% with the same number of players and the same strategies (can both be changed
% in initialize.m in MarkovTheory directory).

% This will create the theoretical one-step transition matrix MTheory
% needed for the comparisons, which will be loaded in this simulation's
% workspace automatically via save-load. You can change parameter values in
% initialize.m in the present directory.

% The directories MarkovSim and MarkovTheory must both be in the same
% directory

evalin('base','clear');
clc;

% Start stopwatch timer
start = tic;

% The one-step transition matrix resulting from
% simulation. Initialized to 0 here, it is changed only by the functions 
% transferfromXtoY() and remaintosamestate() in function nxt(), whenever a
% state transition from a 'currentstate' to a 'nextstate' is performed 
global Msim;

% Call initialize() for initialization
[p1, p2, p3, payoff, N, rounds, numofreps, alluniquestates, initprobs, ngens] = initializeS();

time = round(rounds*ngens*(0.5*N*(N-1))*numofreps*4.1/1000);
fprintf('Needs approximately %d seconds to execute in my computer\n', time);

% Find all  names of the unique states as strings (i.e. (4,3,2)), needed
% for the Markov chain model hereafter
for i = 1:size(alluniquestates,1)
    statenames(i,1) = "("+num2str(alluniquestates(i,1))+","+num2str(alluniquestates(i,2))+","+num2str(alluniquestates(i,3))+")";
end

% Initialization of the k-step (k big) transition matrix
Mk = zeros(size(alluniquestates,1), size(alluniquestates,1));

% Initialization of the one-step transition matrix
Msim = zeros(size(alluniquestates,1), size(alluniquestates,1));

% Minimum and maximum number of a strategy's population in a generation
nmin = 0;
nmax = N;

% Print a message
fprintf('Starting processing\n');

% Simulate many times (numofreps)
for n1 = nmin:nmax
    % For each n2 from nmin to nmax-n1
    for n2 = nmin:nmax-n1
        % n3 is the rest from nmax
        n3 = nmax - n2 - n1;

        % This is the starting state 
        state = [n1, n2, n3];
        
        % Call onestatesim() to do a simulation, for 'numofreps' repetitions, 
        % starting from state 'state'. Each time, a vector m is returned 
        % with the 'times' a final state was reached, when starting from 'state',
        % transformed to probabilities. This is row 'row' of Mk. The vector 
        % m and 'row' is built in multimultigen.m Repeat for all states.
        [row, m] = multimultigen(p1, p2, p3, state, rounds, payoff, initprobs, numofreps, alluniquestates, ngens);
        
        % Put row vector m in the appropriate row of Mk 
        % row
        Mk(row,:) = m;
        
        % Print a message and time elapsed until now
        fprintf('Processed state %d of %d\n',row,size(alluniquestates,1));
        toc(start)
    end
end

% The global matrix Msim (one-step transition matrix has taken values in
% nxt(). Here the values are normalized to probabilities per row, summing
% to 1 per row.
for i=1:size(alluniquestates,1)
    Msim(i,:) = Msim(i,:)/sum(Msim(i,:));
end

% Print the time elapsed until the end of simulation
toc(start)

% Create Markov chain models for the one-step transition matrix M and for the 
% k-step (k big) final transition matrix Mk. Specify the state names. 
mc1 = dtmc(Msim, StateNames=statenames);
mc2 = dtmc(Mk, StateNames=statenames);

% Load from directory '../MarkovTheory/' TheoryOutput.mat putting one-step 
% transition matrix MTheory in workspace 
load ../MarkovTheory/TheoryOutput.mat;

% Simulated one-step transition matrix Msim heatmap
figure
imagesc(Msim)
colorbar
axis square
h = gca;
h.XTick = 1:size(alluniquestates);
h.YTick = 1:size(alluniquestates);
title("Simulated one-step transition matrix (Msim) heatmap");

% Theoretical one-step transition matrix MTheory heatmap
figure
imagesc(MTheory)
colorbar
axis square
h = gca;
h.XTick = 1:size(alluniquestates);
h.YTick = 1:size(alluniquestates);
title("Theoretical one-step transition matrix (MTheory) heatmap");

clims = [0 1];
% Heatmap of |Msim-Mtheory|
figure
imagesc(abs(Msim-MTheory), clims)
colorbar
axis square
h = gca;
h.XTick = 1:size(alluniquestates);
h.YTick = 1:size(alluniquestates);
title("Simulated vs theoretical difference |Msim-Mtheory| heatmap");

% Theoretical k-step transition matrix (k big) Mtheory^k
MTheoryk = MTheory^ngens;

% Simulated k-step (k big) transition matrix Mk heatmap
figure
imagesc(Mk)
colorbar
axis square
h = gca;
h.XTick = 1:size(alluniquestates);
h.YTick = 1:size(alluniquestates);
title("Simulated k-step transition matrix Mk (k big) heatmap");

% Theoretical k-step (k big) transition matrix Mtheory^k heatmap
figure
imagesc(MTheoryk)
colorbar
axis square
h = gca;
h.XTick = 1:size(alluniquestates);
h.YTick = 1:size(alluniquestates);
title("Theoretical k-step transition matrix Mtheory^k (k big) heatmap");

% Heatmap of |Mk-Mtheory^100|
figure
imagesc(abs(Mk-MTheoryk), clims)
colorbar
axis square
h = gca;
h.XTick = 1:size(alluniquestates);
h.YTick = 1:size(alluniquestates);
title("Simulated vs theoretical difference |Mk-Mtheory^k| heatmap");

% Digraph of the Markov chain for Msim
figure
h1 = graphplot(mc1, ColorEdges=true, ColorNodes=true);
colormap('jet');

% Digraph of the Markov chain for Mk
figure
h1 = graphplot(mc2, ColorEdges=true, ColorNodes=true);
colormap('jet');

% Differences per row
difference1 = zeros(size(alluniquestates,1),1);
difference2 = zeros(size(alluniquestates,1),1);
for i=1:size(alluniquestates) 
    difference1(i) = sum(abs(Msim(i,:)-MTheory(i,:)), 'all');
    difference2(i) = sum(abs(Mk(i,:)-MTheoryk(i,:)), 'all');
end

figure
scatter(1:size(alluniquestates,1),difference1);
hold on;
scatter(1:size(alluniquestates,1),difference2);
legend
grid;

difference1all = sum(difference1(:));
difference2all = sum(difference1(:));

fprintf('Metric for Σ|Msim-Mtheory|: %.2f \n',difference1all);
fprintf('Metric for Σ|Mk-Mtheory^k|: %.2f \n',difference2all);
