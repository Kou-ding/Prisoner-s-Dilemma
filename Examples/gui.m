function gui
    f = figure('Name', 'Genaxel Simulation GUI', 'Position', [300 100 700 600]);

    %%% --- Left side: Strategy list and Sim Mode --- %%%
    uicontrol(f, 'Style', 'text', 'Position', [20 560 150 20], 'String', 'Selected Strategies:');
    stratListBox = uicontrol(f, 'Style', 'listbox', 'Position', [20 430 250 130], 'Max', 2);

    deleteBtn = uicontrol(f, 'Style', 'pushbutton', 'String', 'Delete Selected', ...
        'Position', [20 400 120 25], 'Callback', @deleteStrategy);

    uicontrol(f, 'Style', 'text', 'String', 'Sim Mode:', 'Position', [20 370 100 20]);
    simModeMenu = uicontrol(f, 'Style', 'popupmenu', ...
        'String', {'TourTheFit', 'TourSimImit', 'TourSimFit', 'Axel'}, ...
        'Position', [20 350 200 20], 'Callback', @toggleFields);

    %%% --- Right side: Strategy adding --- %%%
    strategyList = {...
        '1: Random', '2: Cooperate', '3: Defect', '4: Grim', ...
        '5: Tit-for-tat', '6: Hard Tit-for-tat', '7: Slow Tit-for-tat', ...
        '8: Tit-for-two-tat', '9: Soft Majority', '10: Periodic CD', ...
        '11: Periodic Kind', '12: Periodic Nasty', '13: Gradual', ...
        '14: Pavlov', '15: Mistrust', '16: Periodic Ultra Kind', '17: Prober'};

    uicontrol(f, 'Style', 'text', 'Position', [300 560 120 20], 'String', 'Select Strategy:');
    strategyMenu = uicontrol(f, 'Style', 'popupmenu', 'String', strategyList, 'Position', [300 540 200 20]);

    uicontrol(f, 'Style', 'text', 'Position', [510 560 100 20], 'String', 'Population:');
    popInput = uicontrol(f, 'Style', 'edit', 'Position', [510 540 60 20], 'String', '10');

    addBtn = uicontrol(f, 'Style', 'pushbutton', 'String', 'Add strategy +', ...
        'Position', [580 540 100 25], 'Callback', @addStrategy);

    %%% --- Payoff matrix --- %%%
    uicontrol(f, 'Style', 'text', 'Position', [300 500 200 20], 'String', 'Payoff Matrix [R,S;T,P]:');
    payoffTable = uitable(f, 'Data', [3 0; 5 1], 'Position', [300 440 200 60], ...
        'ColumnEditable', [true true], 'ColumnWidth', {60, 60});

    %%% --- Rounds and Generations --- %%%
    uicontrol(f, 'Style', 'text', 'String', 'Rounds:', 'Position', [300 410 100 20]);
    roundsBox = uicontrol(f, 'Style', 'edit', 'Position', [300 390 60 20], 'String', '100');

    uicontrol(f, 'Style', 'text', 'String', 'Generations:', 'Position', [380 410 100 20]);
    gensBox = uicontrol(f, 'Style', 'edit', 'Position', [380 390 60 20], 'String', '90');

    %%% --- Rounding and K on the same line --- %%%
    roundingLabel = uicontrol(f, 'Style', 'text', 'String', 'Rounding:', ...
        'Position', [300 360 100 20], 'Visible', 'on');
    roundingMenu = uicontrol(f, 'Style', 'popupmenu', 'String', {'paper', 'pop', 'dec', 'off'}, ...
        'Position', [300 340 120 20], 'Visible', 'on');

    kLabel = uicontrol(f, 'Style', 'text', 'String', 'Imitators (K):', ...
        'Position', [440 360 100 20], 'Visible', 'off');
    kBox = uicontrol(f, 'Style', 'edit', 'Position', [440 340 60 20], 'String', '5', 'Visible', 'off');

    %%% --- Run button --- %%%
    uicontrol(f, 'Style', 'pushbutton', 'Position', [250 280 200 40], ...
        'String', 'Run Simulation', 'Callback', @runSim);

    % State variables
    strategyIDs = [];
    populationSizes = [];

    function addStrategy(~, ~)
        idx = get(strategyMenu, 'Value');
        pop = str2double(get(popInput, 'String'));
        if isnan(pop) || pop <= 0
            errordlg('Invalid population value.');
            return;
        end
        strategyIDs(end+1) = idx;
        populationSizes(end+1) = pop;
        updateListbox();
    end

    function deleteStrategy(~, ~)
        selected = get(stratListBox, 'Value');
        strategyIDs(selected) = [];
        populationSizes(selected) = [];
        updateListbox();
    end

    function updateListbox()
        entries = arrayfun(@(s, p) sprintf('%s -> %d', strategyList{s}, p), ...
            strategyIDs, populationSizes, 'UniformOutput', false);
        set(stratListBox, 'String', entries, 'Value', 1);
    end

    function toggleFields(~, ~)
        mode = get(simModeMenu, 'Value');
        switch mode
            case 1 % TourTheFit
                set(roundingLabel, 'Visible', 'on');
                set(roundingMenu, 'Visible', 'on');
                set(kLabel, 'Visible', 'off');
                set(kBox, 'Visible', 'off');
            case 2 % TourSimImit
                set(roundingLabel, 'Visible', 'off');
                set(roundingMenu, 'Visible', 'off');
                set(kLabel, 'Visible', 'on');
                set(kBox, 'Visible', 'on');
            case 3 % TourSimFit
                set(roundingLabel, 'Visible', 'on');
                set(roundingMenu, 'Visible', 'on');
                set(kLabel, 'Visible', 'off');
                set(kBox, 'Visible', 'off');
            otherwise
                set(roundingLabel, 'Visible', 'off');
                set(roundingMenu, 'Visible', 'off');
                set(kLabel, 'Visible', 'off');
                set(kBox, 'Visible', 'off');
        end
    end

    function runSim(~, ~)
        if isempty(strategyIDs)
            errordlg('Please add at least one strategy.');
            return;
        end

        addpath('Code/Genaxel/strategies');
        addpath('Code/Genaxel');

        strategiesArray = strategyIDs;
        populationsArray = populationSizes;
        matrix = get(payoffTable, 'Data');
        rounds = str2double(get(roundsBox, 'String'));
        generations = str2double(get(gensBox, 'String'));
        simModes = get(simModeMenu, 'String');
        sim_mode = simModes{get(simModeMenu, 'Value')};
        roundingOptions = get(roundingMenu, 'String');
        rounding = roundingOptions{get(roundingMenu, 'Value')};
        K = str2double(get(kBox, 'String'));

        switch sim_mode
            case "TourTheFit"
                TourTheFit(matrix, strategiesArray, populationsArray, rounds, generations, rounding);
            case "TourSimImit"
                TourSimImit(matrix, strategiesArray, populationsArray, K, rounds, generations);
            case "TourSimFit"
                TourSimFit(matrix, strategiesArray, populationsArray, rounds, generations);
            case "Axel"
                Axel(strategiesArray, populationsArray, matrix, rounds);
            otherwise
                errordlg('Invalid simulation mode.');
        end
    end
end
% function gui
%     f = figure('Name', 'Genaxel Simulation GUI', 'Position', [300 100 650 550]);

%     % Strategy Dropdown + Population Input + Add Button
%     uicontrol(f, ...
%         'Style', 'text', ...
%         'Position', [20 500 120 20], ...
%         'String', 'Select Strategy:');
%     strategyList = { ...
%         '1: Random', '2: Cooperate', '3: Defect', '4: Grim', ...
%         '5: Tit-for-tat', '6: Hard Tit-for-tat', '7: Slow Tit-for-tat', ...
%         '8: Tit-for-two-tat', '9: Soft Majority', '10: Periodic CD', ...
%         '11: Periodic Kind', '12: Periodic Nasty', '13: Gradual', ...
%         '14: Pavlov', '15: Mistrust', '16: Periodic Ultra Kind', ...
%         '17: Prober'};
%     strategyMenu = uicontrol(f, ...
%         'Style', 'popupmenu', ...
%         'String', strategyList, ...
%         'Position', [20 480 150 20]);

%     uicontrol(f, ...
%         'Style', 'text', ...
%         'Position', [180 500 100 20], ... 
%         'String', 'Population:');
%     popInput = uicontrol(f, ...
%         'Style', 'edit', ...
%         'Position', [180 480 60 20], ...
%         'String', '10');

%     addBtn = uicontrol(f, ...
%         'Style', 'pushbutton', ...
%         'String', 'Add strategy +', ...
%         'Position', [260 480 120 25]);

%     % Listbox to show added strategies
%     uicontrol(f, ...
%         'Style', 'text', ...
%         'Position', [400 500 150 20], ...
%         'String', 'Selected Strategies:');
%     stratListBox = uicontrol(f, ...
%         'Style', 'listbox', ...
%         'Position', [400 360 200 140]);

%     % Payoff matrix table
%     uicontrol(f, ...
%         'Style', 'text', ...
%         'Position', [0 440 200 20], ...
%         'String', 'Payoff Matrix [R,S;T,P]:');

%     payoffTable = uitable(f, ...
%         'Data', [3 0; 5 1], ...             % initial data
%         'Position', [20 370 115 65], ...    % position of the table
%         'ColumnEditable', [true true], ...
%         'ColumnWidth', {30, 30});           % width of the two columns


%     % Rounds and Generations
%     uicontrol(f, 'Style', 'text', 'String', 'Rounds:', 'Position', [180 440 100 20]);
%     roundsBox = uicontrol(f, ...
%         'Style', 'edit', ...
%         'Position', [180 420 60 20], ...
%         'String', '100');

%     uicontrol(f, 'Style', 'text', 'String', 'Generations:', 'Position', [260 440 100 20]);
%     gensBox = uicontrol(f, 'Style', 'edit', 'Position', [260 420 60 20], 'String', '90');

%     % Sim mode dropdown
%     uicontrol(f, 'Style', 'text', 'String', 'Sim Mode:', 'Position', [20 350 100 20]);
%     simModeMenu = uicontrol(f, 'Style', 'popupmenu', ...
%         'String', {'TourTheFit', 'TourSimImit', 'TourSimFit', 'Axel'}, ...
%         'Position', [20 330 200 20], ...
%         'Callback', @toggleFields);

%     % Rounding dropdown (hidden by default)
%     roundingLabel = uicontrol(f, 'Style', 'text', 'String', 'Rounding:', ...
%         'Position', [240 350 100 20], 'Visible', 'on');
%     roundingMenu = uicontrol(f, 'Style', 'popupmenu', ...
%         'String', {'paper', 'pop', 'dec', 'off'}, ...
%         'Position', [240 330 200 20], 'Visible', 'on');

%     % K input (hidden by default)
%     kLabel = uicontrol(f, 'Style', 'text', ...
%         'String', 'Imitators (K):', ...
%         'Position', [240 300 100 20], ...
%         'Visible', 'off');
%     kBox = uicontrol(f, 'Style', 'edit', ...
%         'Position', [240 280 60 20], ...
%         'String', '5', ...
%         'Visible', 'off');

%     % Run button
%     uicontrol(f, 'Style', 'pushbutton', 'Position', [200 200 200 40], ...
%         'String', 'Run Simulation', 'Callback', @runSim);

%     % State variables
%     strategyIDs = [];
%     populationSizes = [];

%     function addStrategy(~, ~)
%         idx = get(strategyMenu, 'Value');
%         pop = str2double(get(popInput, 'String'));
%         if isnan(pop) || pop <= 0
%             errordlg('Invalid population value.');
%             return;
%         end
%         strategyIDs(end+1) = idx;
%         populationSizes(end+1) = pop;
%         updateListbox();
%     end

%     function updateListbox()
%         entries = arrayfun(@(s, p) sprintf('%s -> %d', strategyList{s}, p), ...
%                     strategyIDs, populationSizes, 'UniformOutput', false);
%         set(stratListBox, 'String', entries);
%     end

%     function toggleFields(~, ~)
%         mode = get(simModeMenu, 'Value');
%         switch mode
%             case 1 % TourTheFit
%                 set(roundingLabel, 'Visible', 'on');
%                 set(roundingMenu, 'Visible', 'on');
%                 set(kLabel, 'Visible', 'off');
%                 set(kBox, 'Visible', 'off');
%             case 2 % TourSimImit
%                 set(roundingLabel, 'Visible', 'off');
%                 set(roundingMenu, 'Visible', 'off');
%                 set(kLabel, 'Visible', 'on');
%                 set(kBox, 'Visible', 'on');
%             case 3 % TourSimFit
%                 set(roundingLabel, 'Visible', 'on');
%                 set(roundingMenu, 'Visible', 'on');
%                 set(kLabel, 'Visible', 'off');
%                 set(kBox, 'Visible', 'off');
%             otherwise % Axel
%                 set(roundingLabel, 'Visible', 'off');
%                 set(roundingMenu, 'Visible', 'off');
%                 set(kLabel, 'Visible', 'off');
%                 set(kBox, 'Visible', 'off');
%         end
%     end

%     function runSim(~, ~)
%         if isempty(strategyIDs)
%             errordlg('Please add at least one strategy.');
%             return;
%         end

%         addpath('Code/Genaxel/strategies');
%         addpath('Code/Genaxel');

%         strategiesArray = strategyIDs;
%         populationsArray = populationSizes;
%         matrix = get(payoffTable, 'Data');
%         rounds = str2double(get(roundsBox, 'String'));
%         generations = str2double(get(gensBox, 'String'));
%         simModes = get(simModeMenu, 'String');
%         sim_mode = simModes{get(simModeMenu, 'Value')};
%         roundingOptions = get(roundingMenu, 'String');
%         rounding = roundingOptions{get(roundingMenu, 'Value')};
%         K = str2double(get(kBox, 'String'));

%         switch sim_mode
%             case "TourTheFit"
%                 TourTheFit(matrix, strategiesArray, populationsArray, rounds, generations, rounding);
%             case "TourSimImit"
%                 TourSimImit(matrix, strategiesArray, populationsArray, K, rounds, generations);
%             case "TourSimFit"
%                 TourSimFit(matrix, strategiesArray, populationsArray, rounds, generations);
%             case "Axel"
%                 Axel(strategiesArray, populationsArray, matrix, rounds);
%             otherwise
%                 errordlg('Invalid simulation mode.');
%         end
%     end

%     % Attach the strategy button callback
%     addBtn.Callback = @addStrategy;
% end

% % function gui
% %     f = figure('Name', 'Genaxel Simulation GUI', 'Position', [300 200 600 500]);

% %     uicontrol(f, 'Style', 'text', 'String', 'Strategies (select multiple):', 'Position', [20 440 200 20]);
% %     strategiesList = uicontrol(f, 'Style', 'listbox', 'Position', [20 280 200 160], ...
% %         'Max', 15, 'Min', 1, ...
% %         'String', { ...
% %             '1: Random', '2: Cooperate', '3: Defect', '4: Grim', ...
% %             '5: Tit-for-tat', '6: Hard Tit-for-tat', '7: Slow Tit-for-tat', ...
% %             '8: Tit-for-two-tat', '9: Soft Majority', ...
% %             '10: Periodic Cooperate Defect', '11: Periodic Kind', ...
% %             '12: Periodic Nasty', '13: Gradual', '14: Pavlov', ...
% %             '15: Mistrust', '16: Periodic Ultra Kind', '17: Prober'});

% %     uicontrol(f, 'Style', 'text', 'String', 'Population (comma-separated):', 'Position', [240 440 200 20]);
% %     popBox = uicontrol(f, 'Style', 'edit', 'Position', [240 420 200 20], 'String', '10,10,10');

% %     uicontrol(f, 'Style', 'text', 'String', 'Payoff Matrix [[R,S];[T,P]]:', 'Position', [240 390 200 20]);
% %     payoffBox = uicontrol(f, 'Style', 'edit', 'Position', [240 370 200 20], 'String', '[3,0;5,1]');

% %     uicontrol(f, 'Style', 'text', 'String', 'Rounds:', 'Position', [240 340 100 20]);
% %     roundsBox = uicontrol(f, 'Style', 'edit', 'Position', [240 320 100 20], 'String', '100');

% %     uicontrol(f, 'Style', 'text', 'String', 'Generations:', 'Position', [240 290 100 20]);
% %     gensBox = uicontrol(f, 'Style', 'edit', 'Position', [240 270 100 20], 'String', '90');

% %     uicontrol(f, 'Style', 'text', 'String', 'Sim Mode:', 'Position', [20 240 100 20]);
% %     simModeMenu = uicontrol(f, 'Style', 'popupmenu', 'Position', [20 220 200 20], ...
% %         'String', {'TourTheFit', 'TourSimImit', 'TourSimFit', 'Axel'});

% %     uicontrol(f, 'Style', 'text', 'String', 'Rounding:', 'Position', [240 240 100 20]);
% %     roundingMenu = uicontrol(f, 'Style', 'popupmenu', 'Position', [240 220 200 20], ...
% %         'String', {'paper', 'pop', 'dec', 'off'});

% %     uicontrol(f, 'Style', 'text', 'String', 'Imitators (K):', 'Position', [240 190 100 20]);
% %     kBox = uicontrol(f, 'Style', 'edit', 'Position', [240 170 100 20], 'String', '5');

% %     runBtn = uicontrol(f, 'Style', 'pushbutton', 'Position', [200 100 200 40], ...
% %         'String', 'Run Simulation', 'Callback', @runSim);

% %     function runSim(~, ~)
% %         addpath('Code/Genaxel/strategies');
% %         addpath('Code/Genaxel');

% %         strategyIndices = get(strategiesList, 'Value');
% %         populations = str2num(get(popBox, 'String')); %#ok<ST2NM>
% %         matrix = str2num(get(payoffBox, 'String')); %#ok<ST2NM>
% %         rounds = str2double(get(roundsBox, 'String'));
% %         generations = str2double(get(gensBox, 'String'));
% %         simModes = get(simModeMenu, 'String');
% %         sim_mode = simModes{get(simModeMenu, 'Value')};
% %         roundingOptions = get(roundingMenu, 'String');
% %         rounding = roundingOptions{get(roundingMenu, 'Value')};
% %         K = str2double(get(kBox, 'String'));

% %         strategiesArray = strategyIndices;
% %         populationsArray = populations;
% %         custom = true;

% %         % Simulation dispatch
% %         switch sim_mode
% %             case "TourTheFit"
% %                 TourTheFit(matrix, strategiesArray, populationsArray, rounds, generations, rounding);
% %             case "TourSimImit"
% %                 TourSimImit(matrix, strategiesArray, populationsArray, K, rounds, generations);
% %             case "TourSimFit"
% %                 TourSimFit(matrix, strategiesArray, populationsArray, rounds, generations);
% %             case "Axel"
% %                 Axel(strategiesArray, populationsArray, matrix, rounds);
% %             otherwise
% %                 errordlg('Invalid simulation mode.');
% %         end
% %     end
% % end
