function gui
    %%% --- GUI window --- %%%
    figWidth = 700;
    figHeight = 370;

    f = figure(...
        'Name', 'Genaxel Simulation GUI', ...
        'Position', [300 100 figWidth figHeight], ...
        'Resize', 'on', ... % This makes it resizable
        'MenuBar', 'none', ... % Remove default menu bar
        'NumberTitle', 'off'); % Remove "Figure 1" title

    %%% --- Left side --- %%%
    %%% --- Strategy list and Sim Mode --- %%%
    uicontrol(f, ...
        'Style', 'text', ...
        'Position', [5 330 150 20], ...
        'String', 'Selected Strategies:');
    
    stratListBox = uicontrol(f, ...
        'Style', 'listbox', ...
        'Position', [20 190 250 130], ...
        'Max', 2);

    deleteBtn = uicontrol(f, ...
        'Style', 'pushbutton', ...
        'String', 'Delete Selected', ...
        'Position', [20 160 120 25], ...
        'Callback', @deleteStrategy);

    uicontrol(f, ...
        'Style', 'text', ...
        'String', 'Sim Mode:', ...
        'Position', [5 130 100 20]);

    simModeMenu = uicontrol(f, ...
        'Style', 'popupmenu', ...
        'String', {'TourTheFit', 'TourSimImit', 'TourSimFit', 'Axel'}, ...
        'Position', [20 110 200 20], ...
        'Callback', @toggleFields);

    % --- New dropdown below simModeMenu ---
    uicontrol(f, ...
        'Style', 'text', ...
        'String', 'Run specific meeting:', ...
        'Position', [5 80 150 20]);

    % Dynamically find all meeting files in "Example/" folder
    exampleDir = 'Examples';
    if ~isfolder(exampleDir)
        mkdir(exampleDir); % Create if doesn't exist
    end
    meetingFiles = dir(fullfile(exampleDir, 'figure*.m'));
    meetingNames = sort({meetingFiles.name}); % Alphabetical sort
    figureFiles = ['None', meetingNames];

    meetingMenu = uicontrol(f, ...
        'Style', 'popupmenu', ...
        'String', figureFiles, ...
        'Position', [20 55 200 20], ...
        'Callback', @meetingSelected);

    %%% --- Right side --- %%%
    %%% --- Strategy adding --- %%%
    strategyList = {...
        '1: Random', ...
        '2: Cooperate', ...
        '3: Defect', ...
        '4: Grim', ...
        '5: Tit-for-tat', ...
        '6: Hard Tit-for-tat', ...
        '7: Slow Tit-for-tat', ...
        '8: Tit-for-two-tat', ...
        '9: Soft Majority', ...
        '10: Periodic CD', ...
        '11: Periodic Kind', ...
        '12: Periodic Nasty', ...
        '13: Gradual', ...
        '14: Pavlov', ...
        '15: Mistrust', ...
        '16: Periodic Ultra Kind', ... 
        '17: Prober'};

    uicontrol(f, ...
        'Style', 'text', ...
        'Position', [288 330 120 20], ...
        'String', 'Select Strategy:');

    strategyMenu = uicontrol(f, ...
        'Style', 'popupmenu', ...
        'String', strategyList, ...
        'Position', [300 300 200 20]);

    uicontrol(f, ...
        'Style', 'text', ...
        'Position', [500 330 100 20], ...
        'String', 'Population:');
    popInput = uicontrol(f, ...
        'Style', 'edit', ...
        'Position', [515 300 60 20], ...
        'String', '10');

    addBtn = uicontrol(f, ...
        'Style', 'pushbutton', ...
        'String', 'Add strategy +', ...
        'Position', [585 300 100 25], ...
        'Callback', @addStrategy);

    %%% --- Payoff matrix --- %%%
    uicontrol(f, ...
        'Style', 'text', ...
        'Position', [270 265 200 20], ...
        'String', 'Payoff Matrix [R,S;T,P]:');
    payoffTable = uitable(f, ...
        'Data', [3 0; 5 1], ...
        'Position', [300 195 153 65], ...
        'ColumnEditable', [true true], ...
        'ColumnWidth', {60, 60});

    %%% --- Rounds, Generations and K --- %%%
    uicontrol(f, ...
        'Style', 'text', ...
        'String', 'Rounds:', ...
        'Position', [278 160 100 20]);
    roundsBox = uicontrol(f, ...
        'Style', 'edit', ...
        'Position', [300 135 60 20], ...
        'String', '100');

    uicontrol(f, ...
        'Style', 'text', ...
        'String', 'Generations:', ...
        'Position', [370 160 100 20]);
    gensBox = uicontrol(f, ...
        'Style', 'edit', ...
        'Position', [380 135 80 20], ...
        'String', '90');

    kLabel = uicontrol(f, ...
        'Style', 'text', ...
        'String', 'Imitators (K):', ...
        'Position', [470 160 100 20], ...
        'Visible', 'off');
    kBox = uicontrol(f, ...
        'Style', 'edit', ...
        'Position', [480 135 70 20], ...
        'String', '5', ...
        'Visible', 'off');

    %%% --- Rounding --- %%%
    roundingLabel = uicontrol(f, ...
        'Style', 'text', ...
        'String', 'Rounding:', ...
        'Position', [285 100 100 20], ...
        'Visible', 'on');
    roundingMenu = uicontrol(f, ...
        'Style', 'popupmenu', ...
        'String', {'paper', 'pop', 'dec', 'off'}, ...
        'Position', [300 80 120 20], ...
        'Visible', 'on');

    %%% --- Run button --- %%%
    uicontrol(f, ...
        'Style', 'pushbutton', ...
        'Position', [250 15 200 40], ...
        'String', 'Run Simulation', ...
        'Callback', @runSim);

    % State variables
    strategyIDs = [];
    populationSizes = [];

    % Flag whether a figure is selected for meeting
    selectedMeeting = 'None';

    function addStrategy(~, ~)
        % Only allow adding strategies if no meeting is selected
        if ~strcmp(selectedMeeting, 'None')
            errordlg('Cannot add strategies while a specific meeting is selected. Choose "None" to customize.');
            return;
        end
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
        if ~strcmp(selectedMeeting, 'None')
            errordlg('Cannot delete strategies while a specific meeting is selected. Choose "None" to customize.');
            return;
        end
        selected = get(stratListBox, 'Value');
        strategyIDs(selected) = [];
        populationSizes(selected) = [];
        updateListbox();
    end

    function updateListbox()
        if isempty(strategyIDs)
            set(stratListBox, 'String', {});
        else
            entries = arrayfun(@(s, p) sprintf('%s -> %d', strategyList{s}, p), ...
                strategyIDs, populationSizes, 'UniformOutput', false);
            set(stratListBox, 'String', entries, 'Value', 1);
        end
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

    function meetingSelected(src, ~)
        val = get(src, 'Value');
        selectedMeeting = figureFiles{val};
        if strcmp(selectedMeeting, 'None')
            % Enable strategy adding controls
            set(strategyMenu, 'Enable', 'on');
            set(popInput, 'Enable', 'on');
            set(addBtn, 'Enable', 'on');
            set(deleteBtn, 'Enable', 'on');
            % Reset listbox to show current strategies
            updateListbox();
            % Also enable payoff, rounds, generations editing
            set(payoffTable, 'Enable', 'on');
            set(roundsBox, 'Enable', 'on');
            set(gensBox, 'Enable', 'on');
            set(roundingMenu, 'Enable', 'on');
            set(kBox, 'Enable', 'on');
        else
            % Disable strategy adding controls
            set(strategyMenu, 'Enable', 'off');
            set(popInput, 'Enable', 'off');
            set(addBtn, 'Enable', 'off');
            set(deleteBtn, 'Enable', 'off');
            % Disable payoff, rounds, generations editing to avoid conflicts
            set(payoffTable, 'Enable', 'off');
            set(roundsBox, 'Enable', 'off');
            set(gensBox, 'Enable', 'off');
            set(roundingMenu, 'Enable', 'off');
            set(kBox, 'Enable', 'off');

            % Clear strategy list box, or indicate the selected figure meeting
            set(stratListBox, 'String', {['Using meeting: ' selectedMeeting]}, 'Value', 1);
        end
    end

    function runSim(~, ~)
        addpath('Code/Genaxel/strategies');
        addpath('Code/Genaxel');

        if strcmp(selectedMeeting, 'None')
            % Custom meeting from GUI
            if isempty(strategyIDs)
                errordlg('Please add at least one strategy.');
                return;
            end
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
        else
            % Load selected meeting file and override parameters
            try
                % Extract filename without extension
                [~, fName] = fileparts(selectedMeeting);
                % Assume these files are in folder 'Example' or current path
                run(fullfile('Examples', fName)); % or just run(fName);

                % After running, expect variables defined:
                % strategiesArray, populationsArray, matrix, rounds, generations, rounding, K
                % Provide defaults if missing
                if ~exist('rounding', 'var')
                    rounding = "paper";
                end
                if ~exist('K', 'var')
                    K = 5;
                end
                simModes = get(simModeMenu, 'String');
                sim_mode = simModes{get(simModeMenu, 'Value')};
            catch ME
                errordlg(['Error loading meeting file: ' ME.message]);
                return;
            end
        end

        % Run the chosen simulation mode
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
