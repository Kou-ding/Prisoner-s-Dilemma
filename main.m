addpath('strategies');
function PrisonersDilemma()
    % % Prompt user to select strategies
    % players = input(['Select the strategies you want to play against each other:\n'...
    %                  '1. Random\n'...
    %                  '2. Cooperate\n'...
    %                  '3. Defect\n'...
    %                  '4. Tit-for-tat\n'...
    %                  '5. Grim\n'...
    %                  'Separate the stategies with a comma.\n'...
    %                  'Strategies: '], 's');
    % playerArray = str2double(strsplit(players, ' '));
    % disp(playerArray);

    % % Prompt user to select populations
    % while true
    %     populations = input(['Which is their corresponding population?\n'...
    %                         'Separate the populations with a comma.\n'...
    %                         'Populations: '], 's');
    %     populationsArray = str2double(strsplit(populations, ' '));
    %     if(length(populationsArray) == length(playerArray))
    %         break;
    %     else
    %         disp('The player and population arrays do not match');
    %     end
        
    %     disp(populationsArray);
    % end

    % % Prompt user to select payoff matrix
    % while true
    %     payoffMatrix = input(['Select the payoff matrix:\n'...
    %                           '1. Prisoner’s Dilemma\n'...
    %                           '2. Custom\n'...
    %                           'Choice: '], 's');
    %     if strcmp(payoffMatrix, '1')
    %         matrix =  {3, 1; 4, 2}; % Standard payoff matrix
    %         break;
    %     elseif strcmp(payoffMatrix, '2')
    %         matrixTemp = input(['Enter the custom payoff matrix in the following format:\n'...
    %                             'a b c d e f g h i\n'...
    %                             'where the above are the values of a 3x3 matrix when traversed from left to right and top to bottom\n'...
    %                             'Matrix: '], 's');
    %         matrix = str2double(strsplit(matrixTemp, ' '));

    %     else
    %         disp('Invalid choice. Please select 1 or 2.');
    %     end
    % end
    % disp(matrix);

    % % Prompt user to select number of rounds
    % rounds = input(['How many rounds would you like to simulate?\n'...
    %                            'Rounds: '], 's');
    % disp(rounds);

    % % Initialize the axelrod tournament
    % tournament = axelrod();
    % tournament.initAxel(playerArray, populationsArray, rounds, matrix);
    % tournament.begin();


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
