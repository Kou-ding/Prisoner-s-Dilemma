addpath('strategies');
function PrisonersDilemma()
    % Prompt user to select strategies
    while true
        playersInput = input(['Select the strategies you want to play against each other:\n'...
                        '1. Random\n'...
                        '2. Cooperate\n'...
                        '3. Defect\n'...
                        '4. Tit-for-tat\n'...
                        '5. Grim\n'...
                        'Separate the stategies with a comma.\n'...
                        'Strategies: '], 's');
        playerArray = str2double(strsplit(playersInput, ' '));
        % Guarantee strategy uniqueness
        if length(playerArray) ~= length(unique(playerArray))
            disp('There are repeating elements in the array. Please select unique strategies.');
        else
            break;
        end
        disp(playerArray);
    end

    % Prompt user to select populations
    while true
        populationsInput = input(['Which is their corresponding population?\n'...
                            'Separate the populations with a comma.\n'...
                            'Populations: '], 's');
        populationsArray = str2double(strsplit(populationsInput, ' '));
        if(length(populationsArray) == length(playerArray))
            break;
        else
            disp('The player and population arrays do not match');
        end
        
        disp(populationsArray);
    end

    % Prompt user to select payoff matrix
    while true
        payoffSelector = input(['Select the payoff matrix:\n'...
                              '1. Prisoner’s Dilemma\n'...
                              '2. Custom\n'...
                              'Choice: '], 's');
        % Standard Prisoner's Dilemma payoff matrix
        if strcmp(payoffSelector, '1')
            matrixArray =  {3, 1; 4, 2};
            break;
        % Custom payoff matrix
        elseif strcmp(payoffSelector, '2')
            payoffMatrixInput = input(['Enter the custom payoff matrix in the following format:\n'...
                                'a b c d e f g h i\n'...
                                'Which corresponds to:\n'...
                                'a b c\n'...
                                'd e f\n'...
                                'g h i\n'...
                                'where the above are the values of a 3x3 matrix when traversed from left to right and top to bottom\n'...
                                'Matrix: '], 's');
            payoffMatrixArray = str2double(strsplit(payoffMatrixInput, ' '));

            % Check if the matrix is nxn
            if mod(sqrt(length(payoffMatrixArray)), 1) == 0
                n = sqrt(length(payoffMatrixArray));
                matrixArray = reshape(payoffMatrixArray, [n, n]);
                break;
            else
                disp('The matrix provided is not nxn. Please enter a valid matrix.');
            end
        else
            disp('Invalid choice. Please select 1 or 2.');
        end
    end
    disp(matrixArray);

    % Prompt user to select number of rounds
    while true
        rounds = input(['How many rounds would you like to simulate?\n'...
                                'Rounds: '], 's');
        disp(rounds);
        if str2double(rounds) > 0
            break;
        else
            disp('Invalid input. Please enter a positive integer.');
        end
    end

    % Create players based on playerArray
    function players = InitPlayers(playerArray)
        % Define function handles for each player type
        playerConstructors = containers.Map(...
            {1, 2, 3, 4, 5}, ... % Strategy numbers
            {@random, @cooperate, @defect, @tit_for_tat, @grim} ... % Corresponding constructors
        );
    
        % Initialize players array
        players = player.empty(1, length(playerArray));
    
        % Create players based on playerArray
        for i = 1:length(playerArray)
            if playerConstructors.isKey(playerArray(i))
                players(i) = playerConstructors(playerArray(i)); % Call constructor dynamically
            else
                error('Invalid strategy number: %d', playerArray(i));
            end
        end
    end
    players = InitPlayers(playerArray);
    disp(players);

    % Initialize the axelrod tournament
    tournament = axelrod();
    tournament.initAxel(InitPlayers(playerArray), populationsArray, rounds, matrix);
    tournament.begin();


    players = player.empty(2,0); % Initialize the players variable
    players{1} = grim();
    players{2} = defect();

    disp('Player 1 strategy');
    disp(players{1}.strategy);
    disp('Player 2 strategy');
    disp(players{2}.strategy);
    
    disp('Player 1 move');
    disp(players{1}.move);


end

PrisonersDilemma();
