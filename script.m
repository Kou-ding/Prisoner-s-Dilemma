% Strategy correspondance
% 1: Random 🗸
% 2: Cooperate 🗸
% 3: Defect 🗸
% 4: Grim 🗸
% 5: Tit-for-tat 🗸
% 6: Hard Tit-for-tat (hard_tft) 🗸
% 7: Slow Tit-for-tat (slow_tft) 🗸
% 8: Tit-for-two-tat (tf2t) 🗸
% 9: Soft Majority 🗸
% 10: Periodic Cooperate Defect (per_cd) 🗸
% 11: Periodic Kind (per_kind) 🗸
% 12: Periodic Nasty (per_nasty) 🗸
% 13: Gradual 🗸
% 14: Pavlov 🗸
% 15: Mistrust 🗸
% 16: Periodic Very Kind (per_ccccd)
% 17: Prober

% Mode
mode = "Defectors may be strong";
K = 5;
switch mode
    case "Default"
        strategiesArray = [2, 3]; % Strategy numbers
        populationsArray = [1, 1]; % Population sizes
        matrix = [3, 0; 5, 1]; % Payoff matrix
        rounds = 10; % Number of rounds
        generations = 90;
    case "Defectors may be strong"
        strategiesArray = [9, 10, 12]; % soft_majo, per_cd, per_ddc
        populationsArray = [100, 100, 100];
        matrix = [3, 0; 5, 1];
        rounds = 1000;
        generations = 90;
    case "Monotonous convergence"
        strategiesArray = [5, 10, 13]; % tft, per_cd, gradual
        populationsArray = [100, 100, 100];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 90;
    case "Attenuated oscillatory movements"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 450, 1000];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 400 ;
    case "Periodic movements"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 200];
        matrix = [3, 0; 5,1];
        rounds = 100;
        generations = 90;
    case "Disordered oscillations"
        strategiesArray = [9, 16, 17]; % soft_majo, per_ccccd, prober
        populationsArray = [100, 500, 800];
        matrix = [3, 0; 5,1];
        rounds = 100;
        generations = 90;
end