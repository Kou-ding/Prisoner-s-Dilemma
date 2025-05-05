addpath('strategies');
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

% Simulation Mode
sim_mode = "TourTheFit";

% Meeting Mode
meeting_mode = "Game length sensitivity before";

% Number of players that imitate
K = 5;

rounding = true;

switch meeting_mode
    % Custom
    case "Custom"
        strategiesArray = [2, 3, 5]; % Strategy numbers
        populationsArray = [10, 10, 10]; % Population sizes
        matrix = [3, 0; 5, 1]; % Payoff matrix
        rounds = 100; % Number of rounds
        generations = 90;

    % Defectors may be strong 🗸
    case "Defectors may be strong"
        strategiesArray = [9, 10, 12]; % soft_majo, per_cd, per_ddc
        populationsArray = [100, 100, 100];
        matrix = [3, 0; 5, 1];
        rounds = 1000;
        generations = 90;

    % Monotonous convergence 🗸
    case "Monotonous convergence"
        strategiesArray = [5, 10, 13]; % tft, per_cd, gradual
        populationsArray = [100, 100, 100];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 10;

    % Attenuated oscillatory movements 🗸 
    case "Attenuated oscillatory movements"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 450, 1000];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 450;

    % Periodic movements X
    case "Periodic movements"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 200];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 1000;

    % Increasing oscillations X
    case "Increasing oscillations"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [300, 300, 400];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 450;

    % Disordered oscillations X
    case "Disordered oscillations"
        strategiesArray = [9, 16, 17]; % soft_majo, per_ccccd, prober
        populationsArray = [100, 500, 800];
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 300;

    % Population size sensitivity 🗸
    case "Population size sensitivity before"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 252]; % 252 -> 253
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 1000;
    case "Population size sensitivity after"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 253]; % 252 -> 253
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 50;
    case "Population size sensitivity 2 before"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [185, 100, 100]; % 194 -> 195
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 120;
    case "Population size sensitivity 2 after"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [186, 100, 100]; % 194 -> 195
        matrix = [3, 0; 5,1];
        rounds = 1000;
        generations = 40;

    % Game length sensitivity 🗸
    case "Game length sensitivity before"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 244];
        matrix = [3, 0; 5,1];
        rounds = 7; % 7 -> 6
        generations = 1000;
    case "Game length sensitivity after"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 244];
        matrix = [3, 0; 5,1];
        rounds = 6; % 7 -> 6
        generations = 250;

    % Payoff matrix sensitivity 🗸
    case "Payoff matrix sensitivity before"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 244];
        matrix = [3, 0; 5,1]; % 5 -> 5.1
        rounds = 7; 
        generations = 1000;
    case "Payoff matrix sensitivity after"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 244];
        matrix = [3, 0; 5.1,1]; % 5 -> 5.1
        rounds = 7; 
        generations = 1000;

    % Rounding difference
    case "Rounding method sensitivity before"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 200];
        matrix = [3, 0; 5,1];
        rounds = 1000; 
        generations = 1000;
    case "Rounding method sensitivity after"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 300, 200];
        matrix = [3, 0; 5,1];
        rounds = 1000; 
        generations = 1000;
        rounding = false;
    case "Rounding method sensitivity 2 before"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100, 450, 1000];
        matrix = [3, 0; 5,1];
        rounds = 1000; 
        generations = 450;
    case "Rounding method sensitivity 2 after"
        strategiesArray = [9, 11, 12]; % soft_majo, per_ccd, per_ddc
        populationsArray = [100/10, 450/10, 1000/10];
        matrix = [3, 0; 5,1];
        rounds = 1000; 
        generations = 160;
    otherwise
        error('Invalid meeting mode. Choose a valid option.');
end

switch sim_mode
    case "TourTheFit"
        TourTheFit(matrix, strategiesArray, populationsArray, rounds, generations, rounding);
    case "TourSimImit"
        TourSimImit(matrix, strategiesArray, populationsArray, K , rounds, generations);
    case "TourSimFit"
        TourSimFit(matrix, strategiesArray, populationsArray, rounds, generations);
    case "Axel"
        Axel(strategiesArray, populationsArray, matrix, rounds);
    otherwise
        error('Invalid simulation mode. Choose "TourTheFit", "TourSimImit", "TourSimFit", or "Axel".');
end
