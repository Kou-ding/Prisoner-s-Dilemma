%% playmatch.m
% Plays a match between two players, returning the choices of the two players
% in every round and the score of each player at the end of the match.
%
%% Inputs:
%
%   rounds      : Number of columns of CprobsX, CprobsY, rounds in a match.
%   firstX      : First move of player X.
%   firstY      : First move of player Y.
%   CprobsX     : Possible responses of X, depending on previous state
%                 ('CC', 'CD', 'DC', or 'DD'), with respective
%                 probabilities p(C|CC), p(C|CD), p(C|DC), p(C|DD) for 'C'
%                 to appear.
%   CprobsY     : Possible responses of Y, depending on previous state
%                 ('CC', 'CD', 'DC', or 'DD'), with respective
%                 probabilities p(C|CC), p(C|CD), p(C|DC), p(C|DD) for 'C'
%                 to appear.
%   payoff      : Payoff matrix, [R, S, T, P] of the game.
%
%% Outputs:
%
%   XYchoices   : Matrix, 2 x rounds, with the choices of the two players
%                 during the match.
%   matchscores : The scores of the two players at the end of the match.
%
%% Example:
%
%
function [XYchoices, matchscores] = playmatch(rounds, firstX, CprobsX, firstY, CprobsY, payoff)

    % Payoff matrix elements
    R = payoff(1); S = payoff(2); T = payoff(3); P = payoff(4);

    % The output matrices
    XYchoices = zeros(2, rounds);
    roundscores = zeros(2, rounds);
    
    % First moves of the players
    XYchoices(1,1) = firstX;
    XYchoices(2,1) = firstY;

    % Calculate the scores which correspond to the first moves
    % Create a string representing the first moves of the players. For
    % example, '01' denotes that player X played 'C' and player Y played 'D'
    choice = strcat(num2str(XYchoices(1,1)),num2str(XYchoices(2,1)));
    % Scores depending on the first move
    switch(choice)
        case '00'
            roundscores(:,1) = [R; R];
        case '01'
            roundscores(:,1) = [S; T];
        case '10'
            roundscores(:,1) = [T; S];
        case '11'
            roundscores(:,1) = [P; P];
    end
    
    % Calculate next moves and the respective scores
    for i = 2:rounds
        % String corresponding to the previous round moves
        choice = strcat(num2str(XYchoices(1,i-1)), num2str(XYchoices(2,i-1)));
        % Find next move and round score, depending on the previous move
        switch(choice)
            % Notice the inversion in the cases '01' and '10' for the
            % second player. For example, when the previous move was '01',
            % i.e. 'CD' for the second player we need a move with
            % probability p(C/DC), i.e. from the third row of CprobsY
            case '00'
                % Take the next moves from the premade 'move matrices'
                % CprobsX and CprobsY. Note: they have one element less
                % than rounds in every row, because the first move is given
                % separately
                XYchoices(:,i) = [CprobsX(1,i-1); CprobsY(1,i-1)];
                % The round scores for both players
                roundscores(:,i) = [R; R];
            case '01'
                XYchoices(:,i) = [CprobsX(2,i-1); CprobsY(3,i-1)];
                % The round scores for both players
                roundscores(:,i) = [S; T];
            case '10'
                XYchoices(:,i) = [CprobsX(3,i-1); CprobsY(2,i-1)];
                % The round scores for both players
                roundscores(:,i) = [T; S];
            case '11'
                XYchoices(:,i) = [CprobsX(4,i-1); CprobsY(4,i-1)];
                % The round scores for both players
                roundscores(:,i) = [P; P];
        end
    end

    % Match scores for both players
    matchscores = [sum(roundscores(1,:)) sum(roundscores(2,:))];
    
end