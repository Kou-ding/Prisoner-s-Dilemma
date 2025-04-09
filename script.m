% Strategy correspondance
% 1: Random
% 2: Cooperate
% 3: Defect
% 4: Grim
% 5: Tit-for-tat
% 6: Hard Tit-for-tat
% 7: Slow Tit-for-tat
% 8: Tit-for-two-tat
% 9: Soft Majority
% 10: Periodic Cooperate Defect
% 11: Periodic Kind
% 12: Periodic Nasty
% 13: Gradual
% 14: Pavlov
% 15: Mistrust 
strategiesArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]; % Strategy numbers
populationsArray = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; % Population sizes
matrix = [3, 1; 4, 2]; % Payoff matrix
rounds = 20; % Number of rounds