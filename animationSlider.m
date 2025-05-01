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

fig = uifigure('Name', 'Animated Plot', 'Position',[50 150 500 400]);
ax1 = uiaxes(fig, 'Position', [50, 100, 400, 300], 'Xgrid', 'on', 'Ygrid', 'on');
% Create a slider
% slider = uislider(fig, 'Position', [50, 100, 400, 3], 'ValueChangedFcn', @(sld,event) sliderf(event));
slider = uislider(fig, 'Position', [50, 100, 400, 3]);
% Set the limits based on your data
slider.Limits = [1/5000 1/100]; 
% Initialize the slider at the start position
slider.Value = 1/1000;

lbl1 = uilabel(fig);
lbl1.Text = "Slower";
lbl1.FontSize = 12;
lbl1.Position = [50 40 100 30];

lbl2 = uilabel(fig);
lbl2.Text = "Faster";
lbl2.FontSize = 12;
lbl2.Position = [420 40 100 30];

% hold on;

for i=1:totalstrategies
    h(i) = animatedline(ax1, 'Color',colors(i),'LineWidth',2);
end

axis(ax1,[0,6*pi,0,max(W,[],"all")+5]);
%grid;
hxlabel = xlabel(ax1,'$Generations$');
set(hxlabel,'Interpreter','latex');
hylabel = ylabel(ax1,'$Population$');
set(hylabel,'Interpreter','latex');
htitle = title(ax1,'$Evolution$ $of$ $population$ $for$ $each$ $strategy$');
set(htitle,'Interpreter','latex');

legendstrings=cell(totalstrategies,1);
namesofStrategies = containers.Map({1, 2, 3, 4, 5},{'Random', 'Cooperate', 'Defect', ...
    'Tit-for-tat', 'Grim'});
for n=1:totalstrategies
    legendstrings{n}=namesofStrategies(strategiesArray(n)); 
end
hlegend =legend(h,legendstrings,'location','bestoutside', 'Orientation', 'horizontal');
set(hlegend,'Interpreter','latex');

a = tic; % Start timer
%threshold = get(slider,'value');
for k = 1:numofgenerations
    for i = 1:totalstrategies
        addpoints(h(i),x(k),W(i,k))
        % pause(0.002);
    end
    b = toc(a); % Check timer
    if b > (get(slider, 'Value'))
        drawnow % Update screen every 1/1000 seconds
        a = tic; % Reset timer after updating
    end
end

% function threshold = sliderf(event)
%   threshold = event.Value  
% end 
