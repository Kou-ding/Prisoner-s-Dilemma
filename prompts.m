function [strategiesArray, populationsArray, matrix, rounds] = prompts()
    % Prompt user to select strategies
    while true
        strategiesInput = input(['Select the strategies you want to play against each other:\n'...
                        '1. Random\n'...
                        '2. Cooperate\n'...
                        '3. Defect\n'...
                        '4. Tit-for-tat\n'...
                        '5. Grim\n'...
                        'Separate the stategies with a space.\n'...
                        'Strategies: '], 's');
        strategiesArray = str2double(strsplit(strategiesInput, ' '));
        % Guarantee strategy uniqueness
        if length(strategiesArray) ~= length(unique(strategiesArray))
            disp('There are repeating elements in the array. Please select unique strategies.');
        else
            break;
        end
        disp(strategiesArray);
    end

    % Prompt user to select populations
    while true
        populationsInput = input(['Which is their corresponding population?\n'...
                            'Separate the populations with a space.\n'...
                            'Populations: '], 's');
        populationsArray = str2double(strsplit(populationsInput, ' '));
        if(length(populationsArray) == length(strategiesArray))
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
            matrix =  [3, 1; 4, 2];
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
                matrix = reshape(payoffMatrixArray, [n, n]);
                break;
            else
                disp('The matrix provided is not nxn. Please enter a valid matrix.');
            end
        else
            disp('Invalid choice. Please select 1 or 2.');
        end
    end
    disp(matrix);

    % Prompt user to select number of rounds
    while true
        roundsInput = input(['How many rounds would you like to simulate?\n'...
                                'Rounds: '], 's');       
        rounds = str2double(roundsInput);
        disp(rounds);
        if (rounds) > 0
            break;
        else
            disp('Invalid input. Please enter a positive integer.');
        end
    end
end