function PrisonersDilemma()
    % Initialize tournament
    tournament = tournament();
    % Prompt user to select number of rounds
    tournament.rounds = input('Enter the number of rounds you want to play: ');
    % Prompt user to select players
    tournament.players = input(['Select the strategies you want to play against each other:\n'...
                    '1. Random\n'...
                    '2. Cooperate\n'...
                    '3. Defect\n'...
                    '4. Tit-for-tat\n'...
                    'Separate the stategies with a comma.'], 's');
    % Start the tournament
    playTournament(tournament);
end

PrisonersDilemma();