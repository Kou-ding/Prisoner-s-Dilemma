% Variables needed
numofgenerations = 1000; % Now, variable "rounds"
strategiesArray = [1 3 4 5];
populationsArray = [50 50 50 50];
%totalplayers = sum(populationsArray,'all');
totalstrategies = length(strategiesArray);
W = zeros(totalstrategies,numofgenerations);

% Dummy W
x = linspace(0,6*pi,numofgenerations);

W(1,:) = populationsArray(1)+20*sin(x);
W(2,:) = populationsArray(2)+20*cos(x);
W(3,:) = abs(30*sin(x).*cos(x));
W(4,:) = 30*sin(x).^2;

namesofStrategies = containers.Map({1, 2, 3, 4, 5},{'Random', 'Cooperate', 'Defect', ...
    'Tit-for-tat', 'Grim'});

% The function's arguments should be:
% 1. W (totalstrategies x numofgenerations)
% 2. strategiesArray
% 3. A map with the strategy names, in order to create legendstrings
populationAnimation(W, strategiesArray, namesofStrategies)