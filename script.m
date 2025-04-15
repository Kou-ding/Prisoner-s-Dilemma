% Strategy correspondance
% 1: Random 🗸
% 2: Cooperate 🗸
% 3: Defect 🗸
% 4: Grim 🗸
% 5: Tit-for-tat 🗸
% 6: Hard Tit-for-tat 🗸
% 7: Slow Tit-for-tat 🗸
% 8: Tit-for-two-tat 🗸
% 9: Soft Majority 🗸
% 10: Periodic Cooperate Defect 🗸
% 11: Periodic Kind 🗸
% 12: Periodic Nasty 🗸
% 13: Gradual 🗸
% 14: Pavlov 🗸
% 15: Mistrust 🗸

% Mode
mode = "Defectors may be strong";

switch mode
    case "Default"
        strategiesArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]; % Strategy numbers
        populationsArray = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]; % Population sizes
        matrix = [3, 1; 4, 2]; % Payoff matrix
        rounds = 10; % Number of rounds
    case "Defectors may be strong"
        strategiesArray = [9, 10, 12]; % soflt_majo, per_cd, per_ddc
        populationsArray = [100, 100, 100];
        matrix = [3, 1; 4, 2];
        rounds = 10;
    case "Monotonous convergence"
        strategiesArray = [5, 10, 13]; % tft, per_cd, gradual
        populationsArray = [100, 100, 100];
        matrix = [3, 1; 4, 2];
        rounds = 10;
    case "Attenuated oscillatory movements"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 450, 1000];
        matrix = [3, 1; 4, 2];
        rounds = 10;
    case "Periodic movements"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 200];
        matrix = [3, 1; 4, 2];
        rounds = 10;
    case "Disordered oscillations"
        strategiesArray = [9, 16, 17]; % soft_majo, per_ccccd, prober
        populationsArray = [100, 500, 800];
        matrix = [3, 1; 4, 2];
        rounds = 10;
end