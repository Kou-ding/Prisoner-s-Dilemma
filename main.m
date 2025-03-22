function PrisonersDilemma()
    
    % Prompt user to select number of rounds
    % tournament.rounds = input('Enter the number of rounds you want to play: ');
    % Prompt user to select players
    % tournament.
    players = input(['Select the strategies you want to play against each other:\n'...
                    '1. Random\n'...
                    '2. Cooperate\n'...
                    '3. Defect\n'...
                    '4. Tit-for-tat\n'...
                    'Separate the stategies with a comma.\n'...
                    'Strategies: '], 's');
    playerArray = str2double(strsplit(players, ','));
    display(playerArray);

    populations = input(['Which is their corresponding population?\n'...
                        'Separate the populations with a comma.\n'...
                        'Populations: '], 's');
    populationsArray = str2double(strsplit(populations, ','));
    display(populationsArray);
    
    % Initialize the axelrod tournament
    tournament = axelrod();

    % Set tournament's players
    tournament.setPlayers(playerArray);

    % Set tournament's 

    display(tournament.getPayoffMatrix());

end

PrisonersDilemma();
