% Include all strategies
addpath('Code/Genaxel/strategies');
% Include all fitness and simulation classes
addpath('Code/Genaxel');

%%%%%% Strategy correspondance %%%%%%
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

%%%%%% Rounding method %%%%%%
% paper: Follows the paper's rounding method
% pop: Attributes decimals to the largest populations
% dec: Attributes decimals to the populations closer to the next integer
% off: Turns off rounding 
rounding = "off";

%%%%%% Imitators %%%%%%
% If sim_mode == TourSimImit, it is the number of players that imitate the best strategy per generation
K = 5;

%%%%%% Load your desired meeting %%%%%%
% Pick any meeting you want to recreate out of the figure files inside the Example folder
% figure01: Defectors may be strong
% figure02: Monotonous convergance  
% figure03: Attenuated oscillatory movements
% figure04: Periodic movements
% figure05: Increasing oscillations
% figure06: Disordered oscillations
% figure07_1, figure07_2: Population size sensitivity
% figure08_1, figure08_2: Population size sensitivity 2
% figure09_1, figure09_2: Game length sensitivity
% figure10_1, figure10_2: Payoff matrix sensitivity
% figure11_1, figure11_2: Rounding method sensitivity
% figure12_1, figure12_2: Rounding method sensitivity 2
figure01;

%%%%%% Custom meeting %%%%%%
% Set custom -> true, to set your own parameters
% This overrides the previous meeting's parameters
custom = true;
if custom == true
    % Custom
    strategiesArray = [2, 3, 5]; % Strategy numbers from the list above
    populationsArray = [10, 10, 10]; % Population sizes for each strategy
    matrix = [3, 0; 5, 1]; % Payoff matrix
    rounds = 100; % Number of rounds
    generations = 10; % Number of generations
end

%%%%%% Simulation Mode %%%%%%
% Choose the simulation mode you want to run
% Axel: Simple Axelrod tournament
% TourTheFit: Theoretical fitness tournament
% TourSimFit: Simulated fitness tournament
% TourSimImit: Simulated imitation tournament
sim_mode = "TourTheFit";

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