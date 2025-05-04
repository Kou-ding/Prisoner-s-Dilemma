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
% 16: Periodic Ultra Kind (per_ccccd)
% 17: Prober

% Mode
mode = "Population size sensitivity";
K = 5;
switch mode
    % Custom
    case "Custom"
        strategiesArray = [2, 3, 5]; % Strategy numbers
        populationsArray = [10, 10, 10]; % Population sizes
        matrix = [3, 0; 5, 1]; % Payoff matrix
        rounds = 100; % Number of rounds
        generations = 90;
    % Defectors may be strong
    case "Defectors may be strong"
        strategiesArray = [9, 10, 12]; % soft_majo, per_cd, per_ddc
        populationsArray = [100, 100, 100];
        matrix = [3, 0; 5, 1];
        rounds = 1000;
        generations = 90;
    % Monotonous convergence
    case "Monotonous convergence"
        strategiesArray = [5, 10, 13]; % tft, per_cd, gradual
        populationsArray = [100, 100, 100];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 10;
    % Attenuated oscillatory movements
    case "Attenuated oscillatory movements"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 450, 1000];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 450;
    % Periodic movements
    case "Periodic movements"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 200];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 1000;
    % Increasing oscillations
    case "Increasing oscillations"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [200, 300, 400];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 450;
    % Disordered oscillations
    case "Disordered oscillations"
        strategiesArray = [9, 16, 17]; % soft_majo, per_ccccd, prober
        populationsArray = [100, 500, 800];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 300;
    % Population size sensitivity
    case "Population size sensitivity"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 244]; % 244 -> 245
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 50;

    case "Population size sensitivity 2"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [159, 100, 100]; % 159 -> 160
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 50;
    case "Population size sensitivity 3"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 244];
        matrix = [3, 0; 5,1];
        rounds = 7; % 7 -> 6
        generations = 50;
    case "Population size sensitivity 4"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 244];
        matrix = [3, 0; 4.6,1]; % 4.6 -> 4.7
        rounds = 7; 
        generations = 50;
    % Rounding difference
    case "Population size sensitivity 5"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 200];
        matrix = [3, 0; 5,1];
        rounds = 1000; 
        generations = 50;
    case "Population size sensitivity 6"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 450, 1000];
        matrix = [3, 0; 5,1];
        rounds = 1000; 
        generations = 50;
end