% STRATEGIES
% 1: Random
% 2: Cooperate
% 3: Defect
% 4: Tit-for-tat
% 5: Grim

% Variables needed
numofgenerations = 1000; % Now, variable "rounds"
strategiesArray = [2 3 4 5];
populationsArray = [50 50 50 50];
totalplayers = sum(populationsArray,'all');
totalstrategies = length(strategiesArray);
W = zeros(totalstrategies,numofgenerations);

% Dummy W
x = linspace(0,6*pi,numofgenerations);

W(1,:) = populationsArray(1)+20*sin(x);
W(2,:) = populationsArray(2)+20*cos(x);
W(3,:) = abs(30*sin(x).*cos(x));
W(4,:) = 30*sin(x).^2;

% Colors (enough colors needed)
colors=['r', 'b',"#FFD900", 'k'];

figure
grid

% animatedline
for i=1:totalstrategies
    h(i) = animatedline('Color',colors(i),'LineWidth',2);
end

% axis
axis([0,6*pi,0,max(W,[],"all")+5]);

% xlabel
hxlabel = xlabel('$Generations$');
set(hxlabel,'Interpreter','latex');
% ylabel
hylabel = ylabel('$Population$');
set(hylabel,'Interpreter','latex');
% title
htitle = title('$Evolution$ $of$ $population$ $for$ $each$ $strategy$');
set(htitle,'Interpreter','latex');
% legend
% Strategy names
namesofStrategies = containers.Map({1, 2, 3, 4, 5},{'Random', 'Cooperate', 'Defect', ...
    'Tit-for-tat', 'Grim'});
% Legend string
legendstrings=cell(totalstrategies,1);
for n=1:totalstrategies
    legendstrings{n}=namesofStrategies(strategiesArray(n)); 
end
% The legend
hlegend =legend(h,legendstrings,'location','bestoutside', 'Orientation', 'horizontal');
set(hlegend,'Interpreter','latex');

a = tic; % Start timer

for k = 1:numofgenerations
    for i = 1:totalstrategies
        addpoints(h(i),x(k),W(i,k))
    end
    b = toc(a); % Check timer
    if b > (1/1000)
        drawnow % Update screen every 1/1000 seconds
        a = tic; % Reset timer after updating
    end
end