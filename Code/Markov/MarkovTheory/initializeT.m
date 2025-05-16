% Choose opponents, strategy vectors, pay-off matrix and polulation
function [p1, p2, p3, R, S, T, P, n, rounds] = initializeT()
    
    % Total population (n=n1+n2+n3, ni players for strategy i)
    n = 9;

    % Pay-off matrix
    R = 3; T = 5; S = 0; P = 1;

    % Rounds in game between two opponents
    rounds = 1000;
    
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
    
    % Strategy names map
    names = containers.Map({1,2,3,4,5,6,7,8,9,10,11},...
        {'All-C', 'All-D', 'Random', 'Tit-for-Tat', 'GTFT',...
        'Pavlov', 'GEN-2', 'SET-2', 'SET-3',...
        'EXT-2', 'EXT-5'});
    
    % Strategyvectors
    ps = containers.Map({'All-C','All-D','Random','Tit-for-Tat', 'GTFT'...
        'Pavlov', 'GEN-2', 'SET-2', 'SET-3',...
        'EXT-2', 'EXT-5'},...
        {[1 1 1 1], [0 0 0 0], [0.5 0.5 0.5 0.5], [1 0 1 0], [1 q 1 q],...
        [1 0 0 1], [1 0.5625 0.5 0.125], [0.75 0.25 0.5 0.25], [1 0.9 0.15 0.1],...
        [0.875 0.4375 0.375 0], [0.68 0.16 0.36 0]});
    
    % Strategy vectors for the 3 opponents
    p1 = ps(names(chosen(1)));
    p2 = ps(names(chosen(2)));
    p3 = ps(names(chosen(3)));

end
