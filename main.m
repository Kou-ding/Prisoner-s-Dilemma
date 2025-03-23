addpath('strategies');
function PrisonersDilemma()
    % % Prompt user to select strategies
    % while true
    %     strategiesInput = input(['Select the strategies you want to play against each other:\n'...
    %                     '1. Random\n'...
    %                     '2. Cooperate\n'...
    %                     '3. Defect\n'...
    %                     '4. Tit-for-tat\n'...
    %                     '5. Grim\n'...
    %                     'Separate the stategies with a space.\n'...
    %                     'Strategies: '], 's');
    %     strategiesArray = str2double(strsplit(strategiesInput, ' '));
    %     % Guarantee strategy uniqueness
    %     if length(strategiesArray) ~= length(unique(strategiesArray))
    %         disp('There are repeating elements in the array. Please select unique strategies.');
    %     else
    %         break;
    %     end
    %     disp(strategiesArray);
    % end

    % % Prompt user to select populations
    % while true
    %     populationsInput = input(['Which is their corresponding population?\n'...
    %                         'Separate the populations with a space.\n'...
    %                         'Populations: '], 's');
    %     populationsArray = str2double(strsplit(populationsInput, ' '));
    %     if(length(populationsArray) == length(strategiesArray))
    %         break;
    %     else
    %         disp('The player and population arrays do not match');
    %     end
        
    %     disp(populationsArray);
    % end

    % % Prompt user to select payoff matrix
    % while true
    %     payoffSelector = input(['Select the payoff matrix:\n'...
    %                           '1. Prisoner’s Dilemma\n'...
    %                           '2. Custom\n'...
    %                           'Choice: '], 's');
    %     % Standard Prisoner's Dilemma payoff matrix
    %     if strcmp(payoffSelector, '1')
    %         matrixArray =  {3, 1; 4, 2};
    %         break;
    %     % Custom payoff matrix
    %     elseif strcmp(payoffSelector, '2')
    %         payoffMatrixInput = input(['Enter the custom payoff matrix in the following format:\n'...
    %                             'a b c d e f g h i\n'...
    %                             'Which corresponds to:\n'...
    %                             'a b c\n'...
    %                             'd e f\n'...
    %                             'g h i\n'...
    %                             'where the above are the values of a 3x3 matrix when traversed from left to right and top to bottom\n'...
    %                             'Matrix: '], 's');
    %         payoffMatrixArray = str2double(strsplit(payoffMatrixInput, ' '));

    %         % Check if the matrix is nxn
    %         if mod(sqrt(length(payoffMatrixArray)), 1) == 0
    %             n = sqrt(length(payoffMatrixArray));
    %             matrixArray = reshape(payoffMatrixArray, [n, n]);
    %             break;
    %         else
    %             disp('The matrix provided is not nxn. Please enter a valid matrix.');
    %         end
    %     else
    %         disp('Invalid choice. Please select 1 or 2.');
    %     end
    % end
    % disp(matrixArray);

    % % Prompt user to select number of rounds
    % while true
    %     rounds = input(['How many rounds would you like to simulate?\n'...
    %                             'Rounds: '], 's');
    %     disp(rounds);
    %     if str2double(rounds) > 0
    %         break;
    %     else
    %         disp('Invalid input. Please enter a positive integer.');
    %     end
    % end

    % Debuging values
    strategiesArray = [1, 2];
    populationsArray = [2, 2];
    matrix = {3, 1; 4, 2};
    rounds = 10;

    function players = InitPlayers(strategiesArray, populationsArray, rounds)
        % Define function handles for each player type
        playerConstructors = containers.Map(...
            {1, 2, 3, 4, 5}, ... % Strategy numbers
            {@random, @cooperate, @defect, @tit_for_tat, @grim} ... % Corresponding constructors
        );
    
        % Calculate the total number of players
        totalPlayers = sum(populationsArray, "all");
    
        % Preallocate the players array as a cell array
        players = cell(1, totalPlayers);
    
        % Create players based on strategiesArray and populationsArray
        playerIndex = 1; % Track the current position in the players array
        for strategy = 1:length(strategiesArray)
            % Get the current strategy number
            strategyNumber = strategiesArray(strategy);
            
            % Get the population for the current strategy
            population = populationsArray(strategy);
            
            % Check if the strategy is valid
            if playerConstructors.isKey(strategyNumber)
                % Create 'population' number of players for the current strategy
                for i = 1:population
                    % Dynamically call the constructor for the current strategy
                    constructorHandle = playerConstructors(strategyNumber); % Get the function handle
                    players{playerIndex} = constructorHandle(); % Call the constructor to create a player object
                    playerIndex = playerIndex + 1; % Move to the next position in the players array
                end
            else
                error('Invalid strategy number: %d', strategyNumber);
            end
        end
        
        % Set the index and history matrix for each player
        for i = 1:length(players)
            players{i}.index = i;
            players{i}.initHistory(length(players), rounds);
        end
    end

    players = InitPlayers(strategiesArray, populationsArray, rounds);
    disp(players);

    % Initialize the axelrod tournament
    tournament = axelrod();
    tournament.initAxel(players, matrix, rounds);
    tournament.begin();

end

PrisonersDilemma();
