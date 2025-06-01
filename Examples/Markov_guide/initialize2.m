%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INITIALIZE FOR FIGURES 14 TO 25 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Choose opponents, strategy vectors, pay-off matrix, polulation, rounds (separate
% for the theoretical and simulation part),
% number of repetitions starting from each state, unique states and probabilities
% that a strategy chooses 'C' as its first move. Choose also if a
% predetermined outcome meeting is applied.

function [p1, p2, p3, payoff, N, roundsth, roundssim, numofreps, alluniquestates, initprobs, ngens, predetermined, names, chosen] = initialize()
    
    fprintf('Performing initialization calculations...\n\n');

    % Total population (n=n1+n2+n3, ni players for strategy i)
    N = 9;

    % Pay-off matrix
    R = 3; T = 5; S = 0; P = 1;
    payoff = [R, S, T, P];

    % Rounds in a game between two opponents (used in theoretical
    % calculations)
    roundsth = 1000;

    % Rounds in a game between two opponents (used in simulation
    % calculations)
    roundssim = 500;

    % Number of repetitions starting from each state
    numofreps = 15;

    % Number of generations
    ngens = 50;

    % Strategy vectors
    % 01. All-C:                                [1 1 1 1]
    % 02. All-D:                                [0 0 0 0]
    % 03. Random:                               [0.5 0.5 0.5 0.5]
    % 04. Tif-for-Tat                           [1 0 1 0]
    % 05. Generous Tit-for-Tat                  [1 q 1 q]
    % 06. Pavlov                                [1 0 0 1]
    % 07. GEN-2 (generous-zero-determinant):    [1 0.5625 0.5 0.125]
    % 08. SET-2 equalizer                       [0.75 0.25 0.5 0.25]
    % 09. SET-3 equalizer                       [1 0.9 0.15 0.1]
    % 10. EXT-2                                 [0.875 0.4375 0.375 0]
    % 11. EXT-5                                 [0.68 0.16 0.36 0]
    
    % Interesting opponents
    % All-C vs GTFT (q=0.25) vs Random [1,5,3]
    % SET-3 vs TFT vs EXT-5 [9,4,11]
    % SET-2 vs TFT vs EXT-5 [8,4,11]
    % GEN-2 vs SET-3 vs TFT [7,9,4]

    % Choose parameters for the strategy vectors
    % Generous Tit-for-Tat, probability to choose C
    q = 0.25;
    
    % Vector of chosen opponents
    chosen = [7, 9, 4];

    % PREDETERMINED OUTCOME MEETINGS
    % HAS PRIORITY OVER MEETINGS WITH STRATEGY VECTORS
    % CHOOSE EMPTY STRING ('') TO APPLY A MEETING WITH STRATEGY VECTORS
    % ELSE CHOOSE 'A', 'B',... (ATTENTION, USE ENGLISH LETTERS)
    % A: All-C vs All-D vs Trigger
    % B: CCD vs DDC vs Soft-Majo
    predetermined = '';

    % Strategy names map
    names = containers.Map({1,2,3,4,5,6,7,8,9,10,11},...
        {'All-C', 'All-D', 'Random', 'Tit-for-Tat', 'GTFT',...
        'Pavlov', 'GEN-2', 'SET-2', 'SET-3',...
        'EXT-2', 'EXT-5'});

    % Print info message
    switch predetermined
        case ""
            fprintf('%s vs %s vs %s was chosen.\n\n', names(chosen(1)), names(chosen(2)), names(chosen(3)));
        case 'A'
            fprintf('All-C vs All-D vs Trigger was chosen, with predetermined outcome meetings.\n\n');
        case 'B'
            fprintf('CCD vs DDC vs Trigger was chosen, with predetermined outcome meetings.\n\n');
    end

    % Info message
    fprintf(['%d players in total, %d rounds per game for the theoretical calculations,\n' ...
        '%d rounds per game for the simulation calculations, %d repetitions per initial state, %d generations.\n' ...
        'The payoff matrix is [R=%d, S=%d, T=%d, P=%d].\n\n'], N, roundsth, roundssim, numofreps, ngens, R, S, T, P);

    % Strategy vectors map
    ps = containers.Map({'All-C','All-D','Random','Tit-for-Tat', 'GTFT'...
        'Pavlov', 'GEN-2', 'SET-2', 'SET-3',...
        'EXT-2', 'EXT-5'},...
        {[1 1 1 1], [0 0 0 0], [0.5 0.5 0.5 0.5], [1 0 1 0], [1 q 1 q],...
        [1 0 0 1], [1 0.5625 0.5 0.125], [0.75 0.25 0.5 0.25], [1 0.9 0.15 0.1],...
        [0.875 0.4375 0.375 0], [0.68 0.16 0.36 0]});

    % Strategy probability for initial move to be 'C'
    pinitC = containers.Map({'All-C','All-D','Random','Tit-for-Tat', 'GTFT'...
        'Pavlov', 'GEN-2', 'SET-2', 'SET-3',...
        'EXT-2', 'EXT-5'},...
        {1, 0, 0.5, 1, 1,...
         1, 0.5, 0.5, 0.5,...
         0.5, 0.5});
    
    % Strategy vectors for the 3 opponents
    p1 = ps(names(chosen(1)));
    p2 = ps(names(chosen(2)));
    p3 = ps(names(chosen(3)));

    % Probabilities for first move to be 'C' for the 3 opponents
    initprobs = [pinitC(names(chosen(1))), pinitC(names(chosen(2))), pinitC(names(chosen(3)))];

    % Minimum and maximum number of a strategy's population in a generation
    nmin = 0;
    nmax = N;
    
    % To store all unique states
    alluniquestates = [];
    
    % Find all possible states
    % For each n1 from nmin to nmax
    for n1 = nmin:nmax
        % For each n2 from nmin to nmax-n1
        for n2 = nmin:nmax-n1
            % n3 is the rest from nmax
            n3 = nmax - n2 - n1;
            alluniquestates = [alluniquestates;[n1, n2, n3]];
        end
    end

end
