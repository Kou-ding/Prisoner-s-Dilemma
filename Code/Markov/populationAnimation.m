function populationAnimation(W, strategiesArray, namesofStrategies)

    % The function's arguments should be:
    % 1. W (totalstrategies x numofgenerations)
    % 2. strategiesArray
    % 3. A map with the strategy names, in order to create legendstrings

    % Number of strategies
    totalstrategies = length(strategiesArray);
    % Number of generations
    numofgenerations = size(W,2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%% TO BE CHANGED %%%%%%%%%%%%%%%%
    % Needed here only for the dummy case. Normally, x = 1:numofgenerations;
    x = linspace(0,6*pi,numofgenerations);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%% TO BE CHANGED %%%%%%%%%%%%%%%%
    % Put here more colors than the max strategies to be plotted
    % Colors (enough colors needed)
    colors=['r', 'b',"#FFD900", 'k'];
    
    % Figure and axes
    fig = uifigure('Name', 'Animated plot', 'Position',[50 150 500 400]);
    ax1 = uiaxes(fig, 'Position', [50, 100, 400, 300], 'Xgrid', 'on', 'Ygrid', 'on');
    % Create a slider
    slider = uislider(fig, 'Position', [50, 100, 400, 3]);
    % Set the limits  of the slider
    slider.Limits = [1/5000 1/100]; 
    % Initialize the slider
    slider.Value = 1/5000;
    
    % Labels around the slider
    lbl1 = uilabel(fig);
    lbl1.Text = "Slower";
    lbl1.FontSize = 12;
    lbl1.Position = [50 40 100 30];
    
    lbl2 = uilabel(fig);
    lbl2.Text = "Faster";
    lbl2.FontSize = 12;
    lbl2.Position = [420 40 100 30];
    
    % animatedlines and handles (one for each strategy to be plotted)
    for i=1:totalstrategies
        h(i) = animatedline(ax1, 'Color',colors(i),'LineWidth',2);
    end
    
    % Axis limits, x-label, y-label, title
    %%%%%%% TO BE CHANGED %%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    axis(ax1,[0,6*pi,0,max(W,[],"all")+5]);
    hxlabel = xlabel(ax1,'$Generations$');
    set(hxlabel,'Interpreter','latex');
    hylabel = ylabel(ax1,'$Population$');
    set(hylabel,'Interpreter','latex');
    htitle = title(ax1,'$Evolution$ $of$ $population$ $for$ $each$ $strategy$');
    set(htitle,'Interpreter','latex');
    
    % Legend
    legendstrings=cell(totalstrategies,1);

    for n=1:totalstrategies
        legendstrings{n}=namesofStrategies(strategiesArray(n)); 
    end
    hlegend =legend(h,legendstrings,'location','bestoutside', 'Orientation', 'horizontal');
    set(hlegend,'Interpreter','latex');
    
    % Draw
    a = tic; % Start timer
    for k = 1:numofgenerations
        for i = 1:totalstrategies
            addpoints(h(i),x(k),W(i,k))
        end
        b = toc(a); % Check timer
        if b > (get(slider, 'Value'))
            drawnow % Update screen every 1/1000 seconds
            a = tic; % Reset timer after updating
        end
    end

end